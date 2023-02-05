-- Active: 1670399129309@@127.0.0.1@3307@healthdb
-- show databases;

-- create DATABASE healthdb;

show tables;
select count(*) from treatment;

desc pharmacy;
desc keep;

select * 
from disease NATURAL JOIN treatment
;

