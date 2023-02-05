use world;

select `DEPTNO`
from dept20 where deptno not in 
(select deptno from emp)
;

use hr;

show tables;

desc employees;
desc departments;

select department_id
from departments where department_id not in 
(select department_id from employees )
;

select d.department_id from departments d
where NOT EXISTS 
( select 1 from employees e where d.`department_id`=e.`department_id` )
;

select d.department_id 
from departments d left join employees e 
ON d.department_id = e.department_id
where e.employee_id is NULL
;

-- Table 1: id- 1,1,1,2,4
-- Table 2: id- 1,1,1,null,5

create table ta (a int );
create table tb (a int );
select * from tc;
insert into ta values (1),(1),(1),(2),(4);
insert into tb values (1),(1),(1),(null),(5);

select count(*) from 
ta cross join tb
;

create table tc (id int, a int);
insert into tc values (1,1), (2,1), (3,1), (4,2), (5,3), (6,3);

select * from tc where id not in (
select max(id)
from tc
group by a )
;

select a
from tc 
group by a 
having count(*)>1;

select *, count(*)over(partition by a) cnt
from tc; 

select * from tc;

select current_date;

show databases;
use testdb;
show tables;
create table t1 ( id int );
insert into t1 values(4105);

create table t2( id int );
insert into t2 values(101), (1056), (1407), (1404), (109), (1402);

select * 
from t1 left join t2
ON t1.id = t2.id
where t2.id is NULL
;

use world;
desc emp;
show tables;
create table stud select empno, ename from chk_extent limit 7
;
drop table stud;

with cte1 as (
	select empno, ename,
	COALESCE (case 
		when mod(empno,2)=0 then lag(ename) over(order by empno) 
		else lead(ename) over(order by empno) 
	end , ename) as na
	from stud 
)
select empno as id, na as student from cte1
;

-- create table s2 as select * from stud;
-- update s2 set ename = COALESCE (case 
-- 	when mod(empno,2)=0 then lag(ename) over(order by empno) 
--     else lead(ename) over(order by empno) 
-- end , ename)
-- ;



