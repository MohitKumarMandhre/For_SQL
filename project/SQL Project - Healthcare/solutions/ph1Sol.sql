-- Active: 1670399129309@@127.0.0.1@3307@healthdb

show TABLEs;
/*
Problem Statement 1:  Jimmy, from the healthcare department, has requested a report that shows how the number of treatments each age category of patients has gone through in the year 2022. 
The age category is as follows, Children (00-14 years), Youth (15-24 years), Adults (25-64 years), and Seniors (65 years and over).
Assist Jimmy in generating the report. 
*/

desc patient;
desc treatment;


create table age_category (type VARCHAR(20), minAge int, maxAge int);
insert into age_category values 
    ('Children', 0, 14),
    ('Youth', 15, 24),
    ('Adults', 25, 64),
    ('Seniors', 65, 130)
;
select * from patient limit 4;

with cte_age as (
    select *, DATE_FORMAT(FROM_DAYS(DATEDIFF(NOW(), dob)), '%Y') + 0 AS age
    from patient
    limit 100
)
SELECT `patientID`, ssn, dob, age
-- , CASE
--     when age BETWEEN 0 and 14 then 'Children',
--     -- when age >= 15 and age <= 24 then 'Youth',
--     -- when age >= 25 and age <= 64 then 'Adults',
--     else 'Seniors' 
-- end as 'age_category'
from cte_age 
where age BETWEEN 25 and 64
;

select count(*)
from patient pa JOIN person pe on
pa.`patientID` = pe.`personID`
-- limit 20
;

desc disease;