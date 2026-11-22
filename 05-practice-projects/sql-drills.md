# SQL Drills: 40 Progressive Exercises (DuckDB)

These drills run on a small **golf-simulator analytics** schema, the same shape as the telemetry a Unity golf sim would log. They start easy and get harder in this order: joins, aggregation, CTEs, window functions, gaps and islands, sessionization, funnels, retention. The last four topics are what Data Analyst and Analytics Engineer interviews test hardest.

**Verified:** the seed and all 40 solutions were run on DuckDB 2.0.1 on 2026-11-21. Every query ran without errors. A sample of the output is listed under each "Check" line.

## Setup (2 minutes, free)

```bash
# Option A: DuckDB CLI (macOS)
brew install duckdb
duckdb drills.duckdb < sql-drills-seed.sql   # seed file sits next to this doc
duckdb drills.duckdb                          # then paste queries

# Option B: Python
python3 -m venv .venv && . .venv/bin/activate && pip install duckdb
python -c "import duckdb; c=duckdb.connect('drills.duckdb'); c.execute(open('sql-drills-seed.sql').read())"

# Option C: zero install, in the browser: https://shell.duckdb.org (paste the seed, then the queries)
```

How to work through it:
1. Read the task and write your own query **before** you open the solution.
2. Compare your output with the "Check" line.
3. Then read the solution and its notes. Most of them point out a trap or a Postgres/BigQuery difference.
4. Redo any drill you got wrong two days later. Spaced repetition beats grinding.

DuckDB-only syntax used here, and what to write in Postgres instead:
- `QUALIFY`: use a subquery and filter on the window column.
- `count(*) FILTER (WHERE ...)`: Postgres supports this too. In BigQuery use `COUNTIF`.
- `GROUP BY ALL`: list the columns.
- `median()`: use `percentile_cont(0.5) WITHIN GROUP (ORDER BY x)`.
- `date_diff('day', a, b)`: Postgres uses `b::date - a::date`. BigQuery uses `DATE_DIFF(b, a, DAY)`.

## Schema

```
players(player_id PK, username, country NULLABLE, platform, signup_date, referred_by -> players)
courses(course_id PK, name, par, difficulty)
sessions(session_id PK, player_id -> players, course_id -> courses, started_at, ended_at)
shots(shot_id PK, session_id -> sessions, player_id, shot_no, club, ball_speed_mph, launch_deg, shot_ts, carry_yds)
purchases(purchase_id PK, player_id, purchased_at, sku, amount_usd)
events(player_id, event_name, event_ts)   -- install, tutorial_start, tutorial_complete, first_round, first_purchase
```

Traps built in on purpose:
- Player 20 never plays.
- Player 14 has a NULL country.
- Course 6 is never played.
- Players 7 and 14 skip the tutorial but still play.
- Some sessions are back-to-back, 20 minutes apart.

Data covers 2026-01-02 to 2026-03-01.

## Seed script

The same script is saved as `sql-drills-seed.sql` next to this file.

