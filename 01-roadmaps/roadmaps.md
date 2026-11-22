# Free Roadmaps for Data Engineering and Data Analysis

Every URL below was checked on 2026-11-21 (HTTP 200 unless noted). Everything listed is free, or has a free tier that covers what you need. Paid add-ons are flagged.

Legend: **[DE]** Data Engineer · **[AE]** Analytics Engineer · **[DA]** Data Analyst · **[ALL]** all three

## Suggested order for your background (senior SWE: TS/Node/.NET, Postgres/Mongo, AWS serverless)

1. Skim `roadmap.sh/data-engineer` to find your gaps. You already cover about 40% of it: Git, Linux, Docker, APIs, cloud, and OLTP databases.
2. Do the **DataTalksClub DE Zoomcamp** end to end. It is the main spine of this plan.
3. Run **DataExpert intermediate bootcamp** material alongside it for data modeling, Spark, and interview depth.
4. Work through **Start Data Engineering** posts and project templates to build a portfolio.
5. Take **AWS Skill Builder DEA-C01 prep** to turn your AWS experience into a data credential.

---

## 1. Visual skill roadmaps (roadmap.sh)

Interactive, open source, and kept up to date. Click any node for free links. Official PDFs are downloaded to `pdfs/`.

| Roadmap | URL | Note |
|---|---|---|
| Data Engineer [DE] | https://roadmap.sh/data-engineer | The main skill map: ingestion, warehousing, orchestration, streaming, and IaC. |
| Data Analyst [DA] | https://roadmap.sh/data-analyst | Excel to SQL to stats to BI to Python. Shows the minimum an analyst needs. |
| BI Analyst [DA] | https://roadmap.sh/bi-analyst | Dashboards, KPIs, and stakeholder work. Use it for the Power BI and Tableau side. |
| SQL [ALL] | https://roadmap.sh/sql | Joins, window functions, CTEs, and optimization. This is your biggest single gap. |
| Python [ALL] | https://roadmap.sh/python | Language map. You can skip the beginner nodes, given your C#/TS background. |
| PostgreSQL DBA [DE] | https://roadmap.sh/postgresql-dba | Internals, indexing, query plans, and replication. Deepens Postgres you already know. |
| AI & Data Scientist | https://roadmap.sh/ai-data-scientist | Optional. Stats and ML for later, after you are hired. |
| AWS | https://roadmap.sh/aws | Fills the AWS service gaps around S3, Glue, Athena, Redshift, and Kinesis. |
| Docker / Linux | https://roadmap.sh/docker · https://roadmap.sh/linux | Mostly review for you. Use them to check for gaps. |
| MongoDB | https://roadmap.sh/mongodb | Optional. Your NoSQL experience already covers it. |

**PDFs (official download links from roadmap.sh, for personal use):** `pdfs/roadmapsh-data-engineer.pdf`, `roadmapsh-data-analyst.pdf`, `roadmapsh-bi-analyst.pdf`, `roadmapsh-sql.pdf`, `roadmapsh-python.pdf`, `roadmapsh-postgresql-dba.pdf`. The PDFs only show the map. The free links are on the interactive site.

## 2. Full free curricula (course-style roadmaps)

| Resource | URL | Note |
|---|---|---|
| **DataTalksClub Data Engineering Zoomcamp** [DE] | https://github.com/DataTalksClub/data-engineering-zoomcamp | A free 9-week course: Docker/Terraform, orchestration, BigQuery DWH, dbt, Spark, Kafka, and a capstone project. About 47k stars. You can take it self-paced at any time. A free certificate needs a live cohort. |
| Zoomcamp 2027 cohort (draft) | https://github.com/DataTalksClub/data-engineering-zoomcamp/tree/main/cohorts/2027 | The next cohort, with dates still TBD. Register at https://courses.datatalks.club/ for the certificate and peer-reviewed project. |
| Zoomcamp Module 4: Analytics Engineering [AE] | https://github.com/DataTalksClub/data-engineering-zoomcamp/tree/main/04-analytics-engineering | The dbt module. This is the fastest route into AE skills. |
| DataTalksClub ML / LLM / MLOps Zoomcamps | https://github.com/DataTalksClub/machine-learning-zoomcamp · https://github.com/DataTalksClub/llm-zoomcamp · https://github.com/DataTalksClub/mlops-zoomcamp | Optional follow-ups for after you land a DE role. |
| **DataExpert.io Data Engineer Handbook** (Zach Wilson) [DE] | https://github.com/DataExpert-io/data-engineer-handbook | About 45k stars. Lists books, communities, newsletters, projects, and interview prep. |
| DataExpert free intermediate bootcamp (6 weeks) | https://github.com/DataExpert-io/data-engineer-handbook/tree/main/intermediate-bootcamp · https://learn.dataexpert.io/program/free-community-boot-camp/details | Covers dimensional and fact modeling, Spark, data quality, and pipelines. It is strong on modeling, which is one of your gaps. Signup is free. |
| DataExpert free beginner bootcamp (4 weeks) | https://github.com/DataExpert-io/data-engineer-handbook/tree/main/beginner-bootcamp | Probably too basic for you. Skim the SQL and Python parts only. |
| Zach Wilson's "Breaking into DE" roadmap | https://blog.dataengineer.io/p/the-2024-breaking-into-data-engineering | Short opinionated roadmap: SQL, Python, Spark/Airflow, then modeling. Dated 2024 but still valid. |
| **Data Engineering Cookbook** (Andreas Kretz) [DE] | https://github.com/andkret/Cookbook | About 15.6k stars. Covers DE fundamentals, platform architecture, and case studies from Netflix, Uber, and others. Still updated in 2026. |
| datastacktv Data Engineer Roadmap | https://github.com/datastacktv/data-engineer-roadmap | About 12.7k stars, but **stale (last updated 2022)**. Use the overview image only. Prefer roadmap.sh. |

