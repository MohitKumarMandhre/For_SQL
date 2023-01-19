use world;

with recursive cte3 as (
    select 1 'n'
    union all 
    select n+1 from cte3 where cte3.n <= 15
)
select * from cte3;
;
show databases;
use air2db;
show tables;

create database testdb;
use testdb;

create table if not exists dummy( name int, email varchar(50), phn varchar(10) );

-- insert into table dummy(1, 'bob@gmail.com', '9993817110') GO 55;

show databases;
use world;

show tables;

select count(*) from host_summary;

create table chk_tab( c1 int);

select tablespace_name, file_name, total_extents
from information_schema.files
where tablespace_name like '%chk_tab%'
;

show create table chk_tab;

-- create a table

-- rows inside datapages
-- datapages inside extends
-- extends inside datafiles
-- datafiles inside tablespaces

-- other table types :-
-- partition tables
-- temporary tables

create table chk_extent select * from emp where 1=2;

delete from chk_extent where ename = 'y' ;
select * from chk_extent;

drop table chk_extent;
truncate chk_extent;

alter table chk_extent modify empno int auto_increment primary key;

insert into chk_extent (ename, job, mgr, hiredate, sal, comm, deptno)
select ename, job, mgr, hiredate, sal, comm, deptno
from emp where  ename <> 'y'
;

select count(*) from chk_extent
; 
-- total => 212993

insert into chk_extent (ename, job, mgr, hiredate, sal, comm, deptno)
select ename, job, mgr, hiredate, sal, comm, deptno
from chk_extent where  ename <> 'king'
;

select tablespace_name, file_name, total_extents
from information_schema.files
where tablespace_name like '%chk_extent%'
;

select count(*) from chk_extent
where job like '%clerk%'
; -- 65536

-- to reduce IO, by dividing the table into smaller subsets, to provide storage characterstics for same logical data

-- partition tables - 
-- list partitions

select distinct job from chk_extent;

create table list_job(empno int, ename varchar(20), job varchar(20))
partition by list columns(JOB)
(
	partition p_clerk values in ('CLERK'),
    partition p_sales values in ('SALESMAN'),
    partition p_anal values in ('ANALYST'),
    partition p_man values in ('MANAGER'),
    partition p_pres values in ('PRESIDENT')
)
;

insert into list_job select empno, ename, job from chk_extent;

explain select count(*) from list_job where job like'clerk%' ;

use world;
explain select * from emp where deptno = 10;
explain select * from dept where dname = 'sales' ;
use hr;
explain select * from regions where region_id=1;
-- type = const, ALL, ref
explain select * from departments where location_id = 1700 ;

explain select * from emp;

explain select count(*) from chk_extent where job like'clerk%' ;

-- it just produces a **probable plan**
-- query time - ( response time -> processing + waiting time(because resourse may be busy) )

explain select ename, sal from emp where sal IN ( select max(sal) from emp) ;

explain 
select * from emp where job = 'clerk'
union 
select * from emp where job = 'analyst'
;

explain 
select ename from emp 
union 
select dname from dept;

explain 
select ename, dname from emp 
natural join dept;


-- fruits task

create table fruits( id int, name varchar(20), price numeric(5,0));

insert into fruits values (103, 'guava', 80), (101, 'mango', 150), (105, 'apple', 200);

select * from fruits;

alter table fruits modify price numeric(11,2) ;

explain format=tree select * from fruits where id = 105;

explain format = tree select * from list_job where job like 'analyst%' ;
explain format = tree select * from chk_extent where job like 'analyst%' ;

/*
when table scan happens :- 
* selecting all rows, so simetimes it is allowed
*/

-- INDEXES - automatically created on primary, foreign & unique key

show index from world.emp;

show index from world.company;

create table uni_tab ( c1 int unique);

show index from world.uni_tab;
show create table uni_tab;

select distinct table_name, column_name, index_name
from information_schema.statistics
where table_schema = 'world' and table_name = 'fruits'
;

-- creating index

create index idx_id on fruits(id);
explain format=tree select * from fruits where id = 101; 
-- table scan, index scan, index lookup

explain format=tree select empno from emp;

use hr;
show tables;
select * from country;

create database airportdb;
use airportdb;
show tables;