
-- create database FlightDB; 
use FlightDB;


create table country(
iata_country_code char(2) primary key,
name varchar(45));

create table if not exists client(
client_id int primary key,
first_name varchar(45) not null,
middle_name varchar(45),
last_name varchar(45) not null,
phone varchar(45) unique,
email varchar(45) not null,
passport varchar(45) unique,
iata_country_code char(2),
INDEX names(last_name,first_name),
index cntry_code(iata_country_code),
constraint fk_country_code 
foreign key(iata_country_code)
references country(iata_country_code)
on update cascade);

create table if not exists airport(
iata_airport_coode char(3) primary key,
name varchar(45) not null,
city varchar(45) not null,
iata_country_code char(2),
index ct(city),
index cntry_code(iata_country_code),
constraint fk_country_code_airport foreign key(iata_country_code)
references country(iata_country_code)
on update cascade);

alter table airport
rename column iata_airport_coode to iata_airport_code;

create table direction(
origin_iata_airport_code char(3),
dest_iata_airport_code char(3),
constraint pk_origin_desr primary key(origin_iata_airport_code,dest_iata_airport_code),
constraint fk_origin foreign key(origin_iata_airport_code)
references airport(iata_airport_code),
constraint fk_dest foreign key(dest_iata_airport_code)
references airport(iata_airport_code));

create table schedule(
schedule_id int primary key,
origin_iata_airport_code char(3),
dest_iata_airport_code char(3),
departure_time_gmt timestamp,
arrival_time_gmt timestamp,
constraint fk_originate foreign key(origin_iata_airport_code)
references direction(origin_iata_airport_code),
constraint fk_destination foreign key(dest_iata_airport_code)
references direction(dest_iata_airport_code));

create index origin_dest on schedule(origin_iata_airport_code,dest_iata_airport_code);

create table flight_status(
flight_status_id int primary key,
name varchar(45) not null);

create table flight(
flight_call int primary key,
schedule_id int,
flight_status_id int,
constraint fk_schedule foreign key(schedule_id)
references schedule(schedule_id)
on update cascade,
constraint fk_status_id foreign key(flight_status_id)
references flight_status(flight_status_id)
on update cascade);

create index scheduling on flight(schedule_id,flight_status_id);

create table aircraftnamufacturer(
aircraft_manufacturer_id int primary key,
name varchar(45) not null);

create table aircraft(
aircraft_id int primary key,
aircraft_manufacturer_id int,
model varchar(45),
index manu_id(aircraft_manufacturer_id),
constraint fk_manufacturer_id foreign key(aircraft_manufacturer_id)
references aircraftnamufacturer(aircraft_manufacturer_id)
on update cascade);

create table travelclass(
travel_class_id int primary key,
name varchar(45) not null,
description text,
constraint travel_classes check (name in ('Business','Economy')),
index class_name(name));

create table if not exists aircraftinstance(
aircraft_instance_id int primary key,
aircraft_id int,
index aircraft_idx(aircraft_id),
constraint fk_aircraft_id foreign key(aircraft_id)
references aircraft(aircraft_id));

create table flightaircraftinstance(
flight_call int,
aircraft_instance_id int,
constraint pk_flightaircraftinstance primary key(flight_call,aircraft_instance_id),
constraint fk_aircraft_instance foreign key(aircraft_instance_id)
references aircraftinstance(aircraft_instance_id)
on update cascade,
index aircraftinstance_idx(aircraft_instance_id));
select * from flightaircraftinstance;

alter table flightaircraftinstance
add constraint ck_flight_call foreign key(flight_call)
references flight(flight_call);

create table if not exists flight(
flight_call int primary key,
schedule_id int,
flight_status_id int,
constraint fk_schedule_id foreign key(schedule_id)
references schedule(schedule_id)
on update cascade,
constraint fk_flight_status_id foreign key(flight_status_id)
references flightstatus(flight_status_id)
on update cascade,
index flight_idx(flight_status_id,schedule_id));

