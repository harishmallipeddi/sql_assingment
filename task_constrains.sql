create table students(student_id int auto_increment primary key,
 email varchar(100) unique,
 name varchar(50) not null,
 age int check ( age between 18 and 30),
 city varchar(50) default 'hyd' );
 
 show tables;
 desc students;
 
 create table employee (emp_id int auto_increment primary key,
 emp_name varchar(50) not null,
 email varchar(100) unique,
 salary int check(salary >15000),
 joining_date date default (current_date)
 );


CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    barcode VARCHAR(50) UNIQUE,
    price DECIMAL(10,2) CHECK (price > 0),
    stock INT DEFAULT 0
);


CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    age INT CHECK (age >= 18),
    city VARCHAR(50) DEFAULT 'Hyderabad'
);

INSERT INTO Customers (customer_name, email, age)
VALUES ('Harish', 'harish@example.com', 22);

INSERT INTO Customers (customer_name, email, age, city)
VALUES ('Ravi', 'ravi@example.com', 25, 'Chennai');

INSERT INTO Customers (customer_name, email, age)
VALUES ('Kiran', 'kiran@example.com', 28);

INSERT INTO Customers (customer_name, email, age)
VALUES ('Teja', 'teja@example.com', 16);

INSERT INTO Customers (email, age)
VALUES ('anon@example.com', 20);

select*from customers;
 
 
