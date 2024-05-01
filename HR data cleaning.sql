select * from hr;

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
 
 select * from hr where age >=18;
 select * from hr where termdate is null;
 select * from hr where termdate > curdate()