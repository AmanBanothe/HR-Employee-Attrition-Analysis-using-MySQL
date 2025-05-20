# 💼 HR Employee Attrition Analysis using MySQL

This project is a comprehensive HR analytics case study using MySQL, based on IBM's HR dataset. The goal is to identify trends, patterns, and drivers of employee attrition, helping HR teams make data-driven decisions to improve retention.

---

## 📂 Dataset

- **Source**: [IBM HR Analytics Dataset (Kaggle)](https://www.kaggle.com/datasets/pavansubhasht/ibm-hr-analytics-attrition-dataset)
- **Format**: CSV
- **Columns Used** (selected):
  - `Age`, `Attrition`, `BusinessTravel`, `Department`, `DistanceFromHome`
  - `Education`, `EnvironmentSatisfaction`, `JobRole`, `MonthlyIncome`
  - `OverTime`, `PerformanceRating`, `TotalWorkingYears`, `YearsAtCompany`

---

## 🛠 Tools Used

| Tool   |           Purpose             |
|--------|-------------------------------|
| MySQL  | Data storage and analysis     |
| Excel  | Preprocessing CSV (optional)  |
| GitHub | Project documentation         |

---

📈 Project Objectives
> Identify key factors contributing to employee attrition.

> Segment high-risk employee groups.

> Suggest actionable retention strategies using data.

.

🔍 Key SQL Queries and Insights

✅ Attrition Rate by Department
💡 Insight: Departments like Sales or R&D have higher attrition — worth deeper investigation.

SELECT Department, 
       COUNT(*) AS Total_Employees,
       SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attritions,
       ROUND(SUM(CASE WHEN Attrition = 'Yes') * 100.0 / COUNT(*), 2) AS Attrition_Rate
FROM hr_attrition
GROUP BY Department;


✅ Income Group vs Attrition
💡 Insight: Lower income groups show significantly higher attrition.

SELECT 
  CASE 
    WHEN MonthlyIncome < 3000 THEN 'Low Income'
    WHEN MonthlyIncome BETWEEN 3000 AND 6000 THEN 'Mid Income'
    ELSE 'High Income' END AS Income_Bracket,
  COUNT(*) AS Total,
  SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attritions,
  ROUND(SUM(CASE WHEN Attrition = 'Yes') * 100.0 / COUNT(*), 2) AS Attrition_Rate
FROM hr_attrition
GROUP BY Income_Bracket;

✅ High Risk Attrition Profile (Custom Scoring)
💡 Insight: Employees with low pay, long commute, and overtime are most at risk.

SELECT *
FROM hr_attrition
WHERE MonthlyIncome < 3000 
  AND DistanceFromHome > 10
  AND OverTime = 'Yes';

✅ Job Role + Department Attrition Hotspots
💡 Insight: Focus on specific job-department pairs that drive attrition.

SELECT Department, JobRole,
       ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)*100.0 / COUNT(*), 2) AS Attrition_Rate
FROM hr_attrition
GROUP BY Department, JobRole
ORDER BY Attrition_Rate DESC
LIMIT 5;

💡 More Queries:
#1. Overall Attrition Rate
#2. Attrition by Job Role
#3. Attrition by Age Group
#4. Impact of Overtime on Attrition
#5. Attrition by Distance from Home
#6. Monthly Income vs Attrition (Income brackets)
#7. Attrition by Department
#8. Job Role vs Monthly Income
#9. Attrition by Education Level
#10. Total Working Years vs Attrition
#11. Years at Company Grouped
#12. Performance Rating vs Attrition
#13. High Risk Employees (Low Income + High Distance + Overtime)
#Advanced analyze
#14 Which combination of Job Role & Department shows highest attrition?
#Insight: Helps HR target specific job roles within departments for retention strategies.
#15. Compare average tenure (YearsAtCompany) of employees who left vs stayed
#16. Attrition Risk Score (Custom Score Calculation)
#17. Employees with High Performance but Still Left
#18. Average Income vs Years of Experience (Working Years)
#19. Attrition by Distance Buckets
#20. Correlation between Environment Satisfaction & Attrition
#21. Cohort Analysis: Who joined <2 years ago and already left?
#22. Are young employees leaving more frequently?
#23. Employee Retention Ratio by Job Role


📌 Key Insights
> OverTime is a strong attrition driver.
> Low-income and high-distance employees show higher turnover.
> New employees (0-2 years) leave more often — signaling onboarding/culture-fit issues.
> Some high-performing, well-paid employees still leave — possible job dissatisfaction or leadership gap.
> Helps HR target specific job roles within departments for retention strategies.
> Reveals whether long-serving employees or new joiners are leaving more.
> Use this to segment employees for proactive retention programs.
> Losing top performers is costly—this helps flag critical losses.
> Useful for HR compensation benchmarking.
> Helps HR with location-based working policy (WFH/flex commute).
> Poor workplace experience often correlates with employee churn.

✅ Conclusion
Using simple yet powerful SQL analytics, this project uncovers valuable trends hidden in HR data. The goal is to help HR departments identify, understand, and act on attrition patterns — improving employee engagement and reducing talent loss.

📁 Project Structure
📦 HR-Attrition-MySQL
 ┣ 📁 data
 ┃ ┗ hr_attrition.csv
 ┣ 📄 queries.sql
 ┣ 📄 insights.md
 ┣ 📄 README.md


✍ Author
Aman Banothe
📎 LinkedIn : https://www.linkedin.com/in/aman-banothe-5174ba223/
🧠 Data Analyst | Power BI | MySQL | Tableau | Python



⭐ Bonus
Want to go further? Build a Power BI or Tableau dashboard from this dataset and add a short case-study video or presentation to your portfolio.

---

Would you like me to now generate:
- `📄 insights.md` (for detailed query + insight documentation), or
- Start the **next MySQL project**: `AdventureWorks Sales Analysis`?

Just tell me: `insights.md` or `Next Project`.

