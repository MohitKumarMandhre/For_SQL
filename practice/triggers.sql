-- Active: 1670399129309@@127.0.0.1@3307@org

show tables;

-- disc 10

-- 1. Create a stored procedure named getEmployees() to display the following employee and their office info: name, city, state, and country.

delimiter $$

create procedure sp_getEmps()
begin
	select * from products limit 3;
end $$

delimiter ;

call sp_getEmps();

select * from payments;

-- 2. Create a stored procedure named getPayments() that prints the following customer and payment info:customerName, checkNumber, paymentDate, and amount.

DELIMITER $$
CREATE procedure sp_getPayments()
begin
	select * from payments;
end $$

-- disc 13

-- 1. Write a stored function called computeTax that calculates income tax based on the salary for every worker in the Worker table as follows:

-- 10% - salary <= 75000
-- 20% - 75000 < salary <= 150000
-- 30% - salary > 150000

-- Write a query that displays all the details of a worker including their computedTax.

delimiter $
create function computeTax(
    salary int
)
returns decimal(10, 2)
DETERMINISTIC
BEGIN
    declare taxVar decimal(10, 2);
    if salary <= 75000
    then set taxVar = (salary*0.10);
    elseif salary > 75000 and salary <= 150000
    then set taxVar = ( salary*0.20);
    ELSE set taxVar = ( salary*0.3);
    end IF;
    return taxVar;
END $;

select *, computeTax(salary) as bns from worker;

-- 2. Define a stored procedure that takes a salary as input and returns the calculated income tax amount for the input salary. Print the computed tax for an input salary from a calling program. 
-- (Hint - Use the computeTax stored function inside the stored procedure)

delimiter $
create procedure sp_compTax(
    IN sal INT, OUT compTax DECIMAL(10,2)
)
BEGIN
    set compTax = computeTax(sal) ;
end $

call sp_compTax(80000, @compTax);
select @compTax;

-- trying

delimiter $
create function sp_elligible(
    sal int
)
returns VARCHAR(40)
DETERMINISTIC
BEGIN
    DECLARE res VARCHAR(40);
    if sal > 200000 THEN
        set res = 'Le le loan bhai';
    ELSE
        set res = 'Loan lna sakt mna hai';
    end if;
    return res;
end $

delimiter ;

drop function sp_elligible;

select *, sp_elligible(`SALARY`) as "elligibility" from worker;

-- TRIGGERS

select * from worker;
select * from title;

delimiter $
create trigger after_insert_worker
    after INSERT
    on worker
    for each ROW
begin 
    insert into title
    values(NEW.worker_id, "Trainnee", now() ) ;
end $

delimiter ;

insert into worker
values( 9, 'Mohit', 'Kumar', 10000, now(), 'Analytics');

show triggers;

-- DROP TRIGGER IF EXISTS after_worker_insert;
-- SHOW CREATE PROCEDURE getAllProducts;
-- SHOW PROCEDURE STATUS LIKE 'getAllProducts';

-- SELECT 
--     *
-- FROM
--     information_schema.routines
-- WHERE
--     routine_type = 'PROCEDURE'
--         AND routine_schema = 'classicmodels';

create table class(
    cid int, 
    cname varchar(40)
);

alter table class add CONSTRAINT `pk_class` primary key (cid);

delimiter $
create procedure sp_insert_det()
begin
    insert into class(cid, cname) values (null, 'Bobby');
    select "successfully inserted!";
end $

delimiter ;

drop PROCEDURE sp_insert_det;

call sp_insert_det();

-- conditional handler
-- exit HANDLER

delimiter $
create procedure sp_exitH_insert(
    in cid int, in cname varchar(30)
)
begin
    DECLARE not_null int default 0;
    BEGIN
    DECLARE exit HANDLER for 1048 set not_null = 1; 
        insert into class(cid, cname) values (cid, cname);
        select "successfully inserted!";
    end;
    if not_null = 1 then
        select "Unsuccessfull insert, due to null values!" ;
    END IF;
end $

delimiter ;

-- continue HANDLER
-- error handling
-- cursor
-- no data fetch condidion
-- when select statement return more THAN one row, cursor iterate through result dataset

delimiter $$
create procedure sp_my1()
begin 
    declare last_row int DEFAULT 0;
    declare cid int;
    declare cname varchar(30);
    declare c1 cursor for SELECT * from class;
    declare continue HANDLER for not found set last_row = 1;
    open c1;
        myloop:loop
            fetch c1 into cid, cname;
            select cid, cname;
            if last_row = 1 THEN
                SELECT 'no record found' as 'msg' ;
                leave myloop;
            end if;
        end loop myloop;
    close c1;
end $$