```sql
-- Golf-sim analytics schema for SQL drills (DuckDB). Deterministic: no random().
DROP TABLE IF EXISTS events; DROP TABLE IF EXISTS purchases; DROP TABLE IF EXISTS shots;
DROP TABLE IF EXISTS sessions; DROP TABLE IF EXISTS courses; DROP TABLE IF EXISTS players;

CREATE TABLE players (
  player_id   INTEGER PRIMARY KEY,
  username    VARCHAR NOT NULL,
  country     VARCHAR,            -- NULL on purpose for one player
  platform    VARCHAR NOT NULL,   -- 'pc' | 'ios' | 'android' | 'simulator_bay'
  signup_date DATE NOT NULL,
  referred_by INTEGER             -- self-reference for recursive CTE drills
);
INSERT INTO players VALUES
 (1,'ace_ana','CO','pc','2026-01-02',NULL),
 (2,'birdie_ben','US','ios','2026-01-03',1),
 (3,'chip_carla','CO','android','2026-01-05',2),
 (4,'divot_dan','MX','pc','2026-01-06',NULL),
 (5,'eagle_eva','US','simulator_bay','2026-01-08',3),
 (6,'fade_felix','ES','pc','2026-01-10',NULL),
 (7,'green_gabi','CO','ios','2026-01-12',4),
 (8,'hook_hugo','AR','android','2026-01-15',1),
 (9,'iron_ines','US','pc','2026-01-18',NULL),
 (10,'jab_juan','CO','simulator_bay','2026-01-21',8),
 (11,'kick_kim','KR','pc','2026-01-25',NULL),
 (12,'links_lu','CO','ios','2026-01-28',5),
 (13,'mulligan_mo','US','android','2026-02-01',8),
 (14,'nine_nora',NULL,'pc','2026-02-03',NULL),
 (15,'out_oscar','MX','pc','2026-02-05',13),
 (16,'putt_paula','CO','simulator_bay','2026-02-08',NULL),
 (17,'quad_quinn','US','ios','2026-02-10',15),
 (18,'rough_rosa','ES','android','2026-02-12',NULL),
 (19,'slice_sam','CO','pc','2026-02-14',3),
 (20,'tee_tomas','AR','ios','2026-02-15',NULL);  -- signs up, never plays

CREATE TABLE courses (
  course_id  INTEGER PRIMARY KEY,
  name       VARCHAR NOT NULL,
  par        INTEGER NOT NULL,
  difficulty VARCHAR NOT NULL
);
INSERT INTO courses VALUES
 (1,'Bogota Highlands',72,'hard'),
 (2,'Caribbean Dunes',70,'medium'),
 (3,'Andes Valley',71,'medium'),
 (4,'Pacific Cliffs',72,'hard'),
 (5,'Driving Range',0,'easy'),
 (6,'Night Links',68,'easy');      -- never played

-- Sessions: runs of 4 consecutive days separated by (player_id % 5) * 2 day gaps.
-- Every 3rd session gets a "back-to-back" follow-up 20 min later (merges under a 30-min sessionization rule).
CREATE TABLE sessions AS
WITH base AS (
  SELECT p.player_id, p.signup_date, k.k
  FROM players p, range(1, 13) AS k(k)
  WHERE p.player_id <= 19 AND k.k <= 4 + p.player_id % 9
), first_pass AS (
  SELECT player_id, k,
         CAST(signup_date AS TIMESTAMP)
           + to_days(CAST((k - 1) + ((k - 1) // 4) * (player_id % 5) * 2 AS INTEGER))
           + to_hours(CAST(17 + (player_id * k) % 5 AS INTEGER))
           + to_minutes(CAST((player_id * 7 + k * 13) % 60 AS INTEGER)) AS started_at,
         20 + (player_id * k * 7) % 50 AS dur_min
  FROM base
), follow_up AS (
  SELECT player_id, k + 100 AS k,
         started_at + to_minutes(CAST(dur_min + 20 AS INTEGER)) AS started_at,
         25 AS dur_min
  FROM first_pass WHERE k % 3 = 0
), all_s AS (SELECT * FROM first_pass UNION ALL SELECT * FROM follow_up)
SELECT CAST(row_number() OVER (ORDER BY started_at, player_id) AS INTEGER) AS session_id,
       player_id,
       CAST(1 + (player_id * 3 + k) % 5 AS INTEGER)       AS course_id,
       started_at,
       started_at + to_minutes(CAST(dur_min AS INTEGER))  AS ended_at
FROM all_s;

-- Shots: 4..10 per session, evenly spaced inside the session.
CREATE TABLE shots AS
WITH s AS (
  SELECT s.*, 4 + s.session_id % 7 AS n_shots,
         date_diff('second', started_at, ended_at) AS dur_s
  FROM sessions s
), j AS (
  SELECT s.*, j.j FROM s, range(1, 11) AS j(j) WHERE j.j <= s.n_shots
), c AS (
  SELECT *, ['Driver','3W','5I','7I','9I','PW','Putter'][1 + (session_id * 31 + ((j - 1) // (1 + session_id % 3)) * 3) % 7] AS club  -- practice blocks of 1-3 shots
  FROM j
)
SELECT CAST(row_number() OVER (ORDER BY session_id, j) AS INTEGER) AS shot_id,
       session_id, player_id, CAST(j AS INTEGER) AS shot_no, club,
       CAST(CASE club WHEN 'Driver' THEN 150 WHEN '3W' THEN 140 WHEN '5I' THEN 125
                      WHEN '7I' THEN 115 WHEN '9I' THEN 100 WHEN 'PW' THEN 90 ELSE 12 END
            + (session_id * j * 13) % 21 - 10 AS DOUBLE)                   AS ball_speed_mph,
       CAST(CASE club WHEN 'Driver' THEN 11 WHEN '3W' THEN 12 WHEN '5I' THEN 15
                      WHEN '7I' THEN 18 WHEN '9I' THEN 23 WHEN 'PW' THEN 27 ELSE 1 END
            + (session_id + j) % 5 AS DOUBLE)                              AS launch_deg,
       started_at + to_seconds(CAST(dur_s * j // (n_shots + 1) AS BIGINT)) AS shot_ts
FROM c;
ALTER TABLE shots ADD COLUMN carry_yds DOUBLE;
UPDATE shots SET carry_yds = round(ball_speed_mph * CASE WHEN club = 'Putter' THEN 0.6 ELSE 1.7 END
                                   - abs(launch_deg - 14) * 1.5, 1);

-- Purchases: deterministic subset of sessions, 5 minutes before the session ends.
CREATE TABLE purchases AS
SELECT CAST(row_number() OVER (ORDER BY ended_at) AS INTEGER) AS purchase_id,
       player_id,
       ended_at - to_minutes(5) AS purchased_at,
       ['ball_pack','course_unlock','season_pass'][1 + session_id % 3] AS sku,
       CAST([0.99, 4.99, 9.99][1 + session_id % 3] AS DECIMAL(6,2)) AS amount_usd
FROM sessions
WHERE (session_id * 7) % 9 = 0;

-- Product funnel events.
CREATE TABLE events AS
SELECT * FROM (
  SELECT player_id, 'install' AS event_name, CAST(signup_date AS TIMESTAMP) + to_hours(9) AS event_ts FROM players
  UNION ALL
  SELECT player_id, 'tutorial_start', CAST(signup_date AS TIMESTAMP) + to_hours(9) + to_minutes(2)
  FROM players WHERE player_id % 7 <> 0
  UNION ALL
  SELECT player_id, 'tutorial_complete', CAST(signup_date AS TIMESTAMP) + to_hours(9) + to_minutes(12)
  FROM players WHERE player_id % 7 <> 0 AND player_id % 4 <> 0
  UNION ALL
  SELECT player_id, 'first_round', min(started_at) FROM sessions GROUP BY player_id
  UNION ALL
  SELECT player_id, 'first_purchase', min(purchased_at) FROM purchases GROUP BY player_id
) ORDER BY event_ts, player_id;
```

---

## Part 1: Joins and basics (1-8)

### 1. Players per platform
Count players per platform, largest first.
Check: 4 row(s); columns `platform, players`; first: `(pc, 8)`; `(ios, 5)`; `(android, 4)`

<details><summary>Solution</summary>

```sql
-- Q1
SELECT platform, count(*) AS players
FROM players
GROUP BY platform
ORDER BY players DESC, platform;
```
</details>

### 2. Players who never played (anti-join)
List the players with zero sessions.
Check: 1 row(s); columns `player_id, username`; first: `(20, tee_tomas)`

<details><summary>Solution</summary>

```sql
-- Q2
SELECT p.player_id, p.username
FROM players p
LEFT JOIN sessions s ON s.player_id = p.player_id
WHERE s.session_id IS NULL;
```
`WHERE NOT EXISTS (SELECT 1 FROM sessions s WHERE s.player_id = p.player_id)` gives the same result. Avoid `NOT IN (subquery)`: if the subquery returns a single NULL, the whole filter matches nothing.
</details>

### 3. Sessions per course, including unplayed courses
Show every course with its session count. Courses with no sessions show 0.
Check: 6 row(s); columns `name, sessions`; first: `(Andes Valley, 40)`; `(Bogota Highlands, 39)`; `(Caribbean Dunes, 38)`

<details><summary>Solution</summary>

```sql
-- Q3
SELECT c.name, count(s.session_id) AS sessions
FROM courses c
LEFT JOIN sessions s USING (course_id)
GROUP BY c.name
ORDER BY sessions DESC, c.name;
```
Use `count(s.session_id)`, not `count(*)`. `count(*)` counts the NULL row from the LEFT JOIN, so it would show 1 for a course with no sessions.
</details>

