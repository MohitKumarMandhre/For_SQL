-- Active: 1670399129309@@127.0.0.1@3307@classicmodels

show tables;

delimiter $
create procedure sp_str_of_odds()
begin
    declare x int;
    declare str varchar( 255);
    set x = 0;
    set str = '' ;

    loop_label: LOOP
        if x >= 10 THEN
            LEAVE loop_label;
        end if;
        set x = x+1;
        if (x mod 2 = 0) THEN
            ITERATE loop_label;
        ELSE
            set str = concat(str, x, ', ');
        end if;
    end loop;
    select str;
end $

delimiter ;

drop procedure sp_str_of_odds;

call sp_str_of_odds();

delimiter $
create procedure sp_str_of_evens()
begin 
    declare x int;
    declare str varchar( 255);
    set x = 0;
    set str = '' ;

    while x <= 10 DO
        set x = x+1;
        if (x mod 2 = 0) THEN
            set str = concat(str, x, ', ');
        end if;
    end while;

    select str;
end $

drop procedure sp_str_of_evens;

delimiter ;

call sp_str_of_evens();


delimiter $
create procedure sp_str_odds()
begin 
    declare x int;
    declare str varchar( 255);
    set x = 0;
    set str = '' ;

    REPEAT
        set x = x+1;
        if (x mod 2 <> 0) THEN
            set str = concat(str, x, ', ');
        end if;
    until x > 5
    end repeat;

    select str;
end $

drop procedure sp_str_odds;

delimiter ;

call sp_str_odds();

-- MySQL ROLLUP clause is used to generate subtotals and grand totals.
-- The following statement creates a new table named sales that stores the order values summarized by product lines and years.
CREATE TABLE sales
SELECT productLine,
    YEAR(orderDate) orderYear,
    SUM(quantityOrdered * priceEach) orderValue
FROM orderDetails
    INNER JOIN orders USING (orderNumber)
    INNER JOIN products USING (productCode)
GROUP BY productLine,
    YEAR(orderDate)
;

select * from sales;

-- A grouping set is a set of columns to which you want to group. For example, the following query creates a grouping set denoted by (productline)
SELECT productline,
    SUM(orderValue) totalOrderValue
FROM sales
GROUP BY productline;
-- The following query creates an empty grouping set denoted by the ():
SELECT SUM(orderValue) totalOrderValue
FROM sales;
-- If you want to generate two or more grouping sets together in one query, you may use the UNION ALL operator as follows:
SELECT productline,
    SUM(orderValue) totalOrderValue
FROM sales
GROUP BY productline
UNION ALL
SELECT NULL,
    SUM(orderValue) totalOrderValue
FROM sales;
-- Because the UNION ALL requires all queries to have the same number of columns, we added NULL in the select list of the second query to fulfill this requirement.
-- The NULL in the productLine column identifies the grand total super-aggregate line.
-- This query is able to generate the total order values by product lines and also the grand total row. However, it has two problems:
---- The query is quite lengthy.
---- The performance of the query may not be good since the database engine has to internally execute two separate queries and combine the result sets into one.
------------------------------------------------------------
-- To fix these issues, you can use the ROLLUP clause.
-- The ROLLUP clause is an extension of the GROUP BY clause with the following syntax:
-- SELECT select_list
-- FROM table_name
-- GROUP BY c1,
--     c2,
--     c3 WITH ROLLUP;
-- The ROLLUP generates multiple grouping sets based on the columns or expressions specified in the GROUP BY clause. 
-- The ROLLUP clause generates not only the subtotals but also the grand total of the order values. For example:
SELECT productLine,
    SUM(orderValue) totalOrderValue
FROM sales
GROUP BY productline WITH ROLLUP;
-- If you have more than one column specified in the GROUP BY clause, the ROLLUP clause assumes a hierarchy among the input columns.
-- For example:
-- GROUP BY c1, c2, c3 WITH ROLLUP
-- The ROLLUP assumes that there is the following hierarchy:
-- c1 > c2 > c3
-- And it generates the following grouping sets: -- (c1, c2, c3)
-- (c1, c2)
-- (c1)
-- ()
-- And in case you have two columns specified in the GROUP BY clause:
-- GROUP BY c1, c2 WITH ROLLUP
-- then the ROLLUP generates the following grouping sets:
-- (c1, c2)
-- (c1)
-- ()
-- See the following query example. The ROLLUP generates the subtotal row every time the product line changes and the grand total at the end of the result.
-- The hierarchy in this case is:
-- productLine > orderYear
SELECT productLine,
    orderYear,
    SUM(orderValue) totalOrderValue
FROM sales
GROUP BY productline,
    orderYear WITH ROLLUP;
-- If you reverse the hierarchy, the ROLLUP generates the subtotal every time the year changes and the grand total at the end of the result set.
-- The hierarchy in this example is:
-- orderYear > productLine
SELECT orderYear,
    productLine,
    SUM(orderValue) totalOrderValue
FROM sales
GROUP BY orderYear,
    productline WITH ROLLUP;


-- To check whether NULL in the result set represents the subtotals or grand totals, you use the GROUPING() function.
-- The GROUPING() function returns 1 when NULL occurs in a supper-aggregate row, otherwise, it returns 0.
-- The GROUPING() function can be used in the select list, HAVING clause, and (as of MySQL 8.0.12 ) ORDER BY clause.
-- Consider the following query.
-- The GROUPING(orderYear) returns 1 when NULL in the orderYear column occurs in a super-aggregate row, 0 otherwise.
-- Similarly, the GROUPING(productLine) returns 1 when NULL in the productLine column occurs in a super-aggregate row, 0 otherwise.
SELECT orderYear,
    productLine,
    SUM(orderValue) totalOrderValue,
    GROUPING(orderYear),
    GROUPING(productLine)
FROM sales
GROUP BY orderYear,
    productline WITH ROLLUP;
-- We often use GROUPING() function to substitute meaningful labels for super-aggregate NULL values instead of displaying it directly.
-- The following example shows how to combine the IF() function with the GROUPING() function to substitute labels for the super-aggregate NULL values in orderYear and productLine columns:
SELECT IF(
        GROUPING(orderYear),
        'All Years',
        orderYear
    ) orderYear,
    IF(
        GROUPING(productLine),
        'All Product Lines',
        productLine
    ) productLine,
    SUM(orderValue) totalOrderValue
FROM sales
GROUP BY orderYear,
    productline WITH ROLLUP;








