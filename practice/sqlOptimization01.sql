-- sql query optimization
use world;
show tables;

explain select * from fruits where id = 105;

/*
select
----------
	parsing
		optimizing
			executing -- dml 
				fetching
*/

explain format=tree select empno from emp where job = 'clerk' ; 
explain select empno from emp where job = 'clerk' ; 
show indexes from world.emp;

desc dept;
explain select * from dept where dname='sales' ;
explain format = tree select * from dept where dname='sales' ;

create index idx_dname on dept(dname);
explain select * from dept where dname='sales' ;
explain format = tree select * from dept where dname='sales' ;

-- find out emp working in deptno 20 as clerk
-- tune the query

explain select * from emp where deptno=20 and job = 'clerk' ; 
explain format=tree select * from emp where deptno=20 and job = 'clerk' ;

-- for same query, optimizer generates multiple plans and the minimum cost plan is choosen.

/*
table scan
-----------------
	(forcing index)
		use index
			force index
				ignore index
*/

-- select * from emp force index(FK_DEPTNO) where deptno=20 and job='clerk' ;


-- invisible index

alter table emp alter index FK_DEPTNO invisible;
explain select * from emp where deptno=20 and job = 'clerk' ; 
explain format=tree select * from emp where deptno=20 and job = 'clerk' ;

show tables;
explain select * from chk_extent where deptno=20 and job = 'clerk' ; 
explain format=tree select * from chk_extent where deptno=20 and job = 'clerk' ;

desc chk_extent;

explain format = tree select * from dept where dname='sales' ;

alter table dept alter index idx_dname invisible;

select index_name, IS_visible from 
information_schema.statistics
where table_schema='world' and table_name='dept';

show indexes from dept;
alter table dept alter index idx_dname visible;

create index idx_deptno_dname on dept(deptno, dname) ;
show indexes from dept;

explain select * from dept force index(idx_deptno_dname) where deptno =30 and dname='sales' ;
explain format = tree select * from dept force index(idx_deptno_dname) where deptno =30 and dname='sales' ;

select * from dept;

show indexes from emp;
create index idx_empno_deptno on emp(empno, deptno);
drop index idx_empno_deptno on emp;
create index idx_job on emp(job);
create index idx_job_empno on emp(empno, job);

explain select * from emp where deptno=20 and job = 'clerk' ; 
explain format=tree select * from emp force index(idx_job_empno) where deptno=20 and job = 'clerk' ;

desc fruits;

explain select * from fruits where id = 101;
alter table fruits modify column id int primary key;
show indexes from fruits;
explain select * from fruits where id = 105; 
-- type - const
explain format=tree select * from fruits where id = 105;
drop table range_part;
create table range_part ( empno int , ename varchar(30), sal int)
partition by range(sal)
(
	partition p_1000 values less than (1000),
    partition p_2000 values less than (2000),
    partition p_3000 values less than (3000),
    partition p_4000 values less than (4000),
    partition p_5000 values less than (5000),
    partition p_6000 values less than (6000)
);

insert into range_part select empno, ename, sal from chk_extent
;
desc chk_extent;
explain select * from range_part where sal between 2000 and 5000;

select distinct year(hiredate) from chk_extent;

create table year_part ( empno int , ename varchar(30), hiredate date)
partition by range( year( hiredate))
(
	partition p_82l values less than (1982),
    partition p_82m values less than  (1988)
);

insert into year_part select empno, ename, hiredate from chk_extent ;

explain select * from year_part where year( hiredate) = 1987;
explain select * from year_part where year(hiredate) between 1983 and 1985;
explain format=tree select * from year_part where year( hiredate) = 1987;

select partition_name, partition_ordinal_position, table_rows
from information_schema.partitions 
where table_name='year_part' ;

set @var = '1985';
explain select * from year_part where year( hiredate) = @var;
select * from year_part partition( p_82m) order by hiredate limit 20;

select str_to_date("1981-12-03", "%Y-%M-%d" ) ;

SELECT STR_TO_DATE("August 10 2017", "%M %d %Y");

select date_format( curdate(), "%Y");

explain select * from year_part where date_format( hiredate, "%Y") = 1987;
explain select * from year_part where date_format( hiredate, "%Y") between 1985 and 1987;

EXPLAIN SELECT * FROM year_part WHERE hiredate BETWEEN DATE_FORMAT("1984-00-00", "%Y-%m-%d") AND DATE_FORMAT("1987-00-00", "%Y-%m-%d");
-- EXPLAIN SELECT * FROM year_part WHERE hiredate = DATE_FORMAT("1987-00-00", "%Y-%m-%d") ;-- 

-- HASH PARTITION

create table hash_part ( empno int , ename varchar(30), sal float(11,2) )
partition by hash(empno)
partitions 4
;

insert into hash_part select empno, ename, sal from chk_extent ;

explain select * from hash_part where empno= 3000 ;

select partition_name, partition_ordinal_position, table_rows
from information_schema.partitions 
where table_name='hash_part' ;

select * from hash_part partition(p3) limit 20;

-- composite partition(1st partition should be range, )

-- temporary tables- session based tt, data available
-- I/O's get reduced

create temporary table temp1 ( sal float(11,2) );

insert into temp1 select sal from emp;

select * from temp1;

-- cursor
-- handle result set row by row

-- cursors inside procedure- declare - has select, open - executes select, fetch - row by row comparision, close

call sp_cursor01(20);

create table tab_1 (p1  varchar(255));

call proc_cursor_1(20);
select * from tab_1;


