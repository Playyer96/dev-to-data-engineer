# Certifications: which ones help, what they cost, how to get them cheaper

Checked on 2026-11-21. Prices are list prices in USD before tax. Voucher campaigns come and go, so check the official page before you book.

## The honest take first

- For hiring, certifications **break ties**. They do not replace a portfolio. Recruiters for nearshore roles (US companies hiring in Colombia) mostly screen on SQL, Python, one cloud, dbt/Airflow/Spark, and real projects on GitHub.
- One cloud data cert plus one platform cert is enough. More than three starts to look like collecting.
- Your edge is 10+ years of backend work plus AWS (Lambda, Cognito). An AWS data cert turns that into a clear "data engineer on AWS" story quickly.
- No exam here is free by default. Every free route below is a time-limited campaign or a points program. Course materials are free; exams are not.

## Priority ranking for you

| Rank | Certification | Cost (list) | Why this order | Cheaper/free route |
|---|---|---|---|---|
| 1 | **AWS Certified Data Engineer - Associate (DEA-C01)** | $150 | Builds directly on your AWS experience. AWS shows up in a large share of DE job posts. Fastest win. | Free official exam prep on Skill Builder. After passing any AWS exam you get **50% off the next one**. Option: earn a free foundational voucher through AWS Educate / Emerging Talent Community, pass Cloud Practitioner or AI Practitioner, then take DEA-C01 for about $75. |
| 2 | **Databricks Certified Data Engineer Associate** | $200 | Spark + Delta Lake + Lakehouse show up in many DE posts. Works on any cloud. | **Databricks Learning Festival**: finish a self-paced pathway in Customer Academy during the event window and get a **50% voucher** (one per person per event; reported 90-day validity). Several festivals a year (2026 had March-April and June-July). Practice for free on Databricks Free Edition. |
| 3a (DE track) | **dbt Analytics Engineering Certification** | $200 | dbt is close to standard in modern data teams. dbt Labs recommends 6+ months of dbt use, so take it after your projects. | No regular free voucher. Free dbt Fundamentals badge in the meantime. |
| 3b (Analyst track) | **Microsoft PL-300: Power BI Data Analyst** | ~$165 US list, priced by country | Power BI appears in many analyst posts. Take this one if you go for analyst roles first. | Microsoft uses country pricing; open the exam page while signed in with Colombia as your country to see your price. Free practice assessment. Watch Fabric Community / Microsoft Learn campaigns for discount or free vouchers. |
| 4 | **Microsoft DP-700: Fabric Data Engineer Associate** | ~$165 US list, priced by country | Useful if you target companies on Microsoft stacks (many large local enterprises use Azure/Power BI; check the posts you target). | The Fabric Community has run **100% free voucher campaigns** for DP-600/DP-700 (for example a February 2026 offer and a later "Data Days" offer). Typical rules: join the community, watch sessions or finish Learn modules, score high on the official practice assessment, request a voucher, sit the exam by a deadline. Vouchers are limited and can take weeks to arrive. |
| 5 | **Astronomer Certification: Apache Airflow 3 Fundamentals** | $150 | Proves Airflow, which many DE posts ask for. Low priority unless free. | Astronomer regularly gives **free exam codes** at its certification crash-course webinars and workshops. Only take it with a free code. |
| 6 | **Google Cloud Professional Data Engineer** | $200 | Strong cert, but only worth it if you target GCP companies. The Zoomcamp already uses GCP, so you get some prep for free. | Renewal exam is $100. Free skill badges on Google Skills. No regular free voucher found. |
| 6 (alt) | **Google Cloud Associate Data Practitioner** | $125 | Easier entry-level GCP data cert. | Same as above. |
| Optional | **Google Data Analytics Professional Certificate** (Coursera, not a proctored exam) | Coursera subscription | Well-known brand for entry analyst roles. Less useful for a senior dev, but cheap with aid. | **Coursera Financial Aid** per course (see `courses.md`). |
| Optional | **Snowflake SnowPro** | Paid (check page) | Only if the posts you target ask for Snowflake. | Free courses on learn.snowflake.com. |
| Skip | AWS Cloud Practitioner / Azure DP-900 as goals in themselves | $100 / ~$99 | Too basic to impress for a senior dev. Only worth it as a free stepping stone to a 50% AWS discount. | AWS Educate / ETC voucher. |

**Recommended sequence:** AWS DEA-C01 (months 2-3) -> Databricks DE Associate on a 50% Learning Festival voucher (months 4-5) -> then dbt **or** PL-300 depending on which roles answer you. Pick up the Microsoft and Astronomer exams only when a free voucher shows up.

## Details per certification

### 1. AWS Certified Data Engineer - Associate (DEA-C01)
- Page: https://aws.amazon.com/certification/certified-data-engineer-associate/
- $150, 130 minutes, 65 questions (multiple choice / multiple response). Valid 3 years.
- Languages: English, Japanese, Korean, Simplified Chinese. **No Spanish**, so plan for English (Pearson VUE lets non-native speakers request +30 minutes; check the AWS testing policies).
- Free prep: https://skillbuilder.aws/exam-prep/data-engineer-associate (standard exam prep is free; enhanced prep and labs need a Skill Builder subscription).
- Topics: ingestion and transformation (Glue, Kinesis, MSK, DMS), storage (S3, Redshift, DynamoDB, Lake Formation), operations (Step Functions, MWAA, CloudWatch), security and governance.
- Discount: 50% off your next AWS exam after passing one (find it in your AWS Certification account).
- Free foundational voucher routes: AWS Educate https://aws.amazon.com/education/awseducate/ gives access to the Emerging Talent Community, where points from learning activities can be redeemed for vouchers (a readiness score of 70%+ is required). A 2026 AWS Builder Center post describes a Spanish-language LATAM offer where earning 21 badges gives a foundational voucher worth $100: https://builder.aws.com/content/3IYPWbbLaoeRdEl2zXNHLYjPRBA . Eligibility rules change, so check before you plan around it.

