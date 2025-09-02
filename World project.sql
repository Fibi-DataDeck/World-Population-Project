use world;

select * from city;
select * from country;
select * from countrylanguage;


-- Summarizing key  GNP statistics

-- GNP ranking per continent compared to average rank per continent
SELECT `Name`, Continent, GNP,
       RANK() OVER (PARTITION BY Continent ORDER BY GNP DESC) AS GNP_Rank,
       AVG(GNP) OVER (PARTITION BY Continent) AS Avg_GNP_PerContinent
FROM country
ORDER BY Continent, GNP_Rank;

-- ---------------------------------------------------------------------------------
-- ECONOMIC
-- Average GNP per continent

select Continent, AVG(gnp) as AVG_gnp
from country
group by continent
order by 2 desc ; 

-- Average GNP per region 

select region, AVG(GNP) as Avg_GNP_per_region 
from country
group by Region;


-- Per Capita GNP
SELECT c.Name, Continent, GNP,  Population, (GNP/Population) AS PerCapita_GNP
FROM country c
WHERE population > 0 AND GNP > 0
ORDER BY PerCapita_GNP; 


-- Correlation between Life Expectancy and GNP
SELECT c.Name, Continent, GNP, LifeExpectancy
FROM country c
WHERE GNP > 0 AND GNP IS NOT NULL AND LifeExpectancy > 0 AND LifeExpectancy IS NOT NULL
ORDER BY GNP DESC;

-- ----------------------------------------------------------------------------------
-- POPULATION
-- 100 most populated countries in the world
select CountryCode, sum(population) as total_pop_country
from city
group by CountryCode
order by 2 desc
limit 100;


-- Most populated city per country 

SELECT c.`Name` AS CityName, ctry.`Name` AS CountryName, c.CountryCode, c.population AS CityPopulation
FROM city AS c
JOIN Country AS ctry 
ON c.CountryCode = ctry.`Code`
WHERE c.Population = (
       SELECT max(Population) AS most_populated
       FROM city
       WHERE CountryCode = c.CountryCode
       );
       
       
-- -----------------------------------------------------------------------------------------------------
-- LANGUAGE
--  Official language(s) per country

SELECT CountryCode, ctry.`Name` AS CountryName, `language`
FROM countrylanguage AS cl
JOIN country AS ctry
ON cl.CountryCode = ctry.`code`
WHERE IsOfficial = 'T' AND Percentage>0.0
GROUP BY CountryCode, `language`;

-- Countries with more than one official language 

SELECT c.Name 
FROM country AS c
LEFT JOIN countrylanguage AS cl ON c.Code = cl.CountryCode
AND IsOfficial = 'T'
WHERE `language` IS NOT NULL;

select c.Name, COUNT(cl.language) AS official_langCount from countrylanguage cl
Join country c on cl.countrycode= c.code 
WHERE IsOfficial = 'T' 
GROUP BY c.Name
HAVING COUNT(cl.language)> 1
ORDER BY official_langCount;


-- Most popular official language per country 

SELECT cl.CountryCode, ctry.`Name` AS CountryName, cl.`language`, cl.percentage
FROM countrylanguage AS cl
JOIN country AS ctry ON cl.CountryCode = ctry.`code`
WHERE cl.IsOfficial = 'T' 
AND cl.Percentage = (
     SELECT max(cl2.percentage) 
     FROM countrylanguage AS cl2
     WHERE cl2.CountryCode = cl.CountryCode AND cl2.IsOfficial = 'T'
     )
ORDER BY CountryName;



-- TOP 10 Most Spoken Official languages in the world
SELECT cl.CountryCode, SUM(ctry.population * cl.percentage/100) AS LanguageSpeakers, cl.language 
FROM countrylanguage AS cl
JOIN country AS ctry ON cl.CountryCode = ctry.Code 
WHERE IsOfficial = 'T'
GROUP BY cl.Language, cl.CountryCode
ORDER BY LanguageSpeakers DESC
LIMIT 10;

-- ------------------------------------------------------------------------------------
-- LIFE EXPECTANCY
 -- Life Expectancy Stats per Continent 
 -- Avg World Life Expectancy
 SELECT AVG(LifeExpectancy) AS Avg_LifeExpectancy 
 FROM country;
 

 -- Life expectancy per Country as compared to avg life expectancy
 
 SELECT
    `Name` AS CountryName,
    Continent,
    LifeExpectancy,
    AVG(LifeExpectancy) OVER (PARTITION BY Continent) AS Avg_Life_Expectancy
FROM country
WHERE LifeExpectancy IS NOT NULL
ORDER BY Continent, CountryName;
 
 
  -- Countries with above average life expectancy
 SELECT ctry.Name, Continent, LifeExpectancy 
 FROM Country AS ctry
 WHERE LifeExpectancy > (SELECT AVG(LifeExpectancy) FROM country)
 ORDER BY LifeExpectancy DESC;
 
 
  -- Countries with below average life expectancy 
 SELECT ctry.Name, Continent, LifeExpectancy 
 FROM Country AS ctry
 WHERE LifeExpectancy < (SELECT AVG(LifeExpectancy) FROM country)
 ORDER BY LifeExpectancy DESC;
  

-- Continent with the highest to lowest life expectancy
 SELECT Continent, 
        AVG(LifeExpectancy) AS Avg_LifeExp
FROM country
 WHERE LifeExpectancy is NOT NULL
 GROUP BY continent 
 ORDER BY Avg_LifeExp DESC;



-- The average, minimum, and maximum life expectancies per continent 
 SELECT Continent, 
        AVG(LifeExpectancy) AS Avg_LifeExp,
        MAX(LifeExpectancy) AS Highest_LifeExp,
        MIN(LifeExpectancy) AS Lowest_LifeExp
 FROM country
 WHERE LifeExpectancy is NOT NULL
 GROUP BY continent 
 ORDER BY Avg_LifeExp
 ;
 
-- ---------------------------------------------------------------------------------------------------- 
 

