-- Active: 1670399129309@@127.0.0.1@3307@new_hr

show tables;

select region_name, country_name, city, department_name
from regions as r inner join countries as c inner join locations as lo inner join departments as d
ON r.region_id = c.region_id and lo.country_id = c.country_id and d.location_id = lo.location_id
;

SELECT ename, job, sal, dname
from emp as e INNER JOIN dept as d
ON e.job like 'clerk%' and e.sal > 950 and d.dname like 'research%'
; 

select e1.ename as "EMP", e2.ename as 'MGR'
from emp as e1 left join emp as e2 
on e1.`EMPNO` = e2.`MGR`
;

select e1.first_name as "EMP", e2m.first_name as 'MGR'
from employees as e1 left join employees as e2m
on e2m.employee_id = e1.manager_id
;

select DISTINCT e1.first_name , e1.salary --, e2m.first_name, e2m.salary
from employees as e1 inner join employees as e2m
on e2m.salary = e1.salary and e2m.employee_id <> e1.employee_id
;

Select first_name, salary from employees 
where salary in (
    select salary from employees group by salary 
    having count(1)>1
    )
order by salary;

SELECT  distinct CONCAT(e.FIRST_NAME,' ',e.LAST_NAME)employee, e.SALARY
    --CONCAT(m.FIRST_NAME,' ',m.LAST_NAME)manager
FROM employees e INNER JOIN employees m
on e.SALARY=m.SALARY 
and e.EMPLOYEE_ID<>m.EMPLOYEE_ID;


-- find job id which got filled in the 2nd half of any year and again filled in the first half of the next YEAR

with c1 as
(
    SELECT job_id,hire_date, year(hire_date) as y1
    FROM employees
    where month( hire_date) > 6
),
c2 as (
    SELECT job_id,hire_date, year(hire_date) as y2
    FROM employees
    where month( hire_date) <= 6
)
SELECT *
from c1 join c2 
ON c1.job_id = c2.job_id and y1 = y2 -1 
;

SELECT e1.job_id, e1.hire_date, year(e1.hire_date) as y1, e2.hire_date, year(e2.hire_date) as y2
FROM employees as e1 inner join employees as e2
ON e1.job_id = e2.job_id
where month( e1.hire_date) > 6 and month( e2.hire_date) <= 6
and year(e1.hire_date) = year(e2.hire_date)-1
;

select * from employees;

select * from
(
    select first_name, job_id, hire_date
    from employees 
    order by 3 
) as a1 
inner join 
(
    select first_name, job_id, hire_date
    from employees 
    order by 3
) as a2
ON (a1.job_id = a2.job_id) and year(a1.hire_date) = year(a2.hire_date) -1 and month(a2.hire_date) <=6 and month(a1.hire_date) >6
;

SELECT NOW(), DAYNAME( NOW()), DATE_FORMAT( NOW(), '%w');

select first_name, department_name
from employees NATURAL JOIN departments
;

select first_name, department_name
from employees e JOIN departments d
ON d.department_id = e.department_id and d.manager_id = e.manager_id
;

select first_name, department_name
from employees JOIN departments
using( manager_id)
;

show COLUMNS from regions;
desc regions;

-- subqueries

SELECT FIRST_NAME, hire_date from employees where hire_date > (
    select hire_date from employees WHERE first_name like 'lisa%'
)
;

select count(hire_date) from employees;

-- find out dname in which steven king is working

SELECT first_name, e.department_id, department_name
from employees as e INNER JOIN departments as d
ON d.department_id = e.department_id
where concat(first_name, ' ', last_name) like 'steven king%'
;

select department_id, department_name
from departments
where department_id = (
    SELECT department_id FROM employees where concat(first_name, ' ', last_name) like 'steven king%'
);

-- self join using sub queries
-- find out the emps reporting to neena Kochhar

SELECT e1.first_name, e1.manager_id, e2.employee_id, e2.first_name as mgrName
from employees as e1 inner join employees e2
where  e1.manager_id = e2.employee_id and concat(e2.first_name, ' ', e2.last_name) like 'neena kochhar%' 
;

select first_name
from employees where manager_id = (
    select employee_id from employees 
    where concat(first_name, ' ', last_name) like 'neena kochhar%' 
)
;
show tables;

SELECT * from 	
emp_details_view; 
SELECT *
from employees, jobs_grade
;

create table job_grades
(grade_level char(1),
 lowest_sal numeric(11,2),
 high_sal numeric(11,2));

insert into job_grades
values ("A",1000,2999),
("B",3000,5999),
("C",6000,9999),
 ("D",10000,14999),
 ("E",15000,24999),
 ("F",25000,40000);

-- find out grade of Lex De Haan using subquery

select grade_level
from job_grades 
where 
(SELECT salary
from employees
where concat(first_name, ' ', last_name) like 'Lex De Haan%') BETWEEN lowest_sal and high_sal
; 

-- find out emp working in the same dept as Hermann Baer( exclude hermann)

select employee_id, department_id,concat(first_name, ' ', last_name) 
from employees
where department_id = (
    select department_id from employees
    where concat(first_name, ' ', last_name) like 'neena kochhar%'
) and concat(first_name, ' ', last_name) not like 'neena kochhar%'
;

-- find out emps who are working in the same department as Valli, Lex

/* 
single row - RETURNS 1 ROW (=, <>, <, >)
multiple row - RETURNS more than 1 ROW (IN, NOT, IN, ANY, ALL)
multiple cols - 
nested
correlated
*/

select concat(first_name, ' ', last_name) name, department_id
from employees
where department_id IN (
    select department_id from employees
    where first_name IN ('Valli','Lex')
)
;

-- find out dept names where no emps are working

select department_name
from departments
where department_id NOT IN (
    select department_id from employees
)
;

select count(*)
from employees
GROUP BY department_id
;

SELECT * from employees;
select department_name, department_id
from departments
where department_id NOT IN (
    select department_id from employees
    where job_id = 'sa_rep'
)
;

-- subqueries shouldn't return any NULL values

select department_name, department_id
from departments
where department_id NOT IN (
    select department_id from employees
    where job_id like 'sa_rep%' and department_id is NOT NULL
)
;

SELECT * from employees;

-- find out the employees who joined between '1999-06-21' and '1997-08-20

select employee_id, first_name, hire_date
from employees
WHERE hire_date IN ('1997-08-20', '1999-06-21')
;

-- find out emps who joined on same date as of laura, susan

select first_name, hire_date
from employees
where hire_date IN (
    select hire_date from employees
    where first_name IN ('Susan', 'Laura')
);

/*
-- any/or only used with <, >
op   >   <
ANY  >m  <M
OR   >M  <m
-- M = max of sub QUERY
-- m = min of sub query
*/

select first_name, hire_date
from employees
where hire_date > ANY (
    select hire_date from employees
    where first_name IN ('Susan', 'Laura')
);

select first_name, hire_date
from employees
where hire_date > ALL (
    select hire_date from employees
    where first_name IN ('Susan', 'Laura')
);

-- find out emps talking max salaries in each job ids
select first_name, salary, job_id from employees
where salary IN
(select max( salary)
from employees 
group by job_id)
; -- not accurate result

select first_name, salary, job_id from employees
where (salary, job_id) IN
(select max( salary), job_id 
from employees 
where job_id is not NULL
group by job_id)
;

-- find out the job ids having max no. of emps
select count(job_id), job_id from employees
GROUP BY job_id
having count(job_id) IN
(
    select max(a.cnt) from
        (select count(*) as cnt, job_id
        from employees 
        where job_id is not NULL
        group by job_id) a
)
;

-- nested sub queries
select first_name, last_name, job_id
from employees
where job_id IN (
    select job_id from employees
    group by job_id
    having count( job_id) IN (
        select max(a.cnt) FROM (
            select count( job_id) cnt from employees
            group by job_id
        ) a
    )
);

-- correlated sub queries

-- salary greater than respective department average salary 

select e.first_name, department_id, salary
from employees e
where salary > (
    select avg( salary)
    from employees
    where department_id = e.department_id
)
;
select e.first_name, department_id, salary
from employees e
where salary > (
    select avg( salary)
    from employees
    where department_id = e.department_id
)
order by 2
;

select e.first_name, e.salary, e.department_id, a.avsal
from employees e inner join (
    select department_id, avg(salary) as avsal
    from employees
    where department_id is not null 
    group by department_id
)a
ON e.department_id = a.department_id and e.salary > a.avsal
order by 3
;















