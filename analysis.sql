-- DATA ANALYSIS USING SQL ON HealthCare Database 
 -- This dataset is not based on real facts, please don't consider the result sets to be actual and utilize it for any purpose.
    
-- Creating Database named Healthcare.
CREATE DATABASE Healthcare;

-- Selecting Healthcare database to query.
USE Healthcare;

-- Viewing Data on Database
SELECT * FROM healthcare;

-- Describing characteristics of table.
DESC Healthcare;

-- 1. Counting Total Record in Database
SELECT COUNT(*) FROM Healthcare;  

-- 2. Finding maximum age of patient admitted.
select max(age) as Maximum_Age from Healthcare;

-- 3. Finding Average age of hospitalized patients.
select round(avg(age),0) as Average_Age from Healthcare; 

-- 4. Calculating Patients Hospitalized Age-wise from Maximum to Minimum
SELECT AGE, COUNT(AGE) AS Total
FROM Healthcare
GROUP BY age
ORDER BY AGE DESC;
 -- Findings : The output will display a list of unique ages present in the "Healthcare" table along with the count of occurrences for each age, sorted from oldest to youngest.
    
    
-- 5. Calculating Maximum Count of patients on basis of total patients hospitalized with respect to age.
SELECT AGE, COUNT(AGE) AS Total
FROM Healthcare
GROUP BY age
ORDER BY Total DESC,age DESC;

-- 6. Ranking Age on the number of patients Hospitalized   
SELECT AGE, COUNT(AGE) As Total, dense_RANK() OVER(ORDER BY COUNT(AGE) DESC, age DESC) as Ranking_Admitted 
FROM Healthcare
GROUP BY age
HAVING Total > Avg(age);

-- 7. Finding Count of Medical Condition of patients and lisitng it by maximum no of patients.
SELECT Medical_Condition, COUNT(Medical_Condition) as Total_Patients 
FROM healthcare
GROUP BY Medical_Condition
ORDER BY Total_patients DESC;
 -- Findings : This query retrieves a breakdown of medical conditions recorded in a healthcare dataset along with the total number of patients diagnosed with each condition. It groups the data by distinct medical conditions, counting the occurrences of each condition across the dataset. The result is presented in descending order based on the total number of patients affected by each medical condition, providing an insight into the prevalence or frequency of various health issues within the dataset

-- 8. Finding Rank & Maximum number of medicines recommended to patients based on Medical Condition pertaining to them.    
SELECT Medical_Condition, Medication, COUNT(medication) as Total_Medications_to_Patients, RANK() OVER(PARTITION BY Medical_Condition ORDER BY COUNT(medication) DESC) as Rank_Medicine
FROM Healthcare
GROUP BY 1,2
ORDER BY 1; 
 -- Finding : The output provides insight into the most common medications used for various medical conditions, assigning a rank to each medication based on how frequently its prescribed within its corresponding condition.
    

-- 9. Most preffered Insurance Provide by Patients Hospatilized
SELECT Insurance_Provider, COUNT(Insurance_Provider) AS Total 
FROM Healthcare
GROUP BY Insurance_Provider
ORDER BY Total DESC;
 -- Findings : This information helps identify the most prevalent insurance providers among the patient population, offering valuable data for resource allocation, understanding coverage preferences, and potentially indicating trends in healthcare accessibility based on insurance networks
    

-- 10. Finding out most preffered Hospital 
SELECT Hospital, COUNT(hospital) AS Total 
FROM Healthcare
GROUP BY Hospital
ORDER BY Total DESC;
 -- Findings : It provides insight into which hospitals have the highest frequency of records within the healthcare dataset. The resulting list showcases hospitals based on their patient count or the number of entries related to each hospital, allowing for an understanding of the distribution or prominence of healthcare services among different medical facilities.
    

-- 11. Identifying Average Billing Amount by Medical Condition.
SELECT Medical_Condition, ROUND(AVG(Billing_Amount),2) AS Avg_Billing_Amount
FROM Healthcare
GROUP BY Medical_Condition;
 -- Findings : It offers insights into the typical costs associated with various medical conditions. This information can be valuable for analyzing the financial impact of different health issues, identifying expensive conditions, or assisting in resource allocation within healthcare facilities.
    

-- 12. Finding Billing Amount of patients admitted and number of days spent in respective hospital.
SELECT Medical_Condition, Name, Hospital, DATEDIFF(Discharge_date,Date_of_Admission) as Number_of_Days, 
SUM(ROUND(Billing_Amount,2)) OVER(Partition by Hospital ORDER BY Hospital DESC) AS Total_Amount
FROM Healthcare
ORDER BY Medical_Condition;
