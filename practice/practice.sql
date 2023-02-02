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
