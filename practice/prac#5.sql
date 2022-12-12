-- Active: 1670399129309@@127.0.0.1@3307@hr

select * from employees ;

-- Q1 Write a query to find the name (first_name, last_name) and the salary of the employees who have a higher salary than the employee whose last_name='Bull'.
select CONCAT(first_name, `LAST_NAME`) as name, `SALARY`
from employees 
where `SALARY` > (
    select em2.`SALARY`
    from employees as em2
    where em2.`LAST_NAME` = 'Bull'
)
;

-- Q2 Write a query to find the name (first_name, last_name) of all employees who works in the IT department.
select CONCAT(first_name, `LAST_NAME`) as name, `DEPARTMENT_ID`
from employees 
where `DEPARTMENT_ID` IN  (
    select `DEPARTMENT_ID`
    from departments
    where `DEPARTMENT_NAME` = 'IT'
)
;

-- Q3 Write a query to find the name (first_name, last_name) of the employees who have a manager and worked in a USA-based department.


-- Q4 Write a query to find the name (first_name, last_name) of the employees who are managers.
select distinct CONCAT(e2.`first_name`, e2.`LAST_NAME`) as managers 
from employees as e1 inner join employees as e2
on e1.`MANAGER_ID` = e2.`EMPLOYEE_ID`
;

SELECT CONCAT(FIRST_NAME, " ",LAST_NAME) AS NAME
FROM employees
WHERE employees.EMPLOYEE_ID IN (SELECT MANAGER_ID FROM departments);

-- Q5 Write a query to find the name (first_name, last_name), and salary of the employees whose salary is greater than the average salary.
select CONCAT(e1.`first_name`, e1.`LAST_NAME`) as name, e1.`SALARY`
from employees as e1
where e1.`SALARY` > (
    select AVG( `SALARY`) from employees
 )
;

-- Q6 Write a query to find the name (first_name, last_name), and salary of the employees whose salary is equal to the minimum salary for their jobs.
select CONCAT(FIRST_NAME, " ",LAST_NAME) AS NAME, SALARY 
from employees as em INNER join jobs as jo 
ON em.`JOB_ID` = jo.`JOB_ID` 
where em.`SALARY` = jo.`MIN_SALARY`
;

SELECT CONCAT(FIRST_NAME, " ",LAST_NAME) AS NAME, SALARY FROM employees
WHERE SALARY = (SELECT MIN_SALARY FROM jobs WHERE employees.JOB_ID = jobs.JOB_ID);

-- Q7 Write a query to find the name (first_name, last_name), and salary of the employees who earns more than the average salary and works in any of the IT departments.
select CONCAT(e1.`first_name`, e1.`LAST_NAME`) as name, e1.`SALARY`
from employees as e1
where e1.`SALARY` > (
    select AVG( `SALARY`) from employees
 ) and `DEPARTMENT_ID` IN ( 
    select `DEPARTMENT_ID` from departments
    where `DEPARTMENT_NAME` like 'IT%'
 )
;

SELECT CONCAT(FIRST_NAME, " ",LAST_NAME) AS NAME, SALARY 
FROM employees INNER JOIN departments USING (DEPARTMENT_ID)
WHERE SALARY > (SELECT AVG(SALARY) FROM employees) AND departments.DEPARTMENT_NAME LIKE "IT%";

-- Q8 Write a query to find the name (first_name, last_name), and salary of the employees who earns more than the earnings of Mr. Bell.
select CONCAT(first_name, `LAST_NAME`) as name, `SALARY`
from employees 
where `SALARY` > (
    select em2.`SALARY`
    from employees as em2
    where em2.`LAST_NAME` = 'Bell'
)
;

-- Q9 Write a query to find the name (first_name, last_name), and salary of the employees who earn the same salary as the minimum salary for all departments.
SELECT CONCAT(FIRST_NAME, " ",LAST_NAME) AS NAME, SALARY FROM employees
WHERE SALARY = (SELECT min( SALARY) FROM employees);

