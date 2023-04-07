select * 
from [Portfolio Project].dbo.CovidDeaths 
where continent is not null
order by  3,4

--select *
--from [Portfolio Project].dbo.CovidVaccinations
--order by 3,4

--select date that we are going to be using 

 select location , date, total_cases,new_cases,total_deaths ,population
 from [Portfolio Project].dbo.CovidDeaths
 order by 1,2

 --looking at total cases vs total deaths
 --shows likelihood of dying if you contract covid in your country

Select Location, date, total_cases,total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
From [Portfolio Project].dbo.CovidDeaths
Where location like '%states%'
and  continent is not null 
order by 1,2

--looking at total cases vs population 
--show what percentage of 

select location,date,total_cases,population,total_cases,(total_cases/population)*100 as Deathpercenttage
from [Portfolio Project].dbo.CovidDeaths
where location like '%states%'
order by 1,2


--looking at countries with highest infection rate compared to population
select location,population,max (total_cases) as highestinfectioncount ,max 
(total_cases/population)*100 as percentpopulationinfected
from [Portfolio Project].dbo.CovidDeaths
--where location like '%states%'
group by location,population
order by percentpopulationinfected desc
 
 
 --showing countries with highest death count per population

 select location,max(cast( total_deaths as int))as totaldeathcount
 from [Portfolio Project].dbo.CovidDeaths
 where continent is not null
 group by location
 order by totaldeathcount desc

 --lets break things down by continent
 select location,max(cast( total_deaths as int))as totaldeathcount
 from [Portfolio Project].dbo.CovidDeaths
 where continent is  null
 group by  location
 order by totaldeathcount desc

 --showing contintents with the highest death count per population
 select location,max(cast( total_deaths as int))as totaldeathcount
 from [Portfolio Project].dbo.CovidDeaths
 where continent is not   null
 group by  location
 order by totaldeathcount desc

 --globel numbers 
Select  SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From [Portfolio Project].dbo.CovidDeaths
--Where location like '%states%'
where continent is not null 
--Group By date
order by 1,2


--looking at totel population vs vaccinations

select  dea.continent ,dea.location,dea.date,dea.population,vac.new_vaccinations
,  sum (convert(int ,vac.new_vaccinations))over(partition by dea.location order by
dea.location,dea.date)
from [Portfolio Project].dbo.CovidVaccinations vac
join [Portfolio Project].dbo.CovidDeaths dea
on dea.location =vac.location
and dea.date =vac.date
where dea.continent is not null
order by 2,3

--use cte
with popvsvac (contitent ,location,date,population,new_vaccinations,
rollingpepolvaccinated)as (
select  dea.continent ,dea.location,dea.date,dea.population,vac.new_vaccinations
,  sum (convert(int ,vac.new_vaccinations))over(partition by dea.location order by
dea.location,dea.date)
from [Portfolio Project].dbo.CovidVaccinations vac
join [Portfolio Project].dbo.CovidDeaths dea
on dea.location =vac.location
and dea.date =vac.date
where dea.continent is not null
--order by 2,3
)
select * 
from percentpopulationlvaccinated


	
 
