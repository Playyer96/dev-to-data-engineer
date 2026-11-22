# Resume Reposition: Game/Full-Stack Dev → Data Engineer / Analytics Engineer / Data Analyst

> **The rule for this whole file:** reframe, don't invent. Every bullet below is a *template*.
> Keep a bullet only if you can talk about it for 5 minutes in an interview with real details.
> Anything in `[brackets]` is a number or fact you must fill in from memory, old tickets, repos or Slack history. If you can't fill it in, delete the bracket, or the whole bullet.

---

## 1. Positioning: what story are you telling?

You're not a "game dev who wants to switch". You're a **senior engineer who has been building data-producing systems for 7 years**: event telemetry, analytics logging, physics data checked against real measurements, serverless AWS backends and relational databases. The job switch is about which part of that work you focus on.

| What you did | How a data hiring manager reads it |
|---|---|
| Serverless AWS functions handling gameplay events + analytics logging (Optic Power) | Event ingestion, building a pipeline, defining event schemas, writing logs to cloud storage |
| Golf simulator ball physics (Life is the Game) | Checking simulated output against measured data, tolerance thresholds, numerical accuracy, finding outliers |
| AWS Lambda, API Gateway, Cognito, GameLift | Cloud-native, serverless, IAM/auth, operating production services |
| PostgreSQL, MongoDB in full-stack work | Relational modeling, SQL, indexing, document stores vs. relational |
| React/Next/TS/Node/.NET | Can build internal tools, APIs, data apps and dashboards; strong software-engineering habits (tests, CI, code review) |
| 7 years senior, remote-ready, professional English, Medellín (UTC-5) | Low-risk hire who can talk to stakeholders, working the same hours as US Eastern/Central |

**Which roles to target first (most realistic first):**
1. **Analytics Engineer / Data Engineer at gaming, sports-tech, simulation or IoT companies.** Your domain knowledge is a real advantage there.
2. **Data Engineer (backend-leaning)** at startups that want a Python/SQL/AWS generalist.
3. **Product/Data Analyst** roles with heavy SQL. These are easier to land, and from there you can move into DE.
4. **Backend/Platform engineer on a data team.** These are often mislabeled "Software Engineer, Data". This is a bridge role: you get hired for the skills you have today, and the work moves you toward DE.

---

## 2. New professional summary (pick one, edit to truth)

