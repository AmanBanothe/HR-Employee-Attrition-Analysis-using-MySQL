#1. Overall Attrition Rate
SELECT 
  COUNT(*) AS Total_Employees,
  SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attrited_Employees,
  ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Attrition_Rate
FROM hr_attrition;

#2. Attrition by Job Role
SELECT JobRole,
       COUNT(*) AS Total,
       SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attritions,
       ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)*100.0 / COUNT(*), 2) AS Attrition_Percent
FROM hr_attrition
GROUP BY JobRole
ORDER BY Attrition_Percent DESC;

#3. Attrition by Age Group
SELECT 
  CASE 
    WHEN Age < 30 THEN 'Under 30'
    WHEN Age BETWEEN 30 AND 40 THEN '30-40'
    WHEN Age BETWEEN 41 AND 50 THEN '41-50'
    ELSE '50+' END AS Age_Group,
  COUNT(*) AS Total,
  SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attritions,
  ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)*100.0 / COUNT(*), 2) AS Attrition_Rate
FROM hr_attrition
GROUP BY Age_Group;

#4. Impact of Overtime on Attrition
SELECT OverTime,
       COUNT(*) AS Total,
       SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attritions,
       ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)*100.0 / COUNT(*), 2) AS Attrition_Rate
FROM hr_attrition
GROUP BY OverTime;

#5. Attrition by Distance from Home
SELECT DistanceFromHome,
       COUNT(*) AS Total_Employees,
       SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attritions
FROM hr_attrition
GROUP BY DistanceFromHome
ORDER BY DistanceFromHome;

#6. Monthly Income vs Attrition (Income brackets)
SELECT 
  CASE 
    WHEN MonthlyIncome < 3000 THEN 'Low Income (<3000)'
    WHEN MonthlyIncome BETWEEN 3000 AND 6000 THEN 'Mid Income (3000-6000)'
    ELSE 'High Income (>6000)' END AS Income_Bracket,
  COUNT(*) AS Total,
  SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attritions,
  ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)*100.0 / COUNT(*), 2) AS Attrition_Rate
FROM hr_attrition
GROUP BY Income_Bracket;

#7. Attrition by Department
SELECT Department,
       COUNT(*) AS Total_Employees,
       SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attritions,
       ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)*100.0 / COUNT(*), 2) AS Attrition_Rate
FROM hr_attrition
GROUP BY Department;

#8. Job Role vs Monthly Income
SELECT JobRole, 
       ROUND(AVG(MonthlyIncome), 2) AS Avg_Income
FROM hr_attrition
GROUP BY JobRole
ORDER BY Avg_Income DESC;

#9. Attrition by Education Level
SELECT Education,
       COUNT(*) AS Total,
       SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attritions,
       ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)*100.0 / COUNT(*), 2) AS Attrition_Rate
FROM hr_attrition
GROUP BY Education;

#10. Total Working Years vs Attrition
SELECT TotalWorkingYears,
       COUNT(*) AS Employees,
       SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attritions
FROM hr_attrition
GROUP BY TotalWorkingYears
ORDER BY TotalWorkingYears;

#11. Years at Company Grouped
SELECT 
  CASE 
    WHEN YearsAtCompany < 2 THEN '0-2 yrs'
    WHEN YearsAtCompany BETWEEN 2 AND 5 THEN '2-5 yrs'
    ELSE '5+ yrs' END AS Tenure_Group,
  COUNT(*) AS Total,
  SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attritions,
  ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)*100.0 / COUNT(*), 2) AS Attrition_Rate
FROM hr_attrition
GROUP BY Tenure_Group;

#12. Performance Rating vs Attrition
SELECT PerformanceRating,
       COUNT(*) AS Total_Employees,
       SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attritions
FROM hr_attrition
GROUP BY PerformanceRating;

#13. High Risk Employees (Low Income + High Distance + Overtime)
SELECT * FROM hr_attrition
WHERE MonthlyIncome < 3000 
  AND DistanceFromHome > 10
  AND OverTime = 'Yes';

#Advanced analyze

#14 Which combination of Job Role & Department shows highest attrition?
#Insight: Helps HR target specific job roles within departments for retention strategies.

