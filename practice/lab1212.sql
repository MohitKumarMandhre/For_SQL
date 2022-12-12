-- Active: 1670399129309@@127.0.0.1@3307@classicmodels

show TABLES;

select `DEPARTMENT_ID`, count( *) as 'emps'
from employees
GROUP BY `DEPARTMENT_ID`
-- HAVING emps > 5
-- ORDER BY emps desc
;

-- works for some DB vendors like postgreSQL
select `EMPLOYEE_ID` as em 
from employees 
where em < 105
;

select * from orders ;
select status, count( status)
from orders
GROUP BY status
WITH ROLLUP
;

-- 1. # of returned orders for customers
select `customerName`, cu.`customerNumber`, count(*) as "numberOfOrders"
from customers as cu INNER JOIN orders as o
ON o.`customerNumber` = cu.`customerNumber`
where status IN ("Disputed", "resolved" )
group by `customerNumber`
;

select `customerName`, cu.`customerNumber`, count(*) as "numberOfOrders"
from customers as cu LEFT JOIN orders as o
ON o.`customerNumber` = cu.`customerNumber`
where status IN ("Disputed", "resolved" )
group by `customerNumber`
;

-- 2. # of returned orders for customers per year
select `customerNumber`, YEAR( `orderDate`) as yearOd,count(*) as "numberOfOrders"
from orders
where status IN ("Disputed", "resolved" )
group by customerNumber, yearOd
;

-- 3. add total order, returned order percentage to task(1)
select `customerName`, cu.`customerNumber`, count(*) as "numberOfOrders", total_orders, ( count(*)/total_orders * 100 ) as returned_percentage
from 
(
    select `customerNumber`, count( orderNumber) as total_orders
    from orders
    group by customerNumber
) as t1 inner join
customers as cu  INNER JOIN orders as o
ON o.`customerNumber` = cu.`customerNumber` and t1.`customerNumber` = cu.`customerNumber`
where status IN ("Disputed", "resolved" )
group by `customerNumber`
;

-- 4. add total order, returned order percentage to task(1) + year wise
select `customerName`, cu.`customerNumber`, count(*) as "numberOfOrders", total_orders, ( count(*)/total_orders * 100 ) as returned_percentage, YEAR( `orderDate`)
from 
(
    select `customerNumber`, count( orderNumber) as total_orders
    from orders
    group by customerNumber
) as t1 inner join
customers as cu  INNER JOIN orders as o
ON o.`customerNumber` = cu.`customerNumber` and t1.`customerNumber` = cu.`customerNumber`
where status IN ("Disputed", "resolved" )
group by `customerNumber`, YEAR( `orderDate`)
;

-- 5. 4 + customers who have 20% of return rate yearly basis
select `customerName`, cu.`customerNumber`, count(*) as "numberOfOrders", total_orders, ( count(*)/total_orders * 100 ) as returned_percentage, YEAR( `orderDate`)
from 
(
    select `customerNumber`, count( orderNumber) as total_orders
    from orders
    group by customerNumber
) as t1 inner join
customers as cu  INNER JOIN orders as o
ON o.`customerNumber` = cu.`customerNumber` and t1.`customerNumber` = cu.`customerNumber`
where status IN ("Disputed", "resolved" )
group by `customerNumber`, YEAR( `orderDate`)
having returned_percentage > 20
;

-- 6. 3 + all customer
select `customerName`, cu.`customerNumber`, count(*) as "numberOfOrders", total_orders, ( count(*)/total_orders * 100 ) as returned_percentage
from 
(
    select `customerNumber`, count( orderNumber) as total_orders
    from orders
    group by customerNumber
) as t1 inner join
customers as cu  LEFT JOIN orders as o
ON o.`customerNumber` = cu.`customerNumber` and t1.`customerNumber` = cu.`customerNumber`
where status IN ("Disputed", "resolved" )
group by `customerNumber`

UNION ALL

select `customerName`, cu.`customerNumber`, count(*) as "numberOfOrders", total_orders, count(*)/total_orders * 100 as returned_percentage
-- CASE
--     when total_orders = count(*) then 0 else ( count(*)/total_orders * 100 ) 
-- END as returned_percentage
from 
(
    select `customerNumber`, count( orderNumber) as total_orders
    from orders
    group by customerNumber
) as t1 inner join
customers as cu  LEFT JOIN orders as o
ON o.`customerNumber` = cu.`customerNumber` and t1.`customerNumber` = cu.`customerNumber`
where status NOT IN ("Disputed", "resolved" )
group by `customerNumber`
;

select distinct `customerName`
from customers
;