### 4. Longest average sessions
Top 5 usernames by average session length in minutes, rounded to 1 decimal.
Check: 5 row(s); columns `username, avg_min`; first: `(green_gabi, 55.6)`; `(nine_nora, 51.3)`; `(slice_sam, 45)`

<details><summary>Solution</summary>

```sql
-- Q4
SELECT p.username,
       round(avg(date_diff('minute', s.started_at, s.ended_at)), 1) AS avg_min
FROM sessions s
JOIN players p USING (player_id)
GROUP BY p.username
ORDER BY avg_min DESC, p.username
LIMIT 5;
```
</details>

### 5. Revenue by country (NULL handling)
Total revenue and number of payers per country. Every country appears, even with $0 revenue. A NULL country shows as `'Unknown'`.
Check: 7 row(s); columns `country, revenue, payers`; first: `(CO, 7.92, 5)`; `(US, 4.95, 4)`; `(MX, 3.96, 1)`

<details><summary>Solution</summary>

```sql
-- Q5
SELECT coalesce(p.country, 'Unknown')          AS country,
       coalesce(sum(pu.amount_usd), 0)         AS revenue,
       count(DISTINCT pu.player_id)            AS payers
FROM players p
LEFT JOIN purchases pu USING (player_id)
GROUP BY 1
ORDER BY revenue DESC, country;
```
</details>

### 6. Payers who play less than average
List the players who made a purchase and have fewer sessions than the average player who has sessions.
Check: 6 row(s); columns `player_id, sessions`; first: `(2, 8)`; `(3, 9)`; `(9, 5)`

<details><summary>Solution</summary>

```sql
-- Q6
SELECT p.player_id, count(*) AS sessions
FROM sessions p
WHERE p.player_id IN (SELECT player_id FROM purchases)
GROUP BY p.player_id
HAVING count(*) < (SELECT avg(n) FROM (SELECT count(*) AS n FROM sessions GROUP BY player_id))
ORDER BY p.player_id;
```
</details>

### 7. Self-join: same-country pairs
How many distinct pairs of players share a country? Count each pair once.
Check: 5 row(s); columns `country, pairs`; first: `(CO, 21)`; `(US, 10)`; `(AR, 1)`

<details><summary>Solution</summary>

```sql
-- Q7
SELECT a.country, count(*) AS pairs
FROM players a
JOIN players b ON a.country = b.country AND a.player_id < b.player_id
GROUP BY a.country
ORDER BY pairs DESC, a.country;
```
`a.player_id < b.player_id` removes self-pairs and keeps each pair once instead of counting (a,b) and (b,a). A NULL country never equals anything, so player 14 drops out. That is usually what you want here, but say so in an interview.
</details>

### 8. Each player's longest carry and the club used
For each player, return their longest carry and the club that hit it. Ties return more than one row.
Check: 20 row(s); columns `player_id, club, carry_yds`; first: `(1, Driver, 265.4)`; `(2, Driver, 267.1)`; `(3, Driver, 265.8)`

<details><summary>Solution</summary>

```sql
-- Q8
SELECT s.player_id, s.club, s.carry_yds
FROM shots s
JOIN (SELECT player_id, max(carry_yds) AS mx FROM shots GROUP BY player_id) m
  ON m.player_id = s.player_id AND s.carry_yds = m.mx
ORDER BY s.player_id, s.club;
```
DuckDB shortcut: `SELECT player_id, max(carry_yds), arg_max(club, carry_yds) FROM shots GROUP BY 1`. It keeps one row per player and drops ties.
</details>

## Part 2: Aggregation and conditional logic (9-12)

### 9. Pivot shots per club
One row per player and one column per club (Driver, 7I, Putter), each holding the shot count.
Check: 19 row(s); columns `player_id, driver, iron7, putter, total`; first: `(1, 5, 5, 4, 44)`; `(2, 10, 10, 9, 61)`; `(3, 7, 6, 11, 64)`

<details><summary>Solution</summary>

```sql
-- Q9
SELECT player_id,
       count(*) FILTER (WHERE club = 'Driver') AS driver,
       count(*) FILTER (WHERE club = '7I')     AS iron7,
       count(*) FILTER (WHERE club = 'Putter') AS putter,
       count(*)                                AS total
FROM shots
GROUP BY player_id
ORDER BY player_id;
```
The portable version is `sum(CASE WHEN club = 'Driver' THEN 1 ELSE 0 END)`. DuckDB also has `PIVOT shots ON club USING count(*) GROUP BY player_id`.
</details>

### 10. HAVING: long-hitting clubs
List the clubs with at least 50 shots and an average carry above 200 yards.
Check: 3 row(s); columns `club, n, avg_carry`; first: `(Driver, 217, 252.7)`; `(3W, 181, 234.5)`; `(5I, 185, 206.5)`

<details><summary>Solution</summary>

```sql
-- Q10
SELECT club, count(*) AS n, round(avg(carry_yds), 1) AS avg_carry
FROM shots
GROUP BY club
HAVING count(*) >= 50 AND avg(carry_yds) > 200
ORDER BY avg_carry DESC;
```
`WHERE` filters rows before grouping. `HAVING` filters groups after aggregation.
</details>

### 11. Weekend share
What percentage of sessions start on a Saturday or Sunday?
Check: 1 row(s); columns `pct_weekend`; first: `(27.6)`

<details><summary>Solution</summary>

```sql
-- Q11
SELECT round(100.0 * count(*) FILTER (WHERE isodow(started_at) IN (6, 7)) / count(*), 1) AS pct_weekend
FROM sessions;
```
`isodow` numbers Monday as 1 and Sunday as 7. Postgres has `extract(isodow FROM ts)`. Multiply by `100.0`: in Postgres, integer division of two counts gives 0.
</details>

### 12. Monthly active players (MAP)
Count distinct active players per calendar month.
Check: 3 row(s); columns `month, active_players`; first: `(2026-01-01 00:00, 12)`; `(2026-02-01 00:00, 10)`; `(2026-03-01 00:00, 1)`

<details><summary>Solution</summary>

