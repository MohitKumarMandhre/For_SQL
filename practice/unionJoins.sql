-- Active: 1670399129309@@127.0.0.1@3307@new_hr
show tables;

select distinct job
from emp
where `DEPTNO` IN (10, 20);

select job
from emp
where `DEPTNO` IN (10)
UNION
select job
from emp
where `DEPTNO` IN (20)
UNION
select job
from emp
where `DEPTNO` IN (30);

select job
from emp
where `DEPTNO` IN ( 20)
UNION ALL
select job
from emp
where `DEPTNO` IN (10);

select job
from emp
where `DEPTNO` IN ( 20)
INTERSECT
select job
from emp
where `DEPTNO` IN (10);

select ename from emp
union 
select dname from dept;

SELECT job, sum(sal) from emp
group by `job`
UNION
SELECT 'totalSal', sum(sal) from emp;

select ename, null from emp
union 
select null, dname from dept;

SELECT sum(sal), `DEPTNO`, job from emp
group by job, DEPTNO
with ROLLUP;

SELECT sum(sal) as res, `DEPTNO`, job from emp
group by DEPTNO, job
with ROLLUP
UNION
SELECT sum(sal), DEPTNO, job from emp
group by job, `DEPTNO`
with ROLLUP
order by res
;
-- order by in UNION can work only for 1st select projection and it is placed after all other projections
select ename, null as dname from emp
union 
select null, dname from dept
order by dname
;

-- JOINS

select `ENAME`, `DNAME`
from emp as e inner join dept as d
ON e.`DEPTNO` = d.`DEPTNO`
;

select `dname`, sum( `SAL`)
from emp as e inner join dept as d
ON e.`DEPTNO` = d.`DEPTNO` and dname in ('SALES', 'ACCOUNTING')
group by dname
;

select * from dept;
select ename, job, loc
from emp as e inner join dept as d
ON e.`DEPTNO` = d.`DEPTNO` and loc in ('CHICAGO') and job like 'clerk%'
;

insert into emp(empno, ename) values(2222, 'y');

select ename, dname
from emp as e right outer join dept as d
on e.`DEPTNO` = d.`DEPTNO`
;

select ename, dname
from emp as e left join dept as d
on e.`DEPTNO` = d.`DEPTNO`
UNION
select ename, dname
from emp as e right join dept as d
on e.`DEPTNO` = d.`DEPTNO`
;

select ename, sal, `GRADE`
from emp e cross join salgrade s
where sal BETWEEN `LOSAL` and `HISAL`
;

select ename, dname, sal, `GRADE`
from emp cross join salgrade CROSS JOIN dept 
where sal BETWEEN `LOSAL` and `HISAL`
;

---------------
-- change db (NEW_HR)
---------------

show tables;

create DATABASE new_hr;



































































