/*
Question : Quelles sont les compétences les plus demandées pour les analystes de données ?
- Joindre les offres d'emploi à une table de jointure interne similaire à la requête 2
- Identifier les 5 compétences les plus demandées pour un analyste de données.
- Concentrez-vous sur toutes les offres d'emploi.
- Pourquoi ? Pour obtenir les 5 compétences les plus demandées sur le marché de l'emploi, 
    et fournit des informations sur les compétences les plus utiles pour les demandeurs d'emploi.
*/


SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' 
    AND job_work_from_home = True 
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;


/*
Voici la répartition des compétences les plus demandées pour les analystes de données en 2023
SQL et Excel restent fondamentaux, soulignant la nécessité de solides compétences de base en matière de traitement des données et de manipulation des feuilles de calcul.
Les outils de programmation et de visualisation tels que Python, Tableau et Power BI sont essentiels, soulignant l'importance croissante des compétences techniques dans la narration des données et l'aide à la décision.

[
    {
    "skills": "sql",
    "demand_count": "7291"
  },
  {
    "skills": "excel",
    "demand_count": "4611"
  },
  {
    "skills": "python",
    "demand_count": "4330"
  },
  {
    "skills": "tableau",
    "demand_count": "3745"
  },
  {
    "skills": "power bi",
    "demand_count": "2609"
  }
]
*/