# Free Public Datasets for a DE / DA Portfolio

Every link and sample endpoint was checked with `curl` on 2026-11-21. Where the table says "sample request returned data", the API answered with real JSON or the file started downloading.

**How to pick:** hiring managers care less about the dataset than about how you handled it. The parts they look for:
- incremental loads
- schema drift
- deduplication
- partitioning
- data tests
- a dashboard that answers a real question

Pick sources that are **large** (to show partitioning and performance), **messy** (to show data quality work) or **live** (to show incremental and streaming loads). The ones marked ⭐ are the best fit for `portfolio-projects.md`.

## Big batch datasets (show scale + partitioning)

| Dataset | Format / size | Access | DE skills it shows | Status |
|---|---|---|---|---|
| ⭐ [NYC TLC Trip Records](https://www.nyc.gov/site/tlc/about/tlc-trip-record-data.page) | Monthly Parquet, about 50-100 MB/month for yellow cabs, back to 2009 | Direct download, e.g. `https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2024-01.parquet` | Monthly incremental loads, schema changes across years, partitioning, outlier cleaning (negative fares, zero distance) | OK, sample file downloaded |
| ⭐ [GH Archive](https://www.gharchive.org/) | Hourly gzipped JSON of every public GitHub event since 2011 | `https://data.gharchive.org/2024-01-01-15.json.gz` (one file per hour), also on BigQuery as `githubarchive` | Semi-structured JSON, hourly incremental loads, nested fields, event-type modeling. Same shape as game telemetry. | OK, sample file downloaded |
| [Stack Overflow on BigQuery](https://console.cloud.google.com/bigquery?p=bigquery-public-data&d=stackoverflow&page=dataset) | `bigquery-public-data.stackoverflow` (posts, users, votes, tags) | Free in the [BigQuery sandbox](https://cloud.google.com/bigquery/docs/sandbox): no credit card, about 1 TB of queries/month, 10 GB storage, tables expire after 60 days | Warehouse SQL at scale, cost-aware querying (select only the columns you need, filter partitions) | OK |
| [Stack Exchange data dump](https://archive.org/details/stackexchange) | XML dumps per site | archive.org | Parsing XML into a dimensional model, if you want it local instead of BigQuery | OK |
| [Other BigQuery public datasets](https://cloud.google.com/bigquery/public-data) | Hundreds: GitHub, PyPI downloads, Wikipedia, weather, crypto, Google Analytics sample | Sandbox | Free warehouse playground | OK |
| [PyPI downloads (BigQuery)](https://docs.pypi.org/api/bigquery/) | `bigquery-public-data.pypi.file_downloads`, very large | Sandbox (always filter on a date partition) | Partition pruning, cost control | OK |
| [Wikimedia pageviews](https://dumps.wikimedia.org/other/pageviews/) | Hourly gzipped text files | Direct download | Hourly batch loads, big aggregations | OK |
| [Citi Bike trip data](https://citibikenyc.com/system-data) | Monthly CSV zips ([S3 index](https://s3.amazonaws.com/tripdata/index.html)) | Direct download | CSV schema drift (columns changed in 2021), geo data | OK |
| [AWS Open Data Registry](https://registry.opendata.aws/) | Many datasets already in S3 | Read from S3, often without credentials | Query in place with Athena, no copy needed | OK |
| [TPC-H in DuckDB](https://duckdb.org/docs/stable/core_extensions/tpch) | `CALL dbgen(sf = 1)` generates the benchmark tables | Local | Benchmarking, join tuning, Spark vs DuckDB comparisons | OK |
| [ClickHouse example datasets](https://clickhouse.com/docs/getting-started/example-datasets) | Curated big public datasets with loading guides | Various | Ideas and ready-made loaders | OK |
| [IMDb non-commercial datasets](https://developer.imdb.com/non-commercial-datasets/) | Daily TSV snapshots | Direct download | Daily full-snapshot loads, SCD Type 2 practice | OK |
| [MovieLens](https://grouplens.org/datasets/movielens/) | CSV, 100K to 32M ratings | Download | Clean star schema, a good first dbt project | OK |
| [Brazilian e-commerce (Olist)](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) | 9 linked CSVs | Kaggle | Realistic multi-table e-commerce model with orders, payments, reviews | OK |
| [dbt jaffle-shop](https://github.com/dbt-labs/jaffle-shop) | Synthetic shop data plus a reference dbt project | GitHub | See the dbt conventions before you build your own | OK |

## Game data (your edge: you know this domain)

| Dataset | What | Access | Portfolio angle | Status |
|---|---|---|---|---|
| ⭐ [Steam Games Dataset (FronkonGames)](https://www.kaggle.com/datasets/fronkongames/steam-games-dataset) | About 100k+ Steam games: price, tags, reviews, playtime | Kaggle | Market analysis dashboard, e.g. "which genres and price points get the best reviews" | OK |
| [Steam Store Games (nikdavis)](https://www.kaggle.com/datasets/nikdavis/steam-store-games) | About 27k games, cleaned | Kaggle | Easy first dataset for Project 1 | OK |
| [Steam Video Games user behavior (tamber)](https://www.kaggle.com/datasets/tamber/steam-video-games) | 200k user-game purchase/play rows | Kaggle | Retention-style and recommendation SQL | OK |
| [Video game sales (gregorut)](https://www.kaggle.com/datasets/gregorut/videogamesales) / [Global sales](https://www.kaggle.com/datasets/thedevastator/global-video-game-sales) | Sales by platform, region and year | Kaggle | Classic DA dashboard | OK |
| [SteamSpy API](https://steamspy.com/api.php) | Owner estimates and playtime per app, JSON | Free, rate limited | Daily API ingest, then trend tables | OK |
| ⭐ [OpenDota API](https://api.opendota.com/api/heroes) | Dota 2 matches, heroes and players, JSON | Free (about 60 calls/min without a key) | Match-telemetry pipeline, the closest thing to real game events | OK, sample request returned data |
| [Dota 2 matches (Kaggle)](https://www.kaggle.com/datasets/devinanzelmo/dota-2-matches) | 50k matches with player and purchase logs | Kaggle | Bulk event analytics | OK |
| ⭐ [Lichess open database](https://database.lichess.org/) | Every rated game ever played on Lichess, monthly PGN.zst files (very large) | Direct download (no key) | A real event-stream batch at scale, parsing, Spark (Project 5) | OK |
| [Chess games (datasnaek)](https://www.kaggle.com/datasets/datasnaek/chess) | 20k Lichess games as CSV | Kaggle | Small version for quick EDA | OK |
| **Your own golf-sim telemetry** | Simulated shot events (ball speed, launch angle, spin, carry) | A generator script you write | Project 3. Nobody else has this, and it ties straight to your Unity experience. | n/a |

There is no free, verified public dataset of golf shots (launch-monitor data). Two candidate Kaggle PGA datasets returned 404. Simulate the data instead (Project 3) and say so in your README. Being upfront about the data you generated is a plus, not a minus.

## Live / incremental APIs (show scheduling, idempotency, backfills)

| API | Auth | Sample request (tested) | Good for | Status |
|---|---|---|---|---|
| ⭐ [Open-Meteo](https://open-meteo.com/) | None, free for non-commercial use | `https://api.open-meteo.com/v1/forecast?latitude=4.71&longitude=-74.07&hourly=temperature_2m` (Bogotá). History back to 1940: `https://archive-api.open-meteo.com/v1/archive?latitude=4.71&longitude=-74.07&start_date=2024-01-01&end_date=2024-01-02&hourly=temperature_2m` | Daily incremental loads plus **backfills** from the archive endpoint. Join weather to golf-shot carry for a fun analysis. | OK, sample requests returned data |
| ⭐ [datos.gov.co (Colombia open data)](https://www.datos.gov.co/) | None for light use (a free app token raises the rate limits) | Socrata SODA API: `https://www.datos.gov.co/resource/jbjy-vk9h.json?$limit=5` (SECOP II public contracts). Search the catalog: `https://api.us.socrata.com/api/catalog/v1?domains=www.datos.gov.co&q=siniestros` | Paginated ingest (`$limit`/`$offset`), incremental loads via `$where=fecha > '...'`, Spanish-language messy data. A local angle for Colombian employers. | OK, sample request returned data |
| [Socrata API docs](https://dev.socrata.com/docs/endpoints.html) / [SECOP II dataset page](https://dev.socrata.com/foundry/www.datos.gov.co/jbjy-vk9h) | n/a | Other dataset IDs verified: `rpmr-utcd` (SECOP Integrado), `p6dx-8zbt` (SECOP II procesos), `sjpx-eqfp` (Siniestros viales Palmira) | n/a | OK |
| [DANE](https://www.dane.gov.co/) | None | Colombian national statistics (mostly Excel/CSV downloads) | Dimension and reference data, e.g. municipality codes (DIVIPOLA) | OK |
| [World Bank API](https://api.worldbank.org/v2/country/CO/indicator/NY.GDP.MKTP.CD?format=json) | None | GDP for Colombia, as in the URL | Country-level reference data | OK (API). The data.worldbank.org website blocks bots. |
| [USGS Earthquakes](https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson) | None | GeoJSON feed updated every minute | Near-real-time polling, GeoJSON flattening | OK |
| [Hacker News API](https://github.com/HackerNews/API) | None | `https://hacker-news.firebaseio.com/v0/maxitem.json` | Incremental loads by max ID, item trees | OK |
| [Wikimedia EventStreams](https://wikitech.wikimedia.org/wiki/Event_Platform/EventStreams_HTTP_Service) | None | Server-sent events (SSE) at `https://stream.wikimedia.org/v2/stream/recentchange` | A **free real stream** for Project 5 when you do not want to simulate one | OK (docs) |
| [GitHub REST API](https://docs.github.com/en/rest) | A free token | Repos, issues, PRs | Pagination, rate-limit handling | OK |
| [Open Library API](https://openlibrary.org/developers/api) | None | Books and authors | Small, friendly first ingestion | OK |
| [Our World in Data](https://ourworldindata.org/) | None | CSVs behind every chart | Quick DA dashboards | OK |

## Sports stats APIs

| API | Auth | Notes | Status |
|---|---|---|---|
| ⭐ [MLB Stats API](https://statsapi.mlb.com/api/v1/teams) | None | Unofficial but widely used. Teams, schedules, play-by-play, pitch-level data (velocity and spin, which echoes your ball-physics work). | OK, sample request returned data |
| ⭐ [OpenF1](https://www.openf1.org/) | None for historical data | F1 telemetry (car data at about 4 Hz, laps, positions). Sample: `https://api.openf1.org/v1/sessions?year=2024`. Close to game telemetry. | OK, sample request returned data |
| [Jolpica F1 (Ergast successor)](https://github.com/jolpica/jolpica-f1) | None | Ergast-compatible API: `https://api.jolpi.ca/ergast/f1/2024/results.json`. Ergast itself shut down. | OK, sample request returned data |
| [StatsBomb Open Data](https://github.com/statsbomb/open-data) | None | Event-level soccer data (every pass and shot) as JSON on GitHub | OK |
| [football-data.org](https://www.football-data.org/) | Free API key | Football (soccer) fixtures and results, free tier limited to the main competitions | OK |
| [openfootball](https://github.com/openfootball) | None | Open football fixtures and results as plain text/JSON | OK |
| [BALLDONTLIE](https://www.balldontlie.io/) | Free API key | NBA (and other leagues). The free tier is limited. | OK |
| [TheSportsDB](https://www.thesportsdb.com/free_sports_api) | Free test key | Multi-sport metadata | OK |
| [Retrosheet](https://www.retrosheet.org/) | None | Historical MLB play-by-play files | OK |

## Picks for each portfolio project

| Project (see `portfolio-projects.md`) | Primary data | Backup |
|---|---|---|
| 1. SQL analysis + dashboard | Steam Games (Kaggle) or Stack Overflow (BigQuery) | Olist e-commerce |
| 2. Batch ELT | Open-Meteo plus datos.gov.co (API to S3) | NYC TLC monthly Parquet |
| 3. Game telemetry pipeline | Your simulated golf-shot events | OpenDota match events |
| 4. Orchestrated warehouse | GH Archive hourly plus NYC TLC monthly | IMDb daily snapshots (SCD2) |
| 5. Streaming + Spark | Simulated golf events plus Wikimedia EventStreams | Lichess monthly dumps (Spark batch) |

## Licensing note
Most of these are open licenses (CC0 / CC-BY / ODbL). A few are "non-commercial", including Open-Meteo's free API and IMDb. Check the license on each source page and credit it in your README.
