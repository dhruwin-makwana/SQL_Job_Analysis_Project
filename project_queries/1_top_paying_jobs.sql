/* 
    This query retrieves the top 10 highest paying job postings for "data analyst" positions that are located "anywhere". 
    It selects relevant job details including job ID, title, location, schedule type, average yearly salary, posted date, and company name.
    The results are ordered by average yearly salary in descending order.
*/

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
