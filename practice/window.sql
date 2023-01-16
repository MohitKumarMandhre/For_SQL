-- Active: 1670399129309@@127.0.0.1@3307@world

show tables;

select ename, sal from emp;

-- cummilative SUM

select ename, sal, ( select sum(sal) from emp where empno <= e.empno ) as csal from emp e;

select ename, `DEPTNO`, sal, sum(sal) over(partition by deptno order by sal) from emp;

-- ranking functions

-- row_number() - running serial number, 
-- rank() - in case of tie, it leavest he GAP, 
-- dense_rank() - NO GAP

select ename, sal, 
    row_number() 
    -- over(order by sal desc) as 'rn', 
    -- rank() over(order by sal desc) as 'ra', 
    -- dense_rank() over(order by sal desc) as 'dr' 
from emp;

-- comparing functions

-- lag(), lead()

select ename, sal, 
lag(sal) over() as 'lag',
lead(sal) over() as 'lead'
from emp;

select ename, `HIREDATE`, 
lag(HIREDATE) over() as 'lag',
lead(HIREDATE) over() as 'lead'
from emp;

select ename, sal, 
lag(sal) over() as 'lag',
lag(sal, 2) over() '-2lag'
from emp;

select ename, sal, 
lead(sal) over() as 'lead',
lead(sal, 2) over() '+2lead'
from emp;

select ename, `HIREDATE`, 
lead(HIREDATE) over() as 'lead',
lead(HIREDATE, 2) over() '+2lead'
from emp;

-- show DATABASES;

-- 1. find the number of days difference between 1st and 2nd analyst

select ename, job,`HIREDATE`,
DATEDIFF(`HIREDATE`, lead(`HIREDATE`) over()) as 'diff'
from emp
where job like 'analyst%'
;

-- first_value(), last_value(), Nth_value()

select ename, job,`sal`,
first_value(`sal`) over(order by sal desc) as 'fv', 
LAST_VALUE(`sal`) over( ) as 'lv'
from emp
;

select ename, job,`sal`,
NTH_VALUE(sal, 4) over(order by sal DESC) as '3rdHighsal'
from emp
;

select ename, job,`sal`,
first_value(`sal`) over(order by sal desc) as 'fv', 
LAST_VALUE(`sal`) over( order by sal desc) as 'lv'
from emp
;

-- last_value() - 
-- range between UNBOUNDED PRECEDING and UNBOUNDED FOLLOWING
-- rows between UNBOUNDED PRECEDING and CURRENT ROW
--      between current row and unbounded following

SELECT ename, sal, 
first_value(`sal`) over(order by sal desc) as 'fv', 
LAST_VALUE(sal) over(ORDER BY sal asc range between UNBOUNDED PRECEDING and UNBOUNDED FOLLOWING ) as 'last_value'
from emp;


SELECT ename, deptno, sal, 
first_value(`sal`) over(partition by deptno order by sal desc) as 'fv'
from emp;

-- NTILE

SELECT ename, DEPTNO, 
ntile(22) over(order by deptno)
from emp;

-- use WORLD;

SELECT employee_id, department_id, 
ntile(3) over(order by employee_id )
from employees;

SELECT ename, sal,
LAST_VALUE(sal) over(ORDER BY sal asc rows between current row and unbounded following ) as 'lv1',
LAST_VALUE(sal) over(ORDER BY sal asc rows between unbounded PRECEDING and current row) as 'lv2'
from emp;









