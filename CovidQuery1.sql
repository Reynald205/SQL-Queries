-- Covid Dataset Queries by Reynald Walme
--Create new Database named Portfolio_Project
--Import both MS Excel files to Database with each using their file name for Tables

--Making sure correct Database is used
use Portfolio_Project

--Making Sure Table Data was Imported Successfully
SELECT *
FROM Portfolio_Project.dbo.Covid_deaths
ORDER by 3,4

--Making Sure Table Data was Imported Successfully
SELECT *
FROM Portfolio_Project.dbo.Covid_Vaccinations
ORDER by 3,4

--Select Data I am going to use
SELECT Location, date, total_cases, new_cases, total_deaths, population
FROM Portfolio_Project.dbo.Covid_deaths
ORDER BY 1, 2

--Total Cases vs Total Deaths
SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as Death_Percentage
FROM Portfolio_Project.dbo.Covid_deaths
ORDER BY 1, 2

--Narrow Down Results to Location with States in the name and adds Fatality Percentage
SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as Death_Percentage
FROM Portfolio_Project.dbo.Covid_deaths
Where Location like '%states%' 
ORDER BY 1, 2

--Total Cases vs Population --> Shows Population Infection Percentage in the United States
SELECT Location, date, total_cases, population, (total_cases/population)*100 as Infection_Percentage
FROM Portfolio_Project.dbo.Covid_deaths
Where location like '%states%' 
ORDER BY 1, 2

--Countries with highest Infection rate compared to Population
SELECT Location, population, MAX(total_cases) as Higest_Infection_Count, MAX((total_cases/population))*100 as Pop_Infection_Percentage
FROM Portfolio_Project.dbo.Covid_deaths
WHERE continent is not NULL
GROUP BY location, population
ORDER BY 4 DESC

--Countries with highest Mortality rate compared to Population 
--(total_deaths datatype is a varchar and needs to be cast as int for true results)
SELECT Location, population, MAX(cast(total_deaths as int)) as Total_Death_Count, MAX((total_deaths/population))*100 as Pop_Fatality_Percentage
FROM Portfolio_Project.dbo.Covid_deaths
WHERE continent is not NULL
GROUP BY location, population
ORDER BY 3 DESC

--Highest Mortality rate by Continent
SELECT location, population, MAX(cast(total_deaths as int)) as Total_Death_Count, MAX((total_deaths/population))*100 as Pop_Fatality_Percentage
FROM Portfolio_Project.dbo.Covid_deaths
WHERE continent is NULL
GROUP BY location, population
ORDER BY 3 DESC

--Global Mortality rate by Date
SELECT location, date, population, MAX(cast(total_deaths as int)) as Total_Death_Count, MAX((total_deaths/population))*100 as Pop_Fatality_Percentage
FROM Portfolio_Project.dbo.Covid_deaths
WHERE Location like 'World'
GROUP BY date, population,location

--Global Daily New Cases and Deaths
SELECT location, date, SUM(new_cases) as Daily_New_Cases, SUM(cast(new_deaths as int)) as Daily_Fatalities, (SUM(cast(new_deaths as int))/SUM(new_cases))*100 as Fatality_Percentage
FROM Portfolio_Project.dbo.Covid_deaths
WHERE Location like 'World' AND new_cases != 0
GROUP BY date, location

--Join Tables
SELECT *
FROM  Covid_deaths dea 
Join Covid_Vaccinations vac
ON dea.location = vac.location 
AND dea.date = vac.date

--Total Population vs Total Vaccinations

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.location ORDER BY dea.location, dea.date) as Total_Vaccinations
FROM  Covid_deaths dea Join Covid_Vaccinations vac
ON dea.location = vac.location AND dea.date = vac.date
WHERE dea.continent is not NULL AND vac.new_vaccinations is not NULL 
ORDER BY 2, 3

--Total Population vs Total Vaccinations (Further Calculations using CTE)

With PopvsVac (Continent, Location, Date, Population, New_Vaccinations,Total_Vaccinations)
AS
(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.location ORDER BY dea.location, dea.date) as Total_Vaccinations
FROM  Covid_deaths dea Join Covid_Vaccinations vac
ON dea.location = vac.location AND dea.date = vac.date
WHERE dea.continent is not NULL AND vac.new_vaccinations is not NULL 
--ORDER BY 2, 3
)
SELECT * , (Total_Vaccinations/Population)*100 AS Vaccination_Percentage
FROM PopvsVac