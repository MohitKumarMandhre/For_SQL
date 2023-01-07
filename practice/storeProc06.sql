-- Active: 1670399129309@@127.0.0.1@3307@world

show databases;

use classicmodels;
show tables;

-- stored PROCEDURE

-- dated 06/01/2023

delimiter $$

create procedure sp_getEmps()
begin
	select * from products limit 3;
end $$

delimiter ;

call sp_getEmps();

delimiter $$
create procedure sp_getOffice( IN con varchar(100) )
begin
	select * from offices
    where country = con;
end $$

-- func

delimiter $$
create function customerLevel( 
	credit decimal(5, 2)
)
returns varchar(30)
deterministic
begin
	declare elligible varchar(30);
		if credit > 50000 then set elligible = 'yes';
        else set elligible = 'no';
        end if ;
        return elligible;
end $$
