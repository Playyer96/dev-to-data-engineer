# Mac setup: local data-engineering learning stack (free)

Copy-paste commands for Apple Silicon or Intel macOS. Nothing here costs money or needs a cloud account.
Checked 2026-11-21. Versions at that time: Python 3.13 target, DuckDB 2.0, Polars 2.1, pandas 3.1, dbt-core 1.12 + dbt-duckdb 1.11, PySpark 4.3, Airflow 3.4.

> **Why Python 3.13 and not the newest?** Airflow (`!=3.15`), Dagster and Great Expectations (`<3.15`) do not support Python 3.15 yet. Python 3.13 works with every tool on this page. Pin it per project with uv. Do not upgrade the system Python.

What you end up with:

| Piece | Where it runs | Port |
|---|---|---|
| Python 3.13 + pandas, Polars, DuckDB, PySpark, JupyterLab, dbt-duckdb | `~/de-lab` uv project | Jupyter 8888, Spark UI 4040 |
| PostgreSQL 18 | Docker | 5432 |
| Airflow 3 | Docker (Astro CLI **or** official Compose) | 8080 |
| Metabase (optional) | Docker | 3000 |

---

## 0. Prerequisites (once)

```bash
# Apple command-line tools (git, compilers)
xcode-select --install

# Homebrew (skip if `brew --version` already works)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## 1. Homebrew packages

```bash
brew update

# Core CLI tools
brew install uv duckdb git

# Java for PySpark (Spark 4.x runs on Java 17/21/25; 17 is the safest choice)
brew install openjdk@17

# Container runtime: pick ONE
brew install --cask docker-desktop      # Docker Desktop (free for personal use / small business)
# brew install --cask orbstack          # lighter, free for personal use
# brew install colima docker docker-compose && colima start --cpu 4 --memory 8   # fully OSS

# GUI apps
brew install --cask dbeaver-community visual-studio-code

# Airflow local dev (Astronomer CLI; needs Docker)
brew install astro

# Optional, for later
# brew install opentofu                                        # OSS Terraform fork
# brew tap hashicorp/tap && brew install hashicorp/tap/terraform
# brew install --cask tableau-public                           # Tableau Public desktop app
```

Make Java visible to PySpark (`openjdk@17` is keg-only, so it is not on your PATH):

```bash
cat >> ~/.zshrc <<'EOF'
# Java for PySpark
export JAVA_HOME="$(brew --prefix openjdk@17)/libexec/openjdk.jdk/Contents/Home"
export PATH="$JAVA_HOME/bin:$PATH"
EOF
source ~/.zshrc
java -version   # should print 17.x
```

Open Docker Desktop (or OrbStack) once so it finishes setup. Give it **at least 4 GB of RAM (8 GB is better)** under Settings → Resources. Airflow restarts in a loop with less.

## 2. Python project with uv

```bash
mkdir -p ~/de-lab && cd ~/de-lab
uv python install 3.13
uv init --python 3.13 --name de-lab     # also writes .python-version

uv add pandas polars pyarrow duckdb \
       jupyterlab ipykernel \
       pyspark \
       dbt-core dbt-duckdb \
       "psycopg[binary]" sqlalchemy \
       matplotlib

# Optional extras for later chapters
# uv add deltalake "pyiceberg[duckdb,pyarrow]" great-expectations
```

Airflow is **not** installed into this environment on purpose. It pins hundreds of dependencies and runs in Docker in section 5.

Start Jupyter:

```bash
cd ~/de-lab
uv run jupyter lab            # opens http://localhost:8888
```

VS Code: open `~/de-lab` and pick the `.venv/bin/python` interpreter (Cmd+Shift+P → "Python: Select Interpreter"). Notebooks then use the same environment.

## 3. DuckDB smoke test

```bash
cd ~/de-lab
# CLI: query a remote Parquet file directly
duckdb -c "SELECT COUNT(*) FROM 'https://blobs.duckdb.org/train_services.parquet';"

# Python: DuckDB + Polars + pandas together
uv run python - <<'EOF'
import duckdb, polars as pl
df = duckdb.sql("SELECT range AS id, range % 3 AS bucket FROM range(10)").pl()
print(df.group_by("bucket").len().sort("bucket"))
print(duckdb.sql("SELECT bucket, COUNT(*) FROM df GROUP BY ALL ORDER BY 1").df())
EOF
```

## 4. PostgreSQL in Docker

The password lives in a local `.env` file, not in the compose file. It is for this laptop only, so do not reuse a real password.

```bash
mkdir -p ~/de-lab/infra/postgres && cd ~/de-lab/infra/postgres

cat > .env <<'EOF'
POSTGRES_USER=de
POSTGRES_PASSWORD=change-me-local-only
POSTGRES_DB=lab
EOF

cat > compose.yaml <<'EOF'
services:
  postgres:
    image: postgres:18
    container_name: de-postgres
    env_file: .env
    ports:
      - "5432:5432"
    volumes:
      # Postgres 18+ images expect the volume at /var/lib/postgresql (not .../data)
      - pgdata:/var/lib/postgresql
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U $${POSTGRES_USER} -d $${POSTGRES_DB}"]
      interval: 5s
      retries: 10
volumes:
  pgdata:
EOF

