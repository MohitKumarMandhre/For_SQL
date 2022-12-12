show databases ;

use mysqljdbc ;

show tables ;

select * from productlines limit 5 ;

select *
from products t1 
inner join productlines t2
ON t1.productline = t2.productline 
limit 10
;