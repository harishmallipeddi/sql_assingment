-- Airline Booking & Flight Management System
CREATE DATABASE IF NOT EXISTS airline_db;
USE airline_db;

CREATE TABLE AIRPORT(
 airport_id INT PRIMARY KEY,
 airport_name VARCHAR(100),
 city VARCHAR(50),
 country VARCHAR(50)
);

CREATE TABLE AIRCRAFT(
 aircraft_id INT PRIMARY KEY,
 model VARCHAR(50),
 total_seats INT
);

CREATE TABLE FLIGHT(
 flight_id INT PRIMARY KEY,
 flight_number VARCHAR(20),
 source_airport_id INT,
 destination_airport_id INT,
 departure_time DATETIME,
 arrival_time DATETIME,
 aircraft_id INT,
 FOREIGN KEY(source_airport_id) REFERENCES AIRPORT(airport_id),
 FOREIGN KEY(destination_airport_id) REFERENCES AIRPORT(airport_id),
 FOREIGN KEY(aircraft_id) REFERENCES AIRCRAFT(aircraft_id)
);

CREATE TABLE PASSENGER(
 passenger_id INT PRIMARY KEY,
 first_name VARCHAR(50),
 last_name VARCHAR(50),
 gender CHAR(1),
 date_of_birth DATE,
 passport_number VARCHAR(20)
);

CREATE TABLE BOOKING(
 booking_id INT PRIMARY KEY,
 passenger_id INT,
 flight_id INT,
 booking_date DATE,
 seat_number VARCHAR(5),
 booking_status VARCHAR(20),
 FOREIGN KEY(passenger_id) REFERENCES PASSENGER(passenger_id),
 FOREIGN KEY(flight_id) REFERENCES FLIGHT(flight_id)
);

CREATE TABLE PAYMENT(
 payment_id INT PRIMARY KEY,
 booking_id INT,
 payment_date DATE,
 amount DECIMAL(10,2),
 payment_method VARCHAR(30),
 FOREIGN KEY(booking_id) REFERENCES BOOKING(booking_id)
);

CREATE TABLE CREW(
 crew_id INT PRIMARY KEY,
 crew_name VARCHAR(100),
 role VARCHAR(50)
);

CREATE TABLE FLIGHT_CREW(
 flight_id INT,
 crew_id INT,
 PRIMARY KEY(flight_id,crew_id),
 FOREIGN KEY(flight_id) REFERENCES FLIGHT(flight_id),
 FOREIGN KEY(crew_id) REFERENCES CREW(crew_id)
);

ALTER TABLE PASSENGER ADD email VARCHAR(100);
ALTER TABLE BOOKING MODIFY seat_number VARCHAR(10);

INSERT INTO AIRPORT VALUES
(1,'Rajiv Gandhi Airport','Hyderabad','India'),
(2,'Kempegowda Airport','Bangalore','India'),
(3,'Chhatrapati Shivaji Airport','Mumbai','India'),
(4,'Delhi Airport','Delhi','India'),
(5,'Chennai Airport','Chennai','India');

INSERT INTO AIRCRAFT VALUES
(101,'Airbus A320',180),
(102,'Boeing 737',190),
(103,'Airbus A321',220),
(104,'Boeing 777',350),
(105,'ATR 72',80);

INSERT INTO FLIGHT VALUES
(1,'AI101',1,2,'2025-08-01 09:00:00','2025-08-01 10:30:00',101),
(2,'AI102',2,3,'2025-08-02 11:00:00','2025-08-02 13:00:00',102),
(3,'AI103',3,4,'2025-08-03 14:00:00','2025-08-03 16:30:00',103);

INSERT INTO PASSENGER VALUES
(1,'Ravi','Kumar','M','1998-06-12','P12345','ravi@gmail.com'),
(2,'Priya','Sharma','F','1999-02-15','P23456','priya@gmail.com'),
(3,'Amit','Verma','M','2000-09-18','P34567','amit@gmail.com');

