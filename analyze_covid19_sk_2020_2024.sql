/*
COVID-19 in South Korea: A Retrospective Data Analysis (2020-2024)
*/



-- Mortality Rate
--===================================================================================================


-- Mortality Rate by country from 2020 to 2024
SELECT 
    location, date, total_deaths, population,
    CAST(total_deaths AS FLOAT) / population * 100 AS mortality_rate
FROM covid_deaths
-- WHERE continent IS NOT NULL
WHERE total_deaths IS NOT NULL
    AND location 
        IN ('South Korea', 'Japan', 'United States',
            'United Kingdom', 'Germany', 'Israel', 
            'Singapore', 'Australia', 'World')
ORDER BY 1, 2



-- Total Mortality Rate by country
SELECT location, 
    MAX(total_deaths) AS total_deaths, 
    MAX(population) AS population, 
    MAX(CAST(total_deaths AS FLOAT) / population) * 100 AS mortality_rate
FROM covid_deaths
-- WHERE continent IS NOT NULL 
WHERE location 
    IN ('South Korea', 'Japan', 'United States',
        'United Kingdom', 'Germany', 'Israel', 
        'Singapore', 'Australia', 'World')
GROUP BY location
ORDER BY mortality_rate DESC



-- Mortality Rate by country from 2020 to 2024 monthly
SELECT location, MAX(total_deaths) AS total_deaths, 
    YEAR(date) AS year, 
    MONTH(date) AS month,
    MAX(CAST(total_deaths AS FLOAT) / population) * 100 AS mortality_rate
FROM covid_deaths
-- WHERE continent IS NOT NULL 
WHERE total_deaths IS NOT NULL
    AND location 
        IN ('South Korea', 'Japan', 'United States',
            'United Kingdom', 'Germany', 'Israel', 
            'Singapore', 'Australia', 'World')
GROUP BY location, YEAR(date), MONTH(date)
ORDER BY location, year, month, mortality_rate DESC





-- Case Fatality Rate(CFR)
--===================================================================================================


-- Case Fatality Rate(CFR) by country from 2020 to 2024
SELECT 
    location, date, total_deaths, total_cases,
    CAST(total_deaths AS FLOAT) / total_cases * 100 AS case_fatality_rate
FROM covid_deaths
-- WHERE continent IS NOT NULL
WHERE total_deaths IS NOT NULL
    AND location 
        IN ('South Korea', 'Japan', 'United States',
            'United Kingdom', 'Germany', 'Israel', 
            'Singapore', 'Australia', 'World')
ORDER BY 1, 2



-- Total Case Fatality Rate(CFR) by country
SELECT location, 
    MAX(total_deaths) AS total_deaths, 
    MAX(total_cases) AS total_cases, 
    MAX(CAST(total_deaths AS FLOAT)) / MAX(total_cases) * 100 AS case_fatality_rate
FROM covid_deaths
-- WHERE continent IS NOT NULL 
WHERE location 
    IN ('South Korea', 'Japan', 'United States',
        'United Kingdom', 'Germany', 'Israel', 
        'Singapore', 'Australia', 'World')
GROUP BY location 
ORDER BY case_fatality_rate DESC



-- Case Fatality Rate(CFR) by country from 2020 to 2024 monthly
SELECT location, MAX(total_deaths) AS total_deaths, MAX(total_cases) AS total_cases, 
    YEAR(date) AS year, 
    MONTH(date) AS month,
    MAX(CAST(total_deaths AS FLOAT)) / MAX(total_cases) * 100 AS case_fatality_rate
FROM covid_deaths
-- WHERE continent IS NOT NULL
WHERE total_deaths IS NOT NULL
    AND location 
        IN ('South Korea', 'Japan', 'United States',
            'United Kingdom', 'Germany', 'Israel', 
            'Singapore', 'Australia', 'World')
GROUP BY location, YEAR(date), MONTH(date)
ORDER BY location, year, month, case_fatality_rate DESC



-- Global deaths, cases, and CFR
SELECT 
    SUM(new_deaths) AS total_deaths, 
    SUM(new_cases) AS total_cases, 
    SUM(CAST(new_deaths AS FLOAT)) / SUM(new_cases) * 100 
    AS global_case_fatality_rate
From covid_deaths
WHERE continent IS NOT NULL 





-- Total Deaths
--===================================================================================================


-- Total Deaths by country
SELECT 
    location, 
    SUM(new_deaths) AS total_deaths
FROM covid_deaths
-- WHERE continent IS NOT NULL 
WHERE location 
    IN ('South Korea', 'Japan', 'United States',
        'United Kingdom', 'Germany', 'Israel', 
        'Singapore', 'Australia', 'World')
GROUP BY location
ORDER BY total_deaths DESC



-- Total Deaths by continent
SELECT 
    location, 
    SUM(new_deaths) AS total_deaths_by_continent
FROM covid_deaths
WHERE continent IS NULL
AND location 
    NOT IN ('European Union', 'High income', 'Upper middle income', 
            'Lower middle income', 'Low income')
GROUP BY location
ORDER BY total_deaths_by_continent DESC





-- Infection rate
--===================================================================================================


-- Infection Rate by country from 2020 to 2024
SELECT 
    location, date, population, 
    total_cases AS infected_population,
    CAST(total_cases AS FLOAT) / population * 100 AS infection_rate
