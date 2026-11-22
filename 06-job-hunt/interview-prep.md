# Interview Prep: Data Engineer / Analytics Engineer / Data Analyst

> Links checked 2026-11-21 (OK = loaded; CF/429 = live but blocks scripted checks).
> SQL examples are PostgreSQL. Swap functions for Snowflake/BigQuery as needed.

---

## 1. The typical loop

| Stage | DE | AE | DA | What they're testing |
|---|---|---|---|---|
| Recruiter screen (20–30 min) | ✔ | ✔ | ✔ | Story, English, comp, timezone, work eligibility (contractor?) |
| Hiring-manager screen (30–45 min) | ✔ | ✔ | ✔ | Why data, past projects, depth on one system you built |
| Technical screen: live SQL (45–60 min) | ✔ | ✔ | ✔ | Joins, aggregations, window functions, edge cases (NULLs, dupes) |
| Technical: Python/pandas or coding (45–60 min) | ✔ | sometimes | sometimes | Data wrangling, parsing, dicts/lists, sometimes LeetCode easy/medium |
| Take-home (2–6 h) | often | often | often | Clean code, modeling, tests, README, judgment |
| Data modeling (45–60 min) | ✔ | ✔✔ | sometimes | Star schema, grain, SCDs, metrics definitions |
| Pipeline / system design (45–60 min) | ✔✔ | ✔ | rare | Batch vs stream, idempotency, backfills, quality, cost |
| Behavioral (45 min) | ✔ | ✔ | ✔ | STAR stories: ownership, conflict, ambiguity, failure |
| Product/business case | rare | ✔ | ✔✔ | Metric design, A/B test reading, "why did DAU drop?" |

Your pitch for "why are you moving to data?" (60 seconds, rehearse it):
> "For 7 years the parts of my work I enjoyed most were the data parts: building the serverless AWS functions that logged gameplay events at Optic Power, and checking our golf ball-flight simulation against measured shot data at Life is the Game. I realized the work I want to own is making data reliable and useful, not the gameplay layer. So I've been building on that: `[Python, dbt, Airflow, project X]`. I bring production engineering habits that a lot of career switchers into data don't have yet."

---

## 2. Top SQL questions, with answer outlines

Practice platforms: DataLemur https://datalemur.com/sql-interview-questions (OK) · StrataScratch https://www.stratascratch.com/ (OK) · LeetCode Top SQL 50 https://leetcode.com/studyplan/top-sql-50/ (CF) · PostgreSQL Exercises https://pgexercises.com/ (OK) · SQLBolt https://sqlbolt.com/ (OK) · Kaggle Advanced SQL https://www.kaggle.com/learn/advanced-sql (OK) · Window functions reference https://neon.com/postgresql/window-function (OK; ex-postgresqltutorial.com)

**Always say out loud:** the grain of each table, how you handle NULLs, duplicates and ties, and how you'd check the result (row counts).

### Q1. Top N per group: "top 3 highest-scoring players per country"
```sql
SELECT *
FROM (
  SELECT player_id, country, score,
         DENSE_RANK() OVER (PARTITION BY country ORDER BY score DESC) AS rnk
  FROM players
) t
WHERE rnk <= 3;
```
Talk about **ROW_NUMBER vs RANK vs DENSE_RANK** (ties!). Ask which one they want.

### Q2. Second-highest value (classic)
```sql
SELECT MAX(salary) FROM employees
WHERE salary < (SELECT MAX(salary) FROM employees);
-- or: DENSE_RANK() = 2; returns NULL/empty when no 2nd value exists. Mention it.
```

### Q3. Running total / moving average
```sql
SELECT event_date, revenue,
       SUM(revenue) OVER (ORDER BY event_date) AS running_total,
       AVG(revenue) OVER (ORDER BY event_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS ma_7d
FROM daily_revenue;
```
Explain the `ROWS` vs `RANGE` frame and what missing dates do (fill them with a date spine via `generate_series`).

