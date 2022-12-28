-- Active: 1670399129309@@127.0.0.1@3307@world

show tables;

select * from employees;

with cte as (
    select FIRST_Name , `SALARY`,`DEPARTMENT_ID`, DENSE_RANK() over( PARTITION BY `DEPARTMENT_ID` order by `SALARY` desc) as rn
    FROM employees
    
)
SELECT * from cte where rn = 1;
;

SELECT e1.`FIRST_NAME`, e1.
from employees as e1, employees as e2
where e1.`EMPLOYEE_ID` = e2.`EMPLOYEE_ID`
and e1.`DEPARTMENT_ID` = 10
;

create view emp_age as 
select `HIREDATE`, DATEDIFF( NOW(), `HIREDATE`) as age1, TIMESTAMPDIFF( YEAR, `HIREDATE`, NOW() ) as age2 from emp;

select * from emp_age;

--  date 26/12/2022

drop table atype;

create table if not exists atype(
    tid int(11) not null PRIMARY KEY AUTO_INCREMENT,
    tname varchar( 100) DEFAULT NULL
);


create table if not exists accounts(
    accno int(11) not null PRIMARY KEY AUTO_INCREMENT,
    name varchar( 100) DEFAULT NULL,
    tid int(11),
    Foreign Key (tid) REFERENCES atype(tid)
);

insert into atype VALUES (1, 'salary');
insert into atype VALUES (2,'current');

insert into accounts values (101, 'MKM', 1), (102, 'LAY', 2), (103, 'NIS', 1), (104, 'AKA', 2) ;

 create table if not exists savings(
    tid int(11),
    minbal DECIMAL(8, 2) DEFAULT 5000,
    Foreign Key (tid) REFERENCES atype(tid)
 );

 insert into savings values (1, 6000);

create table if not exists current(
    tid int(11),
    od DECIMAL(8, 2) DEFAULT 10000,
    Foreign Key (tid) REFERENCES atype(tid)
 );

 insert into current values (2, 10000);

  select * from savings  ;

  select ename, sal, sal*0.4 as hra, sal*0.3 as da, sal*0.12 as pf, (sal*0.1 as tax, sal*0.4 + sal*0.3 - sal*0.1 - sal*0.12 + sal) as totalsal
  from emp;

  set @v1 = 1250;

  select * from emp where sal = @v1;

select empno, ename, job as 'kaam'
from emp 
order by kaam
limit 2, 5
;

show tables;

select * from salgrade ;
select *
from salgrade
order by grade, losal, hisal desc
limit 2 ;

select concat( ename,'\'s ', job )
from emp
;

SELECT SUBSTR(job, 1, 4), SUBSTR(job, 4)
from emp;

select SUBSTR( ename, length(ename)) ,lower( SUBSTR(ename, -1))
from emp;

select concat( lower( SUBSTR( ename, 1, length( ename)-1)), upper( SUBSTR(ename, -1)) ) as 'name'
from emp;

SELECT INSTR( 'chitti chilakamma', 't');

select ename, 
case 
when INSTR( ename, SUBSTR(ename, -1)) = LENGTH( ename) then 'NO' else 'yes'
end as repi
from emp;

select ename, INSTR( ename, SUBSTR(ename, -1)) as repi
from emp
where INSTR( ename, SUBSTR(ename, -1)) < LENGTH( ename) ;

SELECT RIGHT(ename, 3) as rn, LEFT( ename, 3) as ln
from emp;

select concat( lower( left( ename, length(ename)-1)), RIGHT( ename, 1) ) as 'specialName'
from emp;

select TRIM("   mkm ");

select trim('he' from 'hello brother');

select REPLACE( 'mary had a little lamb', 'lamb', 'bomb' );

set @str='mary had a little lamb';

select LENGTH( @str) - length(REPLACE( @str, 'a', '' )) as occOfA;

select job, LPAD(job, 15, '*'), RPAD(job, 15, '$')
from emp;

select REPEAT( 'hello', 5) ;

SELECT ename, REVERSE( ename) FROM emp;

set @a1 = 'mohit';
set @a2 = 'kumar';

select sign( @a1 - @a2);

select ename, sal, comm
from emp
where SIGN( comm - sal) = 1;

select abs( -98), ascii('A'), char(97 using ascii), char(33);

select round( 157.333, -1), round( 157.333, -2), round( 157.333, -3) ;

SELECT CURRENT_DATE, curdate();
select now(), SYSDATE(), CURRENT_TIMESTAMP ;

select date( now()), time( now());

select year( now()), month( now()), MONTHNAME( now()), day( now()), DAYNAME( now()) ;

SELECT ename, HIREDATE
from emp
where dayname( `HIREDATE`) = 'Tuesday';

SELECT ename, HIREDATE
from emp
where MONTHNAME( `HIREDATE`) = 'December';

SELECT ename, HIREDATE
from emp
where year( `HIREDATE`) = 1981 and ename not like '%s%';

select hour( NOW()), MINUTE( NOW()), SECOND(NOW()), QUARTER( NOW());

-- DATE_FORMAT
-- %a - 3 letter DAY
-- %W - week
-- %M - full month
-- %b - 3 letter MONTH
-- %y - 2 digit
-- %Y - 4 digit
-- %d - day count in MONTH
-- %w - day count in week
-- %j - day count in year

SELECT `HIREDATE`, 
case 
    when (MOD(year(`HIREDATE`),4) = 0 and MOD(year(`HIREDATE`), 100) <> 0 ) then  'LY'
    when MOD(year(`HIREDATE`),400) = 0 then 'LY2'
    else 'NOT LY'
end as joinDate
from emp;

-- SELECT DATE_FORMAT( YEAR( NOW()),  )
select ename, comm from emp order by comm desc;

select concat('domino', '''s ', 'pizza' );

SELECT SUBSTR('pizza', -3) ;