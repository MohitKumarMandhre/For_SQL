-- Active: 1670399129309@@127.0.0.1@3307@world
-- Stored Procedures

-- write a procedure to print whether a number is prime or NOT

show databases;

use world;
show tables;
show procedure status;
select * from show_number;

call isPrime( 11);

-- Assignment - 3

-- * DDL Table Creation Exercise

create table if not exists Patient(
	pid int(7) not null,
    p_name varchar(30) not null
);

alter table Patient add constraint `UC_patient_pid` UNIQUE (pid);
alter table Patient add constraint `PK_patient` PRIMARY KEY (pid);

create table if not exists Treatment(
	tid int(7) not null,
    t_name varchar(30) not null
);

alter table Treatment add constraint `UC_patient_tid` UNIQUE (tid);
alter table Treatment add constraint `PK_treatment` PRIMARY KEY (tid);

create table if not exists Patient_Treatment(
	pid_pt int(7) not null,
    tid_pt int(7) not null,
    date DATETIME not null,
    constraint `FK_Patient_PatientTreatment` Foreign Key (`pid_pt`) REFERENCES `Patient` (`pid`) ON DELETE CASCADE ON UPDATE NO ACTION,
    constraint `FK_Treatment_PatientTreatment` FOREIGN KEY (`tid_pt`) REFERENCES `Treatment` (`tid`) ON DELETE CASCADE ON UPDATE NO ACTION
);
alter table Patient_Treatment add constraint `PK_Patient_Treatment` PRIMARY KEY (pid_pt, tid_pt);
desc Patient_Treatment ;

-- DDL Alter & Drop Exercise

-- 1. In the Patient table, change the maximum length for Patient’s names to be 35 characters long.
alter table Patient modify COLUMN p_name varchar(35);

-- 2. In the Patient_Treatment table, add a column called “Dosage” where the amount of the treatment given will be stored. This column is a fixed numerical value with a maximum of 99. This column cannot be null and the default value should be “0”.
alter table Patient_Treatment add dosage int(7) not null DEFAULT (0) check (dosage <= 99 );

-- 3. In the Treatment table, change the column name “T_Name” to be “Treatment_Name”.
alter table treatment rename column `t_name` to `Treatment_Name`;

-- 4. Remove the Treatment table from the database.
drop table treatment;

-- 5. Remove the foreign key constraints from PID_PT and TID_PT columns in the Patient_Treatment table.
alter table Patient_Treatment drop FOREIGN KEY `FK_Patient_PatientTreatment` ;

alter table Patient_Treatment drop FOREIGN KEY `FK_Treatment_PatientTreatment` ;

-- assignment 4
-- DML Insert Update Delete Exercises
-- 2.
insert into Student values (12345, Chris, Rock),
(23456, Chris, Farley),
(34567, David, Spade),
(45678, Liz, Lemon),
(56789, Jack, Donaghy) ;

insert into course_grade VALUES
(2010101, SP10, 101005, 34567, D+),
(2010308, FA10, 101005, 34567, A), 
(2010309, FA10, 101001, 45678, B+),
(2011308, FA11, 101003, 23456, B), 
(2012206, SU12, 101002, 56789, A+)
;

INSERT into course VALUES
(101001, 'Intro to Computers'),
(101002, 'Programming'),
(101003, 'Databases'),
(101004, 'Websites'),
(101005, 'IS Management')
;

-- 3. In the Student table, change the maximum length for Student first names to be 30 characters long.
alter table Student modify COLUMN s_fname VARCHAR(30);

-- 4. In the Course table, add a column called “Faculty_LName” where the Faculty last name can vary up to 30 characters long. This column cannot be null and the default value should be “TBD”.
alter table Course add 'Faculty_LName' varchar(30) not null default ('TBD') ;

-- 5. In the Course table, update CID 101001 where will be Faculty_LName is “Potter” and C_Name is “Intro to Wizardry”.
update Course set cid = 101001 WHERE Faculty_LName like 'Potter%' and C_Name like 'Intro to Wizardry%' ;

-- 6. In the Course table, change the column name “C_Name” to be “Course_Name”.
alter table Course rename column 'C_Name' to 'Course_Name';

-- 7. Delete the “Websites” class from the Course table.
delete from Course where c_name like 'Websites%' ;

-- 8. Remove the Student table from the database.
drop table Student;

-- 9. Remove all the data from the Course table, but retain the table structure.
truncate table Course;

-- 10. Remove the foreign key constraints from CID and SID columns in the Course_Grades table

alter table Course_Grades drop FOREIGN KEY `FK_Student_CourseGrades` ;

alter table Course_Grades drop FOREIGN KEY `FK_Course_CourseGrades` ;

select * from employees;

-- assignment 5

-- 1. Select employees first name, last name, job_id and salary whose first name starts with alphabet S.
select first_name, last_name, job_id, salary 
from employees
where first_name like 's%'
;

