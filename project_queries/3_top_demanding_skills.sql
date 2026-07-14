SELECT skills, 
    COUNT(*) AS skill_count,
    DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS rank
FROM skills_job_dim
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
GROUP BY skills
ORDER BY rank
LIMIT 10