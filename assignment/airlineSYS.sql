-- Active: 1670399129309@@127.0.0.1@3307@airlinedb
--  create DATABASE airlinedb;

--  use airlinedb;

-- drop DATABASE airlinedb;

-- show DATABASES;

show TABLES;

Create table country(
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
iata_airport_code char(3) primary key,
name varchar(45) not null,
city varchar(45) not null,
iata_country_code char(2),
index ct(city),
index cntry_code(iata_country_code),
constraint fk_country_code_airport foreign key(iata_country_code)
references country(iata_country_code)
on update cascade);

-- drop table airport;

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

-- create index origin_dest on schedule(origin_iata_airport_code,dest_iata_airport_code);

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

-- create index scheduling on flight(schedule_id,flight_status_id);

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
constraint travel_classes check (name in ('Business','Economy'))
);

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
on update cascade
);
-- select * from flightaircraftinstance;

-- alter table flightaircraftinstance
-- add constraint ck_flight_call foreign key(flight_call)
-- references flight(flight_call);

create table if not exists flight(
flight_call int primary key,
schedule_id int,
flight_status_id int,
constraint fk_schedule_id foreign key(schedule_id)
references schedule(schedule_id)
on update cascade,
constraint fk_flight_status_id foreign key(flight_status_id)
references flightstatus(flight_status_id)
on update cascade
);

-- drop table aircraftseat;
create table if not exists aircraftseat(
aircraft_id int,
seat_id int,
travel_class_id int,
constraint pk_aircraft_id primary key(aircraft_id,seat_id),
constraint fk_travel_class_id foreign key(travel_class_id)
references travelclass(travel_class_id)
on update cascade,
constraint fk_aircraft_id_aircraftseat foreign key(aircraft_id)
references aircraft(aircraft_id)
on update cascade);

-- create index idx_seat_id_aircraftseat on aircraftseat(seat_id);

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
on update cascade
);

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
on update cascade
);

show tables;


















