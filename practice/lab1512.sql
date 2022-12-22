-- Active: 1670399129309@@127.0.0.1@3307@world
-- sql query optimization

use world;
show tables;

CREATE TABLE SALGRADE
      ( GRADE int,
	LOSAL int,
	HISAL int );
INSERT INTO SALGRADE VALUES (1,700,1200);
INSERT INTO SALGRADE VALUES (2,1201,1400);
INSERT INTO SALGRADE VALUES (3,1401,2000);
INSERT INTO SALGRADE VALUES (4,2001,3000);
INSERT INTO SALGRADE VALUES (5,3001,9999);


CREATE TABLE DEPT
       (DEPTNO INT(2) PRIMARY KEY,
	DNAME VARCHAR(14) ,
	LOC VARCHAR(13) ) ;


INSERT INTO DEPT VALUES
	(10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES
	(30,'SALES','CHICAGO');
INSERT INTO DEPT VALUES
	(40,'OPERATIONS','BOSTON');


CREATE TABLE EMP
       (EMPNO int(4) PRIMARY KEY,
	ENAME varchar(10),
	JOB varchar(9),
	MGR int(4),
	HIREDATE DATE,
	SAL float(7),
	COMM float(7),
	DEPTNO int(2), CONSTRAINT FK_DEPTNO foreign key(deptno) REFERENCES DEPT(deptno));

INSERT INTO EMP VALUES
(7369,'SMITH','CLERK',7902,'1980-12-17',800,NULL,20);
INSERT INTO EMP VALUES
(7499,'ALLEN','SALESMAN',7698,'1981-2-20',1600,300,30);
INSERT INTO EMP VALUES
(7521,'WARD','SALESMAN',7698,'1981-2-22',1250,500,30);
INSERT INTO EMP VALUES
(7566,'JONES','MANAGER',7839,'1981-4-2',2975,NULL,20);
INSERT INTO EMP VALUES
(7654,'MARTIN','SALESMAN',7698,'1981-9-28',1250,1400,30);
INSERT INTO EMP VALUES
(7698,'BLAKE','MANAGER',7839,'1981-5-1',2850,NULL,30);
INSERT INTO EMP VALUES
(7782,'CLARK','MANAGER',7839,'1981-6-9',2450,NULL,10);
INSERT INTO EMP VALUES
(7788,'SCOTT','ANALYST',7566,'1987-07-13',3000,NULL,20);
INSERT INTO EMP VALUES
(7839,'KING','PRESIDENT',NULL,'1981-11-17',5000,NULL,10);
INSERT INTO EMP VALUES
(7844,'TURNER','SALESMAN',7698,'1981-9-8',1500,0,30);
INSERT INTO EMP VALUES
(7876,'ADAMS','CLERK',7788,'1987-07-13',1100,NULL,20);
INSERT INTO EMP VALUES
(7900,'JAMES','CLERK',7698,'1981-12-3',950,NULL,30);
INSERT INTO EMP VALUES
(7902,'FORD','ANALYST',7566,'1981-12-3',3000,NULL,20);
INSERT INTO EMP VALUES
(7934,'MILLER','CLERK',7782,'1982-1-23',1300,NULL,10);

show tables;

select * from emp;

-- 1. find out ename in the job having maximum no. of employees 

select ename, job
from emp
where job in (
    select job from emp
    GROUP BY job
    having count( *) in (
        select max( b.cnt) from 
        (select count(*) as cnt
        from emp 
        GROUP BY job) as b
    )
)
;

with cte_e as (
    select `DEPTNO`, count(*) as cnt
    from emp
    GROUP BY `DEPTNO`
),
cte_ra as (
    SELECT `DEPTNO`, cnt, rank() over(ORDER BY cnt desc) as ra 
    from cte_e
)
select `ENAME` from emp where `DEPTNO` IN (
select `DEPTNO` from cte_ra where ra =1
)
;

SELECT * from salgrade;

-- 2. find out grade of turner

select grade, `ENAME`
from (select sal, `ENAME` from emp where `ENAME` = 'turner') as b,salgrade
where b.sal>losal and b.sal<hisal
;

select grade
from salgrade
where (select sal from emp where `ENAME` = 'turner') BETWEEN `LOSAL` and `HISAL`
;

-- 3. find the job that got filled in 2nd half of any year filled in the 1st half of the following year
select * from
(select ename, job, hiredate
from emp 
order by 3) as a1 inner join (
    select ename, job, hiredate
    from emp 
    order by 3
) as a2
ON (a1.job = a2.job) and (year(a1.`HIREDATE`)+1 = year(a2.`HIREDATE`)) and ( (month(a1.`HIREDATE`) BETWEEN 7 and 12) and (month(a2.`HIREDATE`) BETWEEN 1 and 6) )
;

select ename, job, hiredate, QUARTER( `HIREDATE`)
from emp 
order by 3;

-- 4. wishing bithdate
set @d1 = '2022-12-15';
 set @d2 = '2022-12-16';
 set @d3 = '2022-12-14';

 select
 case 
    when @d1 = DATE( NOW( )) then "HB"
    when @d1 > CURRENT_DATE() then "Advance HB"
    else "Belated HB"
 end as 'Wish'
 ;

-- #######################################
show tables;

SELECT * from emp;

drop TABLE demo;
create table demo(
    name VARCHAR(100),
    value VARCHAR(100),
    id int
 );

 insert into demo values ('name', 'adam', 1), ('gender', 'male', 1), ('salary', '50000', 1);

 select * from demo;

-- pivot table demo
select id, 
max( CASE
    when name = 'name' then value else ''
end) as 'NAME',
max( CASE
    when name = 'gender' then value else ''
end) as 'GENDER',
max( CASE
    when name = 'salary' then value else ''
end) as 'SAL'
from demo
GROUP BY id
;

select id, [name], [gender], [salary] from
(SELECT id, name as ename, value from demo) as st
PIVOT
(max(value)
for 
ename in ([name], [gender], [salary])
) as pt
;

select `ENAME`, MONTH(`HIREDATE`) 
from emp
ORDER BY MONTH(`HIREDATE`) asc
;

SELECT DATEDIFF( '2030-03-01', '2030-02-28');

with cte_ca as (
    SELECT avg( sal) FROM emp
), 
with cte_da as (
    SELECT `DEPTNO`, avg( `SAL`)
    from emp
    group by `DEPTNO`
)
SELECT e.`ENAME`, e.sal 
from emp e inner join cte_da
WHERE e.sal>cte_da and e.sal<cte_ca
;

select `ENAME`, emp.`DEPTNO`, `SAL`
from (
    select `DEPTNO`, avg(`SAL`) as 'deptavg'
    from emp
    GROUP BY `DEPTNO`
) d1 inner join emp
ON d1.`DEPTNO` = emp.`DEPTNO`
where sal > deptavg
having sal < ( select avg( sal) from emp)
;

SELECT e1.`EMPLOYEE_ID`, e1.`MANAGER_ID`, e1.`SALARY`, e2.`SALARY`
from employees e1 INNER JOIN employees e2
where e1.`MANAGER_ID` = e2.`EMPLOYEE_ID` and e1.`SALARY` > e2.`SALARY`
;

select CURRENT_DATE(), CURRENT_DATE() - 7 ;


select hid, ename, challenges_created from
    (select hid, ename, challenges_created, dense_rank(challenges_created) over(order by t1.challenges_created desc ) as dr
    from 
        (select ha.hacker_id as hid, name as ename, count(*) as challenges_created
        from Hackers as ha inner join Challenges as ch
        ON ha.hacker_id = ch.hacker_id
        group by ha.hacker_id, name
        order by count(*) desc, ha.hacker_id) as t1) as t2
where dr = 1
;