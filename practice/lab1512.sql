-- Active: 1670399129309@@127.0.0.1@3307@world
-- sql query optimization
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
    when @d2 = CURRENT_DATE() then "HB"
    when @d2 > CURRENT_DATE() then "Advance HB"
    else "Belated HB"
 end as 'Wish'
 ;