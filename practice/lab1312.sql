-- Active: 1670399129309@@127.0.0.1@3307@classicmodels

show TABLES;

-- UNION OPERATION
select `customerName`, "cus" as contactType from customers
union 
select `firstName`, "emp" as contactType from employees
ORDER BY 1 desc
;

-----------------

CREATE table emp(
    id int primary key AUTO_INCREMENT,
    name varchar(30) not null,
    age int, 
    salary int, 
    manager_id int,
    department_id int, 
    Foreign Key (department_id) REFERENCES dept(id)
);
drop TABLE emp;

CREATE table dept(
    id int PRIMARY KEY AUTO_INCREMENT, 
    name  VARCHAR(30) not null 
);

INSERT INTO dept
VALUES(1,'Sales'),(2,'Marketing'),(3,'IT');

INSERT INTO emp
VALUES(null,'Alex',30,2000000,3,3),
    (null,'Lisa',26,1000000,1,2),
    (null,'July',33,1500000,1,3),
    (null,'Goofy',29,1600000,3,2);

INSERT INTO emp
VALUES(null,'Dooby',27,900000,1,2),
    (null,'Tommy',25,700000,2,2),
    (null,'Browni',30,900000,1,3),
    (null,'KIki',29,1500000,2,2);

INSERT INTO emp VALUES(null, 'abc', 21, 200000, 1,2), 
        (null, 'def', 24, 150000, 2, 2), 
        (null, 'ghi', 26, 700000, 1,3), 
        (null, 'xyz', 29, 680000, 3, 2) ;

select * from emp ;


-- 1. 


( SELECT em.name EMPNAME, de.name, age, salary
from dept as de INNER JOIN emp as em 
ON de.id = em.department_id
where salary >= 1500000
order by salary desc, em.name asc )

UNION

( select NULL as EMPNAME, d.name, age, salary
from dept as d INNER join emp as e
on d.id = e.department_id
where salary < 1500000
ORDER BY salary desc, age asc )
;


SELECT round( 8.44, -1) ;
select ceil( 5.235) ;

SELECT YEAR( NOW());

SELECT 
case
 when em.salary >= 1500000 then em.name else NULL
end as EMPNAME,
de.name, age, salary
from dept as de INNER JOIN emp as em 
ON de.id = em.department_id
order by salary desc, 
(case 
when em.salary >= 150000 then em.name else age
end) asc
;

SELECT 
case
 when em.salary >= 1500000 then em.name else NULL
end as EMPNAME,
de.name, age, salary
from dept as de INNER JOIN emp as em 
ON de.id = em.department_id
order by salary desc,
if ( em.salary >= 150000, em.name, age ) asc
;


select "20-25" as ageGroup, AVG( salary), MIN( salary), Max( salary)
from emp where age between 20 and 25
union 
select "25-30", AVG( salary),  MIN( salary), Max( salary)
from emp where age between 25 and 30
;

select * from
(select AVG( salary),  MIN( salary), Max( salary)
from emp where age between 20 and 25) t1,
(select AVG( salary),  MIN( salary), Max( salary)
from emp where age between 25 and 30) t2
;


select coalesce( null, "", 1) ;

select 
'avgSal' as 'filter' ,
'salary' as "tag",
avg( case when age BETWEEN 20 and 25 then salary end) as '20-25',
avg( case when age BETWEEN 25 and 30 then salary end) as '25-30'
from emp 
UNION
select
'minSal' as filter ,
'salary' as "tag",
min( case when age BETWEEN 20 and 25 then salary end),
min( case when age BETWEEN 25 and 30 then salary end)
from emp 
UNION
select
'maxSal' as filter ,
'salary' as "tag",
max( case when age BETWEEN 20 and 25 then salary end),
max( case when age BETWEEN 25 and 30 then salary end)
from emp 
UNION
select
'minAge' as filter ,
'age' as "tag",
floor ( min( case when age BETWEEN 20 and 25 then age end)),
floor ( min( case when age BETWEEN 25 and 30 then age end))
from emp 
UNION
select
'maxAge' as filter ,
'age' as "tag",
floor ( max( case when age BETWEEN 20 and 25 then age end)),
floor ( max( case when age BETWEEN 25 and 30 then age end))
from emp 
UNION
select
'avgAge' as filter ,
'age' as "tag",
floor ( avg( case when age BETWEEN 20 and 25 then age end)),
floor ( avg( case when age BETWEEN 25 and 30 then age end))
from emp 
;


select * from
(select round( AVG( salary)), round( MIN( salary)), round( Max( salary))
from emp where age between 20 and 25) t1,
(select round( AVG( salary)), round( MIN( salary)), round( Max( salary))
from emp where age between 25 and 30) t2,
(select AVG( age),  MIN( age), Max( age)
from emp where age between 20 and 25) t3,
(select AVG( age),  MIN( age), Max( age)
from emp where age between 25 and 30) t4
;

select * from
(
    select "20-25"as "grp", round( AVG( salary)) as "avgSal", round( MIN( salary)) as "minSal", round( Max( salary)) as "maxSal", round( AVG( age)) as "avgAge", round( MIN( age)) as "minAge", round( Max( age)) as "maxAge"
from emp where age between 20 and 25
) t1
UNION
(select "25-30" as "grp", round( AVG( salary)) as "avgSal", round( MIN( salary)) as "minSal", round( Max( salary)) as "maxSal", round( AVG( age)) as "avgAge", round( MIN( age)) as "minAge", round( Max( age)) as "maxAge"
from emp where age between 25 and 30
) t2
;

(select "20-25"as "grp", round( AVG( salary)) as "avgSal", round( MIN( salary)) as "minSal", round( Max( salary)) as "maxSal", round( AVG( age)) as "avgAge", round( MIN( age)) as "minAge", round( Max( age)) as "maxAge"
from emp where age between 20 and 25
) 
UNION
(
    select "25-30" as "grp", round( AVG( salary)) as "avgSal", round( MIN( salary)) as "minSal", round( Max( salary)) as "maxSal", round( AVG( age)) as "avgAge", round( MIN( age)) as "minAge", round( Max( age)) as "maxAge"
from emp where age between 25 and 30
) 
;

SELECT floor( 90.666) ;

CREATE table nemp(
    id int primary key AUTO_INCREMENT,
    name varchar(30) not null,
    age int, 
    salary int, 
    manager_id int,
    department_id int, 
    Foreign Key (department_id) REFERENCES dept(id)
);

INSERT INTO nemp VALUES(null, 'abc', 21, 200000, 1,2), 
        (null, 'def', 24, 150000, 2, 2), 
        (null, 'ghi', 26, 700000, 1,3), 
        (null, 'xyz', 29, 680000, 3, 2) ;

select * from nemp;

select distinct e2.name, e2.age, e2.salary
from nemp e1, nemp e2
-- where e1.name <> e2.name and e1.age <> e2.age and e1.salary <> e2.salary
;