-- Active: 1670399129309@@127.0.0.1@3307@world


show tables;
use world; 

sELECT * from emp;

-- delimiter $$
-- create procedure spTest() 
-- BEGIN
--     SELECT empno, ename from emp ;
-- END $$

-- call sptest() ;

-- delimiter $$
-- create procedure spSal() 
-- BEGIN
--     SELECT ename, sal from emp ;
-- END $$
-- ;
-- call spSal () ;

-- delimiter $$
-- create procedure sp_phn_sold()
-- declare @v_product_code varchar(30), @v_product_price float;
-- begin
-- 	select @v_product_code = product_code, @v_product_price = product_price
--     from products 
--     where product_name = 'Iphone 13 pro';
--     
--     insert into sales values ( cast(getdate() as date, @v_product_code, 1, (1*@v_product_price) );
--     
--     update products set quantity_remaining = (quantity_remaining-1), quantity_sold = (quantity_sold+1)
--     where product_code = @v_product_code;
--     
--     print("Product Sold!");
--     
-- end $$

show tables;
select * from country ;

-- call sp_getCountries(500000000, 'Asia');

-- create schema
CREATE SCHEMA stored_proc_tutorial;
 
-- table creation
CREATE TABLE studentMarks (stud_id SMALLINT(5) NOT NULL AUTO_INCREMENT PRIMARY KEY, total_marks INT, grade VARCHAR(5));
 
 
-- insert sample data
INSERT INTO studentMarks(total_marks, grade) VALUES(450, 'A'), (480, 'A+'), (490, 'A++'), (440, 'B+'),(400, 'C+'),(380,'C')
,(250, 'D'),(200,'E'),(100,'F'),(150,'F'),(220, 'E');

select * from studentMarks;

-- call sp_stu_with_id( 3); 

-- For example: Suppose we want to calculate the average marks of all the students 
-- from the studentMarks table and return the average as an OUT field.

-- call sp_avg_marks(@avg_cont) ;
-- select @cont ;

-- Suppose we need to have a function that takes an initial value of the counter and increment it with a given number.

-- set @cnt = 9;
-- call sp_inc_counter(@cnt, 10);
-- select @cnt ;

-- Suppose we want to find the count of students who is having marks below the average marks of all the students.

call sp_stu_lt_avgM(@res1) ;

select @res1 ;





