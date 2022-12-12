-- Active: 1670399129309@@127.0.0.1@3307@classicmodels
show tables;

select * from orderdetails ;

select count( `customerNumber`)
from customers
where `customerNumber` NOT IN (
    SELECT distinct `customerNumber`
    from orders
)
;

select  cu.`customerName`, o.`orderNumber`, sum( `quantityOrdered` * `priceEach`) as amt
from orderdetails as od inner join customers as cu inner join orders as o
on o.`customerNumber` = cu.`customerNumber` and od.`orderNumber` = o.`orderNumber`
group by `orderNumber`
having amt > 60000
order by amt desc 
;



