
show variables like 'data_dir';

show variables like 'datadir';
-- C:\ProgramData\MySQL\MySQL Server 8.0\Data\

show variables like 'basedir';

select TABLESPACE_NAME, file_name
from information_schema.files
where `TABLESPACE_NAME` like '%hr%'
;

show variables;

-- create a table

-- rows inside datapages
-- datapages inside extends
-- extends inside datafiles
-- datafiles inside tablespaces


explain 
select ename, dname from emp 
natural join dept;


explain format=tree select * from fruits where id > 101;