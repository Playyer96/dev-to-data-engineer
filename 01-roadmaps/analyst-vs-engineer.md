# Data Analyst vs Analytics Engineer vs Data Engineer

Written for: a senior SWE with 7 years of Unity/Unreal C#/C++ and full-stack TS/React/Next/Node/.NET, PostgreSQL, MongoDB, and AWS Lambda/API Gateway/Cognito/serverless analytics logging. Based in Colombia and aiming for remote US or LATAM roles.
Last updated: 2026-11-21.

## TL;DR: which path lands fastest

**Target Data Engineer (backend- and AWS-flavored) first, and apply to Analytics Engineer roles at the same time.**
Only take Data Analyst roles as a fallback.

Reasons:
- DE is *software engineering for data*. Your strongest assets already transfer directly: production code, APIs, Postgres, AWS serverless, CI/CD, Docker, and debugging distributed systems. Analyst hiring values none of that much.
- Your serverless analytics-logging work **is already a data pipeline** (events, then Lambda, then storage). Reframe it on your CV as "event ingestion pipeline" work.
- DE and AE pay about 1.5–2.5x what DA pays for LATAM remote roles (see the salaries below). Your seniority counts in DE. In DA you would be competing for junior roles against people with years of BI experience.
- Your gaps are mostly *tools*, not concepts: Python, advanced SQL, dimensional modeling, warehouses, Spark, dbt, and Airflow. A senior SWE can close them in about 8–12 focused weeks. A DA's gaps (business storytelling, stats, and dashboard polish around stakeholders) are slower to prove with portfolio work.

**Recommended positioning:** "Senior Software Engineer → Data Engineer (AWS, Python, SQL, dbt)". Say you have 7 years of building production systems. Do not present yourself as a junior DE.

## Side-by-side comparison