```sql
-- Q12
SELECT date_trunc('month', started_at) AS month, count(DISTINCT player_id) AS active_players
FROM sessions
GROUP BY 1
ORDER BY 1;
```
</details>

## Part 3: CTEs and recursion (13-16)

### 13. Time to first session
For each player, give the signup date, the first session timestamp and the days from signup to first play (NULL if they never played). Then count how many played on their signup day.
Check: 1 row(s); columns `same_day, never_played, players`; first: `(19, 1, 20)`

<details><summary>Solution</summary>

```sql
-- Q13
WITH firsts AS (
  SELECT player_id, min(started_at) AS first_ts
  FROM sessions GROUP BY player_id
), per_player AS (
  SELECT p.player_id, p.signup_date, f.first_ts,
         date_diff('day', p.signup_date, CAST(f.first_ts AS DATE)) AS days_to_first
  FROM players p LEFT JOIN firsts f USING (player_id)
)
SELECT count(*) FILTER (WHERE days_to_first = 0) AS same_day,
       count(*) FILTER (WHERE days_to_first IS NULL) AS never_played,
       count(*) AS players
FROM per_player;
```
</details>

### 14. ARPU, ARPPU, payer conversion
In one row: number of players, number of payers, revenue, ARPU (revenue / all players), ARPPU (revenue / payers) and payer %.
Check: 1 row(s); columns `players, payers, revenue, arpu, arppu, payer_pct`; first: `(20, 13, 20.79, 1.04, 1.6, 65)`

<details><summary>Solution</summary>

```sql
-- Q14
WITH rev AS (
  SELECT player_id, sum(amount_usd) AS r FROM purchases GROUP BY player_id
), totals AS (
  SELECT (SELECT count(*) FROM players) AS players, count(*) AS payers, sum(r) AS revenue FROM rev
)
SELECT players, payers, revenue,
       round(revenue / players, 2)     AS arpu,
       round(revenue / payers, 2)      AS arppu,
       round(100.0 * payers / players, 1) AS payer_pct
FROM totals;
```
</details>

### 15. Recursive calendar: days with zero sessions
Use a recursive CTE to build every date from 2026-01-01 to 2026-03-01. Count sessions per day, keeping days with zero sessions, and report how many days had zero.
Check: 1 row(s); columns `days, zero_days, busiest_day`; first: `(60, 4, 6)`

<details><summary>Solution</summary>

```sql
-- Q15
WITH RECURSIVE cal(d) AS (
  SELECT DATE '2026-01-01'
  UNION ALL
  SELECT d + 1 FROM cal WHERE d < DATE '2026-03-01'
), daily AS (
  SELECT cal.d, count(s.session_id) AS sessions
  FROM cal LEFT JOIN sessions s ON CAST(s.started_at AS DATE) = cal.d
  GROUP BY cal.d
)
SELECT count(*) AS days, count(*) FILTER (WHERE sessions = 0) AS zero_days, max(sessions) AS busiest_day
FROM daily;
```
Without recursion: `generate_series(DATE '2026-01-01', DATE '2026-03-01', INTERVAL 1 DAY)` works in both DuckDB and Postgres. A date spine is how you fill gaps in time-series dashboards.
</details>

### 16. Recursive referral tree
For each player, find the root referrer (the top of the chain) and their depth in the tree. Then list each root's network size.
Check: 9 row(s); columns `root_id, network_size, max_depth`; first: `(1, 11, 4)`; `(4, 2, 1)`; `(6, 1, 0)`

<details><summary>Solution</summary>

```sql
-- Q16
WITH RECURSIVE tree AS (
  SELECT player_id, player_id AS root_id, 0 AS depth
  FROM players WHERE referred_by IS NULL
  UNION ALL
  SELECT p.player_id, t.root_id, t.depth + 1
  FROM players p JOIN tree t ON p.referred_by = t.player_id
)
SELECT root_id, count(*) AS network_size, max(depth) AS max_depth
FROM tree
GROUP BY root_id
ORDER BY network_size DESC, root_id;
```
</details>

## Part 4: Window functions (17-26)

### 17. Top-N per group
Each player's 3 most recent sessions.
Check: 57 row(s); columns `player_id, session_id, started_at`; first: `(1, 17, 2026-01-08 17:12)`; `(1, 10, 2026-01-05 21:59)`; `(1, 6, 2026-01-04 21:47)`

<details><summary>Solution</summary>

```sql
-- Q17
SELECT player_id, session_id, started_at
FROM sessions
QUALIFY row_number() OVER (PARTITION BY player_id ORDER BY started_at DESC) <= 3
ORDER BY player_id, started_at DESC;
```
Portable version: wrap it as `SELECT * FROM (SELECT ..., row_number() OVER (...) AS rn FROM sessions) WHERE rn <= 3`.
</details>

### 18. ROW_NUMBER vs RANK vs DENSE_RANK
Rank players by total shots using all three functions side by side. Find a tie and explain how the three differ on it.
Check: 19 row(s); columns `player_id, shots, rn, rnk, drnk`; first: `(17, 111, 1, 1, 1)`; `(8, 110, 2, 2, 2)`; `(16, 108, 3, 3, 3)`

<details><summary>Solution</summary>

```sql
-- Q18
SELECT player_id, count(*) AS shots,
       row_number() OVER (ORDER BY count(*) DESC, player_id) AS rn,
       rank()       OVER (ORDER BY count(*) DESC)            AS rnk,
       dense_rank() OVER (ORDER BY count(*) DESC)            AS drnk
FROM shots
GROUP BY player_id
ORDER BY shots DESC, player_id;
```
On a tie, `rank` skips the following numbers (1,1,3). `dense_rank` does not skip (1,1,2). `row_number` breaks ties arbitrarily unless you add a tiebreaker column.
</details>

### 19. Running total
Each player's cumulative spend, in purchase order.
Check: 21 row(s); columns `player_id, purchased_at, amount_usd, running_spend`; first: `(2, 2026-01-11 17:54, 0.99, 0.99)`; `(3, 2026-01-05 21:10, 0.99, 0.99)`; `(5, 2026-01-08 18:38, 0.99, 0.99)`

<details><summary>Solution</summary>

