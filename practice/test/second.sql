-- employees ( id, name, salary, departmentId )
-- department ( id, name )


select `DEPARTMENT_NAME`, `FIRST_NAME`, `SALARY`
from departments as d inner join (
    select `DEPARTMENT_ID` as DEPARTMENT_ID, salary, `FIRST_NAME`, DENSE_RANK() 
    over( PARTITION BY `DEPARTMENT_ID` ORDER BY `SALARY` desc ) as rn
    from employees
) as t
ON d.`DEPARTMENT_ID` = t.DEPARTMENT_ID
where rn <= 3
;

