
-- PART TWO: Exploatory Data Analysis


/* --------------------
   Case Study Questions
   --------------------*/


-- 1. How do layoff statistics vary across different companies?
-- 1.1. Total Layoffs of Each Company
-- 1.2. Companies with the Highest Number of Layoffs in a Single Event

-- 2. What are the yearly trends in layoffs from 2020 to 2023?
-- 2.1. Number of Layoffs by Year
-- 2.2. Ranking Companies by Number of Layoffs for Each Year

-- 3. Which industries experienced the highest number of layoffs?
-- 3.1. Number of Companies and Layoffs per Industry
-- 3.2. Top 3 Industries in Each Year that Laid Off Employees

-- 4. How does the geographical distribution of layoffs vary across different countries?
-- 4.1. Number of Layoffs and Companies per Country
-- 4.2. Percentage of Companies that Closed Down Due to Layoffs per Country

-- 5. How do layoffs differ across various stages of company maturity?
-- 5.1. Number of Layoffs and Companies per Business Stage
-- 5.2. Percentage of Companies that Closed Down Due to Layoffs per Business Stage



SELECT * 
FROM layoffs_staging2;



-- 1. How do layoff statistics vary across different companies?

-- 1.1. Total Layoffs of each company

SELECT 
    company,
    SUM(COALESCE(total_laid_off, 0)) AS Total_Layoffs
FROM layoffs_staging2
GROUP BY company
ORDER BY Total_Layoffs DESC;


-- 1.2. Companies with the Highest Number of Layoffs in a Single Event

SELECT 
    company,
    MAX(COALESCE(total_laid_off, 0)) AS Max_Laid_Off
FROM layoffs_staging2
GROUP BY company
ORDER BY Max_Laid_Off DESC
LIMIT 10;



-- 2. What are the yearly trends in layoffs from 2020 to 2023?

-- 2.1. Number of Layoffs by year

SELECT 
	YEAR(`date`) AS `Year`, 
	SUM(total_laid_off) AS Total_Layoffs,
	COUNT(*) AS num_of_layoffs_announced
FROM layoffs_staging2
GROUP BY YEAR(`date`)
HAVING `Year` IS NOT NULL
ORDER BY `Year` ASC;


-- 2.2. Ranking companies by number of layoffs for each year

WITH company_year (company, industry, `year`, total_laid_off) AS
(
SELECT company, industry, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, industry, YEAR(`date`)
ORDER BY 4 DESC
),
company_rank AS
(
SELECT *,
 DENSE_RANK() OVER(PARTITION BY `year` ORDER BY total_laid_off DESC) AS layoff_ranking
FROM company_year
WHERE `year` IS NOT NULL
)
SELECT *
FROM company_rank
WHERE layoff_ranking <= 3
ORDER BY `year`, layoff_ranking;



-- 3. Which industries experienced the highest number of layoffs?

-- 3.1. Number of companies and layoffs per industry.

SELECT 
	industry, 
	COUNT(DISTINCT company) AS num_of_companies, 
	SUM(total_laid_off) AS num_of_layoffs
FROM layoffs_staging2
GROUP BY industry
ORDER BY num_of_layoffs DESC;


-- 3.2. Top 3 industries in each year that laid off their employees

WITH top_industries AS
(
SELECT industry, YEAR(`date`) as year_of_layoff, SUM(total_laid_off) AS total_laid_off_in_a_year
FROM layoffs_staging2
GROUP BY industry, year_of_layoff
),
industry_ranking AS
(
SELECT *,
DENSE_RANK() OVER(PARTITION BY year_of_layoff ORDER BY total_laid_off_in_a_year DESC) AS ranking
FROM top_industries
WHERE year_of_layoff IS NOT NULL OR year_of_layoff!=''
)
SELECT * 
FROM industry_ranking
WHERE ranking<=3;



-- 4. How does the geographical distribution of layoffs vary across different countries?

-- 4.1. Number of layoffs and companies per country.

SELECT 
	country,
	COUNT(DISTINCT company) AS num_of_companies,
	SUM(total_laid_off) AS num_of_layoffs
FROM layoffs_staging2
GROUP BY country
HAVING SUM(total_laid_off) IS NOT NULL
ORDER BY 3 DESC;


-- 4.2. The percentage companies that closed down because of the layoffs, per country.

WITH total_companies AS
(
SELECT country, COUNT(DISTINCT company) AS num_of_companies
FROM layoffs_staging2
GROUP BY country
),
closed_companies AS
(
SELECT country, COUNT(company) AS num_of_companies_closed
FROM layoffs_staging2
WHERE percentage_laid_off = 1
GROUP BY country
)
SELECT 
	t.country, num_of_companies, num_of_companies_closed,
	ROUND((num_of_companies_closed/num_of_companies) * 100,2) AS percent_total
FROM total_companies t
JOIN closed_companies cc
ON t.country = cc.country
ORDER BY percent_total DESC;



-- 5. How do layoffs differ across various stages of company maturity?

-- 5.1. Number of layoffs and companies per business stage

SELECT 
	stage,
	COUNT(DISTINCT company) AS num_of_companies,
	SUM(total_laid_off) AS num_of_layoffs
FROM layoffs_staging2
GROUP BY stage
HAVING SUM(total_laid_off) IS NOT NULL
ORDER BY 3 DESC;


-- 5.2. The percentage companies that closed down because of the layoffs, per business stage

WITH total_companies AS
(
SELECT stage, COUNT(DISTINCT company) AS num_of_companies
FROM layoffs_staging2
GROUP BY stage
),
closed_companies AS
(
SELECT stage, COUNT(company) AS num_of_companies_closed
FROM layoffs_staging2
WHERE percentage_laid_off = 1
GROUP BY stage
),
stage_layoffs AS
(
SELECT stage, SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY stage
)
SELECT 
    tc.stage,
    num_of_companies, 
    num_of_companies_closed,
    ROUND((COALESCE(num_of_companies_closed, 0) / num_of_companies) * 100, 2) AS percent_total,
    total_layoffs
FROM total_companies tc
JOIN closed_companies cc ON tc.stage = cc.stage
JOIN stage_layoffs sl ON cc.stage = sl.stage
ORDER BY percent_total DESC;

