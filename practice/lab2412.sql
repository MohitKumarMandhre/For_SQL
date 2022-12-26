-- Active: 1670399129309@@127.0.0.1@3307@world

show tables;

select * from employees;

with cte as (
    select FIRST_Name , `SALARY`,`DEPARTMENT_ID`, DENSE_RANK() over( PARTITION BY `DEPARTMENT_ID` order by `SALARY` desc) as rn
    FROM employees
    
)
SELECT * from cte where rn = 1;
;

SELECT e1.`FIRST_NAME`, e1.
from employees as e1, employees as e2
where e1.`EMPLOYEE_ID` = e2.`EMPLOYEE_ID`
and e1.`DEPARTMENT_ID` = 10
;

create view emp_age as 
select `HIREDATE`, DATEDIFF( NOW(), `HIREDATE`) as age1, TIMESTAMPDIFF( YEAR, `HIREDATE`, NOW() ) as age2 from emp;

select * from emp_age;

--  date 26/12/2022

drop table atype;

create table if not exists atype(
    tid int(11) not null PRIMARY KEY AUTO_INCREMENT,
    tname varchar( 100) DEFAULT NULL
);


create table if not exists accounts(
    accno int(11) not null PRIMARY KEY AUTO_INCREMENT,
    name varchar( 100) DEFAULT NULL,
    tid int(11),
    Foreign Key (tid) REFERENCES atype(tid)
);

insert into atype VALUES (1, 'salary');
insert into atype VALUES (2,'current');

insert into accounts values (101, 'MKM', 1), (102, 'LAY', 2), (103, 'NIS', 1), (104, 'AKA', 2) ;

 create table if not exists savings(
    tid int(11),
    minbal DECIMAL(8, 2) DEFAULT 5000,
    Foreign Key (tid) REFERENCES atype(tid)
 );

 insert into savings values (1, 6000);

create table if not exists current(
    tid int(11),
    od DECIMAL(8, 2) DEFAULT 10000,
    Foreign Key (tid) REFERENCES atype(tid)
 );

 insert into current values (2, 10000);

  select * from savings  ;
