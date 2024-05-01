# Employee Data Analysis
## Project Overview
This Analysis provides a comprehensive examination of various aspects of the company's workforce demographics and dynamics. Here's a detailed overview summarizing the key purose of this project:
The analysis delves into the gender breakdown, race/ethnicity distribution, and age demographics of employees within the company. It explores the proportion of employees working at headquarters versus remote locations, shedding light on the company's spatial distribution of workforce resources.
Furthermore, the project investigates the average length of employment for terminated employees, offering insights into turnover rates and potential areas for improvement in employee retention strategies. Additionally, it examines how gender distribution varies across different departments and job titles, providing valuable insights into potential gender disparities within the organizational structure.
Moreover, the distribution of job titles across the company is analyzed, offering a comprehensive understanding of the hierarchical composition of the workforce. The analysis identifies departments with the highest turnover rates, pinpointing areas that may require focused attention to mitigate turnover challenges effectively.
Furthermore, the distribution of employees across different locations by state is examined, providing insights into geographical workforce distribution patterns. Additionally, the project tracks changes in the company's overall employee count over time based on hire and termination dates, offering a longitudinal perspective on workforce dynamics.
Finally, the analysis explores the tenure distribution for each department, providing insights into employee retention and career progression within specific organizational units.
Overall, this HR analysis project offers a holistic overview of the company's workforce landscape, providing actionable insights to inform strategic decision-making and optimize HR practices for improved organizational effectiveness and employee satisfaction.

### Data Source
Human Resources data : The primary source of dataset used in this analyisis is the [Data File](https://github.com/Habeebraji/HR-Analytic/blob/main/Human%20Resources%20(1).csv) Data File file containing detailed information about the company. This dataset has 22000 rowa contains the following columns: id, first_name,	last_name,	birthdate,	gender,	race,	department,	jobtitle,	location,	hire_date, termdate,	location_city,	location_state.

#### Tools Used
- My SQL - Data cleaning and data analysis

- PowerBI - Creating report

#### Approach Used
- Data Wrangling: This is the first step where inspection of data is done to make sure NULL values and missing values are detected and data replacement methods are used to replace, missing or NULL values.
1. Build a database
2. Create table and insert the data.
3. Select columns with null values in them. There are no null values in our database as in creating the tables, we set NOT NULL for each field, hence null values are filtered out.
- Data Cleaning:
    Cleaning Date Columns:
In our data analysis, we encountered a date column with inconsistent and inappropriate date formats. To ensure data consistency and accuracy, we wrote an SQL query to clean and standardize the date column, putting them in the appropriate format. For the full Data cleaning, check the........
- Data Manipulation: Wrote query to alter the table to derived a new Age column from existing colummns to prepare meaningful insight for the analysis.

#### Key Questions:
1. What is the gender breakdown of employees in the company?
2. What is the race/ethnicity breakdown of employees in the company?
3. What is the age distribution of employees in the company?
4. How many employees work at headquarters versus remote locations?
5. What is the average length of employment for employees who have been terminated?
6. How does the gender distribution vary across departments and job titles?
7. What is the distribution of job titles across the company?
8. Which department has the highest turnover rate?
9. What is the distribution of employees across locations by state?
10. How has the company's employee count changed over time based on hire and term dates?
11. What is the tenure distribution for each department?

 
 #### Code
```
create database Human_resources;
show databases;
use human_resources;
create table hr (id  varchar (15) primary key NOT NULL, first_name TEXT NOT NULL, last_name TEXT NOT NULL, birthdate TEXT NOT NULL, gender TEXT NOT NULL,
 race TEXT NOT NULL, department TEXT NOT NULL, jobtitle TEXT NOT NULL, location TEXT NOT NULL, hire_date TEXT NOT NULL,
 termdate TEXT NOT NULL, location_city TEXT NOT NULL, location_state TEXT NOT NULL);
 
 ---------- Transforming dates columns to aapropriate date formats--------------
 update hr set birthdate = case when birthdate like '%-%' then 
 date_format(str_to_date(birthdate, '%m-%d-%Y'),'%Y-%m-%d')
 when birthdate like '%/%' then date_format(str_to_date(birthdate, '%m/%d/%Y'),'%Y-%m-%d') else null end;
 alter table hr modify column birthdate date;
 
 update hr set hire_date = case when hire_date like '%-%' then 
 date_format(str_to_date(hire_date, '%m-%d-%Y'),'%Y-%m-%d')
 when hire_date like '%/%' then date_format(str_to_date(hire_date, '%m/%d/%Y'),'%Y-%m-%d') else null end;
 alter table hr add column term text not null;
  
  ------ Transforming termdate from string to timestamp and extracting date from timestamp datatype----
 update hr set termdate = case when termdate like '%-%' then 
 date_format(date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC')),'%Y-%m-%d')
 when termdate like '%/%' then date_format(date(str_to_date(termdate, '%Y/%m/%d %H:%i:%s UTC')),'%Y-%m-%d')else null end 
 where termdate !='';
 
 ---- Altering empty cells in termdate to allow NULL in order to aid transformation into date column-----
update hr set termdate = null where termdate ='';
 Alter table hr modify column termdate date;
 
 ---------- AGE Column ---------
 alter table hr add column age int;
 update hr set age = timestampdiff(year,birthdate,curdate());
 
 -- There are Outliers in age column showing nagative values as a result of incorrect birthdate --
 
 -------- Gender breakdown in the company ---------
 select gender, count(*) as count from hr where termdate is null or termdate >curdate() and age >=18 
 group by gender;```

#### Results
- There are more male employees
- White race is the most dominant while Native Hawaiian and American Indian are the least dominant.
- 6 age groups were created (18-24, 25-34, 35-44, 45-54, 55-64, 65+). A large number of employees were between 35-44  followed by 25-34 while the smallest group was 65+.
- A large number of employees work at the headquarters versus remotely.
- The average length of employment for terminated employees is around 10 years.
- The gender distribution across departments is fairly balanced but there are generally more male than female employees.
- The Auditing department has the highest turnover rate followed by  Lega. The least turn over rate are in the marketing, business development and services.
- A large number of employees come from the state of Ohio.
- The net change in employees has increased over the years.
- The average tenure for each department is about 10 years with Engineering, sales and services having the highest, legal having the lowest.

#### Limitation
- Some entries with negative ages were omitted during the query process, totaling 967 records. Only ages of 18 years and older were considered.
- Additionally, termination dates that were too distant in the future were excluded from the analysis, totaling 1599 records. Only termination dates equal to or earlier than the current date were included.
- The average tenure for each department is about 10 years with Legal and Auditing having the highest and Services, Sales and Marketing having the lowest.
