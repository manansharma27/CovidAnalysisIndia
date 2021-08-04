SELECT * FROM Covid19_project.dbo.covid_vaccine_statewise$

-- Checking Total Doses Booked in different states, taking maximum number because previous numbers are been added in each row, so max numbers is total doses

SELECT State,MAX([Total Doses Administered]) AS Total_Vaccine_Booked
FROM Covid19_project.dbo.covid_vaccine_statewise$
GROUP BY State
ORDER BY Total_Vaccine_Booked DESC

-- Top States that have been vaccinated 

SELECT DISTINCT State,MAX([Total Individuals Vaccinated]) AS People_Vaccinated
FROM Covid19_project.dbo.covid_vaccine_statewise$
GROUP BY State
ORDER BY People_Vaccinated DESC

-- Checking total number of vaccine booked vs people vaccinated in that state

SELECT State,
		MAX([Total Doses Administered]) AS Total_Vaccination_Administrated,
		MAX([Total Individuals Vaccinated]) AS People_Vaccinated
FROM Covid19_project.dbo.covid_vaccine_statewise$
WHERE State != 'India'
GROUP BY State
ORDER BY People_Vaccinated DESC

-- Checking Different types of vaccines taken by people in each state

SELECT State,
		MAX([Total CoviShield Administered]) AS Covishield_Vaccination, 
		MAX([Total Covaxin Administered]) AS Covaxin_Vaccinated, 
		MAX([Total Individuals Vaccinated]) AS People_Vaccinated
FROM Covid19_project.dbo.covid_vaccine_statewise$
WHERE State != 'India'
GROUP BY State
ORDER BY Covishield_Vaccination DESC, Covaxin_Vaccinated DESC

-- Checking Percentage Coishield Vaccine vs total vaccine

SELECT DISTINCT State,
				Date ,
				([Total CoviShield Administered]/[Total Doses Administered])*100 AS CovishieldVaccinePercent
FROM Covid19_project.dbo.covid_vaccine_statewise$
WHERE State != 'India'
ORDER BY CovishieldVaccinePercent DESC

-- Checking Percentage Covaxin Vaccine vs total vaccine

SELECT DISTINCT State,
				Date,
				([Total Covaxin Administered]/[Total Doses Administered])*100 AS CovaxinVaccinePercent
FROM Covid19_project.dbo.covid_vaccine_statewise$
WHERE State != 'India'
ORDER BY CovaxinVaccinePercent DESC

-- Checking Percentage Sputnik V Vaccine vs total vaccine

SELECT DISTINCT State,
				Date,
				([Total Sputnik V Administered]/[Total Doses Administered])*100 AS SputnikVaccinePercent
FROM Covid19_project.dbo.covid_vaccine_statewise$
WHERE State != 'India'
ORDER BY SputnikVaccinePercent DESC

-- Checking vaccine taken by people based on gender and Total Vaccines

SELECT DISTINCT State,
				MAX([Male(Individuals Vaccinated)]) AS Male,
				MAX([Female(Individuals Vaccinated)]) AS Female,
				MAX([Transgender(Individuals Vaccinated)]) AS Others,
				MAX([Total Individuals Vaccinated]) AS TotalVaccine 
FROM Covid19_project.dbo.covid_vaccine_statewise$
WHERE State != 'India'
GROUP BY State
ORDER BY Male DESC,Female DESC, Others Desc, TotalVaccine DESC

-- Checking Top 10 State that have taken First dose and Second dose 

SELECT DISTINCT TOP(10) State,
				MAX([First Dose Administered]) AS FirstDose,
				MAX([Second Dose Administered]) AS SecondDose,
				MAX([Total Doses Administered]) AS TotalDoseBooked 
FROM Covid19_project.dbo.covid_vaccine_statewise$
WHERE State != 'India'
GROUP BY State
ORDER BY FirstDose DESC,SecondDose DESC,TotalDoseBooked DESC

-- Checking Vaccine taken by people of different age group 

SELECT State,
		MAX(CAST([18-45 years (Age)] AS int)) AS YouthVaccine,
		MAX(CAST([45-60 years (Age)] AS int)) AS MiddleAge,
		MAX(CAST([60+ years (Age)] AS int)) AS SeniorCitizens 
FROM Covid19_project.dbo.covid_vaccine_statewise$
WHERE State != 'India'
GROUP BY State
ORDER BY YouthVaccine DESC,MiddleAge DESC,SeniorCitizens DESC

-- Checking percentage of people that have taken vaccine of different age group 

SELECT State,
		(MAX(CAST([18-45 years (Age)] AS int)) / MAX([Total Individuals Vaccinated])) * 100 AS YouthVaccinePercent,
		(MAX(CAST([45-60 years (Age)] AS int)) / MAX([Total Individuals Vaccinated])) * 100 AS MiddleAgePercent,
		(MAX(CAST([60+ years (Age)] AS int)) / MAX([Total Individuals Vaccinated])) * 100 AS SeniorCitizensPercent 
FROM Covid19_project.dbo.covid_vaccine_statewise$
WHERE State != 'India'
GROUP BY State
ORDER BY YouthVaccinePercent DESC,MiddleAgePercent DESC,SeniorCitizensPercent DESC


-- Checking the vaccine details in the state of 'Madhya Pradesh'

SELECT State,
		MAX([First Dose Administered]) AS FirstDose,
		MAX([Second Dose Administered]) AS SecondDose,
		MAX([Total Doses Administered]) AS TotalDoseBooked,
		MAX([Total Individuals Vaccinated]) AS TotalVaccines
FROM Covid19_project.dbo.covid_vaccine_statewise$
WHERE State LIKE '%Madhya Pradesh%'
GROUP BY State
ORDER BY FirstDose DESC,SecondDose DESC,TotalDoseBooked DESC, TotalVaccines DESC



-- Some Data Cleaning needs to be done like - column name change and dropping the not required columns

-- Dropping columns that are not of use like 'AEFI', 'Total Sites','Total Sessions Conducted'

ALTER TABLE Covid19_project.dbo.covid_vaccine_statewise$
DROP COLUMN AEFI,[Total Sites];

ALTER TABLE Covid19_project.dbo.covid_vaccine_statewise$
DROP COLUMN [Total Sessions Conducted];

-- Changing the datatype of columns (18-45),(45-60),(60+) (Youth,MiddleAge,SeniorCitizen) as it has nvarchar datatype, need to change it to float

ALTER TABLE Covid19_project.dbo.covid_vaccine_statewise$
ALTER COLUMN Youth float;

ALTER TABLE Covid19_project.dbo.covid_vaccine_statewise$
ALTER COLUMN MiddleAge float;

ALTER TABLE Covid19_project.dbo.covid_vaccine_statewise$
ALTER COLUMN SeniorCitizen float;