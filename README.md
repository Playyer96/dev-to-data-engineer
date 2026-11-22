# Dev → Data Engineer: a free, ordered study kit

A complete, **100% free** path from **software developer to Data Engineer / Analytics Engineer / Data Analyst**,
built for someone who already ships production code and wants to get hired in data **fast**.

Everything is in learning order: roadmaps, video courses, courses, certifications, books, papers, software,
practice, datasets, portfolio projects, and the job hunt. Links were checked in November 2026.

> Built while making this switch myself (7 years in games and full-stack, with AWS serverless).
> The plan assumes you can already program; it skips the "what is a variable" material.

## Start here
1. Read **[00-START-HERE](00-START-HERE/README.md)**: the 12-week plan and why Data Engineer is the fastest target for developers.
2. Pick links from **[LINKS.md](LINKS.md)**: all ~490 links in one place, grouped in learning order.
3. Get the PDFs: `bash scripts/download-pdfs.sh` (roadmaps, free books and the foundational papers).

## What's inside
| # | Section | Highlights |
|---|---|---|
| 00 | [Start here](00-START-HERE/README.md) | 12-week plan; apply from week 6 |
| 01 | [Roadmaps](01-roadmaps/) | roadmap.sh, DataTalksClub Zoomcamp, DataExpert, the Cookbook, analyst vs engineer, LATAM salaries |
| 02 | [Courses & certs](02-courses-certs/) | 43 free courses in order (`.md` + `.xlsx`), certificate ranking and voucher tricks |
| 03 | [Books & papers](03-books-papers/) | Free books (Python for Data Analysis, ISLP, OpenIntro, Think Stats) and 14 classic papers (MapReduce → Lakehouse) |
| 04 | [Software & tools](04-software-tools/) | 39 tools by priority (`.md` + `.xlsx`), copy-paste macOS setup |
| 05 | [Practice & projects](05-practice-projects/) | 40 SQL drills with a DuckDB seed, practice sites, ~50 datasets, 5 portfolio projects with architecture diagrams |
| 06 | [Job hunt](06-job-hunt/) | CV/LinkedIn repositioning for devs, remote boards (LATAM → US), interview prep, 30-60-90 plan |
| 07 | [Video courses](07-video-courses/) | 68 free video courses and playlists in order (EN + ES), `.md` + `.xlsx` |

## Quick start: SQL drills in 30 seconds
```bash
brew install duckdb
duckdb drills.duckdb < 05-practice-projects/sql-drills-seed.sql
```
Then work through [`05-practice-projects/sql-drills.md`](05-practice-projects/sql-drills.md).

## Maintenance scripts
- `scripts/download-pdfs.sh` downloads every free PDF. PDFs are git-ignored because not all are licensed for redistribution.
- `scripts/build-links.py` regenerates `LINKS.md` from the section files.

## Contributing
Found a dead link or a great free resource? See [CONTRIBUTING.md](CONTRIBUTING.md). Free and legal resources only.

## License
Content is licensed [CC BY 4.0](LICENSE). Linked resources belong to their respective owners.
