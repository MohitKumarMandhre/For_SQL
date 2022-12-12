-- Active: 1670399129309@@127.0.0.1@3307@classicmodels

show tables ;

-- Q1
select c1.city , c1.customerName, c2.customerName 
from customers as c1 inner join customers as c2
ON c1.`city` = c2.`city`
where c1.`customerName` <> c2.`customerNumber`
;

-- Q2
select pr.`productCode`, pr.`productName`, pl.`textDescription`
from productlines as pl inner join products as pr
ON pr.`productLine` = pl.`productLine`
;

-- Q3
select od.`orderNumber`, o.`status`, sum( od.`priceEach` * od.`quantityOrdered` ) as total
from orders as o inner join orderdetails as od 
ON o.`orderNumber` = od.`orderNumber`
group by od.`orderNumber`
;

-- Q4
select o.`orderNumber`, o.`orderDate`, pr.`productLine`, pr.`productName`, od.`quantityOrdered`, od.`priceEach`
from products as pr inner join orders as o inner join orderdetails as od 
ON o.`orderNumber` = od.`orderNumber` and od.`productCode` = pr.`productCode`
order by od.`orderNumber`, od.`orderLineNumber`
limit 50
;

-- Q5
select o.`orderNumber`, o.`orderDate`, cu.`customerName`, od.`orderLineNumber`, pr.`productName`, od.`quantityOrdered`, od.`priceEach`
from products as pr inner join customers as cu inner join orders as o inner join orderdetails as od 
ON o.`orderNumber` = od.`orderNumber` and od.`productCode` = pr.`productCode` and cu.`customerNumber` = o.`customerNumber`
order by od.`orderNumber`, od.`orderLineNumber`
limit 50
;

-- Q6
select o.`orderNumber`, pr.`productName`, pr.`MSRP`, od.`priceEach`
from products as pr inner join orders as o inner join orderdetails as od 
ON o.`orderNumber` = od.`orderNumber` and od.`productCode` = pr.`productCode`
where pr.`productCode` = 'S10_1678' and od.`priceEach` < pr.`MSRP`
-- order by od.`orderNumber`, od.`orderLineNumber` 
limit 50
;

-- Q7
select cu.`customerNumber`, cu.`customerName`, o.`orderNumber`, o.status
from customers as cu left join orders as o
ON o.`customerNumber` = cu.`customerNumber`
;

-- Q8
select cu.`customerNumber`, cu.`customerName`, o.`orderNumber`, o.status
from customers as cu left join orders as o
ON o.`customerNumber` = cu.`customerNumber`
where  o.`orderNumber` is NULL
;


show tables;

SELECT `orderNumber`, `productCode` 
from orderdetails 
group by `orderNumber`, `productCode` 
;


create table demo9 (
    a int UNIQUE AUTO_INCREMENT PRIMARY Key,
    b int, 
    c int
);

insert into demo9 values (null, 10, 20), (null, 100, 200), (null, 200, 100) ;

insert into demo9 VALUES ( null, 10, 20);
insert into demo9 VALUES ( null, 40, 40);
insert into demo9 VALUES ( null, 40, 40);

select distinct b, c
from demo9 
;

select distinct 
case 
    when  b > c then c else b
end as b,
case
    when  b > c then b else c
end as c
from demo9 
;

select b, c 
from demo9 
GROUP BY b, c 
;

select * from orders limit 20;
select * from orderdetails limit 20;

select `productCode`, quantityOrdered, `quantityOrdered` * `priceEach` as total
from orderdetails
where `productCode` = 'S18_2248'
;

select * 
from orderdetails as o1
where `quantityOrdered` IN (
    select `quantityOrdered` - 1 
    from orderdetails as o2 
    where o2.`productCode` = 'S18_2248'
) ;

SELECT *
from orderdetails as o1 inner join orderdetails o2
where o1.`orderLineNumber` = o2.`orderLineNumber` and o1.`quantityOrdered` = o2.`quantityOrdered` - 1 
and o2.`productCode` = 'S18_2248'
;

select a, b, c from demo9
where c > (
    select avg(c) from demo9 as d2
);

select a, b, newb, c
from
( select  a, b, c, case 
when c > 90 then b*2 else b*3
end as newb
from demo9 ) as b;

