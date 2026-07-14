/* 
    This query retrieves the top 10 paying job postings for the job title "Data Analyst" that are located anywhere. 
    It then identifies the skills associated with these top-paying jobs and ranks them based on their frequency of occurrence.
    With this we can identify the most valuable skills for Data Analyst positions based on salary data.
*/

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