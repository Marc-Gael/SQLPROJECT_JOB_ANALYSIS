# Introduction
📊 Plongez dans le marché des emplois liés aux données ! En vous concentrant sur les rôles d'analyste de données, ce projet explore 💰 les emplois les mieux rémunérés, 🔥 les compétences les plus demandées et 📈 où une forte demande rencontre des salaires élevés dans l'analyse des données.

🔍 Requêtes SQL ? Consultez-les ici : [project_sql folder](/project_sql/)

# Contexte
Animé par une quête pour naviguer plus efficacement sur le marché des emplois d'analyste de données, ce projet est né du désir d'identifier les compétences les mieux rémunérées et les plus demandées, simplifiant ainsi le travail des autres pour trouver des emplois optimaux.

Les données proviennent de mon [SQL Course](https://lukebarousse.com/sql). Elles contiennent des informations sur les intitulés de postes, les salaires, les lieux et les compétences essentielles.

### Les questions auxquelles je voulais répondre grâce à mes requêtes SQL :

1. Quels sont les emplois d'analyste de données les mieux rémunérés ?
2. Quelles compétences sont requises pour ces emplois bien rémunérés ?
3. Quelles compétences sont les plus demandées pour les analystes de données ?
4. Quelles compétences sont associées à des salaires plus élevés ?
5. Quelles sont les compétences les plus optimales à apprendre ?

# Outils Utilisés
Pour ma plongée dans le marché des emplois d'analyste de données, j'ai utilisé plusieurs outils clés :

- **SQL** : L'élément central de mon analyse, me permettant d'interroger la base de données et de découvrir des informations critiques.
- **Visual Studio Code** : Mon outil préféré pour la gestion des bases de données et l'exécution des requêtes SQL.
- **Git & GitHub** : Essentiels pour le contrôle des versions et le partage de mes scripts SQL et analyses, permettant la collaboration et le suivi du projet.

# L'Analyse
Chaque requête de ce projet visait à explorer des aspects spécifiques du marché des emplois d'analyste de données. Voici comment j'ai abordé chaque question :

### 1. Emplois d'Analyste de Données les Mieux Rémunérés
Pour identifier les rôles les mieux rémunérés, j'ai filtré les postes d'analyste de données par salaire annuel moyen et localisation, en me concentrant sur les emplois à distance. Cette requête met en évidence les opportunités les mieux rémunérées dans le domaine.


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
Voici les résultats des emplois d'analyste de données en 2023:
- **Large plage salariale:** Les 10 postes les mieux rémunérés varient entre 184 000 $ et 650 000 $, montrant un potentiel salarial important.
- **Employeurs diversifiés:** Des entreprises comme SmartAsset, Meta et AT&T figurent parmi celles offrant les meilleurs salaires, démontrant un intérêt à travers différents secteurs.
- **Variété des intitulés de poste:** Une grande diversité d'intitulés de postes, allant d'analyste de données à directeur de l'analyse, reflète des rôles variés et des spécialisations dans l'analyse de données.

![Top Paying Roles](assets/1_top_paying_roles.png)
*Graphique représentant les salaires des 10 emplois les mieux rémunérés pour les analystes de données ; généré à partir des résultats de mes requêtes SQL.*

### 2. Compétences pour les Emplois Bien Rémunérés
Pour comprendre quelles compétences sont nécessaires pour les postes les mieux rémunérés, j'ai relié les offres d'emploi aux données sur les compétences, fournissant des informations sur ce que les employeurs valorisent pour les rôles à forte rémunération.
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
Voici les compétences les plus demandées pour les 10 emplois d'analyste de données les mieux rémunérés en 2023:
- **SQL** est en tête avec une forte occurrence.
- **Python** suit de près.
- **Tableau** est également très recherché. D'autres compétences comme **R**, **Snowflake**, **Pandas**, et **Excel** montrent divers degrés de demande.

![Top Paying Skills](assets/2_top_paying_roles_skills.png)
*Graphique à barres visualisant le nombre de compétences pour les 10 emplois les mieux rémunérés pour les analystes de données ; ChatGPT a généré ce graphique à partir des résultats de ma requête SQL.*

### 3. Compétences les Plus Demandées pour les Analystes de Données

Cette requête a permis d’identifier les compétences les plus fréquemment demandées dans les offres d'emploi, en mettant l'accent sur les domaines où la demande est élevée.

```sql
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
```
Voici les compétences les plus demandées pour les analystes de données en 2023 :
- **SQL** et **Excel** restent des compétences fondamentales, soulignant l’importance de solides bases dans le traitement des données et la manipulation de feuilles de calcul.
- Les outils de **Programmation** et de **Visualizsation** comme **Python**, **Tableau**, et **Power BI** sont essentiels, ce qui reflète l'importance croissante des compétences techniques pour la narration de données et l'aide à la décision.

| Skills   | Demand Count |
|----------|--------------|
| SQL      | 7291         |
| Excel    | 4611         |
| Python   | 4330         |
| Tableau  | 3745         |
| Power BI | 2609         |

*Tableau des compétences les plus demandées dans les offres d’emploi pour les analystes de données.*

### 4. Compétences Basées sur le Salaire
L'exploration des salaires moyens associés à différentes compétences a permis d'identifier celles qui offrent les meilleurs revenus.
```sql
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
```
Voici une synthèse des compétences les mieux rémunérées pour les analystes de données:
- **Grande demande pour les compétences Big Data et Machine Learning:** Les meilleurs salaires sont associés à des compétences en technologies Big Data (PySpark, Couchbase), outils de machine learning (DataRobot, Jupyter) et bibliothèques Python (Pandas, NumPy), ce qui reflète une valorisation élevée des capacités de traitement des données et de modélisation prédictive.
- **Maîtrise du développement et du déploiement logiciel:**  La connaissance des outils de développement et de déploiement (GitLab, Kubernetes, Airflow) ouvre des passerelles lucratives entre l'analyse de données et l'ingénierie.
- **Expertise en informatique dématérialisée:** La maîtrise des outils de cloud computing et d'ingénierie des données (Elasticsearch, Databricks, GCP) est un atout majeur, renforçant la pertinence des environnements analytiques dans le cloud.

| Skills        | Average Salary ($) |
|---------------|-------------------:|
| pyspark       |            208,172 |
| bitbucket     |            189,155 |
| couchbase     |            160,515 |
| watson        |            160,515 |
| datarobot     |            155,486 |
| gitlab        |            154,500 |
| swift         |            153,750 |
| jupyter       |            152,777 |
| pandas        |            151,821 |
| elasticsearch |            145,000 |

*Tableau des compétences les mieux rémunérées pour les analystes de données.*

### 5. Compétences les Plus Optimales à Apprendre

En combinant les données sur la demande et les salaires, cette requête a permis d’identifier les compétences à la fois en forte demande et bien rémunérées, offrant un point focal stratégique pour le développement des compétences.

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
    AND job_work_from_home = True 
GROUP BY
    skills_dim.skill_idKnowledge
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```

| Skill ID | Skills     | Demand Count | Average Salary ($) |
|----------|------------|--------------|-------------------:|
| 8        | go         | 27           |            115,320 |
| 234      | confluence | 11           |            114,210 |
| 97       | hadoop     | 22           |            113,193 |
| 80       | snowflake  | 37           |            112,948 |
| 74       | azure      | 34           |            111,225 |
| 77       | bigquery   | 13           |            109,654 |
| 76       | aws        | 32           |            108,317 |
| 4        | java       | 17           |            106,906 |
| 194      | ssis       | 12           |            106,683 |
| 233      | jira       | 20           |            104,918 |

*Tableau des compétences les plus optimales pour un analyste de données triées par salaire*

Voici une répartition des compétences les plus optimales pour les analystes de données en 2023: 
- **Langages de programmation à forte demande:** Python et R se démarquent par leur forte demande, avec un nombre de demandes respectif de 236 et 148. Malgré cette forte demande, leurs salaires moyens sont d'environ 101 397 $ pour Python et 100 499 $ pour R, ce qui indique que la maîtrise de ces langages est très valorisée mais également largement répandue.
- **Outils et technologies cloud:** Les compétences dans des technologies spécialisées telles que Snowflake, Azure, AWS et BigQuery affichent une demande significative avec des salaires moyens relativement élevés, soulignant l'importance croissante des plateformes cloud et des technologies Big Data dans l'analyse de données.
- **Outils de Business Intelligence et de Visualisation:** Tableau et Looker, avec des nombres de demandes respectifs de 230 et 49, et des salaires moyens autour de 99 288 $ et 103 795 $, soulignent le rôle essentiel de la visualisation des données et de la business intelligence dans l'extraction d'insights actionnables à partir des données.
- **Technologies de bases de données:** La demande de compétences dans les bases de données traditionnelles et NoSQL (Oracle, SQL Server, NoSQL), avec des salaires moyens allant de 97 786 $ à 104 534 $, reflète le besoin constant d'expertise en stockage, récupération et gestion des données.

# Ce que j'ai appris

Tout au long de cette aventure, j'ai considérablement renforcé mon arsenal SQL avec des outils puissants:

- **🧩 Création de requêtes complexes:** J'ai maîtrisé l'art du SQL avancé, fusionnant les tables comme un expert et utilisant les clauses WITH pour des manœuvres de tables temporaires de niveau ninja.
- **📊 Agrégation de données:** Je me suis familiarisé avec le GROUP BY et j'ai transformé des fonctions d'agrégation comme COUNT() et AVG() en mes alliées pour résumer les données.
- **💡 Magie analytique:** J'ai amélioré mes compétences en résolution de problèmes concrets, transformant des questions en requêtes SQL actionnables et perspicaces.

# Conclusions

### Insights
De l'analyse, plusieurs conclusions générales ont émergé:

1. **Emplois d'Analyste de Données les Mieux Rémunérés**: Les emplois les mieux rémunérés pour les analystes de données permettant le travail à distance offrent une large gamme de salaires, le plus élevé étant de 650 000 $ !
2. **Compétences pour les Emplois Bien Rémunérés**: Les emplois d'analyste de données bien rémunérés nécessitent une maîtrise avancée de SQL, ce qui suggère que c'est une compétence essentielle pour obtenir un salaire élevé.
3. **Compétences les Plus Demandées**: SQL est également la compétence la plus demandée sur le marché des emplois d'analyste de données, ce qui en fait une compétence essentielle pour les chercheurs d'emploi.
4. **Compétences avec des Salaires Plus Élevés**: Les compétences spécialisées, telles que SVN et Solidity, sont associées aux salaires moyens les plus élevés, ce qui indique une valorisation accrue de l'expertise de niche.
5. **Compétences Optimales pour la Valeur sur le Marché du Travail**: SQL domine en termes de demande et d'offres pour un salaire moyen élevé, le positionnant comme l'une des compétences les plus optimales à apprendre pour les analystes de données afin de maximiser leur valeur sur le marché.
