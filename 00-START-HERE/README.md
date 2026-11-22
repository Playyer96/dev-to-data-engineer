# Data Engineer / Analytics Engineer — Fast Track (from Senior Software Dev)

**Target role:** **Data Engineer** or **Analytics Engineer**, with Data Analyst roles as a backup to apply to at the same time.
Why: you already have the hard part of DE — production code, AWS serverless (Lambda, API Gateway, Cognito),
**event handling + analytics logging pipelines** (Optic Power), Postgres/Mongo, remote work with US teams.
What's missing: **Python, deep SQL, data modeling, a warehouse, dbt, an orchestrator, and one cloud data stack**.
A pure Analyst role would ignore half of what you already know.

## Where everything is (work through it in this order)
| Folder | What's inside |
|---|---|
| `00-START-HERE` | This plan and the 12-week schedule |
| `01-roadmaps` | Visual roadmaps (roadmap.sh, Zoomcamp, cookbook), and analyst vs engineer compared |
| `02-courses-certs` | Free courses in order (md + xlsx), and which certificates to get |
| `03-books-papers` | Free books, the papers every data engineer should know, and downloaded PDFs |
| `04-software-tools` | The full tool stack (md + xlsx) and the Mac setup commands |
| `05-practice-projects` | SQL drills, practice sites, datasets, 5 portfolio projects |
| `06-job-hunt` | How to reposition your CV, job boards, interview prep, search plan |

## 12-week plan (about 15–20 h/week next to your current job)
Start applying in **week 6**. Don't wait until you feel "ready".

| Week | Focus | Output |
|---|---|---|
| 1 | Python fast track (you already know how to program: CS50P lectures at 2x, then Kaggle Python + Pandas) | 1 notebook analyzing a CSV |
| 2 | SQL fundamentals → intermediate (Mode SQL, SQLBolt, pgexercises) | SQL drills 1–20 |
| 3 | Advanced SQL: window functions, CTEs, gaps & islands, funnels, retention | SQL drills 21–40, LeetCode SQL 50 started |
| 4 | Data modeling: Kimball star schema, slowly changing dimensions (SCDs), normalization vs denormalization. DuckDB + Parquet | **Project 1** (SQL analysis + dashboard in Looker Studio / Metabase) |
| 5 | dbt Core (dbt Learn Fundamentals) on DuckDB, Git, tests, docs | dbt models for Project 2 |
| 6 | Cloud data on AWS (your advantage): S3, Glue, Athena, IAM, Lambda ingestion | **Project 2** batch ELT shipped. **Start applying (10/week)** |
| 7 | Orchestration: Airflow (Astronomer Academy) or Dagster. Docker | Project 2 scheduled + CI |
| 8 | DE Zoomcamp modules: Spark/PySpark (Databricks Free Edition) | Spark notebook on NYC TLC |
| 9 | Streaming: Kafka/Redpanda or Kinesis | **Project 3** golf-shot telemetry pipeline, your signature project |
| 10 | Data quality (dbt tests / Great Expectations), Iceberg/Delta, cost & partitioning | Project 3 polished, README + diagram |
| 11 | AWS Certified Data Engineer – Associate (DEA-C01) prep | Practice exams |
| 12 | Interview prep: SQL timed, system design, STAR stories | Mock interviews, 15+ applications/week |

## Your edge: put it in every application
- "Built serverless AWS pipelines for gameplay event handling and analytics logging": this is literally event ingestion.
- Golf simulator: validated simulated ball physics against measured data. That's **data quality and validation**.
- 7 years of shipping production code, CI, and debugging tools. Many data analysts can't do this.
- Bilingual; already working remotely with US teams.

## Rules for going fast
1. Only one course per topic at a time. Use the order in `02-courses-certs/courses.md`.
2. Everything you learn ends up in a **public GitHub repo** with a README and an architecture diagram.
3. Do SQL every day: 3 problems on DataLemur or LeetCode.
4. Post weekly on LinkedIn about what you built ("learning in public").
5. Apply before you're ready. Interviews teach you what to study.
