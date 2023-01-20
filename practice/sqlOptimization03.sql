use world;

show tables;

/*
composite partition
-------------------------
* main partition should be list/range
	* subpartition hash
    * good for AND operator
*/

create table compo_range_hash( empno int, ename varchar(40), sal int, job varchar(30) )
partition by range(sal)
subpartition by hash(empno)
subpartitions 2 (
	partition p_1k values less than (1000),
    partition p_2k values less than (2000),
    partition p_3k values less than (3000),
    partition p_4k values less than (4000),
    partition p_maxx values less than MAXVALUE
)
;

insert into compo_range_hash select empno, ename, sal, job from chk_extent;

desc compo_range_hash;

explain select * from compo_range_hash;

select partition_name, table_rows, subpartition_name
from information_schema.partitions
where table_name = 'compo_range_hash'
;
select * from compo_range_hash partition (p_maxx) limit 20;
show create table compo_range_hash ;

explain format=tree select * from emp where sal in ( select min(sal) from emp );
explain format=tree select * from emp where sal = ( select min(sal) from emp );
explain format=tree select * from emp force index(idx_sal) where sal in ( select min(sal) from emp );
show indexes from emp;

explain select ename ,sal, deptno from emp where sal > ( select avg(sal) from emp );
explain format=tree select ename ,sal, deptno from emp where sal > ( select avg(sal) from emp );
explain format = tree select e.ename, e.sal, e.deptno, m.avgsal
from emp e join ( select deptno, avg(sal) avgsal from emp group by  deptno ) m
ON e.deptno = m.deptno and e.sal>m.avgsal
;

# find deptno, where salesman is not working
select distinct deptno from emp where deptno NOT IN ( select deptno from emp where job='salesman' );
explain format=tree select distinct deptno from emp where deptno NOT IN ( select deptno from emp where job='salesman' );

explain format=tree 
select d.deptno, d.dname 
from dept d where not exists (
	select 1 from emp e where e.deptno = d.deptno
)
;

explain format=tree select d.dname, d.deptno from dept d where deptno not in ( select deptno from emp where deptno = d.deptno);

show create table emp;

/*
indexes 
--------------
	* unique
    * non-unique
    * function based indexes
    * hash index( can only be created in memory )
    * fulltext - match, against
    * covering index- data is in index and table, produce result using index in single shot
*/
explain select * from emp where monthname( hiredate)='January' ;
explain format=tree select * from emp where monthname( hiredate)='January' ;

show engines;

create table testhash (
fname varchar(50) not null, 
lname varchar(50) not null,
key using hash(fname)
)engine=memory
;

insert into testhash select first_name, last_name from hr.employees where department_id IN (60, 90) ;
show indexes from testhash;
explain select * from testhash where fname = 'david';
explain format=tree select * from testhash where fname = 'david';

create table full_t as select first_name, last_name from hr.employees;
alter table full_t add fulltext( first_name, last_name);
show indexes from full_t;
explain format=tree select * from full_t where match(first_name, last_name) against ('David%') ;


explain format=tree select ename, sal, case
when sal>3000 then 'G'
when sal = 3000 then 'A'
else 'B'
end as 'type' from emp
where deptno = 30
;

explain format=tree select ename, sal, sal*1.5 from emp where sal> 3000/1.5 ;
-- going for table scan as index col 
-- making LHS matching the index column

-- profiler
select @@profiling;
set profiling = 1;

select * from hr.regions;
select count(*) from chk_extent;
select * from  compo_range_hash where sal = 3000;

show profiles;
show profile for query 5;

select state, format(duration, 6) as duration from 
information_schema.profiling where query_id = 3 
order by seq;
set profiling = 0;
select @@profiling;