INSERT INTO BOOKING VALUES
(101,1,1,CURDATE(),'A1','Confirmed'),
(102,2,2,CURDATE(),'B2','Confirmed'),
(103,3,1,CURDATE(),'A2','Confirmed');

INSERT INTO PAYMENT VALUES
(1,101,CURDATE(),5000,'UPI'),
(2,102,CURDATE(),6500,'Card'),
(3,103,CURDATE(),5000,'Cash');

UPDATE BOOKING SET booking_status='Cancelled' WHERE booking_id=101;
UPDATE PAYMENT SET amount=amount*1.10;
DELETE FROM PASSENGER WHERE passenger_id NOT IN (SELECT passenger_id FROM BOOKING);

-- SQL Clauses
SELECT * FROM FLIGHT f JOIN AIRPORT a ON f.source_airport_id=a.airport_id WHERE a.city='Hyderabad';
SELECT * FROM PASSENGER WHERE date_of_birth>'1995-12-31';
SELECT flight_id,COUNT(*) total_bookings FROM BOOKING GROUP BY flight_id;
SELECT flight_id,COUNT(*) total_bookings FROM BOOKING GROUP BY flight_id HAVING COUNT(*)>50;
SELECT * FROM PASSENGER ORDER BY last_name;

-- Joins
SELECT p.first_name,p.last_name,f.flight_number FROM PASSENGER p JOIN BOOKING b ON p.passenger_id=b.passenger_id JOIN FLIGHT f ON b.flight_id=f.flight_id;
SELECT f.flight_number,p.first_name,p.last_name FROM FLIGHT f LEFT JOIN BOOKING b ON f.flight_id=b.flight_id LEFT JOIN PASSENGER p ON b.passenger_id=p.passenger_id;
SELECT f.flight_number,py.amount,py.payment_method FROM FLIGHT f JOIN BOOKING b ON f.flight_id=b.flight_id JOIN PAYMENT py ON b.booking_id=py.booking_id;
SELECT f.flight_number,c.crew_name,c.role FROM FLIGHT f JOIN FLIGHT_CREW fc ON f.flight_id=fc.flight_id JOIN CREW c ON fc.crew_id=c.crew_id;
SELECT p.first_name,p.last_name,s.city Source,d.city Destination FROM PASSENGER p JOIN BOOKING b ON p.passenger_id=b.passenger_id JOIN FLIGHT f ON b.flight_id=f.flight_id JOIN AIRPORT s ON f.source_airport_id=s.airport_id JOIN AIRPORT d ON f.destination_airport_id=d.airport_id;

-- Views
CREATE VIEW passenger_flight_view AS
SELECT p.first_name,p.last_name,f.flight_number,b.seat_number
FROM PASSENGER p JOIN BOOKING b ON p.passenger_id=b.passenger_id JOIN FLIGHT f ON b.flight_id=f.flight_id;

CREATE VIEW active_bookings AS SELECT * FROM BOOKING WHERE booking_status='Confirmed';
CREATE VIEW revenue_view AS SELECT b.flight_id,SUM(py.amount) revenue FROM BOOKING b JOIN PAYMENT py ON b.booking_id=py.booking_id GROUP BY b.flight_id;

DELIMITER $$
CREATE PROCEDURE CancelBooking(IN bid INT)
BEGIN
 UPDATE BOOKING SET booking_status='Cancelled' WHERE booking_id=bid;
END$$
DELIMITER ;

CREATE TABLE booking_audit(
 booking_id INT,
 deleted_on DATETIME
);

DELIMITER $$
CREATE TRIGGER booking_delete
BEFORE DELETE ON BOOKING
FOR EACH ROW
BEGIN
 INSERT INTO booking_audit VALUES(OLD.booking_id,NOW());
END$$
DELIMITER ;

-- Optional DDL for assignment:
-- DROP TABLE PAYMENT;
-- RENAME TABLE CREW TO FLIGHT_CREW_MEMBER;
