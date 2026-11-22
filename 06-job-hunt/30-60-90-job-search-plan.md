# 30-60-90 Day Job Search Plan: Remote Data Roles (start: week of 2026-11-23)

> Goal: offers for remote **Data Engineer / Analytics Engineer / Data Analyst** roles (US or LATAM companies) as fast as possible, **without overstating experience**.
> Approach: apply in parallel with learning. Start now with roles that match your *current* skills (bridge + analyst roles). Add DE-titled roles as projects and skills become real.
> Note: US hiring slows from mid-December to early January. Use that window to build the project and get vetted on the talent networks, then apply hard from January.

Companion files: `resume-reposition.md` · `job-boards.md` · `interview-prep.md`

---

## Weekly scoreboard (track every Friday)

| Metric | Days 1–30 | Days 31–60 | Days 61–90 |
|---|---|---|---|
| Tailored applications / week | 15–20 | 20–25 | 15–20 (more selective) |
| Of which **referral or direct-to-hiring-manager** | ≥ 3 | ≥ 5 | ≥ 5 |
| Networking messages / week | 10 | 15 | 15 |
| Talent-network vetting steps (Turing/Toptal/Arc/Revelo/Andela/BairesDev) | 2 profiles + 1 test | 2 tests | follow-ups |
| LinkedIn posts / week | 2 | 3 | 3 |
| SQL/pandas practice problems / week | 25 | 20 | 15 + mocks |
| Mock interviews / week | 0–1 | 1 | 2 |

**Funnel health checks (adjust after 4 weeks):**
- Response rate (any reply / applications) **< 5%** → the resume/headline is the problem. Rewrite the summary and top bullets, A/B test two versions.
- Recruiter screens but **no technical pass** → shift practice time to SQL/pandas.
- Technical passes but **no offers** → work on STAR stories, system design, and the "why data" pitch.

**Tracker** (Google Sheet / Notion). Columns:
`date_applied | company | role | level | link | source (board/referral) | LATAM-OK? | contact name | status (applied/screen/tech/onsite/offer/rejected) | next action + date | notes`

---

## Days 1–30: Foundations + first wave

### Week 1: Assets
- [ ] Rewrite resume (3 variants: DE / AE / DA) with `resume-reposition.md`. **Truth-check every bullet.**
- [ ] Update LinkedIn: headline, About, experience bullets, Open to Work (recruiters only), custom URL, featured section.
- [ ] Clean GitHub: profile README, pin repos, remove or archive noise.
- [ ] Set up the tracker and 5 LinkedIn job alerts (boolean strings in `job-boards.md` §5).
- [ ] Create profiles on: Get on Board, Torre, Wellfound, Himalayas, Revelo, Arc.dev, Turing.
- [ ] Join communities: **dbt Slack**, **DataTalks.Club Slack**, **Locally Optimistic Slack**, **r/dataengineering** (links below).
- [ ] Start **Project 1** (serverless ingestion on AWS: your fastest win, see resume file §3).

### Weeks 2–4: Apply + build
- [ ] **Apply now** to: data analyst / product analyst (SQL-heavy), "Software Engineer, Data", backend roles on data teams, gaming/sports-tech analytics roles.
- [ ] Do the first vetting test on **one** network (Turing or Arc.dev) *after* 2 weeks of SQL practice. Save Toptal for later (stricter screen, limited retries).
- [ ] SQL drills daily (`interview-prep.md` §2). Python/pandas basics if new to you.
- [ ] Ship Project 1 to GitHub with README + architecture diagram. Post about it.
- [ ] Introduce yourself in every Slack community (template below).

**End of day 30, you should have:** resume v2, LinkedIn updated, 1 shipped project, ~60 applications, 8+ networking conversations, 1 vetting test done.

---

## Days 31–60: Volume + credibility