**Version A: Data Engineer (use once you've built 1–2 pipeline projects)**
> Senior software engineer with 7 years of experience building systems that produce and use event data: serverless AWS backends (Lambda, API Gateway, Cognito) for gameplay event handling and analytics logging, and physics simulations checked against measured real-world data. Now focused on data engineering: SQL, Python, PostgreSQL, data modeling, and reliable batch/event pipelines on AWS. Remote from Medellín, Colombia (UTC-5, fully overlapping US Eastern/Central hours). Professional English.

**Version B: Analytics Engineer / Data Analyst**
> Engineer with 7 years in games and full-stack development, specializing in the data layer: instrumenting analytics events, logging gameplay telemetry through serverless AWS functions, and checking simulated results against measured data. Strong in SQL and PostgreSQL, comfortable turning raw events into clean, tested models and the metrics that stakeholders use. Remote from Colombia, working US hours.

**Version C: Bridge role (backend engineer on a data/platform team)**
> Senior engineer (Unity/Unreal, Node, .NET, React) who has spent 7 years close to the data: event-driven AWS serverless services, analytics logging pipelines, PostgreSQL/MongoDB schemas and validation of simulated data. Looking to own data ingestion and platform work on a product team.

---

## 3. Rewritten experience bullets

Format: **Action verb + what you built + data-flavored nouns + scale/impact.**
Data hiring managers scan for: *events, pipeline, schema, ingestion, validation, SQL, AWS, latency, volume, data quality, stakeholders, metrics.*

### Optic Power: Senior Developer (serverless AWS, gameplay events, analytics logging)

Before (game-dev framing):
- ~~Developed backend functions for the game using AWS.~~

After (pick the ones that are true):
- Designed and shipped **serverless event-handling functions on AWS Lambda behind API Gateway** to process gameplay events in real time for `[N]` daily players / `[N]` events per day.
- Built the **analytics logging path** for gameplay telemetry (session, progression and match events), giving the team the data to `[measure retention / balance gameplay / debug live issues]`.
- Defined **event payload structures** (event name, player/session id, timestamps, context fields), keeping them consistent across clients so the logged data stayed usable for analysis. *(Only if you defined or agreed on the payload format.)*
- Secured event and API endpoints with **Amazon Cognito** auth and IAM roles. Worked with **GameLift** session hosting for multiplayer backends.
- `[If true]` Cut Lambda cost / cold-start latency by `[X]%` by `[batching writes, adjusting memory, reusing connections]`.
- `[If true]` Added structured logging and alarms (`[CloudWatch]`) to find and fix failed events in production.

### Life is the Game: Senior Unity/Unreal Developer (golf simulator ball physics)

Before:
- ~~Implemented realistic golf ball physics in Unity.~~

After (pick the ones that are true):
- Implemented **ball-flight physics models** (launch, spin, drag/lift, bounce/roll) for a commercial golf simulator, turning sensor inputs into simulated trajectories.
- **Checked simulated results against measured data** (`[launch-monitor readings / reference shot data]`), measuring the error in `[carry distance / apex / spin]` and tuning model parameters to within `[X yards / X%]`.
- Wrote **test harnesses / comparison tooling** to run `[N]` reference shots through the model and flag outliers and regressions after physics changes. *(Only if you did. This is your best data-quality story.)*
- Worked with `[hardware / product / QA]` teams to sort out discrepancies between sensor data and simulation output. *(Root-cause analysis on data issues is a core DE skill.)*

### Independent Full-Stack Developer (React/Next/TS/Node/.NET, PostgreSQL, MongoDB)

- Designed **relational schemas in PostgreSQL** (normalization, keys, indexes, migrations) for `[N]` client applications. Chose between PostgreSQL and MongoDB based on how the data was accessed.
- Wrote and optimized **SQL queries** for `[reporting / admin dashboards / search]`, bringing `[query X]` from `[A]` to `[B]` ms with `[indexes / query rewrites]`. *(Only with real numbers, or drop the numbers.)*
- Built **REST APIs** (Node/.NET) and **internal dashboards** (React/Next.js) that show business data to non-technical clients.
- Owned delivery end to end: requirements with clients, deployment, monitoring. This shows you can work with stakeholders.

### Projects section (add ONLY once built and on GitHub)

Projects are the bridge that makes the title change believable. Ideas that build on your background (plan them in `05-practice-projects/`):
- **Golf shot telemetry pipeline:** synthetic or public shot data → S3 → Python ingestion → PostgreSQL/DuckDB → dbt models (fact_shots, dim_player, dim_club) → dashboard. Include data tests and a "simulated vs. measured" comparison mart.
- **Game event analytics warehouse:** a public game dataset → event schema → star schema → retention/funnel SQL → Metabase/Superset dashboard.
- **Serverless ingestion on AWS:** API Gateway → Lambda → Kinesis Firehose/S3 → Athena, with IaC. You already know most of this stack, so this one should come together fastest.

Each project README should have: an architecture diagram, how to run it, the data model, data-quality checks, and "what I'd do at 100x scale".

---

## 4. Skills section: honest now vs. add later

### List NOW (you have real production experience)
- **Languages:** C#, C++, TypeScript/JavaScript, SQL (PostgreSQL)
- **Cloud (AWS):** Lambda, API Gateway, Cognito, GameLift, IAM basics, CloudWatch *(only if used)*
- **Databases:** PostgreSQL, MongoDB
- **Backend/Web:** Node.js, .NET, React, Next.js, REST APIs
- **Practices:** event-driven / serverless design, data validation against measured data, debugging in production, Git, code review

### Add ONLY after you've actually learned it and used it in a project you can show

| Skill | Add it when you can... |
|---|---|
| **Python** (pandas, requests, pytest) | Write an ingestion script with error handling and tests, and solve pandas interview questions without looking things up |
| **Advanced SQL** (window functions, CTEs, gaps-and-islands) | Solve DataLemur/StrataScratch medium questions comfortably |
| **dbt** | Have a dbt project with sources, staging/marts, tests and docs on GitHub |
| **Airflow / Dagster / Prefect** | Have scheduled a real DAG with retries and backfills |
| **Snowflake / BigQuery / Redshift / Databricks** | Have loaded data into one and modeled it (free trials or sandbox) |
| **Spark / PySpark** | Have processed a dataset with DataFrame ops and understand partitions and shuffles |
| **Kafka / Kinesis** | Have built a producer→consumer flow end to end |
| **AWS data services:** S3, Glue, Athena, Firehose, Step Functions | Have used them in a project (an easy add given your AWS background) |
| **Docker** | Can containerize your pipeline *(may already be true; list it if so)* |
| **Terraform / CDK** | Have deployed your project's infra with it |
| **BI:** Metabase, Superset, Looker, Power BI, Tableau | Have published a dashboard from your models |
| **Certs:** AWS Certified Data Engineer – Associate, dbt Analytics Engineering, Databricks DE Associate | Have passed the exam. Never write "in progress" unless the exam is booked |

> ATS tip: write tool names exactly the way job descriptions do ("Amazon Redshift", "Apache Airflow", "dbt"). ATS matches literal keywords.

---

## 5. LinkedIn

### Headline options (220 char max)

**Now (honest, before new skills):**
> Senior Software Engineer → Data Engineering | SQL · PostgreSQL · AWS Serverless (Lambda, API Gateway) | 7 yrs building event telemetry & data-validated simulations | Remote · Colombia (US hours)

**After 1–2 projects + Python/dbt:**
> Data Engineer | Python · SQL · dbt · AWS (Lambda, S3, Athena) · PostgreSQL | Event pipelines & data quality, ex-game telemetry | Remote from Colombia, US time zones

**Analyst-leaning variant:**
> Analytics Engineer / Data Analyst | SQL · PostgreSQL · dbt · Python | Turning event data into metrics | 7 yrs engineering in games & full-stack | Remote, US hours

### About section draft (edit to truth, ~1,500 chars)

> For 7 years I've built software that produces data, and I've increasingly been the person who makes sure that data is right.
>
> At **Optic Power** I built serverless AWS functions (Lambda, API Gateway, Cognito) that handled gameplay events and wrote analytics logs. That's the plumbing that tells a game team what players actually do. At **Life is the Game** I worked on the ball-flight physics of a golf simulator, where "correct" meant matching real measured shot data, and checking simulated results against reality was the job. As an independent full-stack developer I've designed PostgreSQL and MongoDB data models and the APIs and dashboards built on them.
>
> Now I'm focusing my career on **data engineering and analytics engineering**: building reliable pipelines, clean data models and tested metrics. I'm working in `[Python, SQL, dbt, Airflow, AWS data services]`. You can see my projects at `[github link]`.
>
> What I bring:
> • Production engineering habits: testing, monitoring, debugging live systems
> • Cloud-native AWS experience
> • A habit of checking data against ground truth before trusting it
> • Clear communication in English with technical and non-technical teams
>
> Based in Medellín, Colombia (UTC-5), fully overlapping with US Eastern/Central hours. Open to remote Data Engineer, Analytics Engineer and Data Analyst roles.
>
> `[email]` · `[GitHub]` · `[portfolio]`

### Other LinkedIn settings
- **Open to Work:** set to "Recruiters only" (private). Add job titles: Data Engineer, Analytics Engineer, Data Analyst, Software Engineer (Data). Location: Remote + United States + Latin America.
- **Featured:** pin your best pipeline project, plus one post about data validation in simulations.
- **Skills:** LinkedIn allows 100. Put SQL, PostgreSQL, AWS Lambda and Data Modeling in your top 3 now. Add Python/dbt/Airflow when they're earned.
- **Experience entries:** rewrite them with the bullets above. Recruiters search experience text.
- **Custom URL:** `linkedin.com/in/<your-name>` and the same handle on GitHub.

---

## 6. Resume format checklist
- [ ] 1 page (2 max for 7 yrs). Plain single-column layout so ATS can parse it. Export to PDF from Google Docs/Word. No tables or icons for core content.
- [ ] Title line at top that matches the target: "Data Engineer" / "Analytics Engineer". Make the summary say *transitioning* if you haven't held the title. Never fake a past job title.
- [ ] Contact line: email · LinkedIn · GitHub · "Medellín, Colombia, Remote (UTC-5)".
- [ ] Data-flavored bullets first in each role. Gameplay-only bullets get cut or moved to the bottom.
- [ ] Projects section above Education once projects exist.
- [ ] Keep one master resume plus 3 variants (DE / AE / DA). Adjust 3–5 keywords per application to match the JD.
- [ ] Run each variant against a real JD with a free ATS checker (e.g., Jobscan free tier, or paste both into an LLM and ask which keywords are missing).