FROM covid_deaths
WHERE total_cases IS NOT NULL
    AND location 
        IN ('South Korea', 'Japan', 'United States',
            'United Kingdom', 'Germany', 'Israel', 
            'Singapore', 'Australia', 'World')
ORDER BY 1, 2



-- Total Infection Rate by country 
SELECT 
    location, population, 
    MAX(total_cases) AS infected_population, 
    MAX(CAST(total_cases AS FLOAT) / population) * 100 AS infection_rate
FROM covid_deaths
WHERE location 
    IN ('South Korea', 'Japan', 'United States',
        'United Kingdom', 'Germany', 'Israel', 
        'Singapore', 'Australia', 'World')
GROUP BY location, population
ORDER BY infection_rate DESC





-- Full Vaccination Rate
--===================================================================================================


-- Full Vaccination Rate by country from 2020 to 2024
SELECT D.location, D.date, D.population, V.people_fully_vaccinated,
    CAST(V.people_fully_vaccinated AS FLOAT) / population * 100 AS full_vaccination_rate
FROM covid_deaths AS D
JOIN covid_vaccinations AS V
    ON D.location = V.location 
    AND D.date = V.date 
WHERE V.people_fully_vaccinated IS NOT NULL
    AND D.location 
        IN ('South Korea', 'Japan', 'United States',
            'United Kingdom', 'Germany', 'Israel', 
            'Singapore', 'Australia', 'World')
ORDER BY 1, 2



-- Total Full Vaccination Rate by country 
SELECT D.location,
    MAX(CAST(V.people_fully_vaccinated AS FLOAT) / population) * 100 AS full_vaccination_rate
FROM covid_deaths AS D
JOIN covid_vaccinations AS V
    ON D.location = V.location 
    AND D.date = V.date 
WHERE D.location 
    IN ('South Korea', 'Japan', 'United States',
        'United Kingdom', 'Germany', 'Israel',   
        'Singapore', 'Australia', 'World')
GROUP BY D.location 
ORDER BY full_vaccination_rate DESC





-- Daily Percentage of COVID-19 Patients in Hospital
--===================================================================================================


-- Daily Percentage of COVID-19 Patients in Hospital by country from 2020 to 2024
SELECT location, date, 
    hosp_patients AS hospitalized_patients,
    CAST(hosp_patients AS FLOAT) / population * 100 AS daily_percentage_of_patients_in_hospital
FROM covid_deaths
WHERE hosp_patients IS NOT NULL 
    AND location 
        IN ('South Korea', 'Japan', 'United States',
            'United Kingdom', 'Germany', 'Israel', 
            'Singapore', 'Australia', 'World')
ORDER BY 1,2



-- Average Daily Percentage of COVID-19 Patients in Hospital by country
WITH patients_in_hospital (location, daily_percentage_of_patients_in_hospital) AS 
(
    SELECT location,  
        CAST(hosp_patients AS FLOAT) / population * 100 AS daily_percentage_of_patients_in_hospital
    FROM covid_deaths
    WHERE location 
        IN ('South Korea', 'Japan', 'United States',
            'United Kingdom', 'Germany', 'Israel', 
            'Singapore', 'Australia', 'World')
)
SELECT location,
    AVG(daily_percentage_of_patients_in_hospital) AS average_daily_percentage_of_patients_in_hospital
FROM patients_in_hospital
GROUP BY location
ORDER BY average_daily_percentage_of_patients_in_hospital DESC;





-- Daily Percentage of COVID-19 Patients in ICU
--===================================================================================================


-- Daily Percentage of COVID-19 Patients in ICU by country from 2020 to 2024
SELECT location, date, 
    icu_patients,
    CAST(icu_patients AS FLOAT) / population * 100 AS daily_percentage_of_patients_in_icu
FROM covid_deaths
WHERE icu_patients IS NOT NULL 
    AND location 
        IN ('South Korea', 'Japan', 'United States',
            'United Kingdom', 'Germany', 'Israel', 
            'Singapore', 'Australia', 'World')
ORDER BY 1,2



-- Average Daily Percentage of COVID-19 Patients in ICU by country
WITH patients_in_icu (location, daily_percentage_of_patients_in_icu) AS 
(
    SELECT location,
        CAST(icu_patients AS FLOAT) / population * 100 AS daily_percentage_of_patients_in_icu
    FROM covid_deaths
    WHERE location 
        IN ('South Korea', 'Japan', 'United States',
            'United Kingdom', 'Germany', 'Israel', 
            'Singapore', 'Australia', 'World')
)
SELECT location,
    AVG(daily_percentage_of_patients_in_icu) AS average_daily_percentage_of_patients_in_icu
FROM patients_in_icu
GROUP BY location
ORDER BY average_daily_percentage_of_patients_in_icu DESC;





-- Age Data
--===================================================================================================


-- Median age, 65 above, and 70 above
SELECT D.location, 
    MAX(D.population) AS population, MAX(V.median_age) AS median_age,  
    MAX(V.aged_65_older) AS aged_65_older, MAX(V.aged_70_older) AS aged_70_older
FROM covid_deaths AS D
JOIN covid_vaccinations AS V 
    ON D.location = V.location 
    AND D.date = V.date
WHERE D.location 
    IN ('South Korea', 'Japan', 'United States',
        'United Kingdom', 'Germany', 'Israel', 
        'Singapore', 'Australia', 'World')
-- WHERE D.continent IS NOT NULL 
GROUP BY D.location
ORDER BY median_age DESC