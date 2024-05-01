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
 group by gender;
 
 ----------- Age ditribution by gender ----------
 select gender,case when age between 18 and 24 then '18-24' when age between 25 and 34 then '25-34'
 when age between 35 and 44 then '35-44' when age between 45 and 54 then '45-54'
 when age between 55 and 64 then '55-64' else '65+' end as age_group, count(*) as count from hr
 where termdate is null or termdate > curdate() and age >=18 group by gender, age_group;
 
 ---------- What is the race/ethnicity breakdown of employees in the company--------
 select race, count(*) as count from hr where termdate is not null or termdate > curdate() and age >=18
 group by race order by count desc;
 
 -------- What the age distribution of employees in the company------------
 select case when age between 18 and 24 then '18-24' when age between 25 and 34 then '25-34'
 when age between 35 and 44 then '35-44' when age between 45 and 54 then '45-54'
 when age between 55 and 64 then '55-64' else '65+' end as age_group, count(*) as count  
 from hr  where termdate is null or termdate >curdate() and age >=18 group by age_group 
 order by age_group asc;
 
 --------- How many employees work at headquarters versus remote locations --------
 select location,count(*) as count from hr  where
 termdate is null or termdate >curdate() and age >=18 group by location;

-------- What is the average length of employment for employees who have been terminated -----------
select round(avg(datediff(termdate,hire_date))/365) as avg_length from hr  where 
 termdate is not null or termdate<=curdate()  and age >=18;

----------- How does the gender distribution vary across departments and job titles --------
select  department, gender, count(*) as count from hr where termdate is null or termdate>=curdate() and age >=18
 group  by  department,  gender;
 
 select  jobtitle, gender, count(*) as count from hr where  termdate is null or termdate>=curdate() and age >=18
 group  by jobtitle , gender;
 
-------- What is the distribution of job titles across the company---------
select jobtitle, count(*) as count from hr where  termdate is null or termdate <= curdate() and age >=18
 group  by jobtitle;
 
 ------ Which department has the highest turnover rate ------
 select department,count(*) total_employees, sum(case when termdate is not null  and termdate <=curdate() then
 1 else 0 end)/count(*) as turnover_rate from hr where age >=18 group by department order by turnover_rate
 desc; 
 
 -------- What is the distribution of employees across locations by state -----
 select location_state, location_city, location, count(*) as count from hr where  
 termdate is null or termdate >= curdate()  and age >=18 group  by location_state, location_city, 
 location order by count desc;
 
 ---------- How has the companys employee count changed over time based on hire and term dates ------
select year(hire_date), count(hire_date) as hires, sum(case when termdate is not null and termdate <= curdate()
then 1 else 0 end) as terminations, count(hire_date)-sum(case when termdate is not null and termdate <= curdate() then 1 else 0 end) as net_change,
(count(hire_date)-sum(case when termdate is not null and termdate <=curdate() then 1 else 0 end ))/count(hire_date)*100
as net_change_percent from hr where age>=18 group by year(hire_date) order by year(hire_date) Asc;

--------- What is the tenure distribution for each department  -----------
select department, round(avg(datediff(termdate,hire_date)/365)) as avg_tenure from hr where age >=18 and
 termdate is not null or termdate <=curdate() group by department order by department asc;