### Q4. Period-over-period change (LAG)
```sql
SELECT month, revenue,
       revenue - LAG(revenue) OVER (ORDER BY month) AS mom_change,
       ROUND(100.0 * (revenue - LAG(revenue) OVER (ORDER BY month))
             / NULLIF(LAG(revenue) OVER (ORDER BY month), 0), 2) AS mom_pct
FROM monthly_revenue;
```
`NULLIF(..., 0)` avoids division-by-zero. Point it out.

### Q5. Deduplicate: keep the latest record per key
```sql
SELECT * FROM (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY event_id ORDER BY ingested_at DESC) AS rn
  FROM raw_events
) t WHERE rn = 1;
```
This is the core move for at-least-once event delivery (Lambda retries!). Tie it to your Optic Power experience.

### Q6. Gaps & islands: "longest streak of consecutive login days per user"
```sql
WITH d AS (SELECT DISTINCT user_id, login_date::date AS day FROM logins),
g AS (
  SELECT user_id, day,
         day - (ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY day))::int AS grp
  FROM d
)
SELECT user_id, MAX(streak) AS longest_streak
FROM (SELECT user_id, grp, COUNT(*) AS streak FROM g GROUP BY user_id, grp) s
GROUP BY user_id;
```
Key insight: date minus row_number stays constant within a consecutive run.

### Q7. Retention / cohort: "% of users active 7 days after signup"
```sql
SELECT DATE_TRUNC('week', u.signup_date) AS cohort,
       COUNT(DISTINCT u.user_id) AS users,
       COUNT(DISTINCT e.user_id) AS retained_d7,
       ROUND(100.0 * COUNT(DISTINCT e.user_id) / COUNT(DISTINCT u.user_id), 1) AS pct
FROM users u
LEFT JOIN events e
  ON e.user_id = u.user_id
 AND e.event_date::date = u.signup_date::date + 7
GROUP BY 1 ORDER BY 1;
```
Clarify first: "day 7 exactly" vs "within 7 days"? LEFT JOIN so you keep users who didn't come back.

### Q8. Funnel conversion with conditional aggregation
```sql
SELECT COUNT(DISTINCT user_id) FILTER (WHERE event = 'view')     AS viewed,
       COUNT(DISTINCT user_id) FILTER (WHERE event = 'add_cart') AS carted,
       COUNT(DISTINCT user_id) FILTER (WHERE event = 'purchase') AS purchased
FROM events;
-- Portable version: COUNT(DISTINCT CASE WHEN event='view' THEN user_id END)
```
Follow-up: enforce order (view before purchase) with per-user `MIN(ts)` per step.

### Q9. Sessionization: new session after 30 min of inactivity
```sql
WITH x AS (
  SELECT *, CASE WHEN ts - LAG(ts) OVER (PARTITION BY user_id ORDER BY ts)
                     > INTERVAL '30 minutes'
                  OR LAG(ts) OVER (PARTITION BY user_id ORDER BY ts) IS NULL
            THEN 1 ELSE 0 END AS new_session
  FROM events
)
SELECT *, SUM(new_session) OVER (PARTITION BY user_id ORDER BY ts) AS session_id
FROM x;
```
Gameplay telemetry is exactly this. Use it as your "I've lived this" moment.

### Q10. Customers with no orders / anti-join
```sql
SELECT c.* FROM customers c
LEFT JOIN orders o ON o.customer_id = c.id
WHERE o.id IS NULL;           -- or NOT EXISTS (preferred; NOT IN breaks on NULLs)
```

### Q11. Median / percentiles
```sql
SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY carry_yards) AS median_carry
FROM shots;
```

### Q12. Pivot: rows → columns
```sql
SELECT player_id,
       SUM(CASE WHEN club = 'driver' THEN 1 ELSE 0 END) AS driver_shots,
       SUM(CASE WHEN club = 'iron7'  THEN 1 ELSE 0 END) AS iron7_shots
FROM shots GROUP BY player_id;
```