-- Q10 Write a query to find the name (first_name, last_name), and salary of the employees whose salary is greater than the average salary of all departments.
SELECT CONCAT(FIRST_NAME, " ",LAST_NAME) AS NAME, SALARY FROM employees
WHERE SALARY > ALL (SELECT avg( SALARY) FROM employees 
GROUP BY `DEPARTMENT_ID`);

-- Q11 Write a query to find the name (first_name, last_name) and salary of the employees who earn a salary that is higher than the salary of all the Shipping Clerk (JOB_ID = 'SH_CLERK'). Sort the results of the salary from the lowest to highest.
SELECT CONCAT(`first_name`, `LAST_NAME`) as name, `SALARY`
from employees 
where `SALARY` > ( 
    select `MAX_SALARY` from jobs 
    where `JOB_ID` = 'SH_CLERK'
)
;

SELECT CONCAT(FIRST_NAME, " ",LAST_NAME) AS NAME, SALARY 
FROM employees
WHERE SALARY > ALL(SELECT MAX_SALARY FROM jobs WHERE JOB_ID = 'SH_CLERK')
ORDER BY SALARY;

-- Q12 Write a query to find the name (first_name, last_name) of the employees who are not managers.
SELECT CONCAT(FIRST_NAME, " ",LAST_NAME) AS NAME
FROM employees
WHERE employees.EMPLOYEE_ID NOT IN (SELECT MANAGER_ID FROM departments);

-- Q13 Write a query to display the employee ID, first name, last name, and department names of all employees.
SELECT em.`EMPLOYEE_ID`, CONCAT(em.FIRST_NAME, " ",em.LAST_NAME) AS NAME, de.`DEPARTMENT_NAME`
from employees as em INNER JOIN departments as de
ON em.`DEPARTMENT_ID` = de.`DEPARTMENT_ID`
;

-- Q14 Write a query to display the employee ID, first name, last name, salary of all employees whose salary is above average for their departments.
select `EMPLOYEE_ID`, FIRST_NAME, LAST_NAME, `SALARY`
from employees as em
WHERE `SALARY` > ( 
    select avg( e2.`SALARY`) from employees as e2
    where e2.`DEPARTMENT_ID` = em.`DEPARTMENT_ID`
    GROUP BY e2.`DEPARTMENT_ID`
 )
;

-- Q15 Write a query to fetch even numbered records from employees table.
select * from employees where mod(`EMPLOYEE_ID`, 2) =0;

-- Q16 Write a query to find the 5th maximum salary in the employees table.
select *
from employees
order by `SALARY` desc
limit 4, 1
;

-- Q17 Write a query to find the 4th minimum salary in the employees table.
select *
from employees
order by `SALARY` asc
limit 3, 1
;
-- Q18 Write a query to select the last 10 records from a table.
select *
from ( 
    select * from employees 
    order by `EMPLOYEE_ID` desc limit 10
 ) as t
;

-- Q19 Write a query to list the department ID and name of all the departments where no employee is working.
select `DEPARTMENT_ID`, `DEPARTMENT_NAME`
from departments 
where `DEPARTMENT_ID` NOT IN ( 
    select `DEPARTMENT_ID` from employees
 )
;

-- Q20 Write a query to get 3 maximum salaries.
select `EMPLOYEE_ID`, `FIRST_NAME`, `SALARY`
from employees
order by `SALARY` desc 
limit 3
;

-- Q21 Write a query to get 3 minimum salaries.
select `EMPLOYEE_ID`, `FIRST_NAME`, `SALARY`
from employees
order by `SALARY` asc 
limit 3
;

-- Q22 Write a query to get nth max salaries of employees.
-- eg here get 7th ( n-1, 1 )
select `EMPLOYEE_ID`, `FIRST_NAME`, `SALARY`
from employees
order by `SALARY` desc 
limit 6,1
;