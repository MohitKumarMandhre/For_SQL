use healthdb;
-- show tables;

/*
Problem Statement 1:  Jimmy, from the healthcare department, has requested a report that shows how the number of treatments each age category of patients has gone through in the year 2022. 
The age category is as follows, Children (00-14 years), Youth (15-24 years), Adults (25-64 years), and Seniors (65 years and over).
Assist Jimmy in generating the report. 
*/

with cte_age as (
    select *, DATE_FORMAT(FROM_DAYS(DATEDIFF(NOW(), dob)), '%Y') + 0 AS age
    from patient
), 
cte_ageCategory as (
	SELECT *, CASE
		when age BETWEEN 0 and 14 then 'Children'
		when age >= 15 and age <= 24 then 'Youth'
		when age >= 25 and age <= 64 then 'Adults'
		else 'Seniors' 
	end as 'age_category'
	from cte_age c
)
select age_category, count(treatmentID) as 'number of treatments'
from cte_ageCategory as c inner join treatment t
ON c.patientID = t.patientID
group by age_category 
order by count(treatmentID) desc
;

/*
Problem Statement 2:  Jimmy, from the healthcare department, 
wants to know which disease is infecting people of which gender more often.
Assist Jimmy with this purpose by generating a report that shows for each disease the male-to-female ratio. 
Sort the data in a way that is helpful for Jimmy.
*/

select d.diseaseName, 
COUNT(IF(pe.gender = 'male', 1, NULL)) / Count(if(pe.gender='female', 1, null))  as 'male-to-female ratio'
from disease d inner join treatment t
on d.diseaseID = t.diseaseID
inner join patient pa
on t.patientID = pa.patientID
inner JOIN person pe on
pa.`patientID` = pe.`personID`
group by d.diseaseName
order by COUNT(IF(pe.gender = 'male', 1, NULL)) / Count(if(pe.gender='female', 1, null)) desc
;

/*
Problem Statement 3: Jacob, from insurance management, 
has noticed that insurance claims are not made for all the treatments. 
He also wants to figure out if the gender of the patient has any impact on the insurance claim. 
Assist Jacob in this situation by generating a report that finds for each gender the number of treatments, 
number of claims, and treatment-to-claim ratio. 
And notice if there is a significant difference between the treatment-to-claim ratio of male and female patients.
*/


