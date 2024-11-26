/*
Question : Quelles sont les compétences les plus importantes en termes de salaire ?
- Consultez le salaire moyen associé à chaque compétence pour les postes d'analystes de données.
- Se concentre sur les rôles avec des salaires spécifiques, indépendamment du lieu.
- Pourquoi ? Cela révèle l'impact des différentes compétences sur les niveaux de salaire des analystes de données et 
    permet d'identifier les compétences les plus rémunératrices à acquérir ou à améliorer.
*/

SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True 
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;


/*
Voici une ventilation des résultats concernant les compétences les mieux rémunérées pour les analystes de données :
- Forte demande de compétences en Big Data et ML : Les salaires les plus élevés sont perçus par les analystes qui maîtrisent les technologies Big Data (PySpark, Couchbase), les outils d'apprentissage automatique (DataRobot, Jupyter) et les bibliothèques Python (Pandas, NumPy), ce qui reflète l'importance accordée par le secteur aux capacités de traitement des données et de modélisation prédictive.
- Compétences en matière de développement et de déploiement de logiciels : La connaissance des outils de développement et de déploiement (GitLab, Kubernetes, Airflow) indique un croisement lucratif entre l'analyse de données et l'ingénierie, avec une prime aux compétences qui facilitent l'automatisation et la gestion efficace des pipelines de données.
- Expertise en matière de cloud computing : La familiarité avec les outils de cloud et d'ingénierie des données (Elasticsearch, Databricks, GCP) souligne l'importance croissante des environnements d'analyse basés sur le cloud, ce qui suggère que la maîtrise du cloud stimule considérablement le potentiel de rémunération dans l'analyse des données.


[
  {
    "skills": "pyspark",
    "avg_salary": "208172"
  },
  {
    "skills": "bitbucket",
    "avg_salary": "189155"
  },
  {
    "skills": "couchbase",
    "avg_salary": "160515"
  },
  {
    "skills": "watson",
    "avg_salary": "160515"
  },
  {
    "skills": "datarobot",
    "avg_salary": "155486"
  },
  {
    "skills": "gitlab",
    "avg_salary": "154500"
  },
  {
    "skills": "swift",
    "avg_salary": "153750"
  },
  {
    "skills": "jupyter",
    "avg_salary": "152777"
  },
  {
    "skills": "pandas",
    "avg_salary": "151821"
  },
  {
    "skills": "elasticsearch",
    "avg_salary": "145000"
  },
  {
    "skills": "golang",
    "avg_salary": "145000"
  },
  {
    "skills": "numpy",
    "avg_salary": "143513"
  },
  {
    "skills": "databricks",
    "avg_salary": "141907"
  },
  {
    "skills": "linux",
    "avg_salary": "136508"
  },
  {
    "skills": "kubernetes",
    "avg_salary": "132500"
  },
  {
    "skills": "atlassian",
    "avg_salary": "131162"
  },
  {
    "skills": "twilio",
    "avg_salary": "127000"
  },
  {
    "skills": "airflow",
    "avg_salary": "126103"
  },
  {
    "skills": "scikit-learn",
    "avg_salary": "125781"
  },
  {
    "skills": "jenkins",
    "avg_salary": "125436"
  },
  {
    "skills": "notion",
    "avg_salary": "125000"
  },
  {
    "skills": "scala",
    "avg_salary": "124903"
  },
  {
    "skills": "postgresql",
    "avg_salary": "123879"
  },
  {
    "skills": "gcp",
    "avg_salary": "122500"
  },
  {
    "skills": "microstrategy",
    "avg_salary": "121619"
  }
]
*/