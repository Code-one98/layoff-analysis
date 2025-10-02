-- data cleaning (things to do)
-- 1. remove duplicates
-- 2. standardizethe data
-- 3. null values or blank values
-- 4. remove any columns 

SELECT * FROM layoffs;

SELECT COUNT(*) AS total_rows
FROM layoffs;

CREATE TABLE edit_layoff LIKE layoffs;

INSERT edit_layoff
SELECT * FROM layoffs;

SELECT * FROM edit_layoff;

#CHECK AND REMOVE DUPLICATES
SELECT *, ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions)
FROM edit_layoff;

#check duplicates
WITH dup_layoff AS 
(SELECT *, ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions) AS row_num
FROM edit_layoff)
SELECT * FROM dup_layoff
WHERE row_num > 1;

SELECT * FROM edit_layoff
WHERE company = 'Casper';

SELECT * FROM edit_layoff
WHERE company = 'Cazoo';

SELECT * FROM edit_layoff
WHERE company = 'Hibob';

SELECT * FROM edit_layoff
WHERE company = 'Wildlife Studios';

SELECT * FROM edit_layoff
WHERE company = 'Yahoo';


#remove duplicates
CREATE TABLE `edit_layoff2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT edit_layoff2
SELECT *, ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions)
FROM edit_layoff;

SELECT * FROM edit_layoff2;

#REMOVE DUPLICATES
DELETE FROM edit_layoff2
WHERE row_num > 1;

SELECT * FROM edit_layoff2
WHERE row_num > 1;
SELECT * FROM edit_layoff2
WHERE company = 'Casper';
#DUPLICATES REMOVED

#STANDARDIZING DATA
#TRIM ALL COLUMNS
SELECT DISTINCT company, LTRIM(company)
FROM edit_layoff2;

UPDATE edit_layoff2
SET company = LTRIM(company);

SELECT COUNT(*) AS row_with_spaces
FROM edit_layoff2
WHERE company <> LTRIM(company);
#no other rows with spaces

SELECT DISTINCT industry
FROM edit_layoff2;

UPDATE edit_layoff2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT * FROM edit_layoff2
WHERE industry LIKE 'Crypto%';

#check country column
SELECT DISTINCT country
FROM edit_layoff2
ORDER BY country;
#issue: 'United States' and 'United States.'

#solve issue
SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
FROM edit_layoff2
ORDER BY country;

UPDATE edit_layoff2
SET country = TRIM(TRAILING '.' FROM country);

SELECT DISTINCT country
FROM edit_layoff2
WHERE country LIKE 'United State%';
#issue solved


#standardise date column

SELECT date, STR_TO_DATE(`date`, '%m/%d/%Y')
FROM edit_layoff2;

UPDATE edit_layoff2
SET date = STR_TO_DATE(`date`, '%m/%d/%Y');
#date changed to standard format

ALTER TABLE edit_layoff2
MODIFY COLUMN date DATE;


#removing null and blank values
SELECT * FROM edit_layoff2
WHERE industry is NULL OR industry = '';
#industry has null/blank values. 

#change blank to null
UPDATE edit_layoff2
SET industry = NULL
WHERE industry = '';

SELECT * FROM edit_layoff2
WHERE company = 'Airbnb';

SELECT * FROM edit_layoff2
WHERE company = "Bally's Interactive";

SELECT * FROM edit_layoff2
WHERE company = 'Carvana';

SELECT * FROM edit_layoff2
WHERE company = 'Juul';

#airbnb, carvana, and juul are populatable
SELECT t1.company, t1.industry, t2.industry FROM edit_layoff2 AS t1
JOIN edit_layoff2 as t2
ON t1.company=t2.company
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

UPDATE edit_layoff2 t1
JOIN edit_layoff2 t2
ON t1.company=t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

#fixing null values in total_laid_off and percentage_laid_off
SELECT * FROM edit_layoff2
WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL;

DELETE FROM edit_layoff2
WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL;
#fixed

# date column
SELECT * FROM edit_layoff2
WHERE date IS NULL;

#stage column
SELECT * FROM edit_layoff2
WHERE stage IS NULL;

#country column
SELECT * FROM edit_layoff2
WHERE country IS NULL;

SELECT * FROM edit_layoff2
WHERE funds_raised_millions IS NULL;


#removing unnecessary columns
ALTER TABLE edit_layoff2
DROP COLUMN row_num;



SELECT * FROM edit_layoff2;

SELECT COUNT(*) AS total_rows_after_cleaning
FROM edit_layoff2;
#PROJECT COMPLETED 