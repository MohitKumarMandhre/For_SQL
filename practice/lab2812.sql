-- Active: 1670399129309@@127.0.0.1@3307@world

show tables;

SHOW DATABASES;

select `HIREDATE`, REVERSE( `HIREDATE`)
from emp;

-- DATE_FORMAT
-- %a - 3 letter DAY
-- %W - full day name
-- %w - day count in week
-- %M - full month
-- %b - 3 letter MONTH
-- %y - 2 digit
-- %Y - 4 digit
-- %d - day count in MONTH
-- %D - add th, rd
-- %j - day count in year

SELECT `HIREDATE`, DATE_FORMAT(`HIREDATE`, '%D') from emp;

-- emp hired on first thrusday
select ename, `HIREDATE`, day( `HIREDATE`), date_format( `HIREDATE`, '%d') from emp where date_format( `HIREDATE`, '%w') = 4 and date_format( `HIREDATE`, '%d') < 7 ;

-- ename joined on 17th Wednesday December 1980
select concat(ename, '  joined on ', DATE_FORMAT(`HIREDATE`, '%D'), ' ',DAYNAME(`HIREDATE`),' ', DATE_FORMAT(`HIREDATE`, '%M'), ' ',DATE_FORMAT(`HIREDATE`, '%Y') ) as details
from emp;

-- extract function
-- year, month, DAY

select hiredate, extract( year from hiredate), extract( month from hiredate), extract( day from hiredate)
from emp;

-- returning difference
-- datediff :- (2) date1, date2 gives day difference
--timestampdiff :- (3) year, month, DAY

select DATEDIFF( NOW(), `HIREDATE`) as ddiff, timestampdiff(year, `HIREDATE`, NOW()) as year, timestampdiff(month, `HIREDATE`, NOW()) as mnt, timestampdiff(day, `HIREDATE`, NOW()) as day
from emp;

-- display how many years, months old are you
set @var1 = '1999-02-23';
set @var2 = CAST(@var1 AS datetime);
SELECT @var1, datediff(NOW(), @var2) / 365 as yr, MOD(TIMESTAMPDIFF( month, @var2, NOW() ), 12) as yearOf, day(NOW() - date_format(@var2, '%d')) as daya
;

SELECT @var1, 
TIMESTAMPDIFF( YEAR, @var2, now() ) as _year, 
TIMESTAMPDIFF( MONTH, @var2, now() ) % 12 as _month, 
FLOOR( TIMESTAMPDIFF( DAY, @var2, now() ) % 30 ) as _day
;

-- modifying dates
-- date_add year, months, days - interval '1' YEAR
-- date_sub year, months, days - interval '1' YEAR

select CURDATE() as 'yr', date_add( CURDATE(), interval '2' year) as 'yr+2', date_sub( CURDATE(), interval '2' year) as 'yr-2' ;

select CURDATE() as 'yr', date_add( CURDATE(), interval '2' month) as 'yr+2', date_sub( CURDATE(), interval '2' month) as 'yr-2' ;

-- last_day - returns last day of month specified
select last_day( @var2);

-- MAKEDATE(year,days)
select MAKEDATE(2022, 100) ;

select ename, sal, if (sal>3000, 'GOODsal', 'LOWsal'), `COMM`, if( sign(sal-comm) = 1, "moreCOMM", "lessCOMM") as 
'comments'
from emp;

select ename, job, sal,
CASE
 WHEN job like 'Clerk%' then 1.5*sal
 WHEN job like 'Salesman%' then 1.7*sal
 WHEN job like 'Analyst%' then 1.9*sal
 else 2.1*sal
end as 'bonus'
from emp
order by 2 asc;

set @a = CURDATE();
set @b = CURDATE()-1;
set @c = CURDATE()+1;

select @b, 
CASE
    WHEN @b = CURDATE() then repeat('hb', 5)
    WHEN datediff(@b, CURDATE()) > 0 then repeat('advanced_hb', 2)
    else repeat('belated_hb', 2)
end as wish
;

-- NULLIF(a, b) - if a=b RETURNS null else a
-- IFNULL(a, b) - if a exp is null return b

select nullif(@a, @b) ;

select ename, length( ename), sal, length(sal), NULLIF(length( ename), length( sal)) as 'nullifUSE'
from emp;

select ename, sal, comm, ifnull((sal+comm), sal) as totSal
from emp;

select STR_TO_DATE('10-May-2002', '%d-%M-%Y');

select STR_TO_DATE('10-10-22', '%d-%m-%y');

-- AGGREGATE FUNCTION
-- count(*) - includes null
-- count(id) - excludes null
set @@sql_mode=only_full_group_by;

select `DEPTNO`, count( `EMPNO`)
from emp
GROUP BY `DEPTNO`
;

select count(comm), count(`HIREDATE`) from emp;

select min(`ENAME`), max(`DEPTNO`), max(job)
from emp;

SELECT YEAR( `HIREDATE`), count(*)
from emp
group by YEAR( `HIREDATE`)
order by 1 desc
;
-- find #emps in each qtr per year
select year(`HIREDATE`) as yr, QUARTER(`HIREDATE`) as qtr, count( *) as '#emps'
from emp
group by year(`HIREDATE`), QUARTER(`HIREDATE`)
order by year(`HIREDATE`) asc, QUARTER(`HIREDATE`) asc ;

-- find out #emps joined in each month and sort
select year(`HIREDATE`) as yr, monthname(`HIREDATE`) as month, count( *) as '#emps'
from emp
group by year(HIREDATE), monthname(HIREDATE),date_format(HIREDATE,"%m")
order by year(HIREDATE), date_format(HIREDATE,"%m") asc;

select job, 
case 
    when job like 'clerk%' then count(*)
    when job like 'salesman%' then max(sal)
    when job like 'analyst%' then sum(sal)
    else avg(sal)
end as "new_col"
from emp
group by job;

-- find out #emps who take same salaries
select sal, count( *)
from emp
group by `SAL`
having count(*) > 1;

-- 7.
select `DEPTNO`, AVG(sal)
from emp 
GROUP BY `DEPTNO`
having count( *) > 5
;

-- 8.
select job
from emp 
GROUP BY `job`
having max(sal) >= 3000
;

-- 9.
select job, min( sal), max(sal), avg(sal), sum(sal), `DEPTNO`
from emp 
where `DEPTNO` = 20
GROUP BY `job`
having avg(sal) > 1000
;

-- wherever where works having can't be used.






