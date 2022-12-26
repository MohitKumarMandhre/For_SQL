-- Active: 1670399129309@@127.0.0.1@3307@world

show tables;

-- 1. Write a SQL statement to create a table countries including columns country_id, country_name, and region_id, 
--and make sure that the combination of columns country_id and region_id will be unique.

create table if not exists `countries`(
    `country_id` int not null ,
    `country_name`  VARCHAR(100), 
    `region_id` int not null
)
;

ALTER table countries ADD constraint `UQ_countryid_country_name_regionid` unique ( country_id, country_name, region_id)
;

ALTER table countries ADD constraint `UQ_countryid_regionid` unique ( country_id, region_id)
;

ALTER table countries ADD constraint `PK_countryid` PRIMARY KEY ( country_id)
;

select * from countries;

show INDEXES from countries;

drop index `UQ_countryid_country_name_regionid` on countries;

-- 2. Write a SQL statement to create a table named jobs including columns job_id, job_title, min_salary, and max_salary, and make sure that, the default value for job_title is blank and min_salary is 8000 and max_salary is NULL will be entered automatically at the time of insertion if no value assigned for the specified columns.

create table if not exists `jobs`(
    job_id int(11) not null, 
    job_title varchar(100) DEFAULT '', 
    min_salary decimal( 6, 2) DEFAULT 8000, 
    max_salary decimal( 6, 2) DEFAULT NULL
);

ALTER table jobs ADD constraint `PK_jobid` PRIMARY KEY ( job_id);

desc jobs;

show INDEXES from jobs;

alter table jobs modify COLUMN job_id varchar(20) ;

-- 3. Write a SQL statement to create a table job_history including columns employee_id, start_date, end_date, job_id, and department_id and make sure that, the employee_id column does not contain any duplicate value at the time of insertion and the foreign key column job_id contain only those values which exist in the jobs table.

create table if not exists `job_history`(
    job_id int(11) not null, 
    job_title varchar(100) DEFAULT '', 
    min_salary decimal( 6, 2) DEFAULT 8000, 
    max_salary decimal( 6, 2) DEFAULT NULL
);

drop table job_history;
alter table `job_history` add constraint 'FK_jobs_jobhistory' FOREIGN KEY (`job_id`) REFERENCES `jobs` (`job_id`)  ON DELETE CASCADE
;

show INDEXES from job_history;
show create table job_history;

