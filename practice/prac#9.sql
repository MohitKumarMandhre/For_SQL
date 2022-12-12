-- Active: 1670399129309@@127.0.0.1@3307@hr
-- 1. Write a query to list the number of jobs available in the employees table.
select count( DISTINCT( `JOB_ID`) ) from employees;

-- 2. Write a query to get the total salaries payable to employees.
Select sum( `SALARY`) from employees;

-- 3. Write a query to get the minimum salary from the employees table.
Select min( `SALARY`) from employees;

-- 4. Write a query to get the maximum salary of an employee working as a Programmer.
Select max( `SALARY`) from employees as em
where `JOB_ID` IN ( select `JOB_ID` from jobs where `JOB_TITLE` = 'Programmer' ) ;

-- 5. Write a query to get the average salary and number of employees working in department 90.
select AVG( `SALARY`) from employees WHERE `DEPARTMENT_ID` = 90;

-- 6. Write a query to get the highest, lowest, sum, and average salary of all employees
Select max( `SALARY`), min(`SALARY`), avg( `SALARY`) from employees;

-- 7. Write a query to get the number of employees with the same job.
Select `JOB_ID`, count( *) from employees GROUP BY `JOB_ID`;

-- 8. Write a query to get the difference between the highest and lowest salaries.
Select max( `SALARY`) - min( `SALARY`) from employees;

-- 9. Write a query to find the manager ID and the salary of the lowest-paid employee for that manager.
select `MANAGER_ID`, `SALARY` from employees
where `SALARY` = ( Select min( `SALARY`) from employees
s );

-- 10. Write a query to get the department ID and the total salary payable in each department.
Select `DEPARTMENT_ID`, sum( `SALARY`) from employees GROUP BY `DEPARTMENT_ID`;

-- 11. Write a query to get the average salary for each job ID excluding programmer.
Select `DEPARTMENT_ID`, avg( `SALARY`) from employees 
where `JOB_ID` NOT IN ( 
    select `JOB_ID` from jobs where `JOB_TITLE` like "Programmer%"
 )
GROUP BY `DEPARTMENT_ID`;

-- 12. Write a query to get the total salary, maximum, minimum, average salary of employees (job ID wise), for department ID 90 only.
Select `DEPARTMENT_ID`, sum( `SALARY`), max( `SALARY`), min( `SALARY`), avg( `SALARY`) from employees where `DEPARTMENT_ID` = 90;

-- 13. Write a query to get the job ID and maximum salary of the employees where maximum salary is greater than or equal to $4000.
select `JOB_ID`, max( `SALARY`) as maxi from employees
GROUP BY `JOB_ID`
HAVING maxi >= 4000;

-- 14. Write a query to get the average salary for all departments employing more than 10 employees.
select count( *) as cnt, AVG( `SALARY`)
from employees
GROUP BY `DEPARTMENT_ID`
HAVING cnt > 10
;