## 3. Curated lists, wikis, and datasets

| Resource | URL | Note |
|---|---|---|
| awesome-data-engineering | https://github.com/igorbarinov/awesome-data-engineering | Catalog of tools by category: DBs, ingestion, batch, streaming, and BI. Use it as a reference, not a course. |
| awesome-public-datasets | https://github.com/awesomedata/awesome-public-datasets | About 80k stars. A source of data for portfolio projects. Pick domains that match your target employers. |
| Data Engineering Wiki (r/dataengineering) | https://dataengineering.wiki · https://dataengineering.wiki/Guides/Getting+Started | Community wiki of concepts, tools, and a getting-started guide. The Reddit wiki itself blocks bots, so use this mirror. |
| DE interview questions | https://github.com/OBenner/data-engineering-interview-questions | About 1.8k stars. A question bank on SQL, modeling, Spark, and Kafka. |
| Kaggle Datasets | https://www.kaggle.com/datasets | Datasets plus free notebooks. Useful for analyst portfolio pieces. |

## 4. Blogs and project-based roadmaps

| Resource | URL | Note |
|---|---|---|
| **Start Data Engineering** (Joseph Machado) | https://www.startdataengineering.com | Practical posts on modeling, testing, and pipelines. The best free blog for experienced SWEs switching to DE. |
| SDE: Projects to impress hiring managers | https://www.startdataengineering.com/post/data-engineering-project-to-impress-hiring-managers/ | Shows how to scope a portfolio project that gets interviews. Read it before you build anything. |
| SDE: DE project list | https://www.startdataengineering.com/post/data-engineering-projects/ | Project ideas with templates. |
| SDE: DE best practices | https://www.startdataengineering.com/post/de_best_practices/ | Idempotency, backfills, and testing. You need these for interviews. |
| SDE project template (GitHub) | https://github.com/josephmachado/data_engineering_project_template | A ready-made repo layout for an Airflow, Docker, and DuckDB/Postgres pipeline. |
| SDE efficient Spark processing | https://github.com/josephmachado/efficient_data_processing_spark | Companion code for learning Spark performance. |
| Streamify (ankurchavda) | https://github.com/ankurchavda/streamify | An end-to-end streaming reference project built with Kafka, Spark Streaming, dbt, and Airflow, from a Zoomcamp alum. |
| e2e-data-engineering (airscholar) | https://github.com/airscholar/e2e-data-engineering | An end-to-end project with Kafka, Airflow, Spark, and Cassandra. |
| Seattle Data Guy (Substack) | https://seattledataguy.substack.com | Career and market commentary, including what hiring managers actually want. |
| Data Engineering Podcast | https://www.dataengineeringpodcast.com | Tool deep dives to listen to on commutes. |

## 5. Vendor learning paths (free tiers)