### 2. Databricks Certified Data Engineer Associate
- Page: https://www.databricks.com/learn/certification/data-engineer-associate
- $200, 90 minutes, 45 scored multiple-choice questions. Valid 2 years. Languages: English, Japanese, Brazilian Portuguese, Korean.
- Free prep: Customer Academy self-paced courses https://customer-academy.databricks.com/ and Free Edition https://www.databricks.com/learn/free-edition .
- 50% voucher: Learning Festivals announced on the Databricks Community "Learning Events" pages. Finish all modules of one pathway inside the event window. Many people reported that modules did not register as complete, so open every item in the course.
- Related: Databricks Certified Data Analyst Associate https://www.databricks.com/learn/certification/data-analyst-associate (analyst-track option).

### 3. dbt Analytics Engineering Certification
- Page: https://www.getdbt.com/certifications/analytics-engineer-certification-exam (overview: https://www.getdbt.com/dbt-certification )
- $200, 2 hours, 65 questions, 65% to pass, online proctored. Covers dbt 1.11. Offered in English, Japanese, **Spanish** and French.
- dbt Labs recommends SQL skills and 6+ months of dbt experience. Build the dbt project in your portfolio first.

### 4. Microsoft PL-300 and DP-700
- PL-300 (Power BI Data Analyst Associate): https://learn.microsoft.com/en-us/credentials/certifications/data-analyst-associate/
- DP-700 (Fabric Data Engineer Associate): https://learn.microsoft.com/en-us/credentials/certifications/fabric-data-engineer-associate/
- Related: DP-600 Fabric Analytics Engineer https://learn.microsoft.com/en-us/credentials/certifications/fabric-analytics-engineer-associate/ ; DP-900 https://learn.microsoft.com/en-us/credentials/certifications/azure-data-fundamentals/
- About $165 US list. Microsoft prices exams by country, so the Colombia price may be lower; the exam page shows your price once your profile country is set.
- Role-based certs last 1 year and **renew for free** with an online assessment on Microsoft Learn.
- Free: all training, practice assessments (https://learn.microsoft.com/en-us/credentials/certifications/practice-assessments-for-microsoft-certifications), and **Applied Skills** credentials (https://learn.microsoft.com/en-us/credentials/applied-skills/), which are free, hands-on and can go on LinkedIn.
- Free voucher campaigns: watch the Microsoft Fabric Community (community.fabric.microsoft.com) and Microsoft Learn challenges (https://learn.microsoft.com/en-us/training/challenges). 2026 campaigns gave 100% vouchers for DP-600/DP-700 with deadlines and limited supply.

### 5. Astronomer Airflow certifications
- Page: https://www.astronomer.io/certification/ ; free prep at https://academy.astronomer.io/
- Airflow Fundamentals: $150 list, 75 multiple-choice questions, 70% to pass (per Astronomer's study guide). DAG Authoring is the second-level exam.
- Free route: Astronomer's "Airflow certification crash course" webinars and workshops usually give a free exam code to attendees.

### 6. Google Cloud
- Professional Data Engineer: https://cloud.google.com/learn/certification/data-engineer . $200, 2 hours, 40-50 questions, valid 2 years, $100 renewal exam.
- Associate Data Practitioner: https://cloud.google.com/learn/certification/data-practitioner . $125, 2 hours.
- Free training: Google Skills (formerly Cloud Skills Boost) https://www.skills.google/ ; training paths https://cloud.google.com/learn/training/data-engineering-and-analytics
- Google sometimes runs "Get Certified" cohort programs with vouchers; none were found active when this was checked.

### Coursera certificates (Google Data Analytics, IBM Data Engineering)
- These are course certificates, not proctored exams. They help most for career changers without a tech background, less for you.
- Cost: Coursera subscription. Free route: **Financial Aid**, applied for course by course (see `courses.md`).

## Free voucher / discount cheat sheet

| Program | Gives | Where |
|---|---|---|
| AWS "50% off next exam" | 50% off any next AWS exam after passing one | AWS Certification account |
| AWS Educate / Emerging Talent Community | Points to redeem for foundational exam vouchers | https://aws.amazon.com/education/awseducate/ |
| Databricks Learning Festival | 50% off any Databricks cert | Databricks Community, Learning Events |
| Microsoft Fabric Community campaigns | Up to 100% off DP-600/DP-700 (limited, time-boxed) | community.fabric.microsoft.com |
| Microsoft Applied Skills | Free hands-on credentials | https://learn.microsoft.com/en-us/credentials/applied-skills/ |
| Astronomer webinars | Free Airflow exam code | https://www.astronomer.io/certification/ |
| DataTalksClub Zoomcamp | Free course certificate (live cohort + project) | https://github.com/DataTalksClub/data-engineering-zoomcamp |
| Coursera Financial Aid | Up to full course fee (recent reports: up to 90%) | Coursera Help Center article in `courses.md` |
