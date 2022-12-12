-- Active: 1670399129309@@127.0.0.1@3307@hr


SELECT `DEPARTMENT_ID` ,sum(`SALARY`) as totalSal, min( `SALARY`) as minimumSal, max( `SALARY`) as maximumSal, AVG( `SALARY`) as averageSal
from employees
WHERE `DEPARTMENT_ID` = 90
group by `DEPARTMENT_ID`
;
