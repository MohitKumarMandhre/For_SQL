use world;

create table demo9( p1 text);
show create table demo9;
create temporary table demo10 select * from emp limit 2;
show tables;

drop temporary table demo10;
-- set snacks =  ('alo', 'chips') ENUM();
-- explain; 

-- -----------------------------------------------------------------

drop table persons;
-- 1. 
create table if not exists persons(
	slno int, name varchar(30), place varchar(30), dob date
);
insert into persons values 
	(1002, 'HITESH', 'DELHI', '2000-05-01'), 
    (1001, 'RITESH', 'MUMBAI', '1998-07-12'),
    (1005, 'BALAN', 'KOCHI', '1999-11-05')
;

-- a.
select TABLESPACE_NAME, file_name
from information_schema.files
where `TABLESPACE_NAME` like '%world%'
;
-- b.
select * from persons where slno = 1001;
-- c.
explain select * from persons where slno = 1001;
explain select * from persons where slno = 1001;
explain format=tree select * from persons where slno = 1001;
-- '-> Filter: (persons.slno = 1001)  (cost=0.55 rows=1)\n    -> Table scan on persons  (cost=0.55 rows=3)\n'
-- d.
create index idx_slno on persons( slno) ;
show index from persons;
explain select * from persons where slno = 1001;
explain format=tree select * from persons where slno = 1001;
-- '-> Index lookup on persons using idx_slno (slno=1001)  (cost=0.35 rows=1)\n'
-- e.
alter table persons add constraint primary key(slno);
show index from persons;
explain select * from persons where slno = 1001;
explain format=tree select * from persons where slno = 1001;
-- '-> Rows fetched before execution  (cost=0.00..0.00 rows=1)\n'
-- f.
/*
observation -
	c - because there is no index present on the table person, thats why it is going for table scan 
    and the filter is because of where filter clause,
    type = all, extra = using where condition
    d - we created an index on slno column, and where condition uses the index 
    and hence it goes for an index lookup, 
    type = ref, extra = NULL, key = idx_slno( indexed column)
    e - here we now have slno as both primary key and indexed as well, so it uses both the indexes and
    rows are fetched before hand 
    type is const as where clause contains primary key column filter,
    extra = NULL, key = primary
*/

-- -------------------------------------------------

use hr;

-- 2. 
-- a.
select l.city, r.region_name, c.country_name, l.location_id
from countries c inner join locations l
on c.country_id = l.country_id
inner join regions r
on r.region_id = c.region_id
where  c.country_name IN ( 'Brazil', 'India' )
;
-- b.
explain 
select l.city, r.region_name, c.country_name, l.location_id 
from countries c inner join locations l 
on c.country_id = l.country_id  
inner join regions r  
on r.region_id = c.region_id 
where  c.country_name IN ( 'Brazil', 'India' ) 
;
show index from regions;

-- c. 
create table part_ran_emp ( empno int , ename varchar(30), sal int)
partition by range(sal)
(
	partition p_13000 values less than (13000),
    partition p_20000 values less than (20000),
    partition p_maxii values less than maxvalue
);
insert into part_ran_emp select employee_id, first_name, salary from employees;
-- d. 
explain format=tree
select * 
from part_ran_emp
where sal between 12000 and 17000;
-- partitions used - p_13000,p_20000, extra = using where
-- '-> Filter: (part_ran_emp.sal between 12000 and 17000)  (cost=10.90 rows=12)\n    
-- 				-> Table scan on part_ran_emp  (cost=10.90 rows=104)\n'
-- e.
explain format = tree 
select l.city, r.region_name, c.country_name, l.location_id 
from countries c inner join locations l 
on c.country_id = l.country_id  
inner join regions r  
on r.region_id = c.region_id 
where  c.country_name IN ( 'Brazil', 'India' ) 
;
-- type = all for regions table, ref (referencial ) for country and location table 
-- index used = primary regions(region_id), country(country_id), combined index (country_id + location_id), foreign key (country_id, region_id)
-- extra = using index; using where

-- g.
-- reason - due to the partitioning present it directly goes to the partitions
-- named - p_13000,p_20000
-- does a range scan based on "IN" clause in where clause





