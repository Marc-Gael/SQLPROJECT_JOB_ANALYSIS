
# Introduction
📊 Plongez dans le marché des emplois liés aux données ! En mettant l'accent sur les rôles d'analyste de données, ce projet explore les emplois les mieux rémunérés, les compétences les plus demandées et là où une forte demande rencontre des salaires élevés dans l'analyse de données.

🔍 Requêtes SQL ? Découvrez-les ici : [Dossier SQL du projet](/project_sql/)

# Contexte
Motivé par le besoin de mieux naviguer sur le marché des emplois d'analyste de données, ce projet est né du désir d'identifier les compétences les mieux rémunérées et les plus demandées, tout en facilitant le travail des autres pour trouver des emplois optimaux.

Les données proviennent de mon [cours SQL](https://lukebarousse.com/sql). Elles contiennent des informations sur les intitulés de postes, les salaires, les lieux et les compétences essentielles.

### Les questions auxquelles je voulais répondre avec mes requêtes SQL :
1. Quels sont les emplois d'analyste de données les mieux rémunérés ?
2. Quelles compétences sont requises pour ces emplois bien payés ?
3. Quelles compétences sont les plus demandées pour les analystes de données ?
4. Quelles compétences sont associées à des salaires plus élevés ?
5. Quelles sont les compétences les plus optimales à apprendre ?

# Outils utilisés
Pour plonger dans le marché des emplois d'analyste de données, j'ai utilisé plusieurs outils clés :

- **SQL** : L'élément central de mon analyse, me permettant d'interroger la base de données et de découvrir des insights essentiels.
- **PostgreSQL** : Le système de gestion de bases de données choisi, idéal pour gérer les données d'offres d'emploi.
- **Visual Studio Code** : Mon éditeur favori pour la gestion des bases de données et l'exécution des requêtes SQL.
- **Git & GitHub** : Indispensables pour le contrôle des versions et le partage de mes scripts SQL et analyses, permettant la collaboration et le suivi du projet.

# Analyse
Chaque requête de ce projet visait à explorer des aspects spécifiques du marché des emplois d'analyste de données. Voici comment j'ai abordé chaque question :

### 1. Emplois d'analyste de données les mieux rémunérés
Pour identifier les postes les mieux rémunérés, j'ai filtré les offres en fonction du salaire annuel moyen et de la localisation, en me concentrant sur les emplois à distance.

```sql
SELECT	
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND 
    job_location = 'Anywhere' AND 
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```

Voici les résultats :
- **Plage de salaires large :** Les 10 postes d'analyste de données les mieux rémunérés vont de 184 000 $ à 650 000 $, indiquant un potentiel salarial important.
- **Employeurs diversifiés :** Des entreprises comme SmartAsset, Meta et AT&T figurent parmi celles offrant des salaires élevés.
- **Variété des intitulés de poste :** Une diversité élevée dans les intitulés de postes, allant d'analyste de données à directeur de l'analyse, reflète les spécialisations dans le domaine.

![Rôles les mieux rémunérés](assets/1_top_paying_roles.png)

### 2. Compétences pour les emplois bien rémunérés
Pour comprendre quelles compétences sont nécessaires, j'ai relié les offres d'emploi aux données sur les compétences.

```sql
WITH top_paying_jobs AS (
    SELECT	
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst' AND 
        job_location = 'Anywhere' AND 
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;
```

Les compétences les plus demandées pour les postes les mieux rémunérés sont :
- **SQL** en tête avec un nombre élevé d'occurrences.
- **Python** arrive en deuxième position.
- **Tableau** est également très recherché.

...

# Ce que j'ai appris
- **Requêtes complexes** : Utilisation avancée des jointures et des clauses `WITH`.
- **Agrégation de données** : Maîtrise des fonctions comme `COUNT()` et `AVG()`.
- **Compétences analytiques** : Résolution de problèmes réels grâce à SQL.

