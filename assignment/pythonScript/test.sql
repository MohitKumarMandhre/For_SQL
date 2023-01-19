use airportdb;

show tables;

select * from schedule limit 20;

show create table airport;

-- CREATE TABLE `airport` (   `iata_airport_code` char(3) NOT NULL,   `name` varchar(45) NOT NULL,   `city` varchar(45) NOT NULL,   `iata_country_code` char(2) DEFAULT NULL,   PRIMARY KEY (`iata_airport_code`),   KEY `fk_country_code_airport` (`iata_country_code`),   CONSTRAINT `fk_country_code_airport` FOREIGN KEY (`iata_country_code`) REFERENCES `country` (`iata_country_code`) ON UPDATE CASCADE ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci



show databases;
use air2db;

show TABLES;