-- CREATE TABLE `job_history` (
--   `job_id` int NOT NULL,
--   `job_title` varchar(100) DEFAULT '',
--   `min_salary` decimal(6,2) DEFAULT '8000.00',
--   `max_salary` decimal(6,2) DEFAULT NULL
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

create table if not exists dept18(
    department_id decimal(4, 0) not null,
    department_name varchar(100) DEFAULT '',
    manager_id  decimal(6, 0),
    location_id  decimal(4, 0)
);

alter table dept18 add constraint PRIMARY KEY(department_id, manager_id);

show indexes from dept18;

-- 4. Write a SQL statement to create a table employees including columns employee_id, first_name, last_name, email, phone_number hire_date, job_id, salary, commission, manager_id, and department_id and make sure that the employee_id column does not contain any duplicate value at the time of insertion and the foreign key columns combined by department_id and manager_id columns contain only those unique combination values, which combinations exist in the departments table.

CREATE TABLE if not exists emp18 (
  employee_id decimal(6, 0) not null, 
  first_name varchar(100) NOT NULL, 
  last_name varchar(100) DEFAULT NULL, 
  email varchar(100) NOT NULL, 
  phone_number varchar(100) DEFAULT NULL, 
  hire_date date NOT NULL, 
  job_id varchar(20) NOT NULL, 
  salary decimal(8, 2) DEFAULT NULL, 
  commission  decimal(2, 2) DEFAULT NULL, 
  manager_id decimal(6, 0) DEFAULT NULL, 
  department_id decimal(4, 0) DEFAULT NULL
);

drop table emp18;

ALTER table emp18 ADD constraint `PK_emp18` PRIMARY KEY ( employee_id);

ALTER table emp18 ADD constraint `UQ_departmentid_managerid` unique (department_id, manager_id)
;

ALTER TABLE `emp18` add CONSTRAINT `FK_dept18_emp18` FOREIGN KEY (department_id, manager_id) REFERENCES `dept18` (department_id, manager_id) ON DELETE CASCADE ;

select * from dept18;
show indexes from dept18;

-- 5. Write a SQL statement to create a table employees including columns employee_id, first_name, last_name, email, phone_number hire_date, job_id, salary, commission, manager_id and department_id and make sure that, the employee_id column does not contain any duplicate value at the time of insertion, and the foreign key column department_id, reference by the column department_id of departments table, can contain only those values which are exists in the departments table and another foreign key column job_id, referenced by the column job_id of jobs table, can contain only those values which are exists in the jobs table. The InnoDB Engine have been used to create the tables.

create table if not exists department2(
    department_id decimal(4, 0) not null,
    department_name varchar(100) DEFAULT '',
    manager_id  decimal(6, 0),
    location_id  decimal(4, 0)
);

ALTER table department2 ADD constraint `PK_department2` PRIMARY KEY ( department_id);

CREATE TABLE if not exists employee2 (
    employee_id decimal(6, 0) not null, 
    first_name varchar(100) NOT NULL, 
    last_name varchar(100) DEFAULT NULL, 
    email varchar(100) NOT NULL, 
    phone_number varchar(100) DEFAULT NULL, 
    hire_date date NOT NULL, 
    job_id varchar(20) , 
    salary decimal(8, 2) DEFAULT NULL, 
    commission  decimal(2, 2) DEFAULT NULL, 
    manager_id decimal(6, 0) DEFAULT NULL, 
    department_id decimal(4, 0) DEFAULT NULL
);

show INDEXES from employee2 ;

alter table employee2 add constraint `FK_department2_employee2` FOREIGN KEY (`department_id`) REFERENCES  department2 (`department_id`) ON DELETE CASCADE
;

alter table employee2 add constraint 
`FK_jobs_employee2` FOREIGN KEY (`job_id`) REFERENCES  jobs (`job_id`) ON DELETE CASCADE
;

-- 6. Write a SQL statement to create a table employees including columns employee_id, first_name, last_name, job_id, salary and make sure that, the employee_id column does not contain any duplicate value at the time of insertion, and the foreign key column job_id, referenced by the column job_id of jobs table, can contain only those values which are exists in the jobs table. The InnoDB Engine have been used to create the tables. The specialty of the statement is that, The ON DELETE CASCADE that lets you allow to delete records in the employees(child) table that refer to a record in the jobs(parent) table when the record in the parent table is deleted and the ON UPDATE RESTRICT actions reject any updates.

CREATE TABLE if not exists employee6 (
    employee_id decimal(6, 0) not null, 
    first_name varchar(100) NOT NULL, 
    last_name varchar(100) DEFAULT NULL, 
    email varchar(100) NOT NULL, 
    phone_number varchar(100) DEFAULT NULL, 
    hire_date date NOT NULL, 
    job_id varchar(20) , 
    salary decimal(8, 2) DEFAULT NULL, 
    commission  decimal(2, 2) DEFAULT NULL, 
    manager_id decimal(6, 0) DEFAULT NULL, 
    department_id decimal(4, 0) DEFAULT NULL
)
ENGINE=InnoDB;

alter table employee6 add constraint 
`FK_jobs_employee6` FOREIGN KEY (`job_id`) REFERENCES  jobs (`job_id`) ON DELETE CASCADE ON UPDATE RESTRICT 
;

show INDEXES from employee6 ;

-- 7. Write a SQL statement to create a table employees including columns employee_id, first_name, last_name, job_id, salary and make sure that, the employee_id column does not contain any duplicate value at the time of insertion, and the foreign key column job_id, referenced by the column job_id of jobs table, can contain only those values which are exists in the jobs table. The InnoDB Engine have been used to create the tables. The specialty of the statement is that, The ON DELETE SET NULL action will set the foreign key column values in the child table(employees) to NULL when the record in the parent table(jobs) is deleted, with a condition that the foreign key column in the child table must accept NULL values and the ON UPDATE SET NULL action resets the values in the rows in the child table(employees) to NULL values when the rows in the parent table(jobs) are updated.

CREATE TABLE IF NOT EXISTS jobs7 (
    JOB_ID integer NOT NULL UNIQUE PRIMARY KEY,
    JOB_TITLE varchar(35) NOT NULL DEFAULT ' ',
    MIN_SALARY decimal(6, 0) DEFAULT 8000,
    MAX_SALARY decimal(6, 0) DEFAULT NULL
) ENGINE = InnoDB;
CREATE TABLE if not exists employee7 (
    employee_id decimal(6, 0) not null, 
    first_name varchar(100) NOT NULL, 
    last_name varchar(100) DEFAULT NULL, 
    email varchar(100) NOT NULL, 
    phone_number varchar(100) DEFAULT NULL, 
    hire_date date NOT NULL, 
    job_id int , 
    salary decimal(8, 2) DEFAULT NULL, 
    commission  decimal(2, 2) DEFAULT NULL, 
    manager_id decimal(6, 0) DEFAULT NULL, 
    department_id decimal(4, 0) DEFAULT NULL
)
ENGINE=InnoDB;

alter table employee7 add constraint 
`FK_jobs7_employee7` FOREIGN KEY (`job_id`) REFERENCES  jobs7 (`job_id`) ON DELETE SET NULL ON UPDATE SET NULL 
;

show INDEXES from employee7 ;

-- alter table employee7 drop FOREIGN KEY `FK_jobs_employee7`;


-- 8. Write a SQL statement to create a table employees including columns employee_id, first_name, last_name, job_id, salary and make sure that, the employee_id column does not contain any duplicate value at the time of insertion, and the foreign key column job_id, referenced by the column job_id of jobs table, can contain only those values which are exists in the jobs table. The InnoDB Engine have been used to create the tables. The specialty of the statement is that, The ON DELETE NO ACTION and the ON UPDATE NO ACTION actions will reject the deletion and any updates

CREATE TABLE if not exists employee8 (
    employee_id decimal(6, 0) not null, 
    first_name varchar(100) NOT NULL, 
    last_name varchar(100) DEFAULT NULL, 
    email varchar(100) NOT NULL, 
    phone_number varchar(100) DEFAULT NULL, 
    hire_date date NOT NULL, 
    job_id int , 
    salary decimal(8, 2) DEFAULT NULL, 
    commission  decimal(2, 2) DEFAULT NULL, 
    manager_id decimal(6, 0) DEFAULT NULL, 
    department_id decimal(4, 0) DEFAULT NULL
)
ENGINE=InnoDB;

alter table employee8 add constraint 
`FK_jobs7_employee8` FOREIGN KEY (`job_id`) REFERENCES  jobs7 (`job_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
;

show INDEXES from employee8 ;

show columns from emp18;
DESCRIBE salgrade ;

select * from emp
where JOB not like 'CLERK%';

select * 
from emp 
where sal not BETWEEN 0 and 3000
;

select * 
from emp 
where sal not BETWEEN 'JAMES' and 'TURNER'
;

select * from emp
where ename like '____';

create Table empn as select * from emp;

UPDATE empn set JOB ="sales_rep" where job = "salesman";
UPDATE empn set JOB ="hr_rep" where job = "clerk";

select *
from empn
where job like '%\_%';

UPDATE empn set JOB ="hr_%rep" where job = "hr_rep";

select *
from empn
where job like '%\_%%';

select *
from empn
where year(`HIREDATE`) = 1981 and ename not like '%s%'
;

select ename, comm 
from emp
where comm is NULL;

select NULL - 8;


create table company( compid SMALLINT PRIMARY key, cname varchar(30));

select * from company;

insert into company values(1, 'wipro'), (2, 'tcs');

insert into company values(3, 'oracle'), (4, 'infosys'), (5, 'sg'), (6, 'cts'), (7, 'emc2');

insert into company values(8, NULL), (9,NULL);

insert into company ( select deptno, dname from dept );

create table DEFAULT_TAB (c1 int primary key AUTO_INCREMENT, c2 TIMESTAMP DEFAULT NOW());
desc DEFAULT_TAB;

insert into default_tab values (), (), () ;

select * from default_tab;