docker compose up -d
docker compose ps                          # wait for "healthy"
docker exec -it de-postgres psql -U de -d lab -c "select version();"
```

DBeaver: New Connection → PostgreSQL → host `localhost`, port `5432`, database `lab`, user `de`, and the password from `.env`.
DuckDB files: New Connection → DuckDB → pick `~/de-lab/lab.duckdb`.

DuckDB can also read Postgres directly, which is handy for ELT practice:

```bash
duckdb -c "INSTALL postgres; LOAD postgres;
ATTACH 'dbname=lab user=de password=change-me-local-only host=localhost' AS pg (TYPE postgres);
SHOW ALL TABLES;"
```

## 5. dbt Core + DuckDB

```bash
cd ~/de-lab
uv run dbt init jaffle            # choose "duckdb" when it asks for an adapter
```

Make sure `~/.dbt/profiles.yml` contains this (create or replace the `jaffle` block):

```yaml
jaffle:
  target: dev
  outputs:
    dev:
      type: duckdb
      path: /Users/YOUR_USER/de-lab/lab.duckdb   # use your real home path
      threads: 4
```

```bash
cd ~/de-lab/jaffle
uv run dbt debug                  # "All checks passed!"
uv run dbt build                  # runs the example models + tests
uv run dbt docs generate && uv run dbt docs serve --port 8081
```

Practice project with real data: https://github.com/dbt-labs/jaffle-shop (its seeds work with DuckDB).

## 6. Airflow 3 (pick ONE option)

Both options use port 8080. Run only one at a time.

### Option A: Astro CLI (simplest)

```bash
mkdir -p ~/de-lab/airflow-astro && cd ~/de-lab/airflow-astro
astro dev init

# The Astro CLI also starts its own Postgres on 5432, which clashes with section 4. Move it:
astro config set postgres.port 5435

astro dev start                   # builds the image, then prints the UI URL and login
# put DAG files in ./dags. The scheduler picks them up automatically.
astro dev logs -f                 # follow logs
astro dev stop                    # stop (keeps state)
astro dev kill                    # stop and delete containers + metadata DB
```

### Option B: official Docker Compose (closer to production)

```bash
mkdir -p ~/de-lab/airflow-compose && cd ~/de-lab/airflow-compose
curl -LfO 'https://airflow.apache.org/docs/apache-airflow/stable/docker-compose.yaml'
mkdir -p ./dags ./logs ./plugins ./config
echo -e "AIRFLOW_UID=$(id -u)" > .env

docker compose up airflow-init    # one-time DB migration + default user
docker compose up -d              # UI at http://localhost:8080 (default login airflow / airflow)
docker compose down               # stop
# docker compose down --volumes --remove-orphans   # full reset
```

This compose file starts its own Postgres inside the Docker network without publishing port 5432, so it does not clash with section 4.

## 7. PySpark (local mode)

```bash
cd ~/de-lab
uv run python - <<'EOF'
from pyspark.sql import SparkSession, functions as F
spark = (SparkSession.builder.master("local[*]").appName("smoke")
         .config("spark.driver.memory", "2g").getOrCreate())
df = spark.range(1_000_000).withColumn("bucket", F.col("id") % 5)
df.groupBy("bucket").count().orderBy("bucket").show()
print("Spark", spark.version, "- UI was at http://localhost:4040 while running")
spark.stop()
EOF
```

If you see `JAVA_HOME is not set` or `Unable to locate a Java Runtime`, re-run the `~/.zshrc` step in section 1 and open a new terminal.

## 8. Optional extras

```bash
# Metabase BI on top of Postgres/DuckDB, at http://localhost:3000
docker run -d --name metabase -p 3000:3000 metabase/metabase

# Kafka-compatible streaming: follow the Redpanda single-broker Docker quickstart
#   https://docs.redpanda.com/streaming/current/get-started/quick-start/
```

## 9. Verify everything

```bash
cd ~/de-lab
uv --version && duckdb --version && java -version 2>&1 | head -1
uv run python -c "import sys, pandas, polars, duckdb, pyspark; print(sys.version.split()[0], 'pandas', pandas.__version__, 'polars', polars.__version__, 'duckdb', duckdb.__version__, 'pyspark', pyspark.__version__)"
uv run dbt --version
docker --version && docker compose version
astro version
docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'
```

## 10. Stop / clean up (frees RAM and disk)

```bash
cd ~/de-lab/infra/postgres && docker compose down            # keep data
# docker compose down --volumes                              # also delete the data
cd ~/de-lab/airflow-astro && astro dev stop                  # or: cd ~/de-lab/airflow-compose && docker compose down
docker rm -f metabase 2>/dev/null
docker system df                                             # see what Docker is using
# docker system prune                                        # remove stopped containers, unused networks and dangling images
```

## Links

- uv: https://docs.astral.sh/uv/
- DuckDB: https://duckdb.org/docs/
- dbt-duckdb adapter: https://github.com/duckdb/dbt-duckdb
- Postgres Docker image: https://hub.docker.com/_/postgres
- Astro CLI: https://www.astronomer.io/docs/astro/cli/overview
- Airflow Docker Compose guide: https://airflow.apache.org/docs/apache-airflow/stable/howto/docker-compose/index.html
- PySpark install guide: https://spark.apache.org/docs/latest/api/python/getting_started/install.html
- Docker Desktop for Mac: https://docs.docker.com/desktop/setup/install/mac-install/
