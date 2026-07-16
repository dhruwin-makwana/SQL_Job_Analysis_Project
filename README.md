# 📊 Data Analyst Job Market Analysis: A SQL Project

## 🌟 Introduction
🚀 Welcome to this SQL-driven exploration of the data analytics job market! This project dives into job posting data to uncover 💸 high-paying roles, 🛠️ sought-after skills, and 🎯 the sweet spot where market demand and lucrative salaries intersect.

Looking for the code? All SQL scripts can be found right here: [SQL Queries Folder](/project_queries/)

Looking for the data? All relevant CSVs can be found here: [Click here to visit Google Drive](https://www.lukeb.co/sql_project_csvs)

*(Note: The dataset used for this project was fetched from a sql course by 
Luke Barousse)*

## 🧠 Background
Navigating the modern job market can feel overwhelming. This project was initiated to demystify what employers are truly looking for in Data Analysts. By analyzing real-world job postings, the goal was to uncover actionable trends to help guide career development and pinpoint the most optimal skills to learn.

*(Note: The dataset used for this project contains detailed information on job titles, geographical locations, salary offerings, and skill requirements.)*

### 🎯 The core questions this project answers are:
1. Which Data Analyst roles offer the most competitive compensation? 💰
2. What specific skills are required for these top-tier jobs? 🔧
3. Which tools and technologies are currently dominating the market demand? 📈
4. How do different skills impact salary expectations for Data Analyst roles? 💵
5. What is the ultimate skill stack for maximizing both employability and income for Data Analyst roles? 🏆

## 🧰 Tools Used
To thoroughly investigate the data landscape, a modern data stack was utilized:
* **SQL:** The core engine of this project, used to extract, manipulate, and analyze large volumes of data. 🗄️
* **PostgreSQL:** The robust relational database system chosen to house and query the job posting dataset. 🐘
* **Visual Studio Code (VS Code):** The preferred IDE for writing, formatting, and executing SQL scripts. 💻
* **Git & GitHub:** Utilized for version control, project tracking, and sharing findings with the community. 🐙

## 🔬 The Analysis


### 1. Top Paying Data Analyst Jobs
This analysis explores the top 10 highest-paying remote ("Anywhere") job postings for Data Analysts in 2023. By analyzing these positions, we can uncover trends in compensation, seniority, and industry demand for top-tier data professionals.

```sql
SELECT job_id,
    job_title, 
    job_location,
    job_schedule_type,
    salary_year_avg, 
    job_posted_date,
    name AS company_name
FROM job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE job_title_short ILIKE '%data analyst%' 
    AND salary_year_avg IS NOT NULL
    AND job_location ILIKE 'anywhere'
ORDER BY salary_year_avg DESC
LIMIT 10
```

* **100% Remote Premium:** Every single top-paying role offers full remote flexibility ("Anywhere"), proving that top organizations pay premium Silicon Valley-level rates to secure global talent.

* **The Mantys Outlier:** At $650,000, the entry for Mantys is a massive statistical outlier—nearly double the second-highest salary—likely reflecting an equity-heavy package or specialized startup funding.

* **Leadership vs. Technical Mastery:** Executive roles (e.g., Meta, AT&T) lead the pack, but highly technical individual contributors (Principal Data Analysts) match them closely, commanding up to $205,000.

* **Cross-Industry Demand:** High-ticket data talent isn't exclusive to big tech; top salaries span Fintech (SmartAsset), Healthcare (Uclahealthcareers), Autonomous Vehicles (Motional), and AI.

![Top Paying Remote Data Analyst Jobs](/assets/top_paying_jobs.png)
*Bar graph visualizing the salary for the top 10 salaries for data analysts; Gemini generated this graph from my SQL query results*

### 2. Skills for Top Paying Jobs

This analysis matches the top 10 highest-paying remote Data Analyst jobs with their required technical skills to identify which toolsets command the highest market value.
```sql
WITH top_paying_job as(
    SELECT job_id,
        job_title, 
         salary_year_avg, 
        name AS company_name
    FROM job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE job_title_short ILIKE '%data analyst%' 
        AND salary_year_avg IS NOT NULL
        AND job_location ILIKE 'anywhere'
    ORDER BY salary_year_avg DESC
    LIMIT 10),

top_paying_skill as(
    SELECT top_paying_job.*,
    skills_dim.skills
FROM top_paying_job
INNER JOIN skills_job_dim ON top_paying_job.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC)

SELECT skills, 
    COUNT(*) AS skill_count,
    DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS rank
FROM top_paying_skill
GROUP BY skills
ORDER BY rank
LIMIT 10;
```


* **The Core Data Trifecta Rules:** **SQL** (8/10 postings), **Python** (7/10), and **Tableau** (6/10) dominate the list. Mastering these three foundational tools is the most reliable gateway to high-paying remote roles.
* **Modern Cloud Stack Emergence:** Cloud infrastructure and storage platforms like **AWS** (3 postings), **Snowflake** (3), and **Azure** (2) are highly represented, indicating that elite roles expect analysts to manage and query data natively in cloud environments.
* **Versatility in Scripting & Math:** The inclusion of **R** (3 postings), **Pandas** (3), and **Go** (2) alongside Python highlights that high-paying roles value programmatic data manipulation and statistical modeling over traditional basic spreadsheet work.
* **Spreadsheets Still Matter:** Despite the advanced tech stack, **Excel** remains a required tool in 3 of the top 10 positions, proving that spreadsheet proficiency is still essential for executive communication and quick modeling.


![Most In-Demand Skills for Top-Paying Remote Data Analyst Jobs in 2023](/assets/top_paying_skills.png)
*Bar graph visualizing the sMost In-Demand Skills for Top-Paying Remote Data Analyst Jobs in 2023; Gemini generated this graph from my SQL query results*


### 3. In-Demand Skills for Overall Roles

This analysis broadens the scope to the entire dataset, mapping out the top 10 most demanded skills across all technology, engineering, and data positions. This provides a macro-level view of the absolute most valuable skills in the modern tech ecosystem.

```sql
SELECT skills, 
    COUNT(*) AS skill_count,
    DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS rank
FROM skills_job_dim
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
GROUP BY skills
ORDER BY rank
LIMIT 10
```

* **The Undisputed Industry Giants:** **SQL** (~385K postings) and **Python** (~381K postings) stand shoulder-to-shoulder at the very top. Regardless of whether you are in data, software engineering, or DevOps, these two languages form the baseline foundation of the modern tech stack.
* **Cloud Platform Dominance:** **AWS** (~145K) and **Azure** (~132K) both rank in the top 5, highlighting that cloud architecture and cloud-native development are universal priorities for employers across almost all engineering disciplines.
* **Data Engineering & Scale:** The heavy presence of **R** (~131K), **Spark** (~114K), and **Java** (~85K) points to a massive industry-wide focus on enterprise-scale software development, statistical modeling, and big data pipeline management.
* **Universal Business Intelligence:** Even in a general tech dataset, visual and spreadsheet tools like **Tableau** (~127K), **Excel** (~127K), and **Power BI** (~98K) command major real estate, proving that data literacy and dashboarding remain critical requirements across all technical domains.

![Top 10 Most In-Demand Data Analyst Skills by Overall Job Postings](/assets/most_in_demand_skills_overall.png)
*Bar graph visualizing the Top 10 Most In-Demand Data Analyst Skills by Overall Job Postings; Gemini generated this graph from my SQL query results*

### 4. Skills Based on Salary
This analysis shifts the focus to compensation, identifying the individual technical skills that yield the highest average yearly salaries for Data Analysts.

```sql
SELECT skills,
    ROUND(AVG(salary_year_avg),2) AS avg_salary,
    DENSE_RANK() OVER (ORDER BY AVG(salary_year_avg) DESC) AS rank
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE salary_year_avg IS NOT NULL AND job_title_short ILIKE '%data analyst%'
GROUP BY skills
ORDER BY rank
```

* **Niche Systems & Version Control Premium:** **SVN** (Apache Subversion) leads with an average salary of **$400,000**, followed by virtual infrastructure tool **VMware** (**$261,250**) and resource manager **Yarn** (**$219,575**). These high figures suggest that Data Analysts operating within legacy corporate systems, systems engineering, or dev-ops-adjacent pipelines command an extreme financial premium.
* **API Development & Backend Integration:** Modern backend programming languages and microservice frameworks like **FastAPI** (**$185,000**) and **Go/Golang** (**$162,833**) are highly compensated. Analysts who can build or interface directly with APIs to deploy models yield significantly higher salaries.
* **Specialized Web3 & Database Technologies:** Specialized data handling tools such as **Solidity** (**$179,000** for Ethereum/Blockchain data analysis) and **Couchbase** (**$160,515** for NoSQL document databases) show that moving beyond relational SQL into non-relational and decentralized data spaces is exceptionally lucrative.
* **Advanced Statistics & Modeling:** Deep learning frameworks like **MXNet** (**$149,000**) and specialized R-packages like **dplyr** (**$147,633**) rank high on the list, confirming that advanced programmatical manipulation and machine learning applications pay better than standard visualization-only analyst roles.critical requirements across all technical domains.

![Top 10 Highest Paying Skills for Data Analysts in 2023](/assets/top_paying_skills_data_analysts.png)
*Bar graph visualizing the Top 10 Highest Paying Skills for Data Analysts in 2023; Gemini generated this graph from my SQL query results*

### 5. Most Optimal Skills to Learn
This analysis compares the top 15 most in-demand skills for Data Analysts against their average yearly salaries. By looking at both metrics side-by-side, we can identify which skills offer the highest return on investment (ROI) for job seekers.

```sql
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    demand_count DESC,
    avg_salary DESC
LIMIT 25;
```

* **The High-Yield Standard (SQL & Python):** **SQL** (3,083 postings) and **Python** (1,840 postings) are not only the most requested skills in the market, but they also command highly competitive average salaries of **$96,435** and **$101,512** respectively. This makes them the ultimate baseline skills for any analyst.
* **The Big Data & Cloud Salary Premium:** While tools like **AWS** (291 postings), **Azure** (319 postings), and cloud platforms have lower volume demand, they yield some of the highest salaries in the dataset (averaging **$106,440** and **$105,400**). If you want to maximize your earning potential, specialize in cloud data engineering.
* **The "Office Suite" Discount:** Traditional tools like **Excel** (2,143 postings), **Word** (527 postings), and **PowerPoint** (524 postings) maintain high-to-moderate demand but represent the lower tier of compensation (averaging **$82,000 to $88,000**). Modern analytics demands moving beyond spreadsheets to programming languages.
* **Visual BI Platform Rivalry:** **Tableau** leads both in market demand (1,659 postings vs. **Power BI's** 1,044) and in average compensation (**$97,978** vs. **Power BI's** **$92,324**), making Tableau slightly more lucrative for BI specialists in this dataset.

![Data Analyst Skills: Demand vs Average Salary](/assets/demand_vs_salary_side_by_side.png)
*Bar graph visualizing the Data Analyst Skills: Demand vs Average Salary; Gemini generated this graph from my SQL query results*


## 📚 Key Learnings
This project served as a comprehensive exercise to level up technical skills. Here are a few key takeaways:
* **Advanced SQL Techniques:** Hands-on experience was gained writing complex queries, utilizing `JOIN`s to connect multiple tables, and leveraging CTEs (`WITH` clauses) to keep the code clean and readable and `RANK` Window Functions to sort the relevance of skills. 🧩
* **Data Aggregation:** High proficiency was developed using `GROUP BY` alongside aggregate functions like `COUNT()` and `AVG()` to summarize vast amounts of raw data into digestible, high-level metrics. 📊
* **Strategic Problem Solving:** This project bridged the gap between raw data and real-world business questions, translating natural curiosity into structured, insightful SQL commands. 💡

## 🏁 Conclusions

### 🔍 Key Insights

1. **High-Value Remote Portability**

    Remote "Anywhere" job openings for Data Analysts command exceptional compensation, averaging over $264,600 annually. Top-tier companies are highly competitive and willing to pay premium, Silicon Valley-level salaries to secure elite remote talent globally.

2. **Universal Tech Ecosystem Foundations**

   Across the broader technology landscape, SQL and Python are the undisputed, dominant tools. Their massive, nearly identical volume of job postings (over 380,000 each) confirms that proficiency in these languages is a universal requirement across technical disciplines.

3. **The Gatekeepers of Elite Analyst Roles**

   Within the highest-paying remote Data Analyst jobs, a core trifecta of SQL (80% representation), Python (70%), and Tableau (60%) emerges as the primary toolkit. Mastering these three core technologies is the most critical checkpoint for bridging the gap into top-tier compensation brackets.

4. **The Skill ROI Sweet Spot**

   There is a distinct trade-off between a skill's sheer volume and its paycheck value. While traditional tools like Excel have massive market demand (over 2,100 postings) they yield a lower average salary (~$86,400). Transitioning to cloud-native big data tools like Spark ($113,000 avg.) and Snowflake ($111,500 avg.) represents the optimal path for maximizing salary return.

5. **The Systems & Infrastructure Premium**

   The highest average salaries are not yielded by standard visualization tools, but by developer-adjacent, specialized engineering skills. Technologies like legacy version control systems (SVN at $400,000), virtualization platforms (VMware at $261,250), and backend framework integrations (FastAPI at $185,000) command an extreme premium for analysts.

### 💭 Closing Thoughts
This project was a stepping stone in advancing SQL proficiency while simultaneously uncovering practical truths about the data industry. The findings provide a clear, data-backed roadmap for anyone looking to upskill efficiently and target the most rewarding opportunities in data analytics. By focusing on high-demand, high-salary skills, aspiring analysts can strategically position themselves to stand out in a highly competitive job market. 🚀