-- Active: 1670399129309@@127.0.0.1@3307@hr
-- * 04/12/22

show tables;

show create table departement;


-- employee
-- ( employeeNumber, firstName, lastName, extension, email, officeCode, reportsTo, jobTitle )

CREATE TABLE `employee` (
  `employeeNumber` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `firstName` varchar(25) NOT NULL, 
  `lastName` varchar(25) DEFAULT NULL,
  `extension` varchar(10) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL, 
  `officeCode` int(11) NOT NULL,
  `reportsTo` int(11) DEFAULT NULL,
  `jobTitle` varchar(25) DEFAULT NULL,

  CONSTRAINT `employee` PRIMARY KEY (`employeeNumber`),
  CONSTRAINT `UQ_employees_email` UNIQUE (`email`),
  CONSTRAINT `FK_employee_employee` FOREIGN KEY (`reportsTo`) REFERENCES `employee` (`employeeNumber`) ON DELETE CASCADE,
  CONSTRAINT `FK_offices_employee` FOREIGN KEY (`officeCode`) REFERENCES `employee` (`officeCode`) ON DELETE CASCADE, 
  INDEX `IX_employee_email` (`email`)
  
) ENGINE=InnoDB;

-- offices
-- ( officeCode, city, code, addressLine1, addressLine2, state, country, postalCode, territory )

CREATE TABLE `offices` (
  `officeCode` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `city` varchar(25) DEFAULT NULL, 
  `phone` int(11) DEFAULT NULL,
  `addressLine1` varchar(50) DEFAULT NULL, 
  `addressLine2` varchar(50) DEFAULT NULL,
  `state` varchar(15) DEFAULT NULL,
  `country` varchar(15) DEFAULT NULL, 
  `postalCode` varchar(8) DEFAULT NULL,
  `territory` varchar(25) DEFAULT NULL,

  CONSTRAINT `offices` PRIMARY KEY (`officeCode`),
  CONSTRAINT `UQ_offices_phone` UNIQUE (`phone`)
  
) ENGINE=InnoDB;

-- customers 
-- ( customerNumber, customerName, contactFirstName, contactLastName, phone, addressLine1, addressLine2, city, state, postalCode, country, salesRepEmployeeNumber, creditLimit  )

CREATE TABLE `customers` (
  `customerNumber` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `customerName` varchar(25) NOT NULL,
  `contactFirstName` varchar(25) DEFAULT NULL, 
  `contactLastName` varchar(25) DEFAULT NULL, 
  `phone` int(11) DEFAULT NULL,
  `addressLine1` varchar(50) DEFAULT NULL, 
  `addressLine2` varchar(50) DEFAULT NULL,
  `city` varchar(25) DEFAULT NULL, 
  `state` varchar(15) DEFAULT NULL,
  `postalCode` varchar(8) DEFAULT NULL,
  `country` varchar(15) DEFAULT NULL, 
  `salesRepEmployeeNumber` int(11) UNSIGNED,
  `creditLimit` decimal(11, 2) DEFAULT NULL,

  CONSTRAINT `customers` PRIMARY KEY (`customerNumber`),
  CONSTRAINT `UQ_customers_phone` UNIQUE (`phone`),
  CONSTRAINT `FK_employee_customers` FOREIGN KEY (`customerNumber`) references `employee` (`employeeNumber`) ON DELETE CASCADE
  
) ENGINE=InnoDB;

-- productlines
-- ( productLine, textDescription, htmlDescription, image )

CREATE TABLE `productlines` (
  `productLine` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `textDescription` varchar(50) DEFAULT NULL, 
  `htmlDescription` varchar(50) DEFAULT NULL
  `image` varchar(25) NOT NULL,

  CONSTRAINT `productlines` PRIMARY KEY (`customerNumber`)
  
) ENGINE=InnoDB;

-- product
-- ( productCode, productName, productLine, productScale, productVender, productDescription, quantityInStock, buyPrice, MSRP )

CREATE TABLE `products` (
  `productCode` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `productName` varchar(25) DEFAULT NULL,
  `productLine` int(11),
  `productScale` varchar(50) DEFAULT NULL, 
  `productVender` varchar(50) DEFAULT NULL,
  `productDescription` varchar(100) DEFAULT NULL,
  `quantityInStock` int(11) UNSIGNED NOT NULL,
  `buyPrice` decimal(11, 2) UNSIGNED DEFAULT NULL,
  `MSRP` decimal(11, 2) UNSIGNED DEFAULT NULL,

  CONSTRAINT `products` PRIMARY KEY (`productCode`),
  CONSTRAINT `UQ_products_productName` UNIQUE (`productName`),
  CONSTRAINT `FK_productlines_products` FOREIGN KEY (`productLine`) references `productlines` (`productLine`) ON DELETE CASCADE
  
) ENGINE=InnoDB;

-- orderdetails 
-- ( orderNumber, productCode, quantityOrdered, priceEach, orderLineNumber )

CREATE TABLE `orderdetails` (
  `orderNumber` int(11) UNSIGNED NOT NULL,
  `productCode` int(11) UNSIGNED NOT NULL,
  `quantityOrdered` int(11) UNSIGNED NOT NULL,
  `priceEach` decimal(11,2) NOT NULL,
  `orderLineNumber` int(11),

  CONSTRAINT `orderNumber_productCode` PRIMARY KEY (`orderNumber`, `productCode`),
  CONSTRAINT `FK_products_orderdetails` FOREIGN KEY (`productCode`) references `productlines` (`productCode`) ON DELETE CASCADE,
  CONSTRAINT `FK_orders_orderdetails` FOREIGN KEY (`orderNumber`) references `productlines` (`orderNumber`) ON DELETE CASCADE
  
) ENGINE=InnoDB;

-- orders
-- ( orderNumber, orderDate, requiredDate, shippedDate, status, comments, customerNumber )

CREATE TABLE `orders` (
  `orderNumber` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `orderDate` datetime NOT NULL,
  `requiredDate` datetime NOT NULL,
  `shippedDate` datetime NOT NULL,
  `status` varchar(15) DEFAULT NULL,
  `comments` varchar(50) DEFAULT NULL,
  `customerNumber` int(11) NOT NULL,

  CONSTRAINT `products` PRIMARY KEY (`orderNumber`),
  CONSTRAINT `FK_orders_customers` FOREIGN KEY (`customerNumber`) references `productlines` (`customerNumber`) ON DELETE CASCADE,
  CONSTRAINT `FK_orderdetails_orders` FOREIGN KEY (`orderNumber`) references `orders` (`orderNumber`) ON DELETE CASCADE
  
) ENGINE=InnoDB;

-- payments
-- ( customerNumber, checkNumber, paymentDate, amount )

CREATE TABLE `payments` (
  `customerNumber` int(11) UNSIGNED NOT NULL,
  `checkNumber` int(11) NOT NULL,
  `paymentDate` datetime NOT NULL,
  `amount` int(11) NOT NULL,

  CONSTRAINT `customerNumber_checkNumber` PRIMARY KEY (`customerNumber`, `checkNumber`),
  CONSTRAINT `FK_customers_payments` FOREIGN KEY (`customerNumber`) references `customers` (`customerNumber`) ON DELETE CASCADE
  
) ENGINE=InnoDB;
