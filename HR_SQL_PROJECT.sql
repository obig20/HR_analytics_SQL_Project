use stud;
select * from project;

## rename the coulmumn age 

ALTER TABLE project
RENAME column ï»¿Age TO Age;

SELECT * FROM project;

#check the number of data point 
SELECT COUNT(*) FROM Project;

# check the information of the data 
describe Project;




## checking  value incocistency
  
SELECT DISTINCT Attrition FROM Project;
SELECT DISTINCT Gender FROM Project;

## checking if any duplicate value exist

select age,Attrition,Department,Education,EmployeeNumber,Gender,JobRole,JobRole , count(*)
from Project
Group by age,Attrition,Department,Education,EmployeeNumber,Gender,JobRole,JobRole

having count(*) > 1;

# checking null values

SELECT
    SUM(Attrition IS NULL) AS Attrition_nulls,
    SUM(BusinessTravel IS NULL) AS BusinessTravel_nulls,
    SUM(DailyRate IS NULL) AS DailyRate_nulls,
    SUM(Department IS NULL) AS Department_nulls,
    SUM(DistanceFromHome IS NULL) AS DistanceFromHome_nulls,
    SUM(Education IS NULL) AS Education_nulls,
    SUM(EducationField IS NULL) AS EducationField_nulls,
    SUM(EmployeeCount IS NULL) AS EmployeeCount_nulls,
    SUM(EmployeeNumber IS NULL) AS EmployeeNumber_nulls,
    SUM(EnvironmentSatisfaction IS NULL) AS EnvironmentSatisfaction_nulls,
    SUM(Gender IS NULL) AS Gender_nulls,
    SUM(HourlyRate IS NULL) AS HourlyRate_nulls,
    SUM(JobInvolvement IS NULL) AS JobInvolvement_nulls,
    SUM(JobLevel IS NULL) AS JobLevel_nulls,
    SUM(JobRole IS NULL) AS JobRole_nulls,
    SUM(JobSatisfaction IS NULL) AS JobSatisfaction_nulls,
    SUM(MaritalStatus IS NULL) AS MaritalStatus_nulls,
    SUM(MonthlyIncome IS NULL) AS MonthlyIncome_nulls,
    SUM(MonthlyRate IS NULL) AS MonthlyRate_nulls,
    SUM(NumCompaniesWorked IS NULL) AS NumCompaniesWorked_nulls,
    SUM(Over18 IS NULL) AS Over18_nulls,
    SUM(OverTime IS NULL) AS OverTime_nulls,
    SUM(PercentSalaryHike IS NULL) AS PercentSalaryHike_nulls,
    SUM(PerformanceRating IS NULL) AS PerformanceRating_nulls,
    SUM(RelationshipSatisfaction IS NULL) AS RelationshipSatisfaction_nulls,
    SUM(StandardHours IS NULL) AS StandardHours_nulls,
    SUM(StockOptionLevel IS NULL) AS StockOptionLevel_nulls,
    SUM(TotalWorkingYears IS NULL) AS TotalWorkingYears_nulls,
    SUM(TrainingTimesLastYear IS NULL) AS TrainingTimesLastYear_nulls,
    SUM(WorkLifeBalance IS NULL) AS WorkLifeBalance_nulls,
    SUM(YearsAtCompany IS NULL) AS YearsAtCompany_nulls,
    SUM(YearsInCurrentRole IS NULL) AS YearsInCurrentRole_nulls,
    SUM(YearsSinceLastPromotion IS NULL) AS YearsSinceLastPromotion_nulls,
    SUM(YearsWithCurrManager IS NULL) AS YearsWithCurrManager_nulls
FROM Project;



SELECT 
    CASE 
        WHEN YearsAtCompany <= 2 THEN '0-2 Years (New Joiner)'
        WHEN YearsAtCompany <= 5 THEN '3-5 Years (Mid-Tenure)'
        WHEN YearsAtCompany <= 10 THEN '6-10 Years (Experienced)'
        ELSE '11+ Years (Veteran)'
    END AS Experience_Bracket,
    COUNT(*) AS Total_Employees,
    ROUND(AVG(MonthlyIncome), 0) AS Avg_Income,
    ROUND(AVG(Attrition = 'Yes') * 100, 2) AS Attrition_Rate_Pct
FROM project
GROUP BY 1 
ORDER BY Avg_Income ASC;



## shew distance from home by job role and attrition

Select Attrition,
	DistanceFromHome,
	JobRole , 
    row_number() over (partition by DistanceFromHome,Attrition order by age) as as_row_rank

from project;

##show distace from home  by job role and attrition if the attrtion is yes and 

Select Attrition,
	DistanceFromHome,
    JobRole,JobSatisfaction , 
    row_number() over (partition by DistanceFromHome,Attrition order by JobSatisfaction ASC) as as_row_rank

from project
where Attrition ='Yes';


