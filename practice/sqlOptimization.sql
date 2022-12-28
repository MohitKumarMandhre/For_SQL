-- Active: 1670399129309@@127.0.0.1@3307@hr
-- set statistics io, time on

show databases;

use world;

show tables;

explain select * from employees;

explain format =JSON select * from employees;

select * from employees;

select employee_id, first_name, hire_date 
from employees as em1
where hire_date IN (
	select max( hire_date )
    from employees as em2
    where year( em1.hire_date) = year( em2.hire_date)
    group by hire_date
)
order by hire_date
;

show tables;
--  ###########################

SHOW PROCEDURE STATUS;

SHOW FUNCTION STATUS;

CALL get_emp() ;

CALL show_number(9) ;

-- date 28/12/2022

set @@sql_mode="only_full_group_by" ;
select *
from emp
GROUP BY `DEPTNO`
;

select sum(sal), deptno from emp;