```sql
-- Q19
SELECT player_id, purchased_at, amount_usd,
       sum(amount_usd) OVER (PARTITION BY player_id ORDER BY purchased_at
                             ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_spend
FROM purchases
ORDER BY player_id, purchased_at;
```
Spell out `ROWS`. With `ORDER BY` and no frame clause, the default frame is `RANGE`, which lumps rows with tied timestamps into one step.
</details>

### 20. LAG: time between sessions
For each player, the average and the maximum gap in days between consecutive sessions.
Check: 19 row(s); columns `player_id, avg_gap_days, max_gap_days`; first: `(4, 1.66, 9)`; `(14, 2.17, 9)`; `(19, 2.37, 9)`

<details><summary>Solution</summary>

```sql
-- Q20
WITH g AS (
  SELECT player_id, started_at,
         lag(started_at) OVER (PARTITION BY player_id ORDER BY started_at) AS prev
  FROM sessions
)
SELECT player_id,
       round(avg(date_diff('hour', prev, started_at)) / 24.0, 2)                   AS avg_gap_days,
       max(date_diff('day', CAST(prev AS DATE), CAST(started_at AS DATE)))         AS max_gap_days
FROM g
WHERE prev IS NOT NULL
GROUP BY player_id
ORDER BY max_gap_days DESC, player_id;
```
</details>

### 21. 7-day moving average (trap)
Compute daily session counts with a trailing 7-day average. Do it two ways: `avg()` over a `RANGE` frame, and `sum()/7`. Explain why the two disagree.
Check: 56 row(s); columns `d, n, avg_of_present_days, true_7d_avg`; first: `(2026-01-02, 1, 1, 0.14)`; `(2026-01-03, 2, 1.5, 0.43)`; `(2026-01-04, 3, 2, 0.86)`

<details><summary>Solution</summary>

```sql
-- Q21
WITH daily AS (
  SELECT CAST(started_at AS DATE) AS d, count(*) AS n FROM sessions GROUP BY 1
)
SELECT d, n,
       round(avg(n) OVER w, 2)       AS avg_of_present_days,
       round(sum(n) OVER w / 7.0, 2) AS true_7d_avg
FROM daily
WINDOW w AS (ORDER BY d RANGE BETWEEN INTERVAL 6 DAY PRECEDING AND CURRENT ROW)
ORDER BY d;
```
`avg()` only counts the days that have rows, so a day with zero sessions is skipped instead of counted as 0, and the average comes out too high. Either join to a date spine (Q15) or divide the sum by 7.
</details>

### 22. NTILE buckets
Split Driver shots into ball-speed quartiles. For each quartile, show the speed range and the average carry.
Check: 4 row(s); columns `quartile, n, min_speed, max_speed, avg_carry`; first: `(1, 55, 140, 146, 241.6)`; `(2, 54, 146, 149, 248.6)`; `(3, 54, 149, 154, 256.2)`

<details><summary>Solution</summary>

```sql
-- Q22
WITH q AS (
  SELECT ball_speed_mph, carry_yds, ntile(4) OVER (ORDER BY ball_speed_mph) AS quartile
  FROM shots WHERE club = 'Driver'
)
SELECT quartile, count(*) AS n, min(ball_speed_mph) AS min_speed, max(ball_speed_mph) AS max_speed,
       round(avg(carry_yds), 1) AS avg_carry
FROM q GROUP BY quartile ORDER BY quartile;
```
</details>

### 23. Percent of total
Each course's share of all shots.
Check: 5 row(s); columns `name, shots, pct_of_shots`; first: `(Caribbean Dunes, 281, 21)`; `(Andes Valley, 279, 20.8)`; `(Pacific Cliffs, 265, 19.8)`

<details><summary>Solution</summary>

```sql
-- Q23
SELECT c.name, count(*) AS shots,
       round(100.0 * count(*) / sum(count(*)) OVER (), 1) AS pct_of_shots
FROM shots sh
JOIN sessions s USING (session_id)
JOIN courses c ON c.course_id = s.course_id
GROUP BY c.name
ORDER BY shots DESC;
```
`sum(count(*)) OVER ()` is a window over the grouped result. This "aggregate inside a window" pattern is worth memorizing.
</details>

### 24. FIRST_VALUE / LAST_VALUE (frame trap)
For the first 5 sessions, show the first club and the last club used.
Check: 5 row(s); columns `session_id, first_club, last_club`; first: `(1, 7I, 5I)`; `(2, Putter, 5I)`; `(3, 5I, Putter)`

<details><summary>Solution</summary>

```sql
-- Q24
SELECT DISTINCT session_id,
       first_value(club) OVER w AS first_club,
       last_value(club)  OVER w AS last_club
FROM shots
WHERE session_id <= 5
WINDOW w AS (PARTITION BY session_id ORDER BY shot_no
             ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
ORDER BY session_id;
```
Without the explicit frame, `last_value` returns the current row's club. The default frame ends at the current row.
</details>

### 25. Mode per group with ties
Each player's most-used club. Return all tied clubs.
Check: 24 row(s); columns `player_id, club, n`; first: `(1, PW, 9)`; `(2, 9I, 11)`; `(3, 5I, 12)`

<details><summary>Solution</summary>

```sql
-- Q25
SELECT player_id, club, count(*) AS n
FROM shots
GROUP BY player_id, club
QUALIFY rank() OVER (PARTITION BY player_id ORDER BY count(*) DESC) = 1
ORDER BY player_id, club;
```
</details>

### 26. Personal-best progression
List the Driver shots that set a new personal-best carry for that player: either the player's first Driver shot, or longer than every earlier one.
Check: 61 row(s); columns `player_id, shot_ts, carry_yds, prev_best`; first: `(1, 2026-01-03 19:54, 248.2, None)`; `(1, 2026-01-04 21:22, 265.4, 248.2)`; `(2, 2026-01-04 22:13, 260.3, None)`

<details><summary>Solution</summary>

```sql
-- Q26
WITH d AS (
  SELECT player_id, shot_ts, carry_yds,
         max(carry_yds) OVER (PARTITION BY player_id ORDER BY shot_ts
                              ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING) AS prev_best
  FROM shots WHERE club = 'Driver'
)
SELECT player_id, shot_ts, carry_yds, prev_best
FROM d
WHERE prev_best IS NULL OR carry_yds > prev_best
ORDER BY player_id, shot_ts;
```
</details>

## Part 5: Gaps and islands (27-30)