- [ ] **Project 2**: dbt + warehouse modeling project (golf shot telemetry or game events star schema, with tests and docs). Now you can honestly add **dbt** and **Python** to your skills.
- [ ] Update resume/LinkedIn skills to match (only what you've built).
- [ ] Start applying to **Data Engineer / Analytics Engineer titled roles** (mid-level, not staff/principal).
- [ ] 2 more vetting processes (Revelo, Andela, or BairesDev; Toptal if SQL and Python feel solid).
- [ ] Weekly mock interview: swap mocks with someone in DataTalks.Club / dbt Slack.
- [ ] Ask 5 people from your previous companies for referrals or intros. Ask former colleagues who moved into US companies where their data teams hire.
- [ ] Optional: book the **AWS Certified Data Engineer – Associate** exam for ~day 75–90 if it fits your budget. It's a strong signal with your AWS background. Don't list it until you pass.

**End of day 60:** 2 projects, ~110 cumulative applications, several recruiter screens, at least 2–3 technical rounds completed.

---

## Days 61–90: Convert

- [ ] Be more selective: spend time on roles where you've reached the screen stage or have a referral.
- [ ] Double down on **interview performance**: 2 mocks/week, system-design prompts out loud, polish STAR stories.
- [ ] **Project 3** (optional): orchestration (Airflow/Dagster) + data-quality checks added to Project 2. Or a small streaming add-on (Kinesis/Kafka).
- [ ] Follow up on every open process each week (polite 1-liner after 5 business days of silence).
- [ ] Offers: compare total comp in USD, contractor vs EOR employment, paid time off, hardware, equipment stipend, contract length. Negotiate. Don't take the first number: use Levels.fyi / Glassdoor / Get on Board salary data for reference. (For Colombian tax treatment of foreign contractor income, check with a local accountant.)

---

## Networking playbook

### Communities (all links checked 2026-11-21, OK)
| Community | Link | How to participate |
|---|---|---|
| dbt Community Slack | https://www.getdbt.com/community/join-the-community | Intro channel, local/regional LATAM channels, job channels, ask/answer in help channels |
| DataTalks.Club Slack | https://datatalks.club/slack.html | Take the free DE Zoomcamp in a cohort, post progress, find mock partners |
| Locally Optimistic Slack | https://locallyoptimistic.com/community/ | Analytics leadership discussions. Read the job channel, ask thoughtful questions |
| r/dataengineering | https://www.reddit.com/r/dataengineering/ | Answer questions you know (AWS Lambda, Postgres, event data). Read the career/salary threads |
| r/analytics, r/dataanalysis | https://www.reddit.com/r/analytics/ · https://www.reddit.com/r/dataanalysis/ | For analyst-track roles |
| Local (Medellín) | Search https://www.meetup.com/ for "AWS User Group Medellín", "PyData", "Data Engineering Colombia" | In-person meetups → referrals to companies paying in USD. (Specific group URLs not linked: none could be verified) |

### Message templates

**Community intro (Slack):**
> Hi all! I'm Danilo, based in Medellín, Colombia. 7 years as a senior engineer in games and full-stack work: AWS serverless event handling and analytics logging, plus golf-simulator physics checked against measured shot data. Moving into data engineering and building `[project]`. Happy to help with AWS Lambda/API Gateway or Postgres questions, and always up for mock-interview swaps.

**Cold message to a hiring manager / data lead (LinkedIn, < 300 chars):**
> Hi `[Name]`, I saw `[Company]` is hiring a `[role]`. I've built serverless AWS event and analytics-logging pipelines for games and validated simulation data against real measurements. I'm in Colombia working US hours. Would you be open to a quick chat, or could you point me to the right person?

**Referral ask (former colleague):**
> Hey `[Name]`! Hope `[Company]` is going well. I'm moving into data engineering (here's my latest project: `[link]`). I saw `[role/link]` on your team. Would you be comfortable referring me, or telling me a bit about how the team works? Totally fine if not.

**Follow-up after applying (5 business days):**
> Hi `[Name]`, I applied for `[role]` on `[date]`. Quick note on fit: `[one specific line from the JD ↔ your experience]`. Happy to share more. Thanks!

Rule of thumb: **give before you ask**. Answer questions, share project write-ups, comment thoughtfully on posts from data leads at your target companies for 1–2 weeks before you DM them.

---

## Content posting plan (LinkedIn first; cross-post to dev.to / Medium if you like)

Cadence: **2 posts/week in days 1–30, then 3/week**. Best times: Tue–Thu, 8–10am US Eastern (= 7–9am Medellín during US daylight time, Mar–Nov; same clock time Nov–Mar).
Format: a hook in the first line → 5–10 short lines → one image or diagram → a question at the end. Comment on 5 other posts on the days you post.

| Week | Post idea | Shows |
|---|---|---|
| 1 | "After 7 years in game dev, I'm moving into data engineering. Here's why." (the honest story) | Narrative, sets expectations |
| 1 | "What a golf simulator taught me about data quality: measured vs simulated" | Your differentiator |
| 2 | "How gameplay events actually reach an analytics database (Lambda + API Gateway)" with a diagram | AWS depth |
| 2 | "At-least-once delivery means duplicates. How I dedupe events with ROW_NUMBER()" | SQL skill |
| 3 | Project 1 launch: architecture diagram + 3 lessons learned | Shipping |
| 3 | "5 SQL window-function patterns I use constantly" (carousel/PDF) | Teaching shows mastery |
| 4 | "Sessionizing player events in SQL: the 30-minute rule" | Domain + SQL |
| 5 | "Star schema for golf shots: choosing the grain" | Modeling |
| 5 | "Postgres vs MongoDB: how I chose for client projects" | Judgment |
| 6 | Project 2 launch (dbt): lineage graph screenshot + tests | dbt credibility |
| 6 | "Why simulated data lies: tolerance thresholds and error metrics" | Data-quality thinking |
| 7 | "Idempotent pipelines explained for software engineers" | DE fundamentals |
| 8 | "What I learned from 10 data engineering interviews" (no company names) | Reflection, community value |
| 9–12 | Weekly project progress (orchestration, data tests, cost tips), plus 1 post/week replying to a trending r/dataengineering topic | Consistency |

Content rules: no fake metrics, no claiming titles you haven't held. Put in a real screenshot or diagram rather than generic AI images. Turn your best post into a pinned **Featured** item.

---

## Weekly rhythm (template)
| Day | Morning (US hours overlap) | Afternoon |
|---|---|---|
| Mon | Applications (5) + LinkedIn alerts | Project work |
| Tue | Networking messages (5) + post | SQL/pandas practice |
| Wed | Applications (5) + follow-ups | Project work |
| Thu | Networking + post (3rd post when on 3/week) | Mock interview / system design |
| Fri | Applications (5) + weekly scoreboard update | Learning (course module) + plan next week |
| Sat | Optional: project or content drafting | — |
| Sun | Rest | — |
