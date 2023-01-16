-- create database libdb;
-- drop database libdb; 
-- use libdb; 

-- show tables;

-- CREATE TABLE BOOK 
--    (	BOOKID int(15)   PRIMARY KEY auto_increment, 
-- 	BPUB varchar(20), 
-- 	BAUTH varchar(20), 
-- 	BTITLE varchar(25), 
-- 	BSUB varchar(25)
--    ) 
--    ;

--   CREATE TABLE MEMBER 
--    (	MID int(4)   PRIMARY KEY auto_increment, 
-- 	MNAME varchar(20), 
-- 	MPHONE numeric(10,0),
--         JOINDATE DATE
--    ) 
--    ;

--   CREATE TABLE BCOPY 
--    (	C_ID int(4), 
-- 	BOOKID int(15), 
-- 	STATUS varchar(20) CHECK (status in('available','rented','reserved')),
--         PRIMARY KEY (C_ID,BOOKID)
--    ); 

--   CREATE TABLE BRES 
--    (	MID int(4) , 
-- 	BOOKID int(15) REFERENCES BOOK, 
-- 	RESDATE DATE,PRIMARY KEY (MID, BOOKID, RESDATE),
--         foreign key(mid) references member(mid)
--    ) ;

--   CREATE TABLE BLOAN 
--    (	BOOKID int(4), 
-- 	LDATE DATE, 
-- 	FINE numeric(11,2), 
-- 	MID int(4), 
-- 	EXP_DATE DATE DEFAULT (curdate()+2), 
-- 	ACT_DATE DATE, 
-- 	C_ID int(4),
--   FOREIGN KEY (C_ID, BOOKID)
-- 	  REFERENCES BCOPY (C_ID, BOOKID),
--  foreign key(mid) references member(mid)
--    ) ;

-- Insert into BOOK (BPUB,BAUTH,BTITLE,BSUB) 
-- values ('IDG Books','Carol','Oracle Bible','Database');

-- Insert into BOOK (BPUB,BAUTH,BTITLE,BSUB) 
-- values ('TMH','James','Information Systems','I.Science');

-- Insert into BOOK (BPUB,BAUTH,BTITLE,BSUB) 
-- values ('SPD','Shah','Java EB 5','Java');

-- Insert into BOOK (BPUB,BAUTH,BTITLE,BSUB) 
-- values ('BPB','Deshpande','P.T.Olap','Database');

-- Insert into MEMBER (MNAME,MPHONE,JOINDATE) 
-- values ('rahul',9343438641,(curdate()-3));

-- Insert into MEMBER (MNAME,MPHONE,joindate)
--  values ('raj',9880138898,(curdate()-2));
--  
-- Insert into MEMBER (MNAME,MPHONE,joindate) 
-- values ('mahesh',9900780859,curdate());

-- Insert into BCOPY (C_ID,BOOKID,STATUS) values (1,1,'available');
-- Insert into BCOPY (C_ID,BOOKID,STATUS) values (2,1,'available');
-- Insert into BCOPY (C_ID,BOOKID,STATUS) values (1,2,'available');
-- Insert into BCOPY (C_ID,BOOKID,STATUS) values (2,2,'available');
-- Insert into BCOPY (C_ID,BOOKID,STATUS) values (1,3,'available');
-- Insert into BCOPY (C_ID,BOOKID,STATUS) values (1,4,'available');

-- a. 	NEW_MEMBER: A  procedure that adds a new member to the MEMBER table. For the join date, use CURDATE(). 
-- 		Pass all other values to be inserted into a new row as parameters.

-- call new_member( name, phn);

-- b.   NEW_BOOK: A procedure that adds a new book to the book table. columns pass as parameter.
--   	Create a trigger to insert into bcopy table whenever insert happens on new_book.(BOOK)
-- 		(Here multiple copies can be entered manually)

-- new_book(pub, auth, title, sub) ;
-- show create table bcopy;
-- desc bcopy;

-- call new_member( 'Rohit', 9876543210);
-- select * from bcopy ;

-- call new_book('ALZ', 'Tom', 'AWS Fundamentals', 'Cloud') ;

-- c. 	NEW_RENTAL: Function to record a new rental. Pass the bID number for the book that is to be rented, 
-- 		pass MID number into the function. The function should return the due date for the book. 
-- 		Due dates are three days from the date the book is rented. 

-- 		If the status for a book requested is listed as AVAILABLE in the bCOPY table for one copy of this title, 
-- 		then update this b_COPY table and set the status to RENTED. If there is no copy available, 
-- 		the function must return NULL. 

-- 		Then, insert a new record into the BLOAN  table identifying the booked date as today's date, 
-- 		the copy ID number, the member ID number, the BOOKID number and the expected return date. 

-- new_rental(p_bid int, p_mid int) 

-- d. 	RETURN_book: A  procedure that updates the status of a book (available, rented, or reserved) and sets the return date. 

-- 		Pass the book ID, the cID and the status to this procedure. 
-- 		Check whether there are reservations for that title, and display a message if it is reserved. 
-- 		Update the RENTAL table and set the actual return date to today’s date. 
-- 		Update the status in the BCOPY table based on the status parameter passed into the procedure. 

-- 	return_book(p_cid int, p_bookid int, p_status varchar(30)

-- e. 	RESERVE_BOOK: A  procedure that executes only if all of the book copies requested in the NEW_RENTAL procedure have a status of RENTED. 
-- 		Pass the member ID number and the book ID number to this procedure. 
-- 		Insert a new record into the BRES table and record the reservation date, member ID number, and BID number. 
-- 		Print out a message indicating that a BOOK is reserved and its expected date of return.

desc bres;


