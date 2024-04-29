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
Human Resources data : The primary source of dataset used in this analyisis is the Data File file containing detailed information about the company. This dataset has 22000 rowa contains the following columns: id, first_name,	last_name,	birthdate,	gender,	race,	department,	jobtitle,	location,	hire_date, termdate,	location_city,	location_state.

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




