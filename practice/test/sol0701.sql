-- Active: 1670399129309@@127.0.0.1@3307@hr

show tables;

-- 1.

select concat(EmpFname, " ", EmpLname) as 'FullName'
from EmployeeInfo
where EmpFname like 'S%' and DOB between 02/05/1970 and 31/12/1975
;

-- 2.

select Department, count(*) as 'DeptEmpCount'
from EmployeeInfo
group by Department
having count(*) < 2
order by count(*) desc
;

-- 3.

select concat(ei.EmpFname, " ", ei.EmpLname) as 'FullName', ep.EmpPosition as position
from EmployeeInfo as ei inner join EmployeePosition as ep
ON ei.empid = ep.empid and ep.EmpPosition like 'Manager%'
;








