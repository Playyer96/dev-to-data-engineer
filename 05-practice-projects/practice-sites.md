# Free Practice Sites (SQL, Python, Kaggle)

Every link was checked with `curl` on 2026-11-21. In the status column:
- **OK**: the page loaded (HTTP 200 or 206).
- **Bot wall**: the site blocks scripts (HTTP 403, Cloudflare) but works in a normal browser.
- **Seasonal**: the site is only up for a few weeks a year.

## The short version (what to actually do)

| Week | Daily 45-min habit | Goal |
|---|---|---|
| 1-2 | SQLBolt, then SQLZoo, then pgexercises | Fluent joins, GROUP BY, subqueries |
| 3-4 | LeetCode SQL 50, plus `sql-drills.md` Q1-26 | Window functions without looking things up |
| 5-6 | DataLemur free questions, StrataScratch free questions, `sql-drills.md` Q27-40 | Interview-grade gaps and islands, funnels, retention |
| 7+ | 3 interview-style SQL problems a day, plus 1 Exercism Python exercise | Keep sharp while you build the portfolio |
| Any | HackerRank SQL (Basic/Intermediate) and Python (Basic) certificates | Free badges to put on LinkedIn |

You already code for a living, so skip the beginner Python tracks. Spend your Python time on **pandas/polars, API pagination, retries, file formats (Parquet, JSON lines) and tests**. Those are the parts of a Data Engineer screen that feel new to a backend developer.

## SQL