#  count the number attrition based on department

SELECT Department, COUNT(*) as Total_employe,
	sum(Attrition='Yes') as total_attirtion,
    sum(Gender='Male') as male,
    sum(Gender ='Female') as female
FROM Project
GROUP BY Department;


# checkin the relationship between job role and attrition

SELECT
    JobRole,
    COUNT(*) total,
    ROUND(AVG(Attrition='Yes') * 100, 2) attrition_rate
FROM Project
GROUP BY JobRole
ORDER BY attrition_rate DESC;



##show distace from home  by job role and attrition 

Select Attrition,
	JobRole,	
    JobSatisfaction ,
    row_number() over (partition by DistanceFromHome,Attrition order by JobSatisfaction desc) as as_row_rank

from project;

## compare average monthly income by education and attrition
	/* Education
	1 'Below College'
	2 'College'
	3 'Bachelor'
	4 'Master'
	5 'Doctor' */

select Education,
	avg(MonthlyIncome) Over(partition by Education,Attrition) 
	AS Average_income,
    Attrition, 
    DistanceFromHome,
	MonthlyIncome , 
	EducationField,
	PerformanceRating,
	YearsAtCompany,
	YearsInCurrentRole

From project;

## from this we learn that year of exeriance is more matter than Education level but average income also increase as education level increase

## as the average income deacrease the number attriation also increase

##  lets show the effect if environmetan satsfaction and DistanceFromHome for attritation at male employee

-- select * from CTE_EXAMPLE_1

##  lets show the effect if environmetan satsfaction and DistanceFromHome for attritation at female employee
 Drop table if exists EXAMPLE_ONE ;
create temporary table EXAMPLE_ONE AS 
SELECT
    COUNT(*) total_employees,
    SUM(Attrition = 'Yes') total_attrition,
    SUM(Attrition = 'No') total_non_attrition,
   round(avg(Attrition = 'Yes') * 100 ,2) attrition_rate_pct,
    EnvironmentSatisfaction,
    AVG(DistanceFromHome) average_distance,
    SUM(Gender = 'Female') female_employee,
    sum(Gender ='Male') male_employee
FROM project
GROUP BY EnvironmentSatisfaction
order by EnvironmentSatisfaction  DESC;

select * from EXAMPLE_ONE;

## total attribution is increase when the enviromental CondtionSatasfication becomes low
## here Distance from home seam like not affcted the attritiion rate
select * from Project;

###EducationField , PercentSalaryHike ,JobRole , JobRole

SELECT
    EducationField,
    
    COUNT(*) total_employees,
    ROUND(AVG(Attrition = 'Yes') * 100, 2) attrition_rate_pct
FROM project
GROUP BY EducationField
ORDER BY EducationField DESC;

SELECT
    MonthlyRate,
    
    COUNT(*) total_employees,
    ROUND(AVG(Attrition = 'Yes') * 100, 2) attrition_rate_pct
FROM project
GROUP BY MonthlyRate
ORDER BY MonthlyRate ASC;



SELECT
    WorkLifeBalance,

    COUNT(*) total_employees,
    ROUND(AVG(Attrition = 'Yes') * 100, 2) attrition_rate_pct
FROM project
GROUP BY WorkLifeBalance
order by WorkLifeBalance DESC;

##Does a lack of promotion lead to higher attrition, regardless of Job Role?

SELECT
    YearsSinceLastPromotion,
    ROUND(AVG(Attrition = 'Yes') * 100, 2) attrition_rate_pct
FROM project
GROUP BY YearsSinceLastPromotion
order by YearsSinceLastPromotion DESC;


SELECT avg(YearsSinceLastPromotion)
from Project
where Attrition='Yes'; 
SELECT avg(YearsSinceLastPromotion)
from Project
where Attrition='No' ;

## WORK life balance vs performane  
SELECT PerformanceRating, AVG(WorkLifeBalance) 
FROM project 
GROUP BY PerformanceRating;


## identigying risk emplooyes 

WITH Risk_Analysis AS (
    SELECT 
        EmployeeNumber,
        Attrition,
        EnvironmentSatisfaction,
        OverTime,
        StockOptionLevel,
        
        CASE 
            WHEN EnvironmentSatisfaction <= 2 
                 AND OverTime = 'Yes' 
                 AND StockOptionLevel = 0 
            THEN 'High Risk'
            ELSE 'Standard'
        END AS Risk_Category
    FROM project
)
SELECT 
    Risk_Category,
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Total_Leavers,
    ROUND(AVG(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100, 2) AS Attrition_Rate_Pct
FROM Risk_Analysis
GROUP BY Risk_Category;


CREATE VIEW attrition_by_role AS
SELECT
    JobRole,
    ROUND(AVG(Attrition='Yes') * 100, 2) attrition_rate
FROM Project
GROUP BY JobRole;

select * from attrition_by_role


