-- Active: 1670399129309@@127.0.0.1@3307@world

show tables;

# query to get all departments having no emps

SELECT e.* 
from emp e inner join dept d 
ON e.`DEPTNO` = d.`DEPTNO`
;

CREATE table dept20 select * from dept;
SELECT * FROM dept20;
-- insert into dept20 VALUES(50, "DEVOPS", "PUNE");

EXPLAIN format = tree
select d.`DEPTNO` from dept20 d
where NOT EXISTS 
( select 1 from emp e where d.`DEPTNO`=e.`DEPTNO` )
;

explain format=tree
select d.deptno 
from dept20 d left join emp e 
on d.deptno = e.deptno
where e.`EMPNO` is NULL
;


select `DEPTNO`
from dept20 where deptno not in 
(select deptno from emp)
;


create 








