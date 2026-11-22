# Books: reading order (Data Analyst / Data Engineer)

For a senior dev moving fast. Free means author-hosted, open-licensed, or an official free edition. Every link was checked on 2026-11-21 (HTTP 200/206 unless noted).
Local PDFs are in `pdfs/`.

## Core track (all free)

| # | Book | Why / what to read | Free status | Link |
|---|------|--------------------|-------------|------|
| 1 | **Python for Data Analysis, 3e** (Wes McKinney) | pandas from the person who wrote it. Read ch. 4-11 and skip the Python basics. | Official "Open Access" HTML edition on the author's site (no copying allowed; code is MIT) | https://wesmckinney.com/book/ |
| 2 | **Use The Index, Luke** (Markus Winand) | SQL indexing and query tuning: B-trees, joins, pagination. Short and dense. | Free web edition of *SQL Performance Explained* (PDF/paperback are paid) | https://use-the-index-luke.com/ |
| 3 | **PostgreSQL Documentation** | Part I Tutorial, Part II "The SQL Language" (window functions, CTEs), ch. 14 "Performance Tips". | Official, free (HTML + PDF) | https://www.postgresql.org/docs/current/ , PDFs: https://www.postgresql.org/docs/ |
| 4 | **Think Stats, 3e** (Allen Downey) | Hands-on stats in Python/pandas. The fastest stats on-ramp for a programmer. | CC BY-NC-SA 4.0. 3e is online (HTML/notebooks); the 2e PDF is downloaded | https://allendowney.github.io/ThinkStats/ (2e PDF: https://greenteapress.com/thinkstats2/thinkstats2.pdf) |
| 5 | **OpenIntro Statistics, 4e** (Diez, Cetinkaya-Rundel, Barr) | Proper intro stats: inference, hypothesis tests, regression. Use it as a reference next to Think Stats. | CC BY-SA. Free PDF from openintro.org (main PDF is "pay what you want, $0 OK" via Leanpub; the screen-reader PDF is a direct download) | https://www.openintro.org/book/os/ |
| 6 | **The Data Engineering Cookbook** (Andreas Kretz) | A map of the DE landscape: pipelines, tools, case studies, interview topics. | Apache-2.0, on GitHub (markdown sections, no PDF in the repo anymore) | https://github.com/andkret/Cookbook |
| 7 | **Kimball Dimensional Modeling Techniques** (Kimball Group) | The free official summary of star schemas, SCDs and fact/dimension patterns. Read this before or instead of the paid book. | Free on the official Kimball Group site | https://www.kimballgroup.com/data-warehouse-business-intelligence-resources/kimball-techniques/dimensional-modeling-techniques/ |
| 8 | **Apache Spark official docs** | Start with the SQL/DataFrame guide and the Structured Streaming guide. | Apache-2.0, official | https://spark.apache.org/docs/latest/ |
| 9 | **Databricks: Big Book of Data Engineering** | Practical lakehouse, Delta and streaming pipeline patterns. | Official free ebook; you fill in a registration form yourself (not downloaded here) | https://www.databricks.com/resources/ebook/big-book-of-data-engineering |
| 10 | **Delta Lake docs** | Table format: ACID, time travel, MERGE. Pairs with the Delta Lake paper. | Official, open source | https://delta.io/ |

## Optional / branch-specific (free)

| Book | When | Free status | Link |
|------|------|-------------|------|
| **An Introduction to Statistical Learning with Python (ISLP)** (James, Witten, Hastie, Tibshirani, Taylor) | If you lean toward analytics/ML (regression, classification, CV). | Free PDF from the authors (statlearning.com, then the Stanford download page). R edition (ISLR2) is free too | https://www.statlearning.com/ |
| **R for Data Science, 2e** (Wickham, Cetinkaya-Rundel, Grolemund) | Only if your target job uses R/tidyverse. | Free online edition (CC BY-NC-ND) | https://r4ds.hadley.nz/ |
| **Think Python, 3e** (Allen Downey) | Skip it as a senior dev. Only useful for a quick refresher on Python idioms. | CC BY-NC-SA, free online | https://allendowney.github.io/ThinkPython/ |
| **Databricks resources hub** | Other official free ebooks (most need a registration form). | Official, free with registration | https://www.databricks.com/resources |

> Note: the old Databricks "Learning Spark 2e" and "Delta Lake: The Definitive Guide" free-ebook pages now return 404 or redirect to the hub, so they are not listed as live links.

## NOT free: get them legally

| Book | Why it matters | Legal options |
|------|----------------|---------------|
| **Designing Data-Intensive Applications** (Martin Kleppmann; 2nd ed. with Chris Riccomini) | *The* DE systems book: replication, partitioning, transactions, batch/stream. Read it after the papers below make sense. | Public library (Libby/OverDrive), O'Reilly Learning 10-day free trial, or ACM membership (includes O'Reilly access). Site: https://dataintensive.net/ |
| **Fundamentals of Data Engineering** (Joe Reis & Matt Housley) | The DE lifecycle and how to pick a stack. The best first "career" book for DE. | Library, O'Reilly trial: https://www.oreilly.com/library/view/fundamentals-of-data/9781098108298/ (O'Reilly blocks automated checks, so this link was not verified by script) |
| **The Data Warehouse Toolkit, 3e** (Ralph Kimball & Margy Ross) | The bible of dimensional modeling. The free techniques page (#7 above) covers most of it. | Library, O'Reilly trial (Wiley titles are on O'Reilly). Book page: https://www.kimballgroup.com/data-warehouse-business-intelligence-resources/books/data-warehouse-dw-toolkit/ |

Tip: with an O'Reilly trial, plan to read FoDE in its 10 days. Get DDIA from the library, since it takes longer.