### 27. Longest daily-play streak
Find each player's longest run of consecutive days with at least one session, with its start and end dates.
Check: 19 row(s); columns `player_id, start_d, end_d, len`; first: `(15, 2026-02-05, 2026-02-14, 10)`; `(5, 2026-01-08, 2026-01-16, 9)`; `(10, 2026-01-21, 2026-01-25, 5)`

<details><summary>Solution</summary>

```sql
-- Q27
WITH days AS (
  SELECT DISTINCT player_id, CAST(started_at AS DATE) AS d FROM sessions
), grp AS (
  SELECT player_id, d,
         d - CAST(row_number() OVER (PARTITION BY player_id ORDER BY d) AS INTEGER) AS island
  FROM days
), streaks AS (
  SELECT player_id, island, min(d) AS start_d, max(d) AS end_d, count(*) AS len
  FROM grp GROUP BY player_id, island
)
SELECT player_id, start_d, end_d, len
FROM streaks
QUALIFY row_number() OVER (PARTITION BY player_id ORDER BY len DESC, start_d) = 1
ORDER BY len DESC, player_id;
```
The classic trick: date minus row_number gives the same value for every day in a consecutive run. Each run (an "island") gets one shared key you can group by.
</details>

### 28. Inactivity gaps
List every stretch of 4 or more idle days between two active days, longest first.
Check: 14 row(s); columns `player_id, gap_start, gap_end, idle_days`; first: `(4, 2026-01-10, 2026-01-17, 8)`; `(14, 2026-02-07, 2026-02-14, 8)`; `(14, 2026-02-19, 2026-02-26, 8)`

<details><summary>Solution</summary>

```sql
-- Q28
WITH days AS (
  SELECT DISTINCT player_id, CAST(started_at AS DATE) AS d FROM sessions
), l AS (
  SELECT player_id, d, lead(d) OVER (PARTITION BY player_id ORDER BY d) AS nxt FROM days
)
SELECT player_id, d + 1 AS gap_start, nxt - 1 AS gap_end, date_diff('day', d, nxt) - 1 AS idle_days
FROM l
WHERE date_diff('day', d, nxt) - 1 >= 4
ORDER BY idle_days DESC, player_id, gap_start;
```
</details>

### 29. Run-length: same-club streaks inside a session
Find runs of 3 or more consecutive shots with the same club inside a session. Return session, club, first shot_no and run length.
Check: 10 row(s); columns `session_id, club, from_shot, len`; first: `(2, Putter, 1, 3)`; `(2, 5I, 4, 3)`; `(5, Driver, 7, 3)`

<details><summary>Solution</summary>

```sql
-- Q29
WITH x AS (
  SELECT session_id, shot_no, club,
         shot_no - row_number() OVER (PARTITION BY session_id, club ORDER BY shot_no) AS grp
  FROM shots
), runs AS (
  SELECT session_id, club, min(shot_no) AS from_shot, count(*) AS len
  FROM x GROUP BY session_id, club, grp
)
SELECT * FROM runs WHERE len >= 3 ORDER BY len DESC, session_id LIMIT 10;
```
This is the same trick as Q27, applied to a sequence number instead of a date.
</details>

### 30. Streak at last activity
For each player, how long is the streak that ends on their most recent active day?
Check: 19 row(s); columns `player_id, last_active, current_streak`; first: `(15, 2026-02-14, 10)`; `(5, 2026-01-16, 9)`; `(10, 2026-01-25, 5)`

<details><summary>Solution</summary>

```sql
-- Q30
WITH days AS (
  SELECT DISTINCT player_id, CAST(started_at AS DATE) AS d FROM sessions
), grp AS (
  SELECT player_id, d,
         d - CAST(row_number() OVER (PARTITION BY player_id ORDER BY d) AS INTEGER) AS island
  FROM days
)
SELECT player_id, max(d) AS last_active, count(*) AS current_streak
FROM grp
GROUP BY player_id, island
QUALIFY max(d) = max(max(d)) OVER (PARTITION BY player_id)
ORDER BY current_streak DESC, player_id;
```
</details>

## Part 6: Sessionization (31-33)

### 31. Rebuild sessions from raw shots
Ignore the `sessions` table. Start a new session whenever a player goes more than 30 minutes without a shot. Compare the derived session count per player with the official count.
Check: 19 row(s); columns `player_id, derived_sessions, official_sessions, merged`; first: `(17, 12, 16, 4)`; `(5, 9, 12, 3)`; `(8, 13, 16, 3)`

<details><summary>Solution</summary>

```sql
-- Q31
WITH f AS (
  SELECT player_id, shot_ts,
         CASE WHEN shot_ts - lag(shot_ts) OVER (PARTITION BY player_id ORDER BY shot_ts)
                   <= INTERVAL 30 MINUTE THEN 0 ELSE 1 END AS is_new
  FROM shots
), s AS (
  SELECT *, sum(is_new) OVER (PARTITION BY player_id ORDER BY shot_ts) AS sess_no FROM f
), derived AS (
  SELECT player_id, max(sess_no) AS derived_sessions FROM s GROUP BY player_id
), official AS (
  SELECT player_id, count(*) AS official_sessions FROM sessions GROUP BY player_id
)
SELECT d.player_id, d.derived_sessions, o.official_sessions,
       o.official_sessions - d.derived_sessions AS merged
FROM derived d JOIN official o USING (player_id)
ORDER BY merged DESC, d.player_id;
```
The pattern has three steps: flag new-session boundaries with `lag`, take a running `sum` of the flags to get a session number, then group by that number. The back-to-back sessions in the seed (20 minutes apart) merge under the 30-minute rule. That is the point of the drill: how a "session" is defined changes your metrics.
</details>

### 32. Derived-session summary
Using the 30-minute rule from Q31, give each derived session its start, end, shot count and duration in minutes. Show the 5 longest.
Check: 5 row(s); columns `player_id, sess_no, start_ts, end_ts, shots, minutes`; first: `(7, 11, 2026-01-28 20:53, 2026-01-28 22:29, 17, 96)`; `(9, 3, 2026-01-20 19:48, 2026-01-20 21:23, 18, 95)`; `(16, 3, 2026-02-10 20:36, 2026-02-10 22:09, 19, 93)`

<details><summary>Solution</summary>

