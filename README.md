# World-Population-Project 🌍

## Project Overview

This exploratory and data analysis project uses the MySQL World Sample Database. It uses SQL queries to explore data related to cities, countries, and languages across the world.The source dataset is "".

## Project Objectives

The goal of this project is to practice SQL querying, window functions, joins and grouping to identify meaningful insights and trends within the dataset that could support data-driven decisions in real life world projects. 

The EDA process sought to uncover trends in `Population`, `Life Expectancy`, `Languages` and `Gross National Product` GNP. 


## Key Analyses Performed 
### Insights:
- Population 🧑‍🤝‍🧑
   - Top 100 most populated countries
   - Most populated cities per country
- Language 📖
   - Official languages per country- 10 most spoken as per population
   - Most popular official language
   - Countries with more than one official language
- Economic 💰
   - Average GNP per region and continent
   - Per Capita GNP
   - GNP Ranking per continent VS. average GNP
- Life Expectancy 📊
   - Global average life expectancy
   - Life expectancy per country and continent
   - Ranking of continental life expectancies
   - Countries with above and below average life expectancy

## Tools Used 
- MySQL Workbench- querying and database management
- GitHub- project documentation

## Sample Query- GNP Ranking per Continent
``` sql

SELECT `Name`, Continent, GNP,
       RANK() OVER (PARTITION BY Continent ORDER BY GNP DESC) AS GNP_Rank,
       AVG(GNP) OVER (PARTITION BY Continent) AS Avg_GNP_PerContinent
FROM country
ORDER BY Continent, GNP_Rank;
```

## Findings
1. The variations of life expectancy across continents and regions are potential indicators of healthcare quality and developmental differences.
2. Population and language percentages are estimates of the number of worldwide speakers.
3. Economic aggregations at country, continent and regional levels are indications of macro and micoreconomic views.
4. Window Functions served as a powerful tool in ranking and comparing data across partitions e.g. continent, region, country.
