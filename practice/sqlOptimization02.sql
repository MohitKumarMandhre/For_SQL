
use world;

show tables;

-- describe vs explain

/*

*/

explain select * from ( select max(sal) ) a;

explain select * from dept where dname = 'sales' ;

show indexes from emp;
alter table emp alter index fk_deptno visible;
alter table emp alter index idx_job_empno invisible;
-- alter table emp alter index primary invisible;

explain select * from emp where job='clerk' and deptno=20;
explain select * from emp where HIREDATE = '1981-12-05' ;

create index idx_hd on emp( hiredate);

create index idx_comm on chk_extent( comm);
-- indexing column with a lot of NULL values, is not advised 
explain select * from chk_extent where comm is not null ;
explain select * from chk_extent where comm is null ;
show indexes from chk_extent ;
alter table chk_extent alter index idx_comm invisible;

create index idx_comm on emp( comm);
explain select * from emp where comm is not null ;

show indexes from emp;
alter table emp alter index fk_deptno invisible;
create index idx_deptno_job on emp(deptno, job);

-- leading columns will be utilizing index
-- we can't force index on non leading columns
explain select * from emp where job='clerk';
explain select * from emp force index(idx_deptno_job) where deptno=20;
explain select * from emp force index(idx_deptno_job) where job='clerk';

select * from sys.schema_unused_indexes
where object_schema like '%world%';

desc employee2;

explain select * from emp where empno > 7500; 
explain select * from emp where empno like '75%'; 
explain select * from emp where empno between 3000 and 7500;
 
-- aggregate function

explain format=tree select deptno from dept ;
explain format=tree select deptno from dept where deptno in (10, 20, 30) ;

explain format=tree select avg(sal) from emp;
create index idx_sal on emp(sal) ;
explain format=tree select sum(sal), deptno from emp group by deptno ;
explain format=tree select sum(sal), job from emp group by job ;
explain format=tree select sum(sal), job from emp group by job having job <> 'analyst' ;
explain format=tree select sum(sal), job from emp where job<>'analyst'group by job ;

create index idx_job on chk_extent(job);
explain format=tree select sum(sal), job from chk_extent group by job having job<>'analyst' ;
explain format=tree select sum(sal), job from chk_extent where job<>'analyst' group by job ;

alter table emp alter index idx_job visible;
show indexes from emp;

-- task
create table student1 ( student_id int primary key, 
	student_name varchar(100), 
	result varchar(1) check ( result in ('P', 'F')) );
    
-- a. 
insert into student1 ( select empno, ename, NULL from emp) ;
select * from student1;

-- b.
update student1 set result = case
when student_name like '%s%' then 'P'
else 'F'
end ;

-- c. 
select result, count(*) as cnt
from student1
group by result
;

-- d. 
explain format=tree select result, count(*) as cnt
from student1
group by result
;

-- e. 

create index idx_res on student1(result) ;  -- low cardinality index
drop index idx_res on student1 ;
explain format=tree select result, count(*) as cnt
from student1
where result = 'F'
group by result
;
show tables;
select count(*) from employee;
truncate student1;

insert into world.student1 ( select employee_id, first_name, null from hr.employees);
show indexes from student1;

explain format = tree
select sum(sal), job from emp group by job
union 
select sum(sal), null from emp;

explain format = tree select sum(sal), job from emp group by job with rollup ;

-- JOINS
show tables;

create table world.reg1 select * from hr.regions;
create table world.country1 as select * from hr.countries;

explain select * from reg1 natural join country1 ;
explain format = tree select * from reg1 natural join country1 ;
-- when no indexes, hash join is performed

create index idx_gerid on country1( region_id); 
-- inner loop join

create index idx_reg on reg1( region_id);
alter table reg1 add primary key(region_id);
explain format = tree select * from reg1 force index(primary) natural join country1 ;
show indexes from country1;

alter table country1 add constraint fk_reg67 foreign key( region_id) references reg1( region_id);

alter table reg1 alter index idx_reg visible ;
desc reg1;
desc country1;

alter table reg1 modify region_id int;
drop index idx_gerid on country1;
explain format = tree select * from reg1 natural join country1 ;

create index idx_id_name on reg1(region_id, region_name)

