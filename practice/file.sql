CREATE DATABASE testdb;

use testdb;

CREATE TABLE Persons (
    PersonID int,
    LastName varchar(255),
    FirstName varchar(255),
    Address varchar(255),
    City varchar(255)
);


Insert into Persons values (1, "Doe", "John", "India", "Goa" ) ;

Select * from Persons;