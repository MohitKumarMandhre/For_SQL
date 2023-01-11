-- Active: 1670399129309@@127.0.0.1@3307@hr

show tables;

select * from employees;

desc employees;

create table if not exists empStats(
    empCnt int
);

drop table empstats;

create table if not exists empStats 
select count(*) from employees
;

alter table empstats RENAME column `count(*)` to empCnt ;
select * from empstats;



-- before INSERT
-- maintain empstats table to maintain cnt of employees
-- after INSERT
-- EmpReminders


delimiter ;
create Trigger after_insert_emp
    after insert on employees
    for each ROW
    update empStats 
    set empCnt = empCnt + 1;
;

desc employees;
select CURDATE();

insert into employees values (2000, 'Laya', 'Sunil', 'laya@gmail.com', '123456789', CURDATE(), 'IT_PROG', 25000, 0.4, 100, 90 );

SELECT * FROM empstats;