```sql
-- Q32
WITH f AS (
  SELECT player_id, shot_ts,
         CASE WHEN shot_ts - lag(shot_ts) OVER (PARTITION BY player_id ORDER BY shot_ts)
                   <= INTERVAL 30 MINUTE THEN 0 ELSE 1 END AS is_new
  FROM shots
), s AS (
  SELECT *, sum(is_new) OVER (PARTITION BY player_id ORDER BY shot_ts) AS sess_no FROM f
)
SELECT player_id, sess_no, min(shot_ts) AS start_ts, max(shot_ts) AS end_ts, count(*) AS shots,
       date_diff('minute', min(shot_ts), max(shot_ts)) AS minutes
FROM s
GROUP BY player_id, sess_no
ORDER BY minutes DESC, player_id
LIMIT 5;
```
</details>

### 33. Threshold sensitivity
How many sessions do you get with a gap threshold of 5, 10, 30, 60 and 240 minutes? Use one query.
Check: 5 row(s); columns `gap_min, sessions`; first: `(5, 723)`; `(10, 220)`; `(30, 165)`

<details><summary>Solution</summary>

```sql
-- Q33
WITH g AS (
  SELECT player_id, shot_ts,
         date_diff('second', lag(shot_ts) OVER (PARTITION BY player_id ORDER BY shot_ts), shot_ts) AS gap_s
  FROM shots
), t AS (
  SELECT * FROM (VALUES (5), (10), (30), (60), (240)) AS t(gap_min)
)
SELECT gap_min, count(*) FILTER (WHERE gap_s IS NULL OR gap_s > gap_min * 60) AS sessions
FROM t CROSS JOIN g
GROUP BY gap_min
ORDER BY gap_min;
```
Cross-joining a small parameter table is a cheap way to run "what-if" analysis in one query.
</details>

## Part 7: Funnels (34-36)

### 34. Simple funnel
Distinct players at each step, listed in step order: install, tutorial_start, tutorial_complete, first_round, first_purchase.
Check: 5 row(s); columns `event_name, players`; first: `(install, 20)`; `(tutorial_start, 18)`; `(tutorial_complete, 13)`

<details><summary>Solution</summary>

```sql
-- Q34
SELECT event_name, count(DISTINCT player_id) AS players
FROM events
GROUP BY event_name
ORDER BY CASE event_name WHEN 'install' THEN 1 WHEN 'tutorial_start' THEN 2
                         WHEN 'tutorial_complete' THEN 3 WHEN 'first_round' THEN 4 ELSE 5 END;
```
This is not a true funnel: a player counts at first_round even if they skipped the tutorial. Q35 fixes that.
</details>

### 35. Strict ordered funnel with conversion rates
A player counts at step N only if they completed steps 1 to N in timestamp order. Show the count, the % of installs and the % of the previous step.
Check: 5 row(s); columns `step, name, n, pct_of_installs, pct_of_prev`; first: `(1, install, 20, 100, None)`; `(2, tutorial_start, 18, 90, 90)`; `(3, tutorial_complete, 13, 65, 72.2)`

<details><summary>Solution</summary>

```sql
-- Q35
WITH p AS (
  SELECT player_id,
         min(event_ts) FILTER (WHERE event_name = 'install')           AS t1,
         min(event_ts) FILTER (WHERE event_name = 'tutorial_start')    AS t2,
         min(event_ts) FILTER (WHERE event_name = 'tutorial_complete') AS t3,
         min(event_ts) FILTER (WHERE event_name = 'first_round')       AS t4,
         min(event_ts) FILTER (WHERE event_name = 'first_purchase')    AS t5
  FROM events GROUP BY player_id
), steps AS (
  SELECT 1 AS step, 'install' AS name, count(t1) AS n FROM p
  UNION ALL SELECT 2, 'tutorial_start',    count(*) FILTER (WHERE t2 >= t1) FROM p
  UNION ALL SELECT 3, 'tutorial_complete', count(*) FILTER (WHERE t2 >= t1 AND t3 >= t2) FROM p
  UNION ALL SELECT 4, 'first_round',       count(*) FILTER (WHERE t2 >= t1 AND t3 >= t2 AND t4 >= t3) FROM p
  UNION ALL SELECT 5, 'first_purchase',    count(*) FILTER (WHERE t2 >= t1 AND t3 >= t2 AND t4 >= t3 AND t5 >= t4) FROM p
)
SELECT step, name, n,
       round(100.0 * n / first_value(n) OVER (ORDER BY step), 1) AS pct_of_installs,
       round(100.0 * n / lag(n) OVER (ORDER BY step), 1)         AS pct_of_prev
FROM steps
ORDER BY step;
```
Comparing against NULL yields NULL, and `FILTER` treats NULL as false. So a missing step drops the player from that step and every later one automatically.
</details>

### 36. Time-to-convert percentiles
For players who reached each milestone: the median and p90 hours from install to first_round, and the median days from install to first_purchase.
Check: 1 row(s); columns `median_h_to_first_round, p90_h_to_first_round, median_days_to_purchase`; first: `(10.4, 12.5, 2.4)`

<details><summary>Solution</summary>

```sql
-- Q36
WITH p AS (
  SELECT player_id,
         min(event_ts) FILTER (WHERE event_name = 'install')        AS inst,
         min(event_ts) FILTER (WHERE event_name = 'first_round')    AS fr,
         min(event_ts) FILTER (WHERE event_name = 'first_purchase') AS fp
  FROM events GROUP BY player_id
)
SELECT round(median(date_diff('minute', inst, fr)) / 60.0, 1)                 AS median_h_to_first_round,
       round(quantile_cont(date_diff('minute', inst, fr), 0.9) / 60.0, 1)     AS p90_h_to_first_round,
       round(median(date_diff('minute', inst, fp)) / 1440.0, 1)               AS median_days_to_purchase
FROM p;
```
Postgres: `percentile_cont(0.9) WITHIN GROUP (ORDER BY x)`. DuckDB accepts that syntax too.
</details>

## Part 8: Retention (37-40)

### 37. Classic D1 / D7 / D14 retention
Out of all signups, what % were active on exactly day 1, day 7 and day 14 after signup? Signup day is day 0.
Check: 1 row(s); columns `cohort_size, d1_pct, d7_pct, d14_pct`; first: `(20, 95, 25, 15)`

