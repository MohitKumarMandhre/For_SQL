-- Active: 1670399129309@@127.0.0.1@3307@world

select * from emp;


/*
information_schema.routines
information_schema.triggers
*/

-- when using mysql dump => tables/ views/ triggers will be exported NO  routines
-- mysqldump -u root -p hr > hr.dump.SQL
-- mysqldump -u root -p --routines hr  > hrdump.SQL
-- mysql -u root -p --port=3307 hrBackup > hrdump.sql






















