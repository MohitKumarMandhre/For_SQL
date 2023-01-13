-- Active: 1670399129309@@127.0.0.1@3307@hr

-- show tables;

use hr;

-- create a func to pass employee_id as para and return a bonous
-- sh_clerk = 1.5*sal
-- sa_rep = 1.75*sal
-- mk_man = 2*sal
-- others sal

select employee_id, salary, job_id, f_getBon( employee_id) as bonous
from employees 
limit 5
;

-- pass the emp_id return if they joined in leap year otr not

select employee_id, hire_date, f_leapOrNot( employee_id) as 'leap/not'
from employees 
limit 5
;

select date_format( '2000-12-31', '%j'); -- this returns the date number

select first_name, employee_id from employees 
where hire_date IN
(select min( hire_date)
from employees)
;

-- trigger timmings
-- => before , after
-- => row level triggers( NEW, OLD)
-- insert				new     -
-- update				new     old
-- delete				-       old

-- create a table insert into retired table whenever delete happens on emp table

drop table retiredEmp;-- 
create table retiredEmp as select first_name from employees where 1=2;
select * from retiredEmp;

create table date_tab(
	slno int primary key, date1 date check( date1<= curdate() )
);

create table retEmp as select first_name from employees where 1=2;
select * from emp_new1 limit 5;

delete from emp_new1 where employee_id = 100;

-- create a table w/o chk constraint

create table date_tab(
	slno int primary key, date1 date
);
select * from date_tab;
insert into date_tab values (1, '2023-01-31');

use hr;
-- create a trigger to restrict lowering of salary
create table emp5 as ( select employee_id, first_name, salary from employees limit 20);
select * from emp5 limit 5;

update emp5 set salary = 8500 where employee_id = 103;

show triggers from hr;

create table account( accno int primary key, 
name varchar(50), balance numeric(11,2)
);

create table trans (
accno int, wd numeric(11,2), dep numeric(11,2),
foreign key( accno) references account(accno)
);

-- create a trigger to update balance in account table whenever withdrawl, deposit happens on trans table

insert into account values( 100, 'Raj', 5000);

select * from account;
desc trans;









