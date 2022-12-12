-- Active: 1670399129309@@127.0.0.1@3307@hr
show tables; 

select * from departments limit 5;

-- Q1 
select t1.location_id, street_address, city, state_province, t3.country_name
from departments as t1 inner join locations as t2 inner join countries t3
where t1.`LOCATION_ID` = t2.`LOCATION_ID` and t2.`COUNTRY_ID` = t3.`COUNTRY_ID`
;

-- Q2 
select first_name, last_name, t1.DEPARTMENT_ID, department_name
from departments as t1 inner join employees as t2 
where t1.`department_ID` = t2.`department_ID`
;

-- Q3 Write a query to find the name (first_name, last_name), job, department ID, and name of the employees who work in London.
select first_name, last_name, de.DEPARTMENT_ID, department_name
from jobs as jo inner join locations as lo inner join departments as de inner join employees as em 
ON em.`JOB_ID` = jo.`JOB_ID` and em.`DEPARTMENT_ID` = de.`DEPARTMENT_ID` 
where de.`LOCATION_ID` = lo.`LOCATION_ID` and lo.`CITY` = 'London'
;

-- Q4 Write a query to find the employee id, name (last_name) along with their manager_id, and name (last_name).
select j1.employee_id, j1.last_name, j1.manager_id, j2.last_name
from employees as j1 join employees as j2
where j2.`EMPLOYEE_ID` = j1.`MANAGER_ID`
;

-- Q5 Write a query to find the name (first_name, last_name) and hire date of the employees who were hired after 'Jones'.
explain select e1.first_name, e1.last_name, e1.hire_date
from employees as e1 inner join employees e2
ON e1.`HIRE_DATE` > e2.`HIRE_DATE` and e2.`LAST_NAME` like '%Jones%' 
;

-- Q6 Write a query to get the department name and number of employees in the department.
explain select de.`DEPARTMENT_NAME`, count( de.`DEPARTMENT_ID`)
from departments as de left join employees as em 
ON em.`DEPARTMENT_ID` = de.`DEPARTMENT_ID`
GROUP BY de.`DEPARTMENT_ID`
; 

-- Q7 Write a query to find the employee ID, job title, number of days between the ending date and the starting date for all jobs in department 90.
select jh.employee_ID, jo.job_title, datediff( jh.end_date, jh.start_date ) as number_of_days
from job_history as jh inner join jobs as jo
ON jo.`JOB_ID` = jh.`JOB_ID`
where jh.`DEPARTMENT_ID` = 90
;
-- TO_DAYS()

-- Q8 Write a query to display the department ID and name and first name of the manager.
select de.`DEPARTMENT_NAME`, em.`FIRST_NAME`
from departments as de left join employees as em
ON de.`MANAGER_ID` = em.`EMPLOYEE_ID`
;

-- Q9 Write a query to display the department name, manager name, and city.
select de.`DEPARTMENT_NAME`, em.`FIRST_NAME`
from departments as de left join employees as em
ON de.`MANAGER_ID` = em.`EMPLOYEE_ID`
;
-- Q10 Write a query to display the job title and average salary of employees.
select jo.job_title, sum( em.`SALARY`) 
from jobs as jo inner join employees as em
ON jo.`JOB_ID` = em.`JOB_ID`
GROUP BY `JOB_TITLE`
;

-- Q11 Write a query to display job title, employee name, and the difference between the salary of the employee and minimum salary for the job.
select JOB_TITLE, FIRST_NAME, SALARY-MIN_SALARY
from jobs as jo inner join employees as em 
ON jo.`JOB_ID` = em.`JOB_ID`
;

-- Q12 Write a query to display the job history of any employee who is currently drawing more than 10000 of salary.
select FIRST_NAME, SALARY, JOB_TITLE
from job_history as jh inner join jobs as jo inner join employees as em 
ON jh.`EMPLOYEE_ID` = em.`EMPLOYEE_ID` and jo.`JOB_ID` = em.`JOB_ID`
where em.`SALARY` > 10000
;

-- Q13 Write a query to display department name, name (first_name, last_name), hire date, the salary of the manager for all managers whose experience is more than 15 years.
select DEPARTMENT_NAME, FIRST_NAME, `HIRE_DATE`, `SALARY`,TIMESTAMPDIFF( YEAR, `HIRE_DATE`, CURDATE( ) ) AS EXP
from departments as de inner join employees as em
ON de.`MANAGER_ID` = em.`EMPLOYEE_ID`
where TIMESTAMPDIFF( YEAR, `HIRE_DATE`, CURDATE() ) > 15
;  

-- timestampDiff
show indexes from departments ;