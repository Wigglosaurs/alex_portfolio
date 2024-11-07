# US Household Income Data Cleaning

SELECT *
FROM us_household_income
;

SELECT *
FROM us_household_income_statistics
;

# Corrected the name of the ID column
ALTER TABLE us_household_income_statistics RENAME COLUMN `ï»¿id` TO `id`;


# Correct Duplicate values using the ID column
SELECT COUNT(id)
FROM us_household_income_statistics
;

SELECT COUNT(id)
FROM us_household_income
;

SELECT id, COUNT(id)
FROM us_household_income
GROUP BY id
HAVING COUNT(id) > 1
;

SELECT *
FROM (
	SELECT row_id,
		   id,
           ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) AS row_num
	FROM us_household_income
) AS duplicates
WHERE row_num > 1
;

DELETE FROM us_household_income
WHERE row_id IN (
	SELECT row_id
	FROM (
		SELECT row_id,
			   id,
               ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) AS row_num
		FROM us_household_income
		) AS duplicates
WHERE row_num > 1)
;


# Duplicate and Incorrect Spelling in State_Name column
SELECT DISTINCT State_Name
FROM us_household_income
ORDER BY 1
;

UPDATE us_household_income
SET State_Name = 'Georgia'
WHERE State_Name = 'georia';

UPDATE us_household_income
SET State_Name = 'Alabama'
WHERE State_Name = 'alabama';


# Missing Values in County column
SELECT DISTINCT *
FROM us_household_income
WHERE County = 'Autauga County'
ORDER BY 1
;

UPDATE us_household_income
SET Place = 'Autaugaville'
WHERE County = 'Autauga County'
AND City = 'Vinemont'
;


# Duplicate Values in Type column
SELECT Type, COUNT(Type)
FROM us_household_income
GROUP BY Type
;

UPDATE us_household_income
SET Type = 'Borough'
WHERE Type = 'Boroughs'
;

SELECT ALand, AWater
FROM us_household_income
WHERE (ALand = 0 OR ALand = '' OR ALand IS NULL)
;