| | **Data Analyst** | **Analytics Engineer** | **Data Engineer** |
|---|---|---|---|
| Core job | Answers business questions with dashboards, reports, and ad-hoc SQL | Builds clean, tested, documented data models in the warehouse that analysts use | Builds and runs the pipelines and platform that move data from sources into the warehouse or lake |
| Main output | Dashboards, insights, slide decks | dbt models, a semantic layer, data tests and docs | Ingestion jobs, orchestrated DAGs, streaming, infra-as-code, data platform |
| Key tools | SQL, Excel/Sheets, Power BI/Tableau/Looker, a bit of Python | SQL (advanced), dbt, Snowflake/BigQuery/Redshift, Git, BI tools | Python, SQL, Airflow/Dagster, Spark, Kafka, AWS (S3, Glue, Athena, Redshift, Kinesis, Lambda), Terraform, Docker |
| SWE skills used | Low | Medium (Git, testing, CI) | **High** (code quality, APIs, infra, reliability) |
| Stakeholder and business load | **High** | Medium | Low to medium |
| Stats needed | Medium (A/B tests, descriptive stats) | Low to medium | Low |
| Typical interview | SQL screen, case study, dashboard take-home | SQL and modeling exercise, dbt project review | SQL, Python coding, data modeling, pipeline system design |
| Your fit today | Weak (no BI portfolio, and seniority doesn't transfer) | Good (needs SQL depth, dbt, and modeling) | **Best** (needs Python, Spark/Airflow, and modeling) |
| Time to job-ready from your background | 6–10 weeks, but at junior pay | 6–10 weeks | 8–12 weeks |
| Remote US/LATAM demand | High volume, more competition | Growing, fewer applicants | High, especially for AWS plus Python |

## Your transferable skills, mapped

| You have | Maps to | How to show it |
|---|---|---|
| AWS Lambda/API Gateway/Cognito, serverless analytics logging | DE ingestion, event pipelines, AWS data stack | Rebuild it as a portfolio project: API events go through Kinesis/Firehose to S3 (Parquet), then Glue/Athena, then dbt, then a dashboard |
| PostgreSQL and MongoDB | OLTP sources, CDC, schema design | Add warehouse modeling (star schema, SCD Type 2) and CDC from Postgres |
| TS/Node/.NET backend | Pipeline code quality, APIs as sources, testing | Write Python with tests, typing, and CI, which shows senior practice |
| Unity/Unreal C#/C++ | Performance thinking, game telemetry | Build a game-telemetry analytics project, which is a niche hook for gaming and ad-tech employers |
| Docker, Git, CI/CD | DataOps | Containerize the Airflow stack and add GitHub Actions for dbt tests |

## The gaps to close, in priority order (all with free resources; see `roadmaps.md`)

1. **Advanced SQL**: window functions, CTEs, query plans, and incremental logic. Use CS50 SQL, Mode, and DataLemur.
2. **Python for data**: pandas/polars, writing to Parquet, and API extraction. Use CS50 Python, then use Python in the Zoomcamp.
3. **Dimensional data modeling**: facts and dimensions, SCDs, grain. Use the DataExpert intermediate bootcamp and Kimball concepts.
4. **Warehouse plus dbt**: BigQuery or Snowflake, and dbt Fundamentals. Use Zoomcamp Module 4 and dbt Learn.
5. **Orchestration**: Airflow, Kestra, or Dagster. Use Zoomcamp Module 2 and Astronomer Academy.
6. **Spark basics**: Use Zoomcamp Module 6 and Databricks Free Edition.
7. **BI (light)**: one dashboard in Power BI, Looker Studio, or Metabase for every project, so it doubles as AE/DA proof.
8. *Optional credential:* **AWS Certified Data Engineer – Associate (DEA-C01).** It fits your AWS background, and the prep is free on Skill Builder. The exam is paid ($150).

## Remote salary ranges for LATAM-based workers (USD/year)

Sources disagree, partly because some report base salary, some report all-in cost, and some report US-company remote pay versus local market pay. Treat all figures as directional.

### Data Engineer
| Source | Range / figure | Notes |
|---|---|---|
| HireTalent.lat (Mar 2026) | LATAM: entry $31K · mid $48K · senior $64K. **Colombia: entry $30K – senior $74K** | Estimates of US-company remote pay ([source](https://hiretalent.lat/salaries/data-engineer)) |
| South / hireinsouth (2026) | Mid $45–62K · senior $68–88K · architect $85–110K. Colombia $30–74K | Recruiter benchmarks ([source](https://www.hireinsouth.com/post/data-engineer-salary)) |
| Remote Rocketship | LATAM remote DE postings span about $38K–$118K | Job board aggregate ([source](https://www.remoterocketship.com/country/latin-america/jobs/data-engineer/)) |
| Levels.fyi (Globant, Colombia) | About COP 102M (semi-senior) to COP 178M (senior). That is very roughly $25–45K at about 4,000 COP/USD | Local-employer total comp ([source](https://www.levels.fyi/companies/globant/salaries/software-engineer/title/data-engineer)) |
| US reference | About $123–130K average, and $121K senior (Salary.com, ZipRecruiter via hireinsouth) | What US-based hires earn, for context |

### Analytics Engineer
| Source | Range / figure | Notes |
|---|---|---|
| HireTalent.lat (Mar 2026) | LATAM: entry $26K · mid $41K · senior $55K. **Colombia: entry $25K – senior $63K** | ([source](https://hiretalent.lat/salaries/analytics-engineer)) |

### Data Analyst
| Source | Range / figure | Notes |
|---|---|---|
| HireTalent.lat (Mar 2026) | LATAM: entry $19K · mid $29K · senior $40K. **Colombia: entry $18K – senior $46K** | ([source](https://hiretalent.lat/salaries/data-analyst)) |
| Plane (EOR data) | Colombia remote DA median **$21.7K** base | ([source](https://plane.com/salaries/data-analyst/colombia)) |
| Levels.fyi | Colombia DA median about COP 36M total comp (about $9K) | Local market ([source](https://www.levels.fyi/t/data-analyst/locations/colombia)) |

### What this means for you
- A realistic **first remote DE offer** for a senior SWE switching tracks is about **$45K–$75K** working for US companies through LATAM contractor or EOR setups. That assumes you sell yourself as senior. Strong AWS-heavy roles at US startups that pay near US rates can reach $80–110K+.
- A realistic **first DA offer** is about **$20K–$45K**, which is likely *below* what you can already earn as a senior SWE.
- Rule of thumb in 2026 LATAM remote hiring: DE ≥ AE > DA, with DE paying about 1.6x DA at the same seniority according to HireTalent's multipliers.

## Job titles to search (remote LATAM-friendly)

"Data Engineer", "Analytics Engineer", "Software Engineer, Data", "Data Platform Engineer", "Backend Engineer (Data)", "ETL Developer", and "Cloud Data Engineer (AWS)". The "Software Engineer, Data" and "Backend Engineer (Data)" titles let you keep senior SWE credit while you pivot.

## Sources (accessed 2026-11-21)
- https://hiretalent.lat/salaries/data-engineer
- https://hiretalent.lat/salaries/analytics-engineer
- https://hiretalent.lat/salaries/data-analyst
- https://www.hireinsouth.com/post/data-engineer-salary
- https://www.remoterocketship.com/country/latin-america/jobs/data-engineer/
- https://plane.com/salaries/data-analyst/colombia
- https://www.levels.fyi/companies/globant/salaries/software-engineer/title/data-engineer
- https://www.levels.fyi/t/data-analyst/locations/colombia

Note: many of these sources are recruiters or marketplaces with commercial interests. Cross-check with real job postings, such as DataTalksClub Slack #jobs, Remote Rocketship, and LinkedIn filtered to "Remote, Latin America".