| Vendor | URL | Note |
|---|---|---|
| **AWS Skill Builder** | https://skillbuilder.aws | Free tier with 600+ courses. **Your fastest credential path**, since you already know Lambda, API Gateway, and Cognito. |
| AWS DEA-C01 Standard Exam Prep plan | https://explore.skillbuilder.aws/learn/learning-plans/2049/standard-exam-prep-plan-aws-certified-data-engineer-associate-dea-c01 | Free official prep for AWS Certified Data Engineer – Associate. **The exam itself is paid ($150).** Watch for AWS free-voucher promos. |
| AWS Data Engineer Associate cert page | https://aws.amazon.com/certification/certified-data-engineer-associate/ | Exam guide and domains: Glue, Redshift, Kinesis, Athena, and Lake Formation. |
| AWS Data Analytics learning | https://aws.amazon.com/training/learn-about/data-analytics/ | Index of free AWS analytics training. |
| **Microsoft Learn – Data Engineer career path** | https://learn.microsoft.com/en-us/training/career-paths/data-engineer | Free modules covering Fabric, Synapse, Databricks on Azure, and the sandbox labs. |
| Microsoft Learn – Data Analyst career path | https://learn.microsoft.com/en-us/training/career-paths/data-analyst | Free Power BI-centric path. |
| Power BI training | https://learn.microsoft.com/en-us/training/powerplatform/power-bi | The free Power BI course. Power BI Desktop is free on Windows. |
| PL-300 Power BI Data Analyst cert | https://learn.microsoft.com/en-us/credentials/certifications/data-analyst-associate/ | The most-requested analyst cert in LATAM job ads. The exam is paid. Microsoft "Cloud Skills Challenge" events sometimes include free vouchers. |
| DP-700 Fabric Data Engineer cert | https://learn.microsoft.com/en-us/credentials/certifications/fabric-data-engineer-associate/ | Free learning path. The exam is paid. |
| Fabric Analytics Engineer (DP-600) | https://learn.microsoft.com/en-us/credentials/certifications/fabric-analytics-engineer-associate/ | Free learning path. The exam is paid. |
| Google Cloud Skills Boost – Data Engineer path | https://www.cloudskillsboost.google/paths/16 | 13 activities covering BigQuery, Dataflow, and Pub/Sub, aimed at the PDE exam. *The site blocks automated checks (403). Its existence was confirmed via search.* Some labs need credits, and the course videos are free. |
| Google Cloud PDE cert page | https://cloud.google.com/learn/certification/data-engineer | Exam overview. The exam is paid. |
| Google Cloud data engineering training index | https://cloud.google.com/learn/training/data-engineering-and-analytics | Index of free GCP data training. |
| **dbt Learn** | https://learn.getdbt.com/catalog | Free official dbt Fundamentals course, the core AE skill. Certification is paid. |
| Databricks Free Edition + training | https://www.databricks.com/learn/free-edition · https://www.databricks.com/learn/training/home | A free workspace for Spark and Delta, plus free self-paced courses. |
| Snowflake learning | https://learn.snowflake.com | Free courses and badges. Pair them with a 30-day Snowflake trial. |
| Astronomer Academy (Airflow) | https://www.astronomer.io/certification/ | Free Airflow 3 prep courses. The Fundamentals exam costs $150, but Astronomer webinars often give **free exam codes**. *academy.astronomer.io blocks automated checks.* |
| Google Data Analytics Certificate | https://grow.google/certificates/data-analytics/ | A well-known analyst cert on Coursera, **paid by subscription**. Free only via Coursera financial aid. Optional. |

## 6. Free SQL and Python practice (for the gaps)

| Resource | URL | Note |
|---|---|---|
| CS50 SQL (Harvard) | https://cs50.harvard.edu/sql/ | A rigorous free SQL course with problem sets. |
| CS50 Python (Harvard) | https://cs50.harvard.edu/python/ | Free Python course. You can move through it quickly. |
| Mode SQL Tutorial | https://mode.com/sql-tutorial | Analyst-style SQL with window functions and real datasets. |
| SQLBolt | https://sqlbolt.com | Interactive basics. Takes about 1 hour for you. |
| DataLemur | https://datalemur.com | Real interview SQL questions. The free tier is enough. |
| PostgreSQL Tutorial | https://www.postgresqltutorial.com | Postgres-specific SQL reference. |
| Kaggle Learn | https://www.kaggle.com/learn | Short free courses on pandas, SQL, and data viz, with certificates. |
| freeCodeCamp Data Analysis with Python | https://www.freecodecamp.org/learn/data-analysis-with-python/ | Free certificate covering NumPy and pandas projects. |
| OSSU Data Science | https://github.com/ossu/data-science | A full free curriculum, if you ever want the stats and ML depth. |

## Communities

- DataTalksClub Slack: https://datatalks.club/slack.html. This is the Zoomcamp hub, and job postings get shared there.
- The DataExpert handbook lists more communities in `communities.md` inside the repo.

## Dropped or caveats

- `github.com/DataTalksClub/analytics-engineering-zoomcamp` returned **404**. There is no separate AE Zoomcamp. Use Module 4 of the DE Zoomcamp instead.
- `reddit.com/r/dataengineering/wiki` returns **403** to bots. Use dataengineering.wiki instead.
- `cloudskillsboost.google`, `skills.google`, and `academy.astronomer.io` return **403** to bots but are live. They were confirmed via web search.
