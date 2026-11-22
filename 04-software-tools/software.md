# Data stack: software and tools (all free)

Free tiers and links checked 2026-11-21. Cloud free tiers change often, so re-check before signing up and set a billing alert.
Spreadsheet version: `software.xlsx`. Local install commands: `mac-setup.md`.

Priority: **Must** = learn in the first 3 months. **Should** = months 3-6, or before interviews. **Later** = when a target job asks for it. Track: DA = data analyst, DE = data engineer.

## Must-learn list

Python 3.13 (via uv), Jupyter (JupyterLab), VS Code (+ Python, Jupyter, dbt extensions), pandas, DuckDB, PostgreSQL, DBeaver Community, dbt Core, Apache Airflow, Apache Spark / PySpark, Docker (Docker Desktop / OrbStack / Colima), AWS Free Tier (account-level), Amazon S3, Google BigQuery (sandbox), Databricks Free Edition, Tableau Public, Excel / Google Sheets.

## Language & environment

| Tool | What it is | Why it matters for jobs | Free tier / OSS | Priority | Track |
|---|---|---|---|---|---|
| [Python 3.13 (via uv)](https://docs.astral.sh/uv/) | The default language for data work. uv (from Astral) installs Python versions, makes venvs and locks dependencies; it replaces pyenv + pip + venv + pip-tools and is very fast. | Required in nearly every DE posting and most DA ones. uv is now the usual way to manage Python projects. | OSS (PSF licence / uv: MIT or Apache-2.0). Free. | **Must** | Both |
| [Jupyter (JupyterLab)](https://jupyter.org/) | Browser notebooks that mix code, output, charts and notes. | Standard for exploring data, take-home tests and portfolio write-ups. Databricks, Colab and Snowflake notebooks all work the same way. | OSS (BSD). Free. | **Must** | Both |
| [VS Code (+ Python, Jupyter, dbt extensions)](https://code.visualstudio.com/) | Code editor that also runs .ipynb notebooks, with SQL and dbt extensions. | One editor for Python, SQL, dbt and Terraform. Most data teams use it. | Free (the VS Code source is MIT). | **Must** | Both |

## DataFrames

| Tool | What it is | Why it matters for jobs | Free tier / OSS | Priority | Track |
|---|---|---|---|---|---|
| [pandas](https://pandas.pydata.org/) | The classic in-memory DataFrame library for Python. | The most-asked Python library in DA interviews and take-home tests. Most existing code is written in it. | OSS (BSD-3). Free. | **Must** | Both |
| [Polars](https://pola.rs/) | Fast DataFrame library written in Rust, built on Apache Arrow, with lazy queries and multi-threading. | Used more and more for single-machine ETL. It shows you know modern tools, and the lazy API is good prep for Spark. | OSS (MIT). Free. | **Should** | Both |

## Databases & SQL

| Tool | What it is | Why it matters for jobs | Free tier / OSS | Priority | Track |
|---|---|---|---|---|---|
| [DuckDB](https://duckdb.org/) | In-process analytical (OLAP) SQL engine that queries Parquet, CSV and JSON files, and S3, directly. Think "SQLite for analytics". | The best free way to practise warehouse-style SQL on a laptop. It also works as the local engine for dbt, and it appears more and more in real pipelines. | OSS (MIT). Free. | **Must** | Both |
| [PostgreSQL](https://www.postgresql.org/) | Open-source relational (OLTP) database. | The most common source system for pipelines (CDC, ELT). You already know it, so focus on window functions, CTEs, EXPLAIN and partitioning. | OSS (PostgreSQL licence). Free. | **Must** | Both |
| [SQLite](https://sqlite.org/) | Embedded, single-file SQL database. | Many SQL practice sites and sample datasets ship as SQLite files. Useful for quick tests. | Public domain. Free. Comes with macOS. | **Should** | Both |
| [DBeaver Community](https://dbeaver.io/) | Universal SQL client and GUI for Postgres, DuckDB, SQLite, Snowflake, BigQuery and many more. | One tool for browsing schemas, running queries and drawing ER diagrams. Analysts use one every day. | OSS Community Edition (Apache-2.0). Free. | **Must** | Both |

## Transformation

| Tool | What it is | Why it matters for jobs | Free tier / OSS | Priority | Track |
|---|---|---|---|---|---|
| [dbt Core](https://docs.getdbt.com/) | SQL-first transformation framework: models, tests, docs and lineage, version-controlled in Git. | The defining tool of the "analytics engineer" role. It appears in a large share of modern DA and DE postings. | dbt Core is OSS (Apache-2.0). dbt Cloud has a free single-developer plan. dbt Labs merged with Fivetran in 2025; check the licence of the newer Fusion engine. | **Must** | Both |

## Orchestration

| Tool | What it is | Why it matters for jobs | Free tier / OSS | Priority | Track |
|---|---|---|---|---|---|
| [Apache Airflow](https://airflow.apache.org/) | Python DAG scheduler and orchestrator (version 3.x). | Still the orchestrator named most often in DE job posts. AWS (MWAA), GCP (Composer) and Astronomer all offer it as a managed service. | OSS (Apache-2.0). Free locally with the Astro CLI or Docker Compose. | **Must** | DE |
| [Dagster](https://dagster.io/) | Asset-based orchestrator with strong dbt integration and local dev tooling. | A popular modern alternative at newer companies. Good to know after Airflow. | OSS (Apache-2.0). Dagster+ has a trial. | **Later** | DE |
| [Prefect](https://www.prefect.io/) | Pythonic workflow orchestration: decorate plain functions as flows and tasks. | Lightweight alternative used by smaller teams. | OSS (Apache-2.0). Prefect Cloud has a free tier. | **Later** | DE |

## Big data & streaming

| Tool | What it is | Why it matters for jobs | Free tier / OSS | Priority | Track |
|---|---|---|---|---|---|
| [Apache Spark / PySpark](https://spark.apache.org/docs/latest/api/python/) | Distributed compute engine (version 4.x). PySpark is its Python API for DataFrames and SQL. | Core DE skill for large-scale batch work, and the engine behind Databricks, EMR and Glue. Expect interview questions on partitioning, shuffles and joins. | OSS (Apache-2.0). Runs free in local mode (needs Java 17 or 21). Also free on Databricks Free Edition. | **Must** | DE |
| [Apache Kafka](https://kafka.apache.org/) | Distributed event-streaming log (4.x uses KRaft only, with no ZooKeeper). | The standard for streaming and CDC pipelines. Know topics, partitions, consumer groups and delivery semantics. | OSS (Apache-2.0). Free locally in Docker. | **Should** | DE |
| [Redpanda](https://www.redpanda.com/) | Kafka-API-compatible streaming platform, written in C++ and shipped as a single binary. | The easiest way to run Kafka locally for learning. Your Kafka client code works unchanged. | Community Edition is free (source-available BSL, not OSI open source). Cloud has trial credits. | **Later** | DE |

## Infrastructure & DevOps

| Tool | What it is | Why it matters for jobs | Free tier / OSS | Priority | Track |
|---|---|---|---|---|---|
| [Docker (Docker Desktop / OrbStack / Colima)](https://docs.docker.com/desktop/setup/install/mac-install/) | Containers for running Postgres, Airflow, Kafka and others locally, and for packaging pipelines. | Expected in DE roles. Every local stack in mac-setup.md uses it. | Docker Engine is OSS. Docker Desktop is free for personal use and small businesses (fewer than 250 staff and under $10M revenue). OrbStack is free for personal use. Colima is OSS (MIT). | **Must** | DE |
| [Terraform / OpenTofu](https://developer.hashicorp.com/terraform) | Infrastructure as code: declare cloud resources such as buckets, IAM, Glue jobs and warehouses in HCL. | Common in DE and platform roles. Terraform is usually the version named in job posts. | Terraform CLI is free under the source-available BSL licence. OpenTofu is the OSS (MPL-2.0) fork and is a drop-in replacement. | **Should** | DE |
| [GitHub Actions](https://docs.github.com/en/actions) | CI/CD built into GitHub. | Use it to run dbt build, tests and linting on every PR. That is a strong portfolio signal. | Free for public repos on standard runners. The Free plan includes a monthly quota of minutes for private repos. | **Should** | Both |

## Cloud: AWS

| Tool | What it is | Why it matters for jobs | Free tier / OSS | Priority | Track |
|---|---|---|---|---|---|
| [AWS Free Tier (account-level)](https://aws.amazon.com/free/) | New accounts get $100 in credits at sign-up and can earn up to $100 more, for up to $200 over 6 months on the Free plan. Some services also have always-free limits. | AWS is the cloud named most often in DE posts. Learn IAM, S3 and the analytics services below. | Free plan: up to $200 in credits over 6 months, then the account closes unless you upgrade. Set an AWS Budgets alert on day 1. | **Must** | DE |
| [Amazon S3](https://aws.amazon.com/s3/) | Object storage. This is the data-lake layer (raw, staged and curated Parquet or Iceberg). | Every AWS data stack starts here. | Pay per GB, which is tiny at learning scale. Covered by Free Tier credits. | **Must** | DE |
| [AWS Glue](https://aws.amazon.com/glue/) | Serverless Spark ETL plus the Glue Data Catalog (a Hive-compatible metastore). | The catalog underpins Athena, EMR and Iceberg on AWS. Glue jobs are a common ETL choice. | Data Catalog: first million objects stored and first million requests per month free. ETL jobs are billed per DPU-hour, so keep them short. | **Should** | DE |
| [Amazon Athena](https://aws.amazon.com/athena/) | Serverless SQL (Trino/Presto) over files in S3. | The cheapest way to do warehouse-style SQL on AWS. Pairs with Glue and Iceberg. | No free tier. Billed per TB scanned. With small, partitioned Parquet files the cost is cents. | **Should** | DE |
| [Amazon Redshift Serverless](https://aws.amazon.com/redshift/free-trial/) | AWS cloud data warehouse that scales automatically. | Appears in AWS-centric DE and DA roles. | One-time $300 credit, valid 90 days, for first-time Redshift Serverless users. Delete the workgroup when you are done. | **Later** | DE |
| [Amazon Kinesis](https://aws.amazon.com/kinesis/) | Managed streaming (Data Streams) and delivery to S3 or Redshift (Data Firehose). | The AWS-native streaming option. The concepts carry over from Kafka. | No free tier: shards are billed per hour. Use on-demand mode, test briefly, then delete. | **Later** | DE |
| [Amazon EMR (incl. EMR Serverless)](https://aws.amazon.com/emr/) | Managed Spark, Hive and Trino clusters, or a serverless Spark option. | Large-scale Spark on AWS. Learn Spark locally first. | No free tier. EMR Serverless bills per vCPU and GB-hour, with no idle cluster cost. Only touch it with credits. | **Later** | DE |

## Cloud warehouses & lakehouses

| Tool | What it is | Why it matters for jobs | Free tier / OSS | Priority | Track |
|---|---|---|---|---|---|
| [Google BigQuery (sandbox)](https://docs.cloud.google.com/bigquery/docs/sandbox) | Serverless warehouse. The sandbox needs no credit card. | A top-3 warehouse in job posts. It hosts many free public datasets, which suit portfolio projects. | Sandbox: no card needed, free usage tier (10 GB storage, 1 TB queries per month). Tables expire after 60 days. Streaming and DML are not supported. | **Must** | Both |
| [Snowflake (trial)](https://signup.snowflake.com/) | Cloud data warehouse with separate storage and compute. | Very common in DA and analytics-engineer posts, often paired with dbt. | 30-day trial with free usage credits, no card needed. Use it in a focused sprint, such as a dbt and Snowflake project. | **Should** | Both |
| [Databricks Free Edition](https://www.databricks.com/learn/free-edition) | Free, permanent Databricks workspace with serverless notebooks, SQL warehouse, Unity Catalog and Delta. It replaced Community Edition. | Databricks and Spark skills are in high demand. The Free Edition is enough to prepare for Databricks certifications. | Free forever, for non-commercial use, with small compute and fair-use limits. | **Must** | DE |

## Open table formats

| Tool | What it is | Why it matters for jobs | Free tier / OSS | Priority | Track |
|---|---|---|---|---|---|
| [Apache Iceberg](https://iceberg.apache.org/) | Open table format that adds ACID transactions, schema and partition evolution, and time travel to Parquet files on object storage. | The emerging standard lakehouse format, supported by AWS (S3 Tables, Athena, Glue), Snowflake and BigQuery. | OSS (Apache-2.0). Practise locally with PyIceberg or DuckDB. | **Should** | DE |
| [Delta Lake](https://delta.io/) | Open table format at the core of Databricks: ACID transactions, MERGE and time travel. | Required knowledge for Databricks roles. | OSS (Apache-2.0, Linux Foundation). The `deltalake` Python package needs no Spark. | **Should** | DE |

## Data quality

| Tool | What it is | Why it matters for jobs | Free tier / OSS | Priority | Track |
|---|---|---|---|---|---|
| [Great Expectations (GX Core)](https://greatexpectations.io/) | Python framework for declaring and running data-quality checks ("expectations"). | Data-quality and observability skills come up in senior DE interviews. | GX Core is OSS (Apache-2.0). GX Cloud has a free tier. | **Later** | DE |
| [Soda Core](https://docs.soda.io/) | YAML (SodaCL) data-quality checks that run against warehouses and DataFrames. | A lighter alternative to GX. Start with dbt tests first, which cover most needs. | Soda Core is OSS (Apache-2.0). Soda Cloud has a free tier. | **Later** | DE |

## BI & visualisation

| Tool | What it is | Why it matters for jobs | Free tier / OSS | Priority | Track |
|---|---|---|---|---|---|
| [Power BI Desktop](https://www.microsoft.com/en-us/microsoft-fabric/features/power-bi/desktop) | Microsoft BI authoring tool for DAX, Power Query and reports. | The BI tool named most often in DA job posts. | Free. WINDOWS ONLY: no macOS version. On a Mac, use Windows 11 ARM in Parallels, UTM or VMware Fusion (free for personal use), or a cloud Windows PC. Web editing in the Power BI service needs a work or school account. Mac alternatives: Tableau Public, Looker Studio, Metabase. | **Should** | DA |
| [Tableau Public](https://public.tableau.com/) | Free Tableau desktop app and hosting. It runs natively on macOS. | Tableau is the second BI tool in DA posts. A public profile works as a ready-made portfolio. | Free, but every workbook you save is public. Do not upload private data. | **Must** | DA |
| [Looker Studio](https://lookerstudio.google.com/) | Google's free browser-based dashboard tool. Connects to BigQuery, Sheets and more. | Quick shareable dashboards. Pairs with the BigQuery sandbox. Works on any OS. | Free (Looker Studio Pro is paid). | **Should** | DA |
| [Metabase](https://www.metabase.com/) | Open-source BI with question builder, SQL editor and dashboards. One Docker container. | Common at startups. The easiest self-hosted BI to put on top of Postgres or DuckDB in a portfolio project. | OSS edition (AGPL) is free to self-host. Cloud has a trial. | **Should** | DA |
| [Apache Superset](https://superset.apache.org/) | Open-source BI and dashboard platform used at scale (for example at Airbnb, where it started). | Shows up at data-platform-heavy companies. Heavier to run than Metabase. | OSS (Apache-2.0). Run it with Docker Compose. Preset Cloud has a free tier. | **Later** | DA |
| [Excel / Google Sheets](https://www.google.com/sheets/about/) | Spreadsheets: pivot tables, XLOOKUP, Power Query in Excel, QUERY() in Sheets. | Still required in almost every DA posting, and the main tool of business stakeholders. | Google Sheets is free. Excel for the web is free with a Microsoft account. Desktop Excel for Mac needs Microsoft 365. Numbers is free but rarely used at work. | **Must** | DA |

## Cost-safety rules for cloud practice

1. Create an AWS Budgets alert ($1 and $10) and turn on MFA for root before you do anything else.
2. Prefer serverless pay-per-use services (Athena, EMR Serverless) over anything with hourly billing (Kinesis shards, provisioned Redshift, EMR clusters).
3. Delete practice resources the same day, and keep a `teardown` note or `terraform destroy` for every lab.
4. Do the free local equivalent first: DuckDB instead of Athena or Redshift, local PySpark instead of EMR or Glue, Redpanda instead of Kinesis or MSK.
