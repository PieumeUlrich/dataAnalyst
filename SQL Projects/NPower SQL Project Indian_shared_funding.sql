-- Exercises on String Patterns, Sorting, and Grouping Built-in Database Functions
SELECT *
FROM indian_funding
;
-- Data Cleaning
-- ALTER TABLE indian_funding RENAME COLUMN `ï»¿Date` TO date_input;
-- ALTER TABLE indian_funding RENAME COLUMN `City  Location` TO `CityLocation`;
-- ALTER TABLE indian_funding RENAME COLUMN `Startup Name` TO `StartupName`;
-- ALTER TABLE indian_funding RENAME COLUMN `Industry Vertical` TO `IndustryVertical`;
-- ALTER TABLE indian_funding RENAME COLUMN `Amount in USD` TO `AmountinUSD`;

-- 1. Write SQL query to sum all the funding AmountinUSD, where City location equals “Bengaluru” 
SELECT `CityLocation`, SUM(`AmountinUSD`)
FROM indian_funding
WHERE `CityLocation` = "Bengaluru"
;

-- 2. Write SQL query to sort the table by startup name DESC 
SELECT *
FROM indian_funding
ORDER BY StartupName DESC
;

-- 3. Write SQL query to sum all the funding AmountinUSD, where City location equals “Bengaluru” and AmountinUSD>380000
SELECT `CityLocation`, SUM(`AmountinUSD`)
FROM indian_funding
WHERE `CityLocation` = "Bengaluru" AND AmountinUSD > 380000
;

-- 4. Write SQL query to get all CityLocations that has an AmountinUSD > 380000 

SELECT CityLocation
FROM indian_funding
WHERE AmountinUSD > 380000
;

-- 5. Write SQL query to get only unique CityLocations that has an AmountinUSD >380000 

SELECT DISTINCT CityLocation
FROM indian_funding
WHERE AmountinUSD > 380000
;

-- 6. Write SQL query to get all StartupNames where AmountinUSD<380000

SELECT DISTINCT StartupName
FROM indian_funding
WHERE AmountinUSD > 380000
;

-- 7. Write SQL query to sort the output from the previous question DESC

SELECT DISTINCT StartupName
FROM indian_funding
WHERE AmountinUSD > 380000
ORDER BY StartupName DESC
;

-- 8. Write SQL query to get the City location that has the maximum funding amount “Note that is the data is not cleaned properly you will get non logical result” 

SELECT CityLocation, AmountinUSD
FROM indian_funding
WHERE AmountinUSD in (SELECT MAX(AmountinUSD) FROM indian_funding)
;

-- 9. Write SQL query to get the total funding AmountinUSD for each IndustryVertical

SELECT IndustryVertical, SUM(AmountinUSD) 'Total Funding'
FROM indian_funding
GROUP BY IndustryVertical
;

-- 10. Write SQL query to get the total funding AmountinUSD for each IndustryVertical that starts with letter “A”

SELECT IndustryVertical, SUM(AmountinUSD) 'Total Funding'
FROM indian_funding
WHERE IndustryVertical LIKE 'A%'
GROUP BY IndustryVertical
;

-- 11. Write SQL query to get the total funding AmountinUSD for each IndustryVertical that starts with letter “A” and sort the output DESC by the total AmountinUSD 

SELECT IndustryVertical, SUM(AmountinUSD) total_funding
FROM indian_funding
WHERE IndustryVertical LIKE 'A%'
GROUP BY IndustryVertical
ORDER BY total_funding DESC
;

-- 12. Write SQL query to count all the start_ups in the Education field

SELECT IndustryVertical, COUNT(IndustryVertical)
FROM indian_funding
WHERE IndustryVertical = 'Education'
;

-- 13. Write SQL query to count all the start_Ups in the E-Commerce field 

SELECT IndustryVertical, COUNT(IndustryVertical)
FROM indian_funding
WHERE IndustryVertical = 'E-Commerce'
;

-- 14. Write SQL query to count all the start_Ups in the E-Commerce field, where city location equals “Bengaluru”

SELECT IndustryVertical, COUNT(IndustryVertical)
FROM indian_funding
WHERE IndustryVertical = 'E-Commerce' AND CityLocation = 'Bengaluru'
;

-- 15. For each Industry Vertical find the total funding amount

SELECT IndustryVertical, SUM(AmountinUSD)
FROM indian_funding
GROUP BY IndustryVertical
;

-- 16. For each Industry Vertical find the total funding amount as “Total_fund” and the average funding amount as “Avg_Fund”. In this question provide two answer 
-- 	1- using group by Industry Vertical
	SELECT IndustryVertical, SUM(AmountinUSD) Total_fund, AVG(AmountinUSD) Avg_Fund , COUNT(IndustryVertical) Count_cat
	FROM indian_funding
	GROUP BY IndustryVertical
	;
    
--  2- using sub_queries 
	SELECT 
		DISTINCT IndustryVertical,
		(SELECT SUM(AmountInUSD) FROM indian_funding WHERE IndustryVertical = isf.IndustryVertical) Total_fund,
		(SELECT AVG(AmountInUSD) FROM indian_funding WHERE IndustryVertical = isf.IndustryVertical) Avg_fund,
		(SELECT COUNT(AmountInUSD) FROM indian_funding WHERE IndustryVertical = isf.IndustryVertical) Num_Cat
	FROM 
		indian_funding isf
	;

-- 17. Write SQL query to get the minimum value of funding for the “Uniphore” start_up

SELECT StartupName, MIN(AmountinUSD) `Min Value`
FROM indian_funding
WHERE StartupName in (SELECT StartupName FROM indian_funding WHERE StartupName = 'Uniphore')
;

-- 18. Write SQL query to get the length of the city location names

SELECT CityLocation, LENGTH(CityLocation)
FROM indian_funding
;

-- 19. Write SQL query to convert start_ups names into uppercase if the funding amount is >380,000 

SELECT UPPER(StartupName)
FROM indian_funding
;

-- 20. Write SQL query to select distinct industry vertical names, knowing that names are mix of lowercase and uppercase values. 

 SELECT DISTINCT LOWER(IndustryVertical)
 FROM indian_funding
 ;