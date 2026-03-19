-- Table Already Exists in the db
DROP TABLE IF EXISTS Hospital_Data;

-- Creating a Table
CREATE TABLE Hospital_Data (
   Hospital_ID SERIAL PRIMARY KEY,
   Hospital_Name VARCHAR(100),
   Location VARCHAR(50),
   Hospital_Name VARCHAR(50),
   Doctors_Count INT,
   Patients_Count INT,
   Admission_Date DATE,
   Discharge_Date DATE,
   Medical_Expenses NUMERIC(10,2),
   Stay_Days INT,
   Daily_Expense NUMERIC(10,3),
   Month TEXT
);

-- Insert the Bulk data into the Hospital Table
COPY Hospital_Data (Hospital_Name, Location, Hospital_Name, Doctors_Count, Patients_Count, Admission_Date, Discharge_Date, Medical_Expenses, Stay_Days, Daily_Expense, Month)
FROM 'D:\All\Complete Data Analyst Project\Hospital_Project\Cleaning_Hospital_Data.csv'
DELIMITER ','
CSV HEADER;

-- Retrieve the all dataset
SELECT * FROM Hospital_Data;

-- 🟢 Q1: Total Patients
SELECT SUM(Patients_Count) AS Total_Patients
FROM Hospital_Data;

-- 🟢 Q2: Avg Doctors per Hospital
SELECT Hospital_Name,
           ROUND(AVG(Doctors_Count),2) AS Average_Doctors_Hospital
FROM Hospital_Data
GROUP BY Hospital_Name;

-- 🟢 Q3: Top 3 Hospital_Names by Patients
SELECT Hospital_Name,
           SUM(Patients_Count) AS Total_Patients
FROM Hospital_Data
GROUP BY Hospital_Name
ORDER BY Total_Patients DESC
LIMIT 3;

-- 🟢 Q4: Highest Revenue Hospital
SELECT Hospital_Name,
           ROUND(SUM(Medical_Expenses),2) AS Total_Expenses
FROM Hospital_Data
GROUP BY Hospital_Name
ORDER BY Total_Expenses DESC
LIMIT 1;

-- 🟢 Q5: Daily Avg Expenses
SELECT Hospital_Name,
           ROUND(AVG(Medical_Expenses / NULLIF(Stay_Days,0)),2) AS Daily_Avg_Expenses
FROM Hospital_Data
GROUP BY Hospital_Name
ORDER BY Daily_Avg_Expenses DESC;

-- Delete the Daily_Expenses Row Not Helpful
ALTER TABLE Hospital_Data
DROP COLUMN daily_expense

-- 🟢 Q6: Longest Stay
SELECT Hospital_Name, Department, Admission_Date, Discharge_Date, Stay_Days
FROM Hospital_Data
ORDER BY Stay_Days DESC
LIMIT 1;

-- 🟢 Q7: Patients per City
SELECT Location AS City,
             SUM(Patients_Count) AS Total_Patients
FROM Hospital_Data
GROUP BY Location
ORDER BY Total_Patients DESC;

-- 🟢 Q8: Avg Stay per Department
SELECT Department,
      ROUND(AVG(Stay_Days),1) AS Avg_Stay
FROM Hospital_Data
GROUP BY Department
ORDER BY Avg_Stay DESC;

-- 🟢 Q9: Least Demanding Department
SELECT Department,
            SUM(Patients_Count) AS Total_Patients
FROM Hospital_Data
GROUP BY Department
ORDER BY Total_Patients ASC
LIMIT 1;

-- 🟢 Q10: Monthly Expenses Trend
SELECT Month,
           ROUND(SUM(Medical_Expenses), 2) AS Total_Medical_Expenses
FROM Hospital_Data
GROUP BY Month
ORDER BY MIN(Admission_Date);

