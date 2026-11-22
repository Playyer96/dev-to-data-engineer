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
