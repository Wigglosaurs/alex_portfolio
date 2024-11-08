# World Life Expectancy Project (Exploratory Data Analysis)

SELECT *
FROM world_life_expectancy
;


#Minimum & Maximum Life Expectancy
SELECT Country,
       MIN(`Life expectancy`),
       MAX(`Life expectancy`),
       ROUND(MAX(`Life expectancy`) - MIN(`Life expectancy`), 1) AS Life_Increase_15_Years
FROM world_life_expectancy
GROUP BY Country
HAVING MIN(`Life expectancy`)
AND MAX(`Life expectancy`) <> 0
ORDER BY Life_Increase_15_Years ASC
;

# Average Life Expectancy each Year 
SELECT Year, ROUND(AVG(`Life expectancy`),2)
FROM world_life_expectancy
WHERE `Life expectancy` <> 0
AND `Life expectancy` <> 0
GROUP BY Year
ORDER BY Year
;


SELECT *
FROM world_life_expectancy
;


# Life Expectancy Vs. GDP
SELECT Country, 
	   ROUND(AVG(`Life expectancy`),1) AS Avg_Life_Exp, 
       ROUND(AVG(GDP),1) AS Avg_GDP
FROM world_life_expectancy
GROUP BY Country
HAVING Avg_Life_Exp > 0
AND Avg_GDP > 0
ORDER BY Avg_GDP DESC
;


# Low Vs. High GDP with Life Expectancy
SELECT
	SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE 0 END) High_GDP_COunt,
    AVG(CASE WHEN GDP >= 1500 THEN `Life expectancy` ELSE NULL END) High_GDP_Life_Expectancy,
    SUM(CASE WHEN GDP <= 1500 THEN 1 ELSE 0 END) Low_GDP_COunt,
    AVG(CASE WHEN GDP <= 1500 THEN `Life expectancy` ELSE NULL END) Low_GDP_Life_Expectancy
FROM world_life_expectancy
;


SELECT *
FROM world_life_expectancy
;


# Status (Developing, Developed) with Average Life Expectancy
SELECT Status, ROUND(AVG(`Life expectancy`),1)
FROM world_life_expectancy
GROUP BY Status
;

SELECT Status, 
	   COUNT(DISTINCT Country) AS Country_Count,
       ROUND(AVG(`Life expectancy`),1) AS Avg_Life_Expectancy
FROM world_life_expectancy
GROUP BY Status
;


# Life Expectancy Vs. BMI
SELECT Country, 
	   ROUND(AVG(`Life expectancy`),1) AS Avg_Life_Exp, 
       ROUND(AVG(BMI),1) AS Avg_BMI
FROM world_life_expectancy
GROUP BY Country
HAVING Avg_Life_Exp > 0
AND Avg_BMI > 0
ORDER BY Avg_BMI ASC
;


# Rolling Total
SELECT Country,
	   Year,
	   `Life expectancy`,
       `Adult Mortality`,
       SUM(`Adult Mortality`) OVER(PARTITION BY Country ORDER BY Year) AS Rolling_Total
FROM world_life_expectancy
WHERE Country LIKE '%United%'
;