create table if not exists aircraftseat(
aircraft_id int,
seat_id int,
travel_class_id int,
index aircraftseat_idx(aircraft_id,travel_class_id),
constraint pk_aircraft_id primary key(aircraft_id,seat_id),
constraint fk_travel_class_id foreign key(travel_class_id)
references travelclass(travel_class_id)
on update cascade,
constraint fk_aircraft_id_aircraftseat foreign key(aircraft_id)
references aircraft(aircraft_id)
on update cascade);

create index idx_seat_id_aircraftseat on aircraftseat(seat_id);

create table if not exists flightseatprice(
flight_call int,
aircraft_id int,
seat_id int,
price_usd decimal(8,2) not null,
constraint pk_flightseatprice primary key(flight_call,aircraft_id,seat_id),
constraint fk_seat_id foreign key(seat_id)
references aircraftseat(seat_id)
on update cascade,
constraint fk_aircraft_id_flightseatprice foreign key(aircraft_id)
references aircraftseat(aircraft_id)
on update cascade,
constraint fk_flight_call_flightseatprice foreign key(flight_call)
references flight(flight_call)
on update cascade,
index idx_flightseatprice(flight_call,aircraft_id,seat_id));

create table if not exists booking(
client_id int,
flight_call int,
aircraft_id int,
seat_id int,
constraint pk_booking primary key(client_id,flight_call, aircraft_id, seat_id),
constraint fk_seat_id_booking foreign key(seat_id)
references flightseatprice(seat_id)
on update cascade,
constraint fk_client_id_booking foreign key(client_id)
references client(client_id)
on update cascade
on delete cascade,
constraint fk_flight_call_booking foreign key(flight_call)
references flightseatprice(flight_call)
on update cascade,
constraint fk_aircraft_id_booking foreign key(aircraft_id)
references flightseatprice(aircraft_id)
on update cascade,
index idx_booking(aircraft_id,client_id,flight_call,seat_id));

show tables;

insert into country values('IN', 'India');
insert into country values('CA', 'Canada');
insert into country values('PK', 'Pakistan');
insert into country values('US', 'United States');
insert into country values('UK', 'United Kingdom');

insert into client values(
1221, 'Peter', 'Mac', 'Espacito', '0991-673524172', 'pme@hotmail.com', 'NHOPS4362712', 'IN');
insert into client values(
1556, 'Anup', 'Kumar', 'Jha', '47382512732', 'amje@hotmail.com', 'HUDA42527SB', 'US');
insert into client values(
3466, 'Tony', 'Tom', 'David', '04637-367828373', 'ttd@yahoo.com', 'NDHKDG67373', 'UK');
insert into client values(
2342, 'Chris', 'Salva', 'Fehrendes', '06452-248489373', 'chris@hotmail.com', 'DAVCSJD72838', 'CA');
insert into client values(
8874, 'Ahmed', 'Saif', 'Ali', '54638635414', 'saif@yahoo.com', 'GDHWT2738844', 'PK');

Insert into airport values('CCU','Netaji Subhas International Airport', 'Kolkata', 'IN');
Insert into airport values('KIA','Jinnah International Airport', 'Karachi', 'PK');
Insert into airport values('YEG','Edmonton International Airport', 'Alberta', 'CA');
Insert into airport values('BHM','Birmingham International Airport', 'Birmingham', 'US');
Insert into airport values('LCB','London City Airport', 'London', 'UK');

insert into direction values('CCU','BHM');
insert into direction values('LCB','BHM');
insert into direction values('CCU','KIA');
insert into direction values('YEG','LCB');
insert into direction values('BHM','CCU');

insert into schedule values(111, 'CCU','BHM','2022-09-10 01:56:47','2022-09-11 15:34:38' );
insert into schedule values(112, 'LCB','BHM','2022-09-07 03:53:07','2022-09-07 10:34:24' );
insert into schedule values(113, 'CCU','KIA','2022-10-09 16:36:47','2022-10-09 22:34:54' );
insert into schedule values(114, 'YEG','LCB','2022-11-24 14:57:38','2022-11-25 02:35:12' );
insert into schedule values(115, 'BHM','CCU','2022-10-11 08:49:17','2022-10-11 21:58:20' );