### Q13. Self-join: "employees earning more than their manager"
```sql
SELECT e.name FROM employees e
JOIN employees m ON e.manager_id = m.id
WHERE e.salary > m.salary;
```

### Q14. Concepts they ask verbally
- `WHERE` vs `HAVING`, and the logical order of execution (FROM → JOIN → WHERE → GROUP BY → HAVING → SELECT → window → ORDER BY → LIMIT)
- `UNION` vs `UNION ALL` (dedupe cost)
- INNER / LEFT / FULL / CROSS joins. Fan-out: a join that multiplies rows and inflates SUMs
- `COUNT(*)` vs `COUNT(col)` vs `COUNT(DISTINCT col)`
- Indexes (B-tree), when they don't help, reading `EXPLAIN ANALYZE`. You have real Postgres experience here: use it
- CTE vs subquery vs temp table. Partitioning and clustering in warehouses
- OLTP (Postgres) vs OLAP (columnar: Snowflake/BigQuery/Redshift). Why columnar is fast for aggregates

---

## 3. Python / pandas questions

Resources: pandas "10 minutes" https://pandas.pydata.org/docs/user_guide/10min.html (OK) · Kaggle pandas https://www.kaggle.com/learn/pandas (OK) · StrataScratch has pandas versions of SQL questions.

| Question | Answer outline |
|---|---|
| Group & aggregate: "avg score per country, top 5" | `df.groupby('country')['score'].mean().nlargest(5)`. Use `.agg({...})` for several metrics |
| Merge two DataFrames, find unmatched rows | `pd.merge(a, b, on='id', how='left', indicator=True)` then filter `_merge == 'left_only'` |
| Dedupe keeping latest | `df.sort_values('ts').drop_duplicates('event_id', keep='last')` |
| Missing values | `isna().sum()`, then decide: `fillna`, `dropna`, or flag. **Explain the business reason** for your choice |
| Window-like ops | `groupby('user')['ts'].diff()`, `.cumsum()`, `.rank()`, `.rolling(7).mean()`, `.shift()` |
| Pivot | `pd.pivot_table(df, index='player', columns='club', values='carry', aggfunc='mean')` |
| Flatten nested JSON events | `pd.json_normalize(records, sep='_')`. Lists → `.explode()` |
| Date handling | `pd.to_datetime(..., utc=True)`, `.dt.floor('D')`, `resample('D')`. Always talk about time zones |
| File too big for memory | `pd.read_csv(..., chunksize=100_000)`, select `usecols`, downcast dtypes, `category` dtype. Or use DuckDB/Polars/Spark |
| Pure Python: count events per user from a log file | Iterate line by line (a generator), `collections.Counter` / `defaultdict(int)`. O(n) time, O(users) memory |
| Pure Python: parse & validate records | `try/except` per record, send bad rows to a dead-letter list or file, count and log them. **Never silently drop data** |
| Call a paginated API | Loop on `next` cursor, retries with exponential backoff, rate limits, idempotent writes |
| Testing | `pytest` with small fixtures; test the transformation functions, not the I/O |

Typical live exercise: *"Here's a CSV of game events. Compute daily active users and average session length."* Steps: load → parse timestamps → dedupe → sessionize (diff > 30 min) → aggregate → state your assumptions out loud.

---

## 4. Data modeling

Resources: Kimball dimensional modeling techniques https://www.kimballgroup.com/data-warehouse-business-intelligence-resources/kimball-techniques/dimensional-modeling-techniques/ (OK) · dbt best practices https://docs.getdbt.com/best-practices (OK)
Book: *The Data Warehouse Toolkit* (Kimball & Ross), chapters 1–3 are enough for interviews.

