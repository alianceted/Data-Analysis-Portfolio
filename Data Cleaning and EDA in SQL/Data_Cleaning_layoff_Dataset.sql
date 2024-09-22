-- This projet has two part; data cleaning and Exploatory Data Analysis


-- PART ONE: DATA CLEANING

-- 1. Remove Duplicates
-- 2. Standardize the data and fix errors
-- 3. Fix null values
-- 4. Remove any columns and rows that are not necessary



-- First thing we want to do is create a staging table. This a duplicate table that we will use so that we can protect the raw data

CREATE TABLE world_layoffs.layoffs_staging 
LIKE world_layoffs.layoffs;

# Inserting values in the staging table
INSERT layoffs_staging 
SELECT * FROM world_layoffs.layoffs;


# Quering all rows in the staging table
SELECT *
FROM layoffs_staging;




-- 1. Remove Duplicates

# Checking for duplicates
WITH duplicate_cte AS 
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off,`date`, stage, country, funds_raised_millions) AS row_num 
FROM layoffs_staging
) 
SELECT * 
FROM duplicate_cte
WHERE row_num > 1;


# Confirming that these are actual duplicates
SELECT *
FROM world_layoffs.layoffs_staging
WHERE company = 'Cazoo';

# Creating a new staging table duplicate with a new column for row_num
DROP TABLE IF EXISTS layoffs_staging2;

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

# Inserting my original data into the new stagging table.
INSERT layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off,`date`, stage, country, funds_raised_millions) AS row_num 
FROM layoffs_staging;

# Deleting the duplicate rows (row_num > 1) from the duplicate staging table
DELETE 
FROM layoffs_staging2
WHERE row_num >1;

SELECT *
FROM layoffs_staging2;




-- 2. Standardize the data and fix errors

-- 2.1 Trimming white spaces before and after words

SELECT company, TRIM(company)
FROM layoffs_staging2;

# Updating the table to replace every column with the respective trimmed column
UPDATE layoffs_staging2
SET company = TRIM(company);

UPDATE layoffs_staging2
SET location = TRIM(location);

UPDATE layoffs_staging2
SET country = TRIM(country);

UPDATE layoffs_staging2
SET industry = TRIM(industry);


-- 2.2 Correcting Inconsistencies in Labeling

# Quering the industry column
SELECT DISTINCT industry
FROM layoffs_staging2;

# The Crypto industry has some variations in labelling
SELECT *
FROM layoffs_staging2
WHERE industry LIKE '%Crypto%';

# Updating the table to aggregate all Crypto industries into one Label
UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE '%Crypto%';

# Quering the location column
SELECT DISTINCT `location`
FROM layoffs_staging2;

# Quering the country column
SELECT DISTINCT country
FROM layoffs_staging2;

# The country column has two different values for the United Sates with one containing a period at the end
SELECT *
FROM layoffs_staging2
WHERE country LIKE '%United States%';

# Updating the table to aggregate the country 'United States' into one Label
UPDATE layoffs_staging2
SET country = 'United States'
WHERE country LIKE '%United States%';


-- 2.3 Changing the date format

# Converting date column from string to date format for time series
SELECT `date`, STR_TO_DATE(`date`,'%m/%d/%Y')
FROM layoffs_staging2;

# Updating the date column to the new format
UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`,'%m/%d/%Y');

# Fixing the data-type of date column from text to date
ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

SELECT `date`
FROM layoffs_staging2;




-- 3. Fix null values

# checking for null or missing values in some columns

SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
OR total_laid_off = '';

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off IS NULL
OR percentage_laid_off = '';

SELECT *
FROM layoffs_staging2
WHERE funds_raised_millions IS NULL
OR funds_raised_millions = '';

SELECT *
FROM layoffs_staging2 
WHERE stage IS NULL 
OR stage='';

/*   For the purpose of this project, the null values in total_laid_off, percentage_laid_off, stage and funds_raised_millions columns will be considered normal for now as this will make our calculations during the EDA phase easy.   */

SELECT *
FROM layoffs_staging2
WHERE industry IS NULL
OR industry = '';

/*  Airbnb, Bally’s Interactive, Carvana, and Juul have null or blank values in their industry column.
Our next step is to find the industry name for these companies in other non-null rows.  */

SELECT *
FROM layoffs_staging2
WHERE company = 'Airbnb';

SELECT *
FROM layoffs_staging2
WHERE company LIKE 'Bally%';

SELECT *
FROM layoffs_staging2
WHERE company = 'Carvana';


SELECT *
FROM layoffs_staging2
WHERE company = 'Juul';


/*  After quering for the industry names of these companies, we discover that Airbnb belongs to the Travel industry, 
Carvana to the Transportation industry and Juul to the Consumer Industry. So, we can populate the null and blank cells 
in the industry column of these companies with their respective industry  */


# Setting the blanks to nulls 
UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = '';


# Updating the staging table to populate where the industry is null.
UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
  ON t1.company = t2.company
  AND t1.location = t2.location
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

# Rechecking for missing values or not in the industry column
SELECT *
FROM layoffs_staging2
WHERE industry IS NULL;

/* All the rows were updated except for Bally% which did not have any other rows to pull the industry 
name from. We will leave it like this because putting the wrong info is worse than having no info */




-- 4. Remove any columns and rows that are not necessary

/*  Because we are conducting an analysis on company layoffs, any company data that does not include the 
numbers of layoffs (total_laid_off column) or the percentage of employees laid off (percentage_laid_off column) 
is useless and should be deleted from our table. */


# Checking for rows where both total_laid_off and percentage_laid_off are null
SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;


# Deleting the rows where both total_laid_off and percentage_laid_off are null
DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL 
AND percentage_laid_off IS NULL;


# Checking the table for any other rows or unnecessary columns
SELECT * 
FROM layoffs_staging2;


# Deleting the row_num column
ALTER TABLE layoffs_staging2
DROP COLUMN row_num;