INSERT INTO FLIGHT_STATUS VALUES(4553,'Delayed');
INSERT INTO FLIGHT_STATUS VALUES(4554,'Arrived');
INSERT INTO FLIGHT_STATUS VALUES(4552,'On time');
INSERT INTO FLIGHT_STATUS VALUES(4551,'Scheduled');
INSERT INTO FLIGHT_STATUS VALUES(4555,'Scheduled');

insert into flight values(3762, 111, 4553);
insert into flight values(3763, 111, 4553);
insert into flight values(3764, 112, 4554);
insert into flight values(3765, 113, 4552);
insert into flight values(3766, 114, 4551);
insert into flight values(3767, 115, 4555);

insert into travelclass values(1, 'Economy', 'Economy class');
insert into travelclass values(2, 'Business', 'Business class');

insert into aircraftnamufacturer values(1, 'Air India');
insert into aircraftnamufacturer values(2, 'Air Asia');
insert into aircraftnamufacturer values(3, 'Indigo');
insert into aircraftnamufacturer values(4, 'Spicejet');
insert into aircraftnamufacturer values(5, 'Vistara');

insert into aircraft values(31, 4, 'A211');
insert into aircraft values(32, 1, 'F212');
insert into aircraft values(33, 2, 'CK476');
insert into aircraft values(34, 3, 'FZ763');
insert into aircraft values(35, 4, 'NJS3');
insert into aircraft values(36, 5, 'KK65');

insert into aircraftinstance values(512, 33);
insert into aircraftinstance values(513, 31);
insert into aircraftinstance values(514, 35);
insert into aircraftinstance values(515, 34);
insert into aircraftinstance values(516, 36);
insert into aircraftinstance values(517, 32);

insert into flightaircraftinstance values(3765,515);
insert into flightaircraftinstance values(3764,514);
insert into flightaircraftinstance values(3763,513);
insert into flightaircraftinstance values(3766,516);
insert into flightaircraftinstance values(3762,512);
insert into flightaircraftinstance values(3767,517);

insert into aircraftseat values(33,23,1);
insert into aircraftseat values(31,21,2);
insert into aircraftseat values(32,22,1);
insert into aircraftseat values(34,24,1);
insert into aircraftseat values(35,25,2);
insert into aircraftseat values(36,26,1);

insert into flightseatprice values(3762, 32,22,6788.54);
insert into flightseatprice values(3763, 33,22,45758.51);
insert into flightseatprice values(3764, 34,24,5632.53);
insert into flightseatprice values(3765, 35,25,1000.98);
insert into flightseatprice values(3766, 36,26,5527.45);
insert into flightseatprice values(3767, 31,21,6888.44);

insert into booking values(1221,3762,32,22);
insert into booking values(1556,3763,33,22);
insert into booking values(3466,3764,34,24);
insert into booking values(2342,3765,35,25);
insert into booking values(8874,3766,36,26);

delimiter &&
create procedure TicketGenerater (in client_prev_id int, in flight_call_ int)
select c.client_id,(c.first_name,' ',c.last_name) as Name,sc.origin_iata_airport_code as From_,sc.dest_iata_airport_code as To_,
sc.departure_time_gmt as Dept_Time_,sc.arrival_time_gmt as Arr_Time,acm.name as Flight_name,tc.name as class,b.Bstatus from aircraftnamufacturer acm
join aircraft ac
on acm.aircraft_manufacturer_id = ac.aircraft_manufacturer_id
join booking b
on ac.aircraft_id = b.aircraft_id
join client c
on b.client_id = c.client_id
join flight f
on b.flight_call = f.flight_call
join schedule sc
on f.schedule_id = sc.schedule_id
join aircraftseat acs
on acs.seat_id = b.seat_id
join travelclass tc
on tc.travel_class_id = acs.travel_class_id
where b.client_id =  client_prev_id and f.flight_call = flight_call_  ;
end &&
delimiter ;

call TicketGenerater (1221,3765);

select * from travelclass;
select * from aircraftseat;
select * from client;
select * from booking;