-- 2. Write a query to select employee with the highest salary.
select * from employees
where salary IN (
    select max(salary) from employees
)
;

-- 3. Select employee with the second highest salary.
with c1 as
(select first_name, salary, DENSE_RANK() over(order by salary desc) dr
from employees
)SELECT * from c1 where dr = 2
;

-- 4. Fetch employees with 2nd or 3rd highest salary.
with c1 as
(select first_name, salary, DENSE_RANK() over(order by salary desc) dr
from employees
)SELECT * from c1 where dr in (2, 3)
;

-- 5. Write a query to select employees and their corresponding managers and their salaries.
select emp.first_name, emp.salary, mgr.first_name, mgr.salary
from employees as emp inner join employees as mgr
ON emp.manager_id = mgr.employee_id
;

-- 6. Write a query to show count of employees under each manager in descending order.
SELECT manager_id, count(*) 
FROM employees
GROUP BY manager_id
order by count(*) desc
;

-- 7. Find the count of employees in each department.
select department_id, count(*)
FROM employees
GROUP BY department_id
order by count(*) desc
;

-- 8. Get the count of employees hired year wise.
select year(hire_date), count(*)
FROM employees
GROUP BY year(hire_date)
order by year(hire_date) asc
;

-- 9. Find the salary range of employees.
select concat(min(salary), " to ", max(salary)) as 'salRange'
from employees;

-- 10. Write a query to divide people into three groups based on their salaries.
with cte1 as
(SELECT first_name, salary, NTILE(3) over(partition by salary) as 'nog'
from employees)
select nog, concat(min(salary), " to ", max(salary)) as 'salRange', count(*) as count
from cte1
group by nog
;

-- 11. Select the employees whose first_name contains “an”.
select FIRST_NAME
from employees
where first_name like '%an%';

-- 12. Select employee first name and the corresponding phone number in the format (_ _ _)-(_ _ _)-(_ _ _ _).
-- eg; 515.123.4567 -> (515)-(123)-(4567)
select FIRST_NAME, concat( '(', substr(replace(phone_number, '.', ''), 1, 3), ')-(', substr(replace(phone_number, '.', ''), 4, 3), ')-(', substr(replace(phone_number, '.', ''), 7, 4), ')' ) as pno
from employees
;

-- 13. Find the employees who joined in August, 1994.
select FIRST_NAME, hire_date
from employees
where year(hire_date) = 1994 and month(hire_date) = 8;

-- 14. Write an SQL query to display employees who earn more than the average salary in that company
select FIRST_NAME, salary
from employees
where salary > (
    select avg(salary) from employees
)
;

-- 15. Find the maximum salary from each department.
select department_name, e.department_id, max(salary) as maxSal
from employees as e inner join departments as d
ON e.department_id = d.department_id
group by department_id
;

-- 16. Write a SQL query to display the 5 least earning employees.
with c1 as
(select first_name, salary, DENSE_RANK() over(order by salary asc) as dr
from employees)
select first_name, salary from c1 where dr <=5
;

-- 17. Find the employees hired in the 80s.
select first_name, hire_date
from employees
where hire_date like '198%'
;

-- 18. Display the employees first name and the name in reverse order.
select first_name, reverse(first_name) as reversedName
from employees
;

-- 19. Find the employees who joined the company after 15th of the month.
select first_name, hire_date
from employees
where day(hire_date) > 15
;

-- 20. Display the managers and the reporting employees who work in different departments.
select mgr.first_name, mgr.department_id, emp.first_name, emp.department_id
from employees as emp inner join employees as mgr
ON emp.manager_id = mgr.employee_id and emp.department_id <> mgr.department_id
;

-- assignment 6
-- SQL_Functions-Aggregate_Functions-Exercise-Database

-- 1. Write a query to list the number of jobs available in the employees table.
select distinct(job_id)
from employees
;

-- 2. Write a query to get the total salaries payable to employees.
select sum( salary) as totalPaidSal
from employees
;

-- 3. Write a query to get the minimum salary from the employees table.


-- 4. Write a query to get the maximum salary of an employee working as a Programmer.
-- 5. Write a query to get the average salary and number of employees working in department 90.
-- 6. Write a query to get the highest, lowest, sum, and average salary of all employees
-- 7. Write a query to get the number of employees with the same job.
-- 8. Write a query to get the difference between the highest and lowest salaries.
-- 9. Write a query to find the manager ID and the salary of the lowest-paid employee for that manager.
-- 10. Write a query to get the department ID and the total salary payable in each department.
-- 11. Write a query to get the average salary for each job ID excluding programmer.
-- 12. Write a query to get the total salary, maximum, minimum, average salary of employees (job ID wise), for department ID 90 only.
-- 13. Write a query to get the job ID and maximum salary of the employees where maximum salary is greater than or equal to $4000.
-- 14. Write a query to get the average salary for all departments employing more than 10 employees.