| Site | Cost | What it is good for | Status |
|---|---|---|---|
| [LeetCode SQL 50](https://leetcode.com/studyplan/top-sql-50/) | Free (a few problems need Premium) | The standard interview set: 50 problems, joins through window functions. Do all of them. | Bot wall |
| [LeetCode 30 Days of Pandas](https://leetcode.com/studyplan/30-days-of-pandas/) | Free | The same style of problems in pandas, good for DA/DE screens that allow Python | Bot wall |
| [DataLemur](https://datalemur.com/questions) | Free tier (some questions Premium) | Real FAANG analyst questions, with company tags and difficulty filter | OK |
| [DataLemur SQL tutorial](https://datalemur.com/sql-tutorial) | Free | Fast refresher, from basics to window functions | OK |
| [StrataScratch](https://platform.stratascratch.com/coding) | Free tier (limited questions/solutions) | Interview questions from Meta, Airbnb, Uber and others. Filter for "free". | OK |
| [HackerRank SQL](https://www.hackerrank.com/domains/sql) | Free | Large problem bank. Pair it with the certificates below. | OK |
| [HackerRank SQL (Basic) cert](https://www.hackerrank.com/skills-verification/sql_basic) / [Intermediate](https://www.hackerrank.com/skills-verification/sql_intermediate) | Free | A timed test that gives you a shareable certificate | OK |
| [SQLZoo](https://sqlzoo.net/wiki/SQL_Tutorial) | Free | Classic interactive tutorial with clear progression | OK |
| [PostgreSQL Exercises (pgexercises)](https://pgexercises.com/questions/basic/) | Free | Postgres-specific practice: joins, aggregates, recursive queries, date math. Fits your Postgres background. | OK |
| [Advent of SQL](https://adventofsql.com/) | Free | 24 puzzle-style SQL challenges each December. The site timed out (TLS error) on 2026-11-21, which is normal before December. Check again Dec 1. | Seasonal |
| [SQLBolt](https://sqlbolt.com/) | Free | The fastest interactive basics. One afternoon. | OK |
| [SQL Murder Mystery](https://mystery.knightlab.com/) | Free | A fun mystery to solve with queries. Good for a break day. | OK |
| [Select Star SQL](https://selectstarsql.com/) | Free | Interactive book built on a real dataset | OK |
| [sql-practice.com](https://www.sql-practice.com/) | Free | Hospital-database problems from easy to hard, runs in the browser | OK |
| [Lost at SQL](https://lost-at-sql.therobinlord.com/) | Free | Game-style SQL practice | OK |
| [Codewars SQL kata](https://www.codewars.com/kata/search/sql) | Free | Community problems, many tricky ones | OK |
| [Exercism SQLite track](https://exercism.org/tracks/sqlite/exercises) | Free | Small graded SQL exercises. Exercism has no generic "SQL" track (that URL returns 404), so use this one. | OK |
| [W3Resource SQL exercises](https://www.w3resource.com/sql-exercises/) | Free | Large drill bank with answers. Good for repetition. | OK |
| [DuckDB Shell (in-browser)](https://shell.duckdb.org/) | Free | Run `sql-drills.md` with zero install | OK |
| **Local:** [`sql-drills.md`](./sql-drills.md) | Free | 40 drills on a golf-sim schema, every solution tested in DuckDB | n/a |

## Python (data engineering flavored)

| Site | Cost | Use it for | Status |
|---|---|---|---|
| [Exercism Python](https://exercism.org/tracks/python) | Free (with optional human mentoring) | Clean, idiomatic Python and testing habits | OK |
| [HackerRank Python](https://www.hackerrank.com/domains/python) | Free | Quick drills, plus the [Python (Basic) certificate](https://www.hackerrank.com/skills-verification/python_basic) | OK |
| [Kaggle Learn: Python](https://www.kaggle.com/learn/python) / [Pandas](https://www.kaggle.com/learn/pandas) | Free with certificate | Short notebook courses. Skim Python and do Pandas properly. | OK |
| [pandas_exercises (GitHub)](https://github.com/guipsamora/pandas_exercises) | Free | Many pandas notebooks with solutions | OK |
| [Advent of Code](https://adventofcode.com/) | Free | Parsing and algorithm puzzles, each December. Fine for warm-ups. | OK |
| [Practice Python](https://www.practicepython.org/) | Free | Very basic. Skip unless you are rusty. | OK |
| [Polars user guide](https://pola.rs/) | Free | Polars is the fast pandas alternative that more and more DE teams use. Redo a few pandas exercises in Polars. | OK |

## Kaggle (data + courses + public portfolio)

| Link | Why | Status |
|---|---|---|
| [Kaggle Learn](https://www.kaggle.com/learn) | Free micro-courses with certificates: [Intro to SQL](https://www.kaggle.com/learn/intro-to-sql) and [Advanced SQL](https://www.kaggle.com/learn/advanced-sql), which run on BigQuery public data | OK |
| [Kaggle Datasets](https://www.kaggle.com/datasets) | Thousands of datasets. See [`datasets.md`](./datasets.md) for the game and sports ones. | OK |
| [Kaggle Competitions](https://www.kaggle.com/competitions) | Mostly ML. For DA/DE, publishing **notebooks** (EDA, SQL on BigQuery) is worth more than competition rank. | OK |

How to use Kaggle for a DA/DE portfolio:
1. Publish 2 or 3 public notebooks with a clear question, clean SQL/pandas, charts and a written conclusion.
2. Link them from your GitHub README and LinkedIn.
3. Kaggle notebooks can query BigQuery public datasets for free, including the Stack Overflow data used in Project 1 of `portfolio-projects.md`.

## Also worth knowing (free)

| Link | Why | Status |
|---|---|---|
| [dbt Learn catalog](https://learn.getdbt.com/catalog) | Free official dbt courses, including dbt Fundamentals. Needed for portfolio Projects 2 and 4. | OK |
| [DataTalksClub DE Zoomcamp](https://github.com/DataTalksClub/data-engineering-zoomcamp) | Free 9-week DE course covering Docker, Terraform, orchestration, BigQuery, dbt, Spark and Kafka. The free cohort starts each January. | OK |
| [W3Schools SQL exercises](https://www.w3schools.com/sql/sql_exercises.asp) | Ultra-basic syntax checks | OK |
| [SQL Habit](https://www.sqlhabit.com/) | Product-analytics SQL course. Mostly paid, with a few free lessons. | OK |

Skipped on purpose:
- **Interview Query**: mostly paid, and it rate-limited the check (HTTP 429).
- **DataCamp**: paid, and it blocked the check (HTTP 403).