### The 4-step Kimball process (say these steps when you answer)
1. **Pick the business process** (e.g., "a golfer hits a shot").
2. **Declare the grain**: "one row per shot". *The grain is the most important sentence in the interview.*
3. **Identify dimensions**: who/what/where/when: player, club, course/bay, device, date, time.
4. **Identify facts**: numeric measurements at that grain: ball speed, launch angle, spin, carry, measured vs simulated deviation.

### Star schema: worked example (use your domain)
```
                 dim_player (player_key, player_id, name, handicap, country, valid_from, valid_to, is_current)
                       |
dim_date ─── fact_shot (shot_id, date_key, player_key, club_key, device_key, session_id,
                       ball_speed_mph, launch_deg, spin_rpm, carry_sim_yd, carry_measured_yd,
                       carry_error_yd)
                       |                 |
              dim_club (club_key...)   dim_device (device_key, model, firmware_version)
```
- **Star vs snowflake**: star = denormalized dims, fewer joins, BI-friendly. Snowflake = normalized dims, less redundancy, more joins. Default to star in a modern warehouse, where storage is cheap.
- **Fact types**: transaction (one row per event), periodic snapshot (daily balance), accumulating snapshot (order lifecycle with several date columns), factless (attendance/eligibility).
- **Surrogate keys** vs natural keys: why (SCD2, multiple source systems, joining on integers).
- **Conformed dimensions**: the same `dim_player` shared across several fact tables.
- **Additive / semi-additive / non-additive** facts: you can sum revenue; account balance can't be summed across time; ratios can't be summed at all.
- One Big Table (OBT) vs star: OBT is common in modern BI. Know the tradeoffs (simpler queries vs duplication and harder changes).

### Slowly Changing Dimensions (SCD)
| Type | Behavior | Example |
|---|---|---|
| **0** | Never changes | Date of birth, original signup date |
| **1** | Overwrite, no history | Fixing a typo in a name |
| **2** | New row per change, with `valid_from`, `valid_to`, `is_current` | Player changes country/handicap and you want history to stay accurate |
| **3** | Extra column for the previous value | `current_region`, `previous_region` |
| **4** | History in a separate table | Rapidly changing attributes |
| **6** | 1+2+3 hybrid | Current value on every historical row + full history |

**SCD2 logic outline** (dbt does this for you with `snapshots`):
1. Compare incoming rows with current dimension rows on the natural key, using a hash of the tracked columns.
2. Changed rows: set `valid_to = now(), is_current = false` on the old row, then insert a new row with `valid_from = now(), valid_to = NULL/'9999-12-31', is_current = true`.
3. New keys: insert. Deleted keys: soft-delete flag.
4. The fact table joins on `player_key` *as of event time*: `fact.ts BETWEEN dim.valid_from AND COALESCE(dim.valid_to, 'infinity')`.

### Modeling questions to rehearse
- "Model a ride-sharing / e-commerce / game-events app." Answer with grain → facts → dims → 2 example queries.
- "How do you handle late-arriving facts/dimensions?" Placeholder "unknown" dim member (key -1), then fix it on the next run.
- "Normalization (3NF) vs dimensional?" OLTP vs analytics, writes vs reads.
- "How would you define DAU / retention / session so that everyone agrees?" A semantic/metrics layer, documented definitions.
- dbt layering: `staging` (1:1 with source, rename/cast) → `intermediate` → `marts` (facts/dims). Plus tests: `unique`, `not_null`, `relationships`, `accepted_values`.

---

## 5. Pipeline system design

Resources: DE Zoomcamp https://github.com/DataTalksClub/data-engineering-zoomcamp (OK) · Data Engineer Handbook https://github.com/DataExpert-io/data-engineer-handbook (OK) · System Design Primer https://github.com/donnemartin/system-design-primer (OK) · AWS Analytics Lens https://docs.aws.amazon.com/wellarchitected/latest/analytics-lens/analytics-lens.html (OK) · Start Data Engineering https://www.startdataengineering.com/ (OK)
Book: *Designing Data-Intensive Applications* (Kleppmann): ch. 1, 3, 10, 11.

### Answer framework (use it every time)
1. **Clarify requirements**: who uses the data, for what decisions, how fresh (seconds / minutes / daily?), volume (events/day, GB/day), retention, SLAs, PII/compliance.
2. **Sources & ingestion**: APIs, DB (CDC), event streams, files. Push vs pull. Batch vs streaming, and *justify* the choice.
3. **Storage layers**: raw/bronze (immutable, replayable) → cleaned/silver → modeled/gold marts. Lake (S3 + Parquet/Iceberg) vs warehouse.
4. **Transformation**: SQL/dbt in the warehouse vs Spark for heavy jobs. Where business logic lives.
5. **Orchestration**: Airflow/Dagster/Step Functions. Dependencies, retries, alerting.
6. **Data quality**: schema validation at ingestion, dbt tests, row-count/freshness checks, anomaly alerts, dead-letter queues.
7. **Reliability**: **idempotency** (re-running a day gives the same result: MERGE/overwrite partition), **backfills**, late data, exactly-once vs at-least-once + dedupe.
8. **Serving**: BI tool, reverse ETL, APIs, ML features.
9. **Ops**: monitoring, lineage, cost (partitioning, file sizes, compute auto-suspend), security (IAM, encryption, PII masking).
10. **Scale it**: "what changes at 100x?"

### Prompt A: "Design a pipeline for game telemetry events" (your home turf)
- **Ingest:** game clients → API Gateway → Lambda (validate schema, add server timestamp) → Kinesis Data Streams / Firehose → S3 raw (partitioned by `dt=/hour=`, Parquet). *Mention you've built the Lambda/API Gateway/Cognito part.*
- **Schema:** versioned event envelope `{event_id (UUID), event_name, schema_version, player_id, session_id, client_ts, server_ts, payload}`. Use a schema registry or JSON Schema checks. Unknown versions go to quarantine.
- **Dedupe:** at-least-once delivery means `event_id` dedupe in silver (Q5 pattern).
- **Clock skew:** trust `server_ts` for partitioning and keep `client_ts` for analysis.
- **Transform:** dbt on Athena/Redshift/Snowflake: `stg_events` → `fct_sessions` (sessionization) → `fct_daily_active_players`, retention marts.
- **Real-time needs** (live ops dashboard): a streaming aggregation (Kinesis Analytics/Flink) or a materialized view in a real-time store. Everything else batch hourly. Explain the cost tradeoff.
- **Quality:** freshness alerts per event type, volume anomaly detection (a drop in `match_end` events = client bug), null-rate checks.

### Prompt B: "Replicate our Postgres app DB into the warehouse for analytics"
- Full daily snapshot (simple, small tables) vs **CDC** (Debezium → Kafka, or AWS DMS) for large or frequently changing tables.
- Land raw change logs → apply MERGE into silver → SCD2 snapshots where history matters.
- Avoid hammering the primary: use a read replica. Handle schema changes (alert, then evolve). Hard deletes come through CDC, not snapshots.

### Prompt C: "Daily report from a third-party REST API"
- Scheduled job (Airflow/Lambda + EventBridge) → paginate + backoff → write raw JSON to S3 by `ingest_date` → load/transform → mart → dashboard.
- Idempotency: overwrite the day's partition. Backfill by parameterizing the date. Secrets in Secrets Manager. Alert on empty pulls.

### Prompt D: "Validate sensor/measured data against a model" (your differentiator)
- Join simulated output with ground-truth measurements on `shot_id`. Compute error metrics (MAE, % error, p95). Set tolerance thresholds per metric. Flag regressions per firmware or model version. Publish a dashboard + alert. This is your Life is the Game story told as a data-quality system.

### Concepts to have one-liners for
Batch vs streaming · Lambda vs Kappa architecture · ETL vs ELT · data lake vs warehouse vs lakehouse · Parquet/columnar + compression · partitioning vs clustering · small-files problem · exactly-once semantics · idempotency · backfill · CDC · schema evolution · data contracts · orchestration vs scheduling · lineage · data observability · Spark basics (partitions, shuffle, skew, broadcast join).

---

## 6. STAR stories mapped to your background

Prepare **6 stories**, 2 minutes each. Format: **S**ituation (1 line) → **T**ask (1 line) → **A**ction (60% of the time, "I" not "we") → **R**esult (a number if you have one) → what you learned.
Fill the brackets with real details. If a detail isn't real, don't use it. Pick a different story.

| # | Theme (common questions) | Your story seed | Data angle to emphasize |
|---|---|---|---|
| 1 | **Data quality / attention to detail**: "Tell me about a time you found bad data" | Life is the Game: simulated ball flight didn't match measured shot data for `[case]` | How you measured the gap, found the root cause `[spin model? sensor noise? units?]`, set tolerances, verified the fix |
| 2 | **Built something end to end / ownership** | Optic Power: serverless gameplay event handling + analytics logging on Lambda/API Gateway | Design choices, failure handling, retries/duplicates, who used the data |
| 3 | **Production incident / debugging under pressure** | `[A live outage, failed event logging, or a Lambda/GameLift issue you fixed]` | Detection, mitigation, root cause, the monitoring you added afterwards |
| 4 | **Stakeholder communication / translating requirements** | Freelance full-stack: a client asked for a report/dashboard. You turned vague needs into a PostgreSQL schema + UI | Asking "what decision will this support?", defining metrics |
| 5 | **Performance / optimization** | `[A slow Postgres query, a Lambda cost/latency fix, or physics frame-time optimization]` | Profiling first, measured before/after |
| 6 | **Learning fast / ambiguity**: "Why the switch?", "Tell me about learning a new technology" | Learning the DE stack: `[project]` built in `[weeks]` | Self-directed, shipped it, what you'd improve |
| + | **Conflict / disagreement** | `[A disagreement on physics accuracy vs. game feel, or tech choices]` | Using data to settle it, staying respectful |
| + | **Failure** | `[A real mistake]` | Owning it + the safeguard you put in place |

Behavioral reference: Tech Interview Handbook https://www.techinterviewhandbook.org/behavioral-interview/ (OK). If you interview at Amazon, map stories to the Leadership Principles: https://www.amazon.jobs/content/en/our-workplace/leadership-principles (OK).

Questions to ask *them* (pick 3):
- "What does the data stack look like today, and what's the biggest pain point?"
- "How do you handle data quality: who gets paged when a pipeline breaks?"
- "What would success look like in my first 90 days?"
- "How is the data team split between platform, analytics engineering and analysts?"
- "How does the team work with people in LATAM time zones?"

---

## 7. Take-home tips
1. **Confirm scope and time box** in writing. Ask questions early; it counts as signal.
2. **README first**: how to run it (one command: `make run` / `docker compose up`), assumptions, design decisions, tradeoffs, what you'd do with more time.
3. **Show the data checks you did**: row counts in/out, nulls, duplicates, schema checks. Show what you found in the data, not only the final numbers.
4. **Structure**: `src/` (extract/transform/load as small pure functions), `tests/` (pytest on transforms), `sql/` or a dbt project, a `data/` sample, `requirements.txt`/`pyproject.toml`.
5. **Idempotent & re-runnable**: running twice must not double-load.
6. **Clean commits** with a readable history. Type hints, docstrings where they help, a linter (ruff).
7. **Answer the business question explicitly** at the end ("Retention dropped 4 pts in week 3, driven by X").
8. **Don't over-engineer** (no Kubernetes for a CSV). But include a short "at scale I would…" section.
9. Prepare to **walk through it live** and extend it. They often ask "add a new field / handle late data".
10. Don't spend 3× the suggested time. If you go over, say so in the README.

---

## 8. Free prep resources

