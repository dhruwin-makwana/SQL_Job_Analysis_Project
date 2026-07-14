/* This query retrieves the top paying skills for data analyst jobs, along with their average salaries and ranks.*/


SELECT skills,
    ROUND(AVG(salary_year_avg),2) AS avg_salary,
    DENSE_RANK() OVER (ORDER BY AVG(salary_year_avg) DESC) AS rank
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE salary_year_avg IS NOT NULL AND job_title_short ILIKE '%data analyst%'
GROUP BY skills
ORDER BY rank