select 
  Department,
  JobRole,
  COUNT(*) AS Total_Employees,
  SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attritions,
  ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)*100.0 / COUNT(*), 2) AS Attrition_Rate
FROM hr_attrition
GROUP BY Department, JobRole
ORDER BY Attrition_Rate DESC
LIMIT 5;

#15. Compare average tenure (YearsAtCompany) of employees who left vs stayed
# Insight: Reveals whether long-serving employees or new joiners are leaving more.
SELECT 
  Attrition,
  ROUND(AVG(YearsAtCompany), 2) AS Avg_YearsAtCompany,
  ROUND(AVG(TotalWorkingYears), 2) AS Avg_TotalExperience
FROM hr_attrition
GROUP BY Attrition;


#16. Attrition Risk Score (Custom Score Calculation)
# Insight: Use this to segment employees for proactive retention programs.
SELECT 
  EmployeeID,
  JobRole,
  Age,
  MonthlyIncome,
  OverTime,
  DistanceFromHome,
  CASE 
    WHEN OverTime = 'Yes' AND MonthlyIncome < 3000 AND DistanceFromHome > 10 THEN 'High Risk'
    WHEN OverTime = 'Yes' AND MonthlyIncome BETWEEN 3000 AND 5000 THEN 'Medium Risk'
    ELSE 'Low Risk'
  END AS Attrition_Risk_Category
FROM hr_attrition;

#17. Employees with High Performance but Still Left
# Insight: Losing top performers is costly—this helps flag critical losses.
SELECT *
FROM hr_attrition
WHERE Attrition = 'Yes'
  AND PerformanceRating = 4
  AND MonthlyIncome > 5000
ORDER BY MonthlyIncome DESC;


#18. Average Income vs Years of Experience (Working Years)
SELECT 
  TotalWorkingYears,
  COUNT(*) AS Employees,
  ROUND(AVG(MonthlyIncome), 2) AS Avg_Income
FROM hr_attrition
GROUP BY TotalWorkingYears
HAVING TotalWorkingYears IS NOT NULL
ORDER BY TotalWorkingYears;

#19. Attrition by Distance Buckets
SELECT 
  CASE 
    WHEN DistanceFromHome BETWEEN 0 AND 5 THEN '0-5 KM'
    WHEN DistanceFromHome BETWEEN 6 AND 10 THEN '6-10 KM'
    ELSE '10+ KM' END AS Distance_Bucket,
  COUNT(*) AS Total,
  SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attritions,
  ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Attrition_Rate
FROM hr_attrition
GROUP BY Distance_Bucket
ORDER BY Attrition_Rate DESC;

#20. Correlation between Environment Satisfaction & Attrition
SELECT EnvironmentSatisfaction,
       COUNT(*) AS Total,
       SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attritions,
       ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)*100.0 / COUNT(*), 2) AS Attrition_Rate
FROM hr_attrition
GROUP BY EnvironmentSatisfaction;

#21. Cohort Analysis: Who joined <2 years ago and already left?
SELECT *
FROM hr_attrition
WHERE Attrition = 'Yes'
  AND YearsAtCompany <= 2;

#22. Are young employees leaving more frequently?
SELECT 
  CASE 
    WHEN Age BETWEEN 18 AND 25 THEN '18-25'
    WHEN Age BETWEEN 26 AND 35 THEN '26-35'
    WHEN Age BETWEEN 36 AND 45 THEN '36-45'
    ELSE '46+' END AS Age_Group,
  COUNT(*) AS Total,
  SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attritions,
  ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)*100.0 / COUNT(*), 2) AS Attrition_Rate
FROM hr_attrition
GROUP BY Age_Group
ORDER BY Attrition_Rate DESC;

#23. Employee Retention Ratio by Job Role
SELECT 
  JobRole,
  COUNT(*) AS Total_Employees,
  SUM(CASE WHEN Attrition = 'No' THEN 1 ELSE 0 END) AS Retained,
  ROUND(SUM(CASE WHEN Attrition = 'No' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Retention_Rate
FROM hr_attrition
GROUP BY JobRole
ORDER BY Retention_Rate ASC;


