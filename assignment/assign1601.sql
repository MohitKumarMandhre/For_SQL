-- Active: 1670399129309@@127.0.0.1@3307@world

create table if not exists dob ( d1 date, d2 varchar(30));

select * from dob;

-- 1
set @d = '1999-02-23';

create table d2 as (
with recursive cte4 as (
    select @d 'dat'
    union ALL
    select DATE_ADD( dat, interval 1 year) 
    from cte4
    where year(dat) <= year(CURDATE())
)
SELECT dat, DAYNAME( dat) from cte4

);

select * from d2;

-- 2

-- a.

select ename, sal, 
rank() over(order by sal) as 'rank',
dense_rank() over(order by sal) as 'denserank'
from emp
;

-- b

select ename, sal, 
lead(sal) over(order by sal) as 'lead',
lag(sal) over(order by sal rows between current row and unbounded following  ) as 'lag'
from emp
;

-- c
select ename, deptno, sal, 
FIRST_VALUE(sal) over(PARTITION BY DEPTNO ORDER BY sal desc) as 'maxiSal'
from emp
;

-- d

select ename, job,
FIRST_VALUE(HIREDATE) over(partition by job order by HIREDATE) as 'joining'
from emp
where job like 'clerk%'
;

-- all 4( smith, james, miller, adams have same DOJ)



















