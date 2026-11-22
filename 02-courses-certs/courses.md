# Free courses: Data Analyst / Data Engineer path

Checked on 2026-11-21. Every URL below returned HTTP 200 on that date (Tableau's main site blocks scripts, so the Tableau Public link was used instead).
Hours are estimates for a working developer. Providers change free tiers often, so check the page before you start.

**How to read "Free?"**
- **Yes**: the full course is free.
- **Free audit**: the videos and readings are free; graded work and the certificate cost money.
- **Audit / Financial Aid**: Coursera. Many courses now offer only a limited preview instead of a full audit. If there is no audit option, apply for **Financial Aid**. You apply per course, on a computer (not the app), and review takes up to about 15 days. Recent reports say aid may cover up to 90% instead of 100%. Official article: https://www.coursera.support/s/article/209819033-Apply-for-Financial-Aid-or-a-Scholarship?language=en_US

**Suggested order for you** (senior dev, AWS background, fastest route to a job):
Python refresh (1 week) -> SQL in depth (3-4 weeks) -> data modeling (1-2 weeks) -> pandas/polars (1-2 weeks) -> statistics in parallel -> one BI tool (1 week) -> DE Zoomcamp + dbt + Airflow (2-3 months) -> Databricks and AWS exam prep.
Pick **one** BI tool (Power BI is a safe default; check which one the job posts you target ask for) and **one** Coursera program at most. The Zoomcamp plus your own projects matter more than any certificate.

Spreadsheet version: `courses.xlsx` (same data, filterable).


## 1. Python

| # | Course | Provider | Hours | Free? | Certificate? | Notes |
|---|---|---|---|---|---|---|
| 1 | [CS50's Introduction to Programming with Python (CS50P)](https://cs50.harvard.edu/python/) | Harvard (CS50) | ~40-60 | Yes | Free CS50 certificate via cs50.harvard.edu; edX verified cert is paid (optional) | You already code: move fast through weeks 0-4, do the problem sets for Python idioms (comprehensions, exceptions, files, regex, OOP, pytest). |
| 2 | [Python for Everybody (PY4E)](https://www.py4e.com/) | Univ. of Michigan / Dr. Chuck | ~40-80 | Yes | Free badges on py4e.com; Coursera version cert is paid (audit or Financial Aid) | Chapters on files, web data, JSON and SQLite are the useful ones for data work. Coursera version: https://www.coursera.org/specializations/python |
| 3 | [Kaggle Learn: Python](https://www.kaggle.com/learn/python) | Kaggle | ~5 | Yes | Free Kaggle certificate | Quick refresher in notebooks; good for getting used to Kaggle before pandas/SQL courses. |
| 4 | [MIT 6.0001 Intro to CS and Programming in Python](https://ocw.mit.edu/courses/6-0001-introduction-to-computer-science-and-programming-in-python-fall-2016/) | MIT OpenCourseWare | ~60 | Yes | No | Optional. Skip if CS50P went fine. |

## 2. SQL

| # | Course | Provider | Hours | Free? | Certificate? | Notes |
|---|---|---|---|---|---|---|
| 5 | [SQLBolt](https://sqlbolt.com/) | SQLBolt | ~3-5 | Yes | No | Interactive basics: SELECT, JOIN, aggregates. One afternoon. |
| 6 | [Mode SQL Tutorial (now hosted by ThoughtSpot)](https://www.thoughtspot.com/sql-tutorial) | ThoughtSpot (ex-Mode) | ~10-15 | Yes | No | mode.com/sql-tutorial now redirects here. Basic, intermediate, advanced (window functions, performance) with an analytics focus. |
| 7 | [Select Star SQL](https://selectstarsql.com/) | Zi Chong Kao | ~3-5 | Yes | No | Interactive book built on one real dataset; good practice with GROUP BY, self joins and window-style thinking. |
| 8 | [Kaggle Learn: Intro to SQL](https://www.kaggle.com/learn/intro-to-sql) | Kaggle | ~3 | Yes | Free Kaggle certificate | BigQuery dialect; gets you used to cloud warehouse SQL. |
| 9 | [Kaggle Learn: Advanced SQL](https://www.kaggle.com/learn/advanced-sql) | Kaggle | ~4 | Yes | Free Kaggle certificate | JOINs/UNIONs, analytic (window) functions, nested and repeated data, query efficiency. |
| 10 | [PostgreSQL Exercises (pgexercises)](https://pgexercises.com/) | pgexercises.com | ~10 | Yes | No | Uses your Postgres background. Do every section, especially Aggregation and Recursive. |
| 11 | [CS50's Introduction to Databases with SQL (CS50 SQL)](https://cs50.harvard.edu/sql/) | Harvard (CS50) | ~30-40 | Yes | Free CS50 certificate via cs50.harvard.edu | Covers schema design, normalization, indexes, views and optimization. Optional if pgexercises felt easy. |
| 12 | [Databases: Relational Databases and SQL (Stanford, Jennifer Widom)](https://www.edx.org/learn/relational-databases/stanford-university-databases-relational-databases-and-sql) | StanfordOnline on edX | ~20-30 | Free audit | Verified certificate is paid | Self-paced, part of the 5-course XSeries https://www.edx.org/xseries/stanfordonline-introduction-to-sql-databases (follow-ons: Advanced Topics in SQL, OLAP and Recursion, Modeling and Theory). Audit is time-limited on edX. |
| 13 | [CMU 15-445/645 Database Systems](https://15445.courses.cs.cmu.edu/) | Carnegie Mellon (Andy Pavlo) | ~60+ | Yes | No | Optional deep dive (storage, indexes, query execution, transactions). Lectures are on YouTube. Great for senior-level interviews. |

## 3. Data modeling

| # | Course | Provider | Hours | Free? | Certificate? | Notes |
|---|---|---|---|---|---|---|
| 14 | [Kimball Dimensional Modeling Techniques](https://www.kimballgroup.com/data-warehouse-business-intelligence-resources/kimball-techniques/dimensional-modeling-techniques/) | Kimball Group | ~10 (reading) | Yes | No | Free official summaries of facts, dimensions, SCDs, grain, conformed dimensions. The full book (The Data Warehouse Toolkit, 3rd ed.) is paid: try a library. |
| 15 | [dbt guide: How we structure our dbt projects](https://docs.getdbt.com/best-practices/how-we-structure/1-guide-overview) | dbt Labs | ~3 | Yes | No | Modern staging / intermediate / marts layering. Read after Kimball and before building the dbt project. |

## 4. pandas / polars

| # | Course | Provider | Hours | Free? | Certificate? | Notes |
|---|---|---|---|---|---|---|
| 16 | [Kaggle Learn: Pandas](https://www.kaggle.com/learn/pandas) | Kaggle | ~4 | Yes | Free Kaggle certificate | Indexing, groupby, dtypes, merges. |
| 17 | [Kaggle Learn: Data Cleaning](https://www.kaggle.com/learn/data-cleaning) | Kaggle | ~4 | Yes | Free Kaggle certificate | Missing values, scaling, parsing dates, encodings, inconsistent data. |
| 18 | [10 minutes to pandas (official)](https://pandas.pydata.org/docs/user_guide/10min.html) | pandas project | ~2 | Yes | No | Keep the rest of the pandas user guide as reference. |
| 19 | [Polars User Guide](https://docs.pola.rs/) | Polars project | ~6-10 | Yes | No | Start at https://docs.pola.rs/user-guide/getting-started/ . Lazy API and expressions, closer to how Spark thinks. |
| 20 | [freeCodeCamp: Data Analysis with Python](https://www.freecodecamp.org/learn/data-analysis-with-python/) | freeCodeCamp | ~300 (nominal; much less for a dev) | Yes | Free freeCodeCamp certification (5 projects) | Useful mainly for the 5 portfolio projects (NumPy, pandas, matplotlib/seaborn). |

## 5. Statistics

| # | Course | Provider | Hours | Free? | Certificate? | Notes |
|---|---|---|---|---|---|---|
| 21 | [StatQuest: Statistics Fundamentals (playlist)](https://www.youtube.com/playlist?list=PLblh5JKOoLUK0FLuzwntyYI10UQFUhsY9) | StatQuest (Josh Starmer) | ~10-15 | Yes | No | Fastest intuition for distributions, p-values, confidence intervals, regression. Channel: https://www.youtube.com/@statquest |
| 22 | [Khan Academy: Statistics and Probability](https://www.khanacademy.org/math/statistics-probability) | Khan Academy | ~40-60 | Yes | No | Do the practice exercises, not just the videos. AP Statistics alternative: https://www.khanacademy.org/math/ap-statistics |
| 23 | [MIT 18.05 Introduction to Probability and Statistics](https://ocw.mit.edu/courses/18-05-introduction-to-probability-and-statistics-spring-2022/) | MIT OpenCourseWare | ~60-80 | Yes | No | Optional, more rigorous. Mainly useful for analyst roles heavy on A/B testing. |
| 24 | [MIT 6.0002 Intro to Computational Thinking and Data Science](https://ocw.mit.edu/courses/6-0002-introduction-to-computational-thinking-and-data-science-fall-2016/) | MIT OpenCourseWare | ~40-60 | Yes | No | Optional. Simulation, sampling, statistical fallacies in Python. |

## 6. BI / visualization

| # | Course | Provider | Hours | Free? | Certificate? | Notes |
|---|---|---|---|---|---|---|
| 25 | [Kaggle Learn: Data Visualization](https://www.kaggle.com/learn/data-visualization) | Kaggle | ~4 | Yes | Free Kaggle certificate | seaborn basics; pick the right chart. |
| 26 | [Power BI training (PL-300 learning path)](https://learn.microsoft.com/en-us/training/courses/pl-300t00) | Microsoft Learn | ~20-30 | Yes | Training free; PL-300 exam is paid | Power BI Desktop is free (Windows). Hub: https://learn.microsoft.com/en-us/training/powerplatform/power-bi . On a Mac use a Windows VM or Power BI in the browser. |
| 27 | [Tableau Public how-to videos](https://public.tableau.com/app/learn/how-to-videos) | Tableau (Salesforce) | ~5-10 | Yes | No | Tableau Public is free and doubles as a public portfolio host. |
| 28 | [Looker Studio (now branded Data Studio) report tutorial](https://support.google.com/looker-studio/topic/9170843) | Google | ~3 | Yes | No | Free BI tool in the browser: https://lookerstudio.google.com/ (redirects to the Data Studio overview). Good for quick portfolio dashboards on BigQuery or Sheets. |

## 7. Coursera certificate programs

| # | Course | Provider | Hours | Free? | Certificate? | Notes |
|---|---|---|---|---|---|---|
| 29 | [Google Data Analytics Professional Certificate](https://www.coursera.org/professional-certificates/google-data-analytics) | Google on Coursera | ~180 (6 months at <10 h/week) | Audit / Financial Aid | Paid via Coursera subscription, or Financial Aid per course | Recognized brand for entry analyst roles. Uses spreadsheets, SQL, Tableau and R. As a dev, skip what you know and focus on the case study. |
| 30 | [IBM Data Engineering Professional Certificate](https://www.coursera.org/professional-certificates/ibm-data-engineer) | IBM on Coursera | ~240 (6 months at 10 h/week) | Audit / Financial Aid | Paid via Coursera subscription, or Financial Aid per course | Broad but shallow (ETL, Airflow, Kafka, Spark, warehouses). Lower priority than the Zoomcamp; take it if you want a Coursera credential. |

## 8. Data engineering core

| # | Course | Provider | Hours | Free? | Certificate? | Notes |
|---|---|---|---|---|---|---|
| 31 | [Data Engineering Zoomcamp](https://github.com/DataTalksClub/data-engineering-zoomcamp) | DataTalksClub | ~100-150 (about 9 weeks + project) | Yes | Free certificate if you finish the homework/capstone during a live cohort | Best free DE course. Docker, Terraform, GCP/BigQuery, workflow orchestration, dbt, Spark, Kafka. The cohort usually starts in January; self-paced any time (no certificate). Community: https://datatalks.club/ |
| 32 | [dbt Fundamentals](https://learn.getdbt.com/courses/dbt-fundamentals) | dbt Labs (dbt Learn) | ~5 | Yes | Free completion badge; dbt certification exam is paid ($200) | Then browse the rest of the free catalog: https://learn.getdbt.com/catalog |
| 33 | [Astronomer Academy: Airflow 3 Fundamentals and DAG Authoring prep](https://academy.astronomer.io/) | Astronomer | ~10-20 | Yes | Prep is free; exam normally $150; free codes are often given at Astronomer certification webinars | Certification info: https://www.astronomer.io/certification/ |
| 34 | [Databricks Free Edition (hands-on workspace)](https://www.databricks.com/learn/free-edition) | Databricks | Practice | Yes | n/a | Free workspace for Spark, Delta Lake and SQL practice. Use it while you take the Academy courses below. |
| 35 | [Databricks Academy (Customer Academy) self-paced: Data Engineering with Databricks](https://customer-academy.databricks.com/) | Databricks | ~15-25 | Yes (self-paced) | Free Fundamentals accreditation (check in Academy); DE Associate exam is paid ($200) | Training hub: https://www.databricks.com/learn/training/home . Learning Festivals give 50% exam vouchers to people who finish a pathway. |
| 36 | [Data Engineer Handbook (free bootcamp materials)](https://github.com/DataExpert-io/data-engineer-handbook) | DataExpert.io (Zach Wilson) | ~50+ | Yes | No | Optional. Curated resources and free bootcamp content on dimensional modeling, Spark and pipelines. |

## 9. Cloud

| # | Course | Provider | Hours | Free? | Certificate? | Notes |
|---|---|---|---|---|---|---|
| 37 | [AWS Skill Builder: Exam Prep for Data Engineer Associate (DEA-C01)](https://skillbuilder.aws/exam-prep/data-engineer-associate) | AWS | ~15-30 | Free tier (some labs need a paid subscription) | Exam is paid ($150) | Start with the free digital courses on https://skillbuilder.aws/ (Glue, Redshift, Kinesis, Athena, Lake Formation). Your AWS background is your advantage. |
| 38 | [AWS Educate](https://aws.amazon.com/education/awseducate/) | AWS | Varies | Yes | Free digital badges | Gives access to the Emerging Talent Community, where points can be redeemed for foundational exam vouchers. |
| 39 | [Google Skills (formerly Google Cloud Skills Boost)](https://www.skills.google/) | Google Cloud | Varies | Free tier (some labs use credits) | Free skill badges; Google certifications are paid | cloudskillsboost.google now redirects here. Data track overview: https://cloud.google.com/learn/training/data-engineering-and-analytics |
| 40 | [Microsoft Learn: DP-900 Azure Data Fundamentals course](https://learn.microsoft.com/en-us/training/courses/dp-900t00) | Microsoft Learn | ~10 | Yes | Training free; exam is paid | Gentle overview of relational, non-relational and analytics on Azure. Optional for you. |
| 41 | [Microsoft Learn: DP-700 Fabric Data Engineer course](https://learn.microsoft.com/en-us/training/courses/dp-700t00) | Microsoft Learn | ~20-30 | Yes | Training free; exam is paid (free voucher campaigns happen) | Lakehouse, Spark, pipelines and real-time in Microsoft Fabric. Get started path: https://learn.microsoft.com/en-us/training/paths/get-started-fabric/ |
| 42 | [Microsoft practice assessments and Applied Skills](https://learn.microsoft.com/en-us/credentials/applied-skills/) | Microsoft Learn | Varies | Yes | Applied Skills credentials are free | Free practice tests for every exam: https://learn.microsoft.com/en-us/credentials/certifications/practice-assessments-for-microsoft-certifications |
| 43 | [Snowflake free courses (optional)](https://learn.snowflake.com/en/) | Snowflake | Varies | Yes | SnowPro certifications are paid | Only if job posts you target ask for Snowflake. Certifications: https://learn.snowflake.com/en/certifications/ |

## Dead or moved links found during the check

- `mode.com/sql-tutorial` now redirects to `thoughtspot.com/sql-tutorial`.
- `cloudskillsboost.google` now redirects to `skills.google`.
- `lookerstudio.google.com` now redirects to the "Data Studio" overview (Google renamed it).
- The old edX Stanford URL (`/learn/databases/...`) returns 404. The working one is `/learn/relational-databases/...`.
- The old Skill Builder DEA-C01 course link (`explore.skillbuilder.aws/.../19359/...`) is gone. Use `skillbuilder.aws/exam-prep/data-engineer-associate`.
- `coursera.org/financial-aid` returns 404. Use the Help Center article above.

