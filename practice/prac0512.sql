show databases ;
use hr ;

show tables ;

select * from countries ;

show create table countries;

show tables ;

-- 16 #############################################

-- 1. Write a query to display the names (first_name, last_name) using alias name “First Name", "Last Name".
select `FIRST_NAME` AS `First Name`, `LAST_NAME` AS `Last Name` from employees limit 10 ; 

-- 2. Write a query to get unique department ID from employee table.
select distinct `DEPARTMENT_ID` from employees;

-- 3. Write a query to get the names (first_name, last_name), salary, PF of all the employees (PF is calculated as 15% of salary).
select `FIRST_NAME` AS `First Name`, `LAST_NAME` AS `Last Name`, `salary`, `salary`*0.15 AS `PF` from employees ; 

-- 4. Write a query to get the maximum and minimum salary from employees table.
select max(salary) AS `MAX SALARY`, min(salary) AS `MIN SALARY` from employees ;

-- 5. Write a query to get the average salary and number of employees in the employees table.
select avg(salary) AS `AVG SALARY`, count(1) AS `NUMBER OF EMP` from employees;

-- 6. Write a query get all first name from employees table in upper case.
select upper(FIRST_NAME) AS `NAME` from employees ;

-- 7. Write a query to get the first 3 characters of first name from employees table.
select left(FIRST_NAME, 3) AS `NAME` from employees ;

-- 8. Write a query to select first 10 records from a table.
select FIRST_NAME AS `NAME` from employees limit 10;

-- 9. Write a query to get monthly salary (round 2 decimal places) of each and every employee.
select round(salary, 2) AS `MONTHLY SALARY` from employees ;

-- 10. Write a query to display the name (first_name, last_name) and department ID of all employees in departments 30 or 100 in ascending order.
select `FIRST_NAME` AS `First Name`, `LAST_NAME` AS `Last Name`, `salary`, `DEPARTMENT_ID` 
from employees
where `DEPARTMENT_ID` IN ( 30, 100) ;


-- 17 #############################################

-- 1. Write a query to display the name (first_name, last_name) and salary for all employees whose salary is not in the range $10,000 through $15,000.
select `FIRST_NAME` AS `First Name`, `LAST_NAME` AS `Last Name`, `salary` 
from employees
where `salary` between 10000 AND 15000; 

-- 2. Write a query to display the name (first_name, last_name) and salary for all employees whose salary is not in the range $10,000 through $15,000 and are in department 30 or 100.
select `FIRST_NAME` AS `First Name`, `LAST_NAME` AS `Last Name`, `salary` 
from employees
where `salary` not between 10000 AND 15000; 

-- 3. Write a query to display the name (first_name, last_name) and hire date for all employees who were hired in 1987.
select `FIRST_NAME` AS `First Name`, `LAST_NAME` AS `Last Name`, `HIRE_DATE` 
from employees
where year(`HIRE_DATE`) = 1987; 

-- 4. Write a query to display the first_name of all employees who have both "b" and "c" in their first name.
select `FIRST_NAME` 
from employees
where FIRST_NAME like "%b%"
AND FIRST_NAME like "%a%"; 

-- 5. Write a query to display the last name, job, and salary for all employees whose job is that of a Programmer or a Shipping Clerk, 
-- and whose salary is not equal to $4,500, $10,000, or $15,000.
select `LAST_NAME`, `JOB_ID`, `SALARY` 
from employees
where `JOB_ID` IN ('IT_PROG', 'SH_CLERK') AND 
`SALARY` NOT IN (4500, 10000, 15000)
;

-- 6. Write a query to display the last name of employees having 'e' as the third character.
select `LAST_NAME` 
from employees
where LAST_NAME like "__e%"
;

-- 7. Write a query to display the last name of employees whose names have exactly 6 characters.
select `LAST_NAME` 
from employees
where LAST_NAME like "______"
;

-- 8. Write a query to select all record from employees where last name in 'BLAKE', 'SCOTT', 'KING' and 'FORD'.
select `LAST_NAME` 
from employees
where LAST_NAME IN ( 'BLAKE', 'SCOTT', 'KING', 'FORD' )
;

-- 18 #############################################

-- 1. Write a SQL statement to create a table countries including columns country_id, country_name, and region_id, and 
-- make sure that the combination of columns country_id and region_id will be unique.

show create table countries ;

CREATE TABLE IF NOT EXISTS `countries` (
  `COUNTRY_ID` varchar(2) NOT NULL,
  `COUNTRY_NAME` varchar(40) DEFAULT NULL,
  `REGION_ID` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`COUNTRY_ID`),
  KEY `COUNTR_REG_FK` (`REGION_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ;

-- 2. Write a SQL statement to create a table job_history including columns employee_id, start_date, end_date, job_id, and 
-- department_id and make sure that, the employee_id column does not contain any duplicate value at the time of insertion 
-- and the foreign key column job_id contain only those values which exist in the jobs table.

show create table job_history ;

CREATE TABLE IF NOT EXISTS `job_history` (
  `EMPLOYEE_ID` decimal(6,0) NOT NULL,
  `START_DATE` date NOT NULL,
  `END_DATE` date NOT NULL,
  `JOB_ID` varchar(10) NOT NULL,
  `DEPARTMENT_ID` decimal(4,0) DEFAULT NULL,
  PRIMARY KEY (`EMPLOYEE_ID`,`START_DATE`),
  KEY `JHIST_DEPARTMENT_IX` (`DEPARTMENT_ID`),
  KEY `JHIST_EMPLOYEE_IX` (`EMPLOYEE_ID`),
  KEY `JHIST_JOB_IX` (`JOB_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ;

-- 3. Write a SQL statement to create a table employees including columns employee_id, first_name, last_name, email,
-- phone_number hire_date, job_id, salary, commission, manager_id, and department_id and 
-- make sure that the employee_id column does not contain any duplicate value at the time of insertion and
-- the foreign key columns combined by department_id and manager_id columns contain only those unique combination values, 
-- which combinations exist in the departments table.

show create table employees ;

CREATE TABLE IF NOT EXISTS `employees` (
  `EMPLOYEE_ID` decimal(6,0) NOT NULL DEFAULT ''0'',
  `FIRST_NAME` varchar(20) DEFAULT NULL,
  `LAST_NAME` varchar(25) NOT NULL,
  `EMAIL` varchar(25) NOT NULL,
  `PHONE_NUMBER` varchar(20) DEFAULT NULL,
  `HIRE_DATE` date NOT NULL,
  `JOB_ID` varchar(10) NOT NULL,
  `SALARY` decimal(8,2) DEFAULT NULL,
  `COMMISSION_PCT` decimal(2,2) DEFAULT NULL,
  `MANAGER_ID` decimal(6,0) DEFAULT NULL,
  `DEPARTMENT_ID` decimal(4,0) DEFAULT NULL,
  PRIMARY KEY (`EMPLOYEE_ID`),
  UNIQUE KEY `EMP_EMAIL_UK` (`EMAIL`),
  KEY `EMP_DEPARTMENT_IX` (`DEPARTMENT_ID`),
  KEY `EMP_JOB_IX` (`JOB_ID`),
  KEY `EMP_MANAGER_IX` (`MANAGER_ID`),
  KEY `EMP_NAME_IX` (`LAST_NAME`,`FIRST_NAME`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ;