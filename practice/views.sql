

use hr;

select * from v4;

create view v5 as 
select * from employees
where department_id = 10 with check option
;

select * from v5;

update v5 set department_id = 55 where employee_id = 200;
-- Error Code: 1369. CHECK OPTION failed 'hr.v5'
/*
PROGRAMMING IN MYSQL
-----------------------------
-- procedures
-- 		functions
-- 			triggers

-- set 
--	  select

procedures - to perform specific activity(select, insert, update, delete), DCL & DDL cmmnds not allowed
trigger - select, insert, commit, rollback not allowed 

procedures are pre-compiled, and just need to run at run-time, hence parsing is avoided
supports modular programming

no alter option to procedures
*/

call get_emp() ;

delimiter $$
create procedure dummy1()
begin 
    select "this is dummy code!";
end $$

delimiter ;

call dummy1() ;

call sp_prod2(12, 19);
call sp_prod2(7, 4);

-- create procedure to pass employee_id as parameter amd print details for him
select * from employees limit 4;
call sp_takesEmpIdandReturnsDet(102);

-- LOOPS - while, simple, repeat

show tables;
drop table odd_even;
create table odd_even( slno int primary key, descn varchar(4) check(descn IN ('odd', 'even') ) );
 
 
 call sp_hr5(1, 100);
 call sp_hr5(101, 1000);
 call sp_hr5(1001, 10000);
 call sp_hr5(10001, 20000);
 
 select count(*) as cnt from odd_even;
 
 select * from odd_even order by slno desc , descn desc limit 1;
 
 truncate odd_even;

-- create a proc to pass dob as para print day of birth starting from birthdate upto curr_date

set @dob = '1999-02-23' ;
select dayname(@dob),  DATE_ADD(@dob, INTERVAL 1 year)  ;

call sp_printDays('1999-02-28');

create table store(dob date, dayN varchar(100) );
select * from store;

select @dob, date_sub(@dob, INTERVAL -1 year) ;

show create procedure sp_takesEmpIdandReturnsDet;

select specific_name, routine_type
	from information_schema.routines
	where routine_schema = 'hr' ;

use hr;
call sp_takesEmpIdandReturnsDet( 2030);

call sp_newhr2(20010);

-- parameter modes - IN, OUT, INOUT

call sp_hr_outP( 2000, @res);
select @res as FN;

set @name= 'Empty set';
call sp_he_inout( @name);
select @name;

















