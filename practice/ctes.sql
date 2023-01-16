-- Active: 1670399129309@@127.0.0.1@3307@world

show tables;

with cte1 as (
    select ename from emp
)
select * from cte1
;

with cte2 as (
    select avg(sal) as avgS, DEPTNO from emp group by `DEPTNO`
)
select e.ename, e.sal, e.`DEPTNO`, avgS
from emp e join cte2
ON e.DEPTNO=cte2.deptno and cte2.avgS <e.sal
;

-- display emp name and mgr NAME

select e.`ENAME`, e.`DEPTNO`, 
count( *) over(PARTITION BY e.deptno) as 'ecnt',
m.enaME as 'mname', m.`DEPTNO`, 
count( *) over(PARTITION BY m.deptno) as 'mcnt'
from emp as e join emp as m
on m.empno = e.MGR
;


select count(*), deptno from emp group by deptno;

with recursive cte3 as (
    select 1 'n'
    union all 
    select n+1 from cte3 where cte3.n <= 15
)
select * from cte3;
;

-- cte to generate calender for current MONTH

with recursive cte4 as (
    select CURDATE() 'da'
    union ALL
    select DATE_ADD( cte4.da, interval 1 day) 
    from cte4
    -- where month( cte4.da)= 1 
    limit 10
)
SELECT * from cte4
;

select month( CURDATE());






