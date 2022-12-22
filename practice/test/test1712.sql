-- Active: 1670399129309@@127.0.0.1@3307@hr
select  round( TRUNCATE( mod( 1600, 10), -1), 2);

show tables ;

with cte_emp as (
    select `FIRST_NAME` as ename ,`DEPARTMENT_ID`, `SALARY`, RANK() over( PARTITION BY `DEPARTMENT_ID` ORDER BY `SALARY` desc ) as dr
    from employees
), 
cte_distinctEmp as
(
    select distinct `DEPARTMENT_ID`,`SALARY`, ename from cte_emp where dr<= 3
)
select ename  from cte_distinctEmp
;

with cte_emp as (
    select `FIRST_NAME` as ename ,`DEPARTMENT_ID` as dept, `SALARY` as sal, DENSE_RANK() over( PARTITION BY `DEPARTMENT_ID` ORDER BY `SALARY` DESC) as dr
    from employees
)
select * from cte_emp where (
    select count(DISTINCT e2.`SALARY`)
    from employees as e2
    where sal > e2.`SALARY` and dept = e2.`DEPARTMENT_ID`
) < 3
;

select `FIRST_NAME` as fn, `DEPARTMENT_ID` as did, `SALARY`as sal from employees as em
where 3 > ( select count(DISTINCT 'salary' ) from employees as e2
where em.`DEPARTMENT_ID` = e2.`DEPARTMENT_ID` and em.SALARY> e2.`SALARY`
)
order by `DEPARTMENT_ID`, sal desc
;

with cte_emp as (
    select `FIRST_NAME` as ename ,`DEPARTMENT_ID`, `SALARY`, DENSE_RANK() over( PARTITION BY `DEPARTMENT_ID` ORDER BY `SALARY` asc) as dr
    from employees
)
select * from cte_emp where dr<= 3
;

-- unique missing

with cte_trip as (
    select * 
    trips as tr
    where client_id IN ( 
        select users_id from users where banned like "No"
    ) and 
    driver_id IN ( 
        select users_id from users where banned like "No"
    )
    where requested_at BETWEEN '2013-10-01' and '2013-10-03'
)
SELECT requested_at, round( (
    (SELECT count(*) FROM cte_trip where status like "cancelled%" and requested_at = t1.requested_at) / (SELECT count(*) FROM cte_trip where requested_at = t1.requested_at)
), 2) as Cancellation_ratio
from cte_trip as t1
GROUP BY requested_at
;

--  5th

with cte_sta as
(
    select id, sum(people) over(rows BETWEEN 3 PRECEDING and current row ) as cumm_sum
    from stadium
)
select id from cte_sta where cumm_sum >= 300
;

select st1.id, st2.id, st3.id
from stadium st1 INNER join stadium st2 inner join stadium st3
ON st1.id +1 = st2.id and st1.id +2 = st3.id
where st1.people >= 100 and st2.people >= 100 and st3.people >= 100
;