create table registration(name varchar(20),email varchar(20) primary key,password varchar(20));
alter table booking add column Bstatus varchar(20) default 'Confirmed';

delimiter &&
CREATE PROCEDURE FlightSearch (in pointA varchar(10),in pointB varchar(10),in dateofflight date)
begin
select f.flight_call as Flight_id,acm.name as Flight_Name,s.origin_iata_airport_code as From_,s.dest_iata_airport_code as To_,s.departure_time_gmt as Dep_Time,
s.arrival_time_gmt as Arr_Time,fp.price_usd as Price,tc.name as Class from schedule s
join flight f
on s.schedule_id = f.schedule_id
join flightseatprice fp
on f.flight_call = fp.flight_call
join aircraft ac
on fp.aircraft_id = ac.aircraft_id
join aircraftnamufacturer acm
on acm.aircraft_manufacturer_id = ac.aircraft_manufacturer_id
join aircraftseat acs
on acs.aircraft_id = ac.aircraft_id
join travelclass tc
on tc.travel_class_id = acs.travel_class_id
where s.origin_iata_airport_code = pointA and s.dest_iata_airport_code = pointB and date(s.departure_time_gmt) = dateofflight;
end &&
delimiter ;
call flightsearch('ccu','bhm','2022-09-10');

delimiter &&
CREATE PROCEDURE credentials (in mail varchar(30),in passw varchar(30))
begin
select * from registration
where email = mail and password = passw;
end &&
delimiter ;

delimiter &&
CREATE PROCEDURE CheckBooking (in cid varchar(10))
select concat(c.first_name,' ',c.last_name) as Name,sc.origin_iata_airport_code as From_,sc.dest_iata_airport_code as To_,
sc.departure_time_gmt as Dept_Time_,sc.arrival_time_gmt as Arr_Time,acm.name as Flight_name,tc.name as class from aircraftnamufacturer acm
join aircraft ac
on acm.aircraft_manufacturer_id = ac.aircraft_manufacturer_id
join booking b
on ac.aircraft_id = b.aircraft_id
join client c
on b.client_id = c.client_id
join flight f
on b.flight_call = f.flight_call
join schedule sc
on f.schedule_id = sc.schedule_id
join aircraftseat acs
on acs.seat_id = b.seat_id
join travelclass tc
on tc.travel_class_id = acs.travel_class_id
where b.client_id = cid;
end &&
delimiter ;
call checkbooking(1221);

delimiter &&
CREATE PROCEDURE CheckFlightStatus (in fid varchar(10))
select fs.name as flight_status from flight f
join flight_status fs
on f.flight_status_id = fs.flight_status_id
where flight_call = fid;
end &&
delimiter ;
select * from flight;
call CheckFlightStatus(3762);

delimiter //
create procedure FlightBooking(in first_name varchar(45), in middle_name varchar(45),in last_name varchar(45),in phone varchar(45),
in email varchar(45),in passport varchar(45),in c_code varchar(10),in flight_name_ varchar(45),in flight_call_ int)
begin
    DECLARE client_prev_id Int;
    DECLARE seat_id_ Int;
    DECLARE aircraft_id_ Int;

    set client_prev_id = (select max(client_id) from client)+1;

    set aircraft_id_= (select min(aircraft_id) from aircraftnamufacturer acm
    inner join aircraft a
    on acm.aircraft_manufacturer_id = a.aircraft_manufacturer_id
    where acm.name = flight_name_);

    set seat_id_ = (select seat_id from aircraftseat where aircraft_id=aircraft_id_);

    insert into client values(client_prev_id,first_name,middle_name,last_name,phone,email,passport,c_code);
    insert into booking(client_id,flight_call,aircraft_id,seat_id) values(client_prev_id,flight_call_,aircraft_id_,seat_id_);
end //
delimiter ;

delete from client 
where first_name = 'Akshay';

call flightbooking('Akshay','M','Saraf','8796135480','akshay@gmail.com','1234687748','IN','Spicejet',3765);

select * from client;
select * from booking;

select coalesce(null,null,7,null,8);