<details><summary>Solution</summary>

```sql
-- Q37
WITH act AS (
  SELECT DISTINCT s.player_id,
         date_diff('day', p.signup_date, CAST(s.started_at AS DATE)) AS day_n
  FROM sessions s JOIN players p USING (player_id)
), cohort AS (SELECT count(*) AS n FROM players)
SELECT n AS cohort_size,
       round(100.0 * count(DISTINCT player_id) FILTER (WHERE day_n = 1)  / n, 1) AS d1_pct,
       round(100.0 * count(DISTINCT player_id) FILTER (WHERE day_n = 7)  / n, 1) AS d7_pct,
       round(100.0 * count(DISTINCT player_id) FILTER (WHERE day_n = 14) / n, 1) AS d14_pct
FROM act, cohort
GROUP BY n;
```
The denominator is **all signups**, including player 20, who never played. Leaving out never-active users inflates retention, and interviewers check for it.
</details>

### 38. Weekly cohort retention matrix
Rows are signup weeks. Columns are weeks since signup (0 to 4). Cells hold % of the cohort active in that week.
Check: 7 row(s); columns `cohort_week, cohort_size, w0, w1, w2, w3, w4`; first: `(2025-12-29 00:00, 2, 100, 50, 0, 0, 0)`; `(2026-01-05 00:00, 4, 100, 100, 25, 0, 0)`; `(2026-01-12 00:00, 3, 100, 67, 67, 33, 0)`

<details><summary>Solution</summary>

```sql
-- Q38
WITH c AS (
  SELECT player_id, signup_date, date_trunc('week', signup_date) AS cohort_week FROM players
), a AS (
  SELECT DISTINCT s.player_id,
         date_diff('day', c.signup_date, CAST(s.started_at AS DATE)) // 7 AS wk
  FROM sessions s JOIN c USING (player_id)
), sz AS (
  SELECT cohort_week, count(*) AS n FROM c GROUP BY cohort_week
)
SELECT c.cohort_week, sz.n AS cohort_size,
       round(100.0 * count(DISTINCT a.player_id) FILTER (WHERE a.wk = 0) / sz.n) AS w0,
       round(100.0 * count(DISTINCT a.player_id) FILTER (WHERE a.wk = 1) / sz.n) AS w1,
       round(100.0 * count(DISTINCT a.player_id) FILTER (WHERE a.wk = 2) / sz.n) AS w2,
       round(100.0 * count(DISTINCT a.player_id) FILTER (WHERE a.wk = 3) / sz.n) AS w3,
       round(100.0 * count(DISTINCT a.player_id) FILTER (WHERE a.wk = 4) / sz.n) AS w4
FROM c
JOIN sz USING (cohort_week)
LEFT JOIN a USING (player_id)
GROUP BY c.cohort_week, sz.n
ORDER BY c.cohort_week;
```
The LEFT JOIN keeps players who never played in their cohort's denominator. Later cohorts have had less time, so their right-hand cells are incomplete and should be read as unknown, not 0.
</details>

### 39. Rolling (unbounded) retention
Per signup month: what % of the cohort was active on day 14 **or later**?
Check: 2 row(s); columns `cohort_month, cohort_size, rolling_d14_pct`; first: `(2026-01-01 00:00, 12, 25)`; `(2026-02-01 00:00, 8, 37.5)`

<details><summary>Solution</summary>

```sql
-- Q39
WITH last_seen AS (
  SELECT p.player_id, date_trunc('month', p.signup_date) AS cohort_month,
         max(date_diff('day', p.signup_date, CAST(s.started_at AS DATE))) AS last_day_n
  FROM players p LEFT JOIN sessions s USING (player_id)
  GROUP BY p.player_id, cohort_month
)
SELECT cohort_month, count(*) AS cohort_size,
       round(100.0 * count(*) FILTER (WHERE last_day_n >= 14) / count(*), 1) AS rolling_d14_pct
FROM last_seen
GROUP BY cohort_month
ORDER BY cohort_month;
```
Classic retention asks whether a player was active on day N exactly. Rolling retention asks whether they were active on day N or any later day. Rolling is always at least as high as classic, so always say which one you report.
</details>

### 40. Lifecycle status as of a date
Treat 2026-03-01 as the as-of date and label every player:
- `never_played`
- `active` (played in the last 7 days)
- `at_risk` (last played 8-14 days ago)
- `churned` (last played more than 14 days ago)

Count players per label and show their total revenue.
Check: 4 row(s); columns `status, players, revenue`; first: `(churned, 14, 16.83)`; `(active, 4, 3.96)`; `(at_risk, 1, 0)`

<details><summary>Solution</summary>

```sql
-- Q40
WITH params AS (SELECT DATE '2026-03-01' AS as_of),
last_play AS (
  SELECT p.player_id, max(CAST(s.started_at AS DATE)) AS last_d
  FROM players p LEFT JOIN sessions s USING (player_id) GROUP BY p.player_id
), labeled AS (
  SELECT l.player_id,
         CASE WHEN l.last_d IS NULL THEN 'never_played'
              WHEN date_diff('day', l.last_d, params.as_of) <= 7  THEN 'active'
              WHEN date_diff('day', l.last_d, params.as_of) <= 14 THEN 'at_risk'
              ELSE 'churned' END AS status
  FROM last_play l, params
)
SELECT status, count(*) AS players, coalesce(sum(r.rev), 0) AS revenue
FROM labeled
LEFT JOIN (SELECT player_id, sum(amount_usd) AS rev FROM purchases GROUP BY player_id) r USING (player_id)
GROUP BY status
ORDER BY players DESC, status;
```
Putting the as-of date in a `params` CTE means you change it in one place. A dbt model would do the same with a `var()`. Next step: a daily snapshot of this status table becomes a slowly changing dimension (SCD), which is the Data Engineer angle.
</details>

---

## What next
- Rewrite five of these against **Postgres** (`docker run -e POSTGRES_PASSWORD=pw -p 5432:5432 postgres:17`) and note every syntax change.
- Swap the seed for real data: GH Archive or NYC TLC (see `datasets.md`). The same sessionization and retention queries work on them.
- Interview drill: talk through Q27, Q31, Q35 and Q38 aloud in under 5 minutes each. Those four patterns cover most "hard SQL" screens.
