-- EXPLORATORY DATA ANALYSIS PROJECT
SELECT * FROM edit_layoff2;

-- layoff start and end year
SELECT DISTINCT year(date)
FROM edit_layoff2
ORDER BY 1;

-- check year with the highest lay offs
SELECT YEAR(`date`) years, SUM(total_laid_off)
FROM edit_layoff2
WHERE YEAR(`date`) IS NOT NULL
GROUP BY 1
ORDER BY 2;
-- check company with the highest funds raised
SELECT DISTINCT company, SUM(funds_raised_millions)
FROM edit_layoff2
GROUP BY company
ORDER BY 2 DESC
LIMIT 5;

-- see companies and their respective industries
SELECT DISTINCT company, industry
FROM edit_layoff2
WHERE company = "Netflix";


-- check industries with highest funds raised 
SELECT DISTINCT industry, SUM(funds_raised_millions)
FROM edit_layoff2
GROUP BY industry
ORDER BY 2 DESC
LIMIT 10;


-- company with the highest total_laid_offs
SELECT company, SUM(total_laid_off)
FROM edit_layoff2
WHERE company IS NOT NULL AND total_laid_off IS NOT NULL
GROUP BY company
ORDER BY 2 DESC
LIMIT 10;


-- industries with highest total laid offs
SELECT DISTINCT industry, SUM(total_laid_off)
FROM edit_layoff2
WHERE industry IS NOT NULL AND total_laid_off IS NOT NULL
GROUP BY industry
ORDER BY  2 DESC
LIMIT 10;

-- check top 10 countries with highest laid offs
SELECT DISTINCT country, SUM(total_laid_off)
FROM edit_layoff2
WHERE industry IS NOT NULL AND total_laid_off IS NOT NULL
GROUP BY country
ORDER BY  2 DESC
LIMIT 10;

-- check lay offs per month
SELECT substring(date, 1, 7) months, SUM(total_laid_off)
FROM edit_layoff2
WHERE substring(date, 1, 7) IS NOT NULL
GROUP BY 1
ORDER BY 1;

-- check number of lay offs per month per company
WITH Monthly_layoff_rank AS
(SELECT company, SUBSTRING(date, 1, 7) AS month, SUM(total_laid_off) AS total_off
FROM edit_layoff2
GROUP BY company, SUBSTRING(date, 1, 7)
ORDER BY 2)
SELECT *, SUM(total_off) OVER(PARTITION BY month ORDER BY total_off) rolling_total
FROM Monthly_layoff_rank
WHERE month IS NOT NULL AND total_off IS NOT NULL ;


-- check company lay off ranking per year
WITH company_rankings AS
(SELECT company, YEAR(`date`) year, SUM(total_laid_off) sum_total_off
FROM edit_layoff2
GROUP BY company, YEAR(`date`)), top10_rankings AS
(SELECT *, DENSE_RANK() OVER(PARTITION BY year ORDER BY sum_total_off DESC) rankings
FROM company_rankings
WHERE year IS NOT NULL)
SELECT * FROM top10_rankings
WHERE rankings <= 10;

SELECT * FROM edit_layoff2;
-- project completed


