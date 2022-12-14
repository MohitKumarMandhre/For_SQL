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
if( em.salary > 150000, em.name, age) asc ;