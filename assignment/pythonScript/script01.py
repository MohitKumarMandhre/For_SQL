from faker import Faker
import random
import mysql.connector

# Connect to the database
mydb = mysql.connector.connect(
  host="localhost",
  user="yourusername",
  password="yourpassword",
  database="yourdatabasename"
)

# Create a cursor object
mycursor = mydb.cursor()

# Create the country table
mycursor.execute("CREATE TABLE country (iata_country_code CHAR(2) PRIMARY KEY, name VARCHAR(45))")

# Create the client table
mycursor.execute("CREATE TABLE client (client_id INT PRIMARY KEY, first_name VARCHAR(45) NOT NULL, middle_name VARCHAR(45), last_name VARCHAR(45) NOT NULL, phone VARCHAR(45) UNIQUE, email VARCHAR(45) NOT NULL, passport VARCHAR(45) UNIQUE, iata_country_code CHAR(2), CONSTRAINT fk_country_code FOREIGN KEY (iata_country_code) REFERENCES country(iata_country_code) ON UPDATE CASCADE)")

# Create the airport table
mycursor.execute("create table if not exists airport(
iata_airport_code char(3) primary key,
name varchar(45) not null,
city varchar(45) not null,
iata_country_code char(2),

constraint fk_country_code_airport foreign key(iata_country_code)
references country(iata_country_code)
on update cascade);")

# # Insert data into the table
# query = "INSERT INTO employees (name, salary) VALUES (%s, %s)"
# values = [("John Doe", 50000), ("Jane Smith", 60000), ("Bob Johnson", 55000)]
# mycursor.executemany(query, values)

insert data into the airport table
for _ in range(5000):
iata_airport_code = faker.random_letter() + faker.random_letter() + faker.random_letter()
name = faker.city()
city = faker.city()
iata_country_code = faker.random_element(country_codes)
sql_airport = "INSERT INTO airport (iata_airport_code, name, city, iata_country_code) VALUES (%s, %s, %s, %s)"
val_airport = (iata_airport_code, name, city, iata_country_code)
mycursor.execute(sql_airport, val_airport)
mydb.commit()

Create the direction table
mycursor.execute("
create table direction(





origin_iata_airport_code char(3),
dest_iata_airport_code char(3),

constraint pk_origin_desr primary key(origin_iata_airport_code,dest_iata_airport_code),
constraint fk_origin foreign key(origin_iata_airport_code)
references airport(iata_airport_code),
constraint fk_dest foreign key(dest_iata_airport_code)
references airport(iata_airport_code));")

Create the schedule table
mycursor.execute("create table schedule(
schedule_id int primary key,
origin_iata_airport_code char(3),
dest_iata_airport_code char(3),
departure_time_gmt timestamp,
arrival_time_gmt timestamp,

constraint fk_originate foreign key(origin_iata_airport_code)
references direction(origin_iata_airport_code),
constraint fk_destination foreign key(dest_iata_airport_code)
references direction(dest_iata_airport_code));")

Create the flight_status table
mycursor.execute("create table flight_status(
flight_status_id int primary key,
name varchar(45) not null);")

Create the flight table
mycursor.execute("create table flight(
flight_call int primary key,
schedule_id int,
flight_status_id int,
constraint fk_schedule foreign key(schedule_id)
references schedule(schedule_id)
on update cascade,
constraint fk_status_id foreign key(flight_status_id)
references flight_status(flight_status_id)
on update cascade);")

Create the aircraftnamufacturer table
mycursor.execute("create table aircraftnamufacturer(
aircraft_manufacturer_id int primary key,
name varchar(45) not null);")

Create the aircraft table
mycursor.execute("create table aircraft(
aircraft_id int primary key,
aircraft_manufacturer_id int,
model varchar(45),
constraint fk_manufacturer_id foreign key(aircraft_manufacturer_id)
references aircraftnamufacturer(aircraft_manufacturer_id)
on update cascade);")

Create the travelclass table
mycursor.execute("create table travelclass(
travel_class_id int primary key,
name varchar(45) not null,
description text,
constraint travel_classes check (name in ('Business','Economy')));")

Create the aircraftinstance table
mycursor.execute("create table if not exists aircraftinstance(
aircraft_instance_id int primary key,
aircraft_id int,
constraint fk_aircraft foreign key(aircraft_id)
references aircraft(aircraft_id)
on update cascade);")

Create the flightinstance table
mycursor.execute("create table if not exists flightinstance(
flight_instance_id int primary key,
flight_call int,
travel_class_id int,





aircraft_instance_id int,
flight_call int,
travel_class_id int,
constraint fk_aircraft_instance foreign key(aircraft_instance_id)
references aircraftinstance(aircraft_instance_id)
on update cascade,
constraint fk_flight_call foreign key(flight_call)
references flight(flight_call)
on update cascade,
constraint fk_travel_class_id foreign key(travel_class_id)
references travelclass(travel_class_id)
on update cascade);

Inserting Data into tables
Inserting data into country table
for i in range(num_of_countries):
country_code = faker.country_code()
country_name = faker.country()
sql = "INSERT INTO country (iata_country_code, name) VALUES (%s, %s)"
val = (country_code, country_name)
mycursor.execute(sql, val)

Inserting data into airport table
for i in range(num_of_airports):
airport_code = faker.random_element(airport_codes)
airport_name = faker.city()
city = faker.city()
country_code = faker.random_element(country_codes)
sql = "INSERT INTO airport (iata_airport_code, name, city, iata_country_code) VALUES (%s, %s, %s, %s)"
val = (airport_code, airport_name, city, country_code)
mycursor.execute(sql, val)

Inserting data into direction table
for i in range(num_of_directions):
origin = faker.random_element(airport_codes)
dest = faker.random_element(airport_codes)
sql = "INSERT INTO direction (origin_iata_airport_code, dest_iata_airport_code) VALUES (%s, %s)"
val = (origin, dest)
mycursor.execute(sql, val)

Inserting data into schedule table
for i in range(num_of_schedules):
origin = faker.random_element(airport_codes)
dest = faker.random_element(airport_codes)
departure_time = faker.date_time_this_decade()
arrival_time = faker.date_time_this_decade()
sql = "INSERT INTO schedule (origin_iata_airport_code, dest_iata_airport_code, departure_time_gmt, arrival_time_gmt) VALUES (%s, %s, %s, %s)"
val = (origin, dest, departure_time, arrival_time)
mycursor.execute(sql, val)

Inserting data into flight_status table
for i in range(num_of_flight_status):
flight_status_name = faker.random_element(flight_status)
sql = "INSERT INTO flight_status (name) VALUES (%s)"
val = (flight_status_name)
mycursor.execute(sql, val)







Inserting data into flight_status table
for i in range(num_of_flight_status):
flight_status = faker.word()
mycursor.execute(f"INSERT INTO flight_status (flight_status_id, name) VALUES({i+1}, '{flight_status}')")

Inserting data into flight table
for i in range(num_of_flights):
flight_call = faker.random_int(min=1000, max=9999)
schedule_id = faker.random_int(min=1, max=num_of_schedules)
flight_status_id = faker.random_int(min=1, max=num_of_flight_status)
mycursor.execute(f"INSERT INTO flight (flight_call, schedule_id, flight_status_id) VALUES({flight_call}, {schedule_id}, {flight_status_id})")

Creating the aircraftmanufacturer table
mycursor.execute("create table aircraftnamufacturer(aircraft_manufacturer_id int primary key, name varchar(45) not null)")

Inserting data into aircraftmanufacturer table
for i in range(num_of_aircraft_manufacturers):
aircraft_manufacturer = faker.company()
mycursor.execute(f"INSERT INTO aircraftnamufacturer (aircraft_manufacturer_id, name) VALUES({i+1}, '{aircraft_manufacturer}')")

Creating the aircraft table
mycursor.execute("create table aircraft(aircraft_id int primary key, aircraft_manufacturer_id int, model varchar(45), constraint fk_manufacturer_id foreign key(aircraft_manufacturer_id) references aircraftnamufacturer(aircraft_manufacturer_id) on update cascade)")

Inserting data into aircraft table
for i in range(num_of_aircrafts):
aircraft_manufacturer_id = faker.random_int(min=1, max=num_of_aircraft_manufacturers)
model = faker.word()
mycursor.execute(f"INSERT INTO aircraft (aircraft_id, aircraft_manufacturer_id, model) VALUES({i+1}, {aircraft_manufacturer_id}, '{model}')")

Creating the travelclass table
mycursor.execute("create table travelclass(travel_class_id int primary key, name varchar(45) not null, description text, constraint travel_classes check (name in ('Business','Economy')))")

Inserting data into travelclass table
for i in range(num_of_travel_class):
travel_class_name = random.choice(["Business", "Economy"])
travel_class_description = faker.paragraph()
mycursor.execute(f"INSERT INTO travelclass (travel_class_id, name, description) VALUES({i+1}, '{travel_class_name}', '{travel_class_description}')")

Creating the flightinstance table
mycursor.execute("create table if not exists flightinstance(flight_instance_id int primary key, flight_call int, departure_time_gmt timestamp, arrival_time_gmt timestamp,flight_call int,aircraft_instance_id int,
travel_class_id int,
departure_time_gmt timestamp,
arrival_time_gmt timestamp,
price float,
seats_available int,
constraint fk_flight_call foreign key(flight_call) references flight(flight_call) on update cascade,
constraint fk_aircraft_instance foreign key(aircraft_instance_id) references aircraftinstance(aircraft_instance_id) on update cascade,
constraint fk_travel_class foreign key(travel_class_id) references travelclass(travel_class_id) on update cascade);
Inserting data into flightinstance table
for i in range(num_of_flight_instance):
flight_call = random.randint(1, num_of_flight)
aircraft_instance_id = random.randint(1, num_of_aircraft_instance)
travel_class_id = random.randint(1, num_of_travel_class)
departure_time_gmt = faker.date_time_between(start_date='-1y', end_date='now', tzinfo=pytz.UTC)
arrival_time_gmt = faker.date_time_between(start_date='-1y', end_date='now', tzinfo=pytz.UTC)
price = round(random.uniform(100, 1000), 2)
seats_available = random.randint(10, 100)
sql_query = f"INSERT INTO flightinstance (flight_instance_id, flight_call, aircraft_instance_id, travel_class_id, departure_time_gmt, arrival_time_gmt, price, seats_available) VALUES ({i}, {flight_call}, {aircraft_instance_id}, {travel_class_id}, '{departure_time_gmt}', '{arrival_time_gmt}', {price}, {seats_available})"
mycursor.execute(sql_query)
mydb.commit()
print(f"{num_of_flight_instance} rows inserted into flightinstance table")
mycursor.close()
mydb.close()
print("All tables created and data inserted successfully")