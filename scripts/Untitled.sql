-- The dataset for this exercise has been derived from the `Indeed Data Scientist/Analyst/Engineer` [dataset](https://www.kaggle.com/elroyggj/indeed-dataset-data-scientistanalystengineer) on kaggle.com. 

-- Before beginning to answer questions, take some time to review the data dictionary and familiarize yourself with the data that is contained in each column.

-- #### Provide the SQL queries and answers for the following questions/tasks using the data_analyst_jobs table you have created in PostgreSQL:

-- 1.	How many rows are in the data_analyst_jobs table?

SELECT COUNT(*)
FROM data_analyst_jobs

--ANSWER: 1793

-- 2.	Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row?

SELECT *
FROM data_analyst_jobs
LIMIT 10

--ANSWER: ExxonMobil

-- 3.	How many postings are in Tennessee? How many are there in either Tennessee or Kentucky?

SELECT COUNT(location)
FROM data_analyst_jobs
WHERE location = 'TN';

SELECT COUNT(location)
FROM data_analyst_jobs
WHERE location = 'TN' OR location = 'KY';

--ANSWER: 21, 27

-- 4.	How many postings in Tennessee have a star rating above 4?

SELECT COUNT(location)
FROM data_analyst_jobs
WHERE star_rating>4
AND location = 'TN';

--ANSWER: 3

-- 5.	How many postings in the dataset have a review count between 500 and 1000?

SELECT COUNT(title)
FROM data_analyst_jobs
WHERE review_count BETWEEN 500 AND 1000;

--ANSWER: 151

-- 6.	Show the average star rating for companies in each state. The output should show the state as `state` and the average rating for the state as `avg_rating`. Which state shows the highest average rating?

SELECT location AS state, AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
GROUP BY location
ORDER BY avg_rating DESC;

--ANSWER: NE

-- 7.	Select unique job titles from the data_analyst_jobs table. How many are there?

SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs;

--ANSWER: 881

-- 8.	How many unique job titles are there for California companies?

SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs
WHERE location = 'CA';

--ANSWER 230

-- 9.	Find the name of each company and its average star rating for all companies that have more than 5000 reviews across all locations. How many companies are there with more that 5000 reviews across all locations?

SELECT company, AVG(star_rating) as avg_rating, SUM(review_count)
FROM data_analyst_jobs
GROUP BY company
HAVING SUM(review_count)>5000;

--ANSWER: 71

-- 10.	Add the code to order the query in #9 from highest to lowest average star rating. Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? What is that rating?

SELECT company, AVG(star_rating) as avg_rating, SUM(review_count)
FROM data_analyst_jobs
GROUP BY company
HAVING SUM(review_count)>5000
ORDER BY avg_rating DESC;

--ANSWER Google, 4.3

-- 11.	Find all the job titles that contain the word ‘Analyst’. How many different job titles are there? 

SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs
WHERE LOWER(title) LIKE '%analyst%';

--ANSWER: 774

-- 12.	How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? What word do these positions have in common?

SELECT title
FROM data_analyst_jobs
WHERE LOWER(title) NOT LIKE '%analyst%'
AND LOWER(title) NOT LIKE '%analytics%';

--ANSWER: 4; Tableau

-- **BONUS:**


-- You want to understand which jobs requiring SQL are hard to fill. Find the number of jobs by industry (domain) that require SQL and have been posted longer than 3 weeks. 


SELECT domain, count(title)
FROM data_analyst_jobs
WHERE LOWEr(skill) LIKE '%sql%'
AND days_since_posting > 21
GROUP BY domain;

--ANSWER: 15

--  - Disregard any postings where the domain is NULL. 

SELECT domain, count(title)
FROM data_analyst_jobs
WHERE LOWER(skill) LIKE '%sql%'
AND days_since_posting > 21
AND domain IS NOT NULL
GROUP BY domain;


--  - Order your results so that the domain with the greatest number of `hard to fill` jobs is at the top. 

SELECT domain, count(title) as jobs
FROM data_analyst_jobs
WHERE LOWER(skill) LIKE '%sql%'
AND days_since_posting > 21
AND domain IS NOT NULL
GROUP BY domain
ORDER BY jobs DESC;

--   - Which three industries are in the top 4 on this list? How many jobs have been listed for more than 3 weeks for each of the top 4?

--ANSWER: Internet and Software (62), Banks and Financial Services (61), Consulting and Business Services (57), Health Care (52)
