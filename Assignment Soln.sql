--DATABASE CREATION
CREATE DATABASE Hospital_Database;

DROP TABLE IF EXISTS Hospital;

--TABLE CREATION 
--HOSPITAL TABLE
CREATE TABLE Hospital (
	Hospital_Name	VARCHAR(69),
	Location	    VARCHAR(69),
	Department	    VARCHAR(69),
	Doctor_Count	INT,
	Patient_Count      	INT,
	Admission_Date	DATE,
	Discharge_Date	DATE,
	Medical_Expenses NUMERIC(10,2)
);

SELECT * FROM Hospital;

--IMPORT TABLE
--IMPORTING DATA IN HOSPITAL TABLE
COPY Hospital(Hospital_Name	,Location ,Department ,Doctor_Count	,Patient_Count ,Admission_Date ,Discharge_Date ,Medical_Expenses)
FROM'C:\Users\Mohammad Kaif Khan\Desktop\PostgreSQL\My Projects\Project 02\Hospital_Data.csv'
CSV HEADER;

--QUERIES

--1.Total Number of Patients
SELECT SUM(Patient_Count) AS Total_Patients
FROM Hospital;

--2.Average Number of Doctors per Hospital
SELECT hospital_name ,AVG(Doctor_Count) AS Average_Doctor_Per_Hospital
FROM Hospital
GROUP BY hospital_name;

--3.Top 3 Departments with the Highest Number of Patients 
SELECT department ,SUM(patient_count) AS Total_Patients
FROM Hospital
GROUP BY department
ORDER BY Total_Patients DESC 
LIMIT 3;

--4.Hospital with the Maximum Medical Expenses 
SELECT hospital_name ,medical_expenses AS Maximum_Medical_Expenses 
FROM Hospital
ORDER BY medical_expenses DESC
LIMIT 1;

--5.Daily Average Medical Expenses
SELECT hospital_name , AVG(medical_expenses/(discharge_date-admission_date)) AS Average_Daily_Medical_Expense
FROM Hospital
GROUP BY hospital_name;

--6.Longest Hospital Stay
SELECT hospital_name ,admission_date ,discharge_date ,discharge_date-admission_date AS Longest_Stay
FROM Hospital
ORDER BY Longest_Stay DESC
LIMIT 1;

--7.Total Patients Treated Per City
SELECT  location ,SUM(patient_count) AS Total_Patient_Per_City
FROM Hospital
GROUP BY location;

--8.Average Length of Stay Per Department 
SELECT department  ,AVG(discharge_date-admission_date)AS Average_Stay
FROM Hospital
GROUP BY department;

--9.Identify the Department with the Lowest Number of Patients
SELECT department , SUM(patient_count) AS Lowest_Number_Of_Patients
FROM Hospital
GROUP BY department
ORDER BY Lowest_Number_Of_Patients ASC
LIMIT 1;

--10.Monthly Medical Expenses Report 
SELECT DATE_TRUNC('month',admission_date) AS Month,
	   SUM(medical_expenses) AS Total_Medical_Expenses
FROM Hospital
GROUP BY Month
ORDER BY Month;