| Resource | Link | Status | Use for |
|---|---|---|---|
| DataLemur (free tier) | https://datalemur.com/ | OK | SQL interview questions by company |
| StrataScratch (free tier) | https://www.stratascratch.com/ | OK | SQL + pandas real interview questions |
| LeetCode Top SQL 50 | https://leetcode.com/studyplan/top-sql-50/ | CF | Classic SQL drills |
| PostgreSQL Exercises | https://pgexercises.com/ | OK | Postgres-specific practice |
| SQLBolt | https://sqlbolt.com/ | OK | Quick refresher |
| SQL Practice | https://www.sql-practice.com/ | OK | Browser-based drills |
| SQL tutorial (ex-Mode) | https://www.thoughtspot.com/sql-tutorial | OK | `mode.com/sql-tutorial` redirects here. Analytics SQL |
| Kaggle Learn: Advanced SQL / Pandas | https://www.kaggle.com/learn/advanced-sql · https://www.kaggle.com/learn/pandas | OK | Short free courses |
| DE Zoomcamp (DataTalks.Club) | https://github.com/DataTalksClub/data-engineering-zoomcamp | OK | Full free DE course: Docker, Terraform, orchestration, dbt, Spark, Kafka |
| Data Engineer Handbook | https://github.com/DataExpert-io/data-engineer-handbook | OK | Curated links, interview section |
| DE interview questions (GitHub) | https://github.com/OBenner/data-engineering-interview-questions | OK | Large question bank |
| Data science interviews (theory Qs) | https://github.com/alexeygrigorev/data-science-interviews | OK | Analyst/stats-side questions |
| dbt Learn (free courses) | https://learn.getdbt.com/catalog | OK | dbt Fundamentals |
| dbt best practices | https://docs.getdbt.com/best-practices | OK | Project structure for AE interviews |
| Kimball techniques | https://www.kimballgroup.com/data-warehouse-business-intelligence-resources/kimball-techniques/dimensional-modeling-techniques/ | OK | Modeling vocabulary |
| Data Engineering Wiki | https://dataengineering.wiki/ | OK | Concept definitions |
| r/dataengineering wiki | https://www.reddit.com/r/dataengineering/wiki/index/ | OK | Community FAQ, learning paths |
| Start Data Engineering | https://www.startdataengineering.com/ | OK | Practical pipeline articles |
| Seattle Data Guy (newsletter) | https://seattledataguy.substack.com/ | OK | Industry + career advice |
| Data Engineering Central (newsletter) | https://dataengineeringcentral.substack.com/ | OK | Practical DE posts |
| System Design Primer | https://github.com/donnemartin/system-design-primer | OK | General system-design fundamentals |
| Tech Interview Handbook: behavioral | https://www.techinterviewhandbook.org/behavioral-interview/ | OK | STAR prep |
| Interview Query (partly free) | https://www.interviewquery.com/ | 429 (live) | Analyst/product case questions |
| roadmap.sh SQL | https://roadmap.sh/sql | OK | Checklist of SQL topics |

Certs worth considering (paid exams; list them only once you've passed):
- AWS Certified Data Engineer – Associate: https://aws.amazon.com/certification/certified-data-engineer-associate/ (OK). Best fit given your AWS background.
- dbt Analytics Engineering certification: https://www.getdbt.com/certifications/analytics-engineer-certification-exam (OK)

---

## 9. Two-week sprint before your first technical screens
| Day | Focus |
|---|---|
| 1–3 | SQL: Q1–Q14 above from memory, then 5 DataLemur easy/medium per day |
| 4–5 | pandas: redo 10 SQL questions in pandas |
| 6–7 | Modeling: draw 3 star schemas (game events, e-commerce, ride-share) and explain SCD2 out loud |
| 8–9 | System design: practice Prompts A–D out loud, 30 min each, recorded |
| 10–11 | STAR: write all 6 stories, say them out loud, cut each to 2 min |
| 12–13 | Mock interviews (a peer from DataTalks.Club / dbt Slack, or record yourself) |
| 14 | Review your weak spots, rest |
