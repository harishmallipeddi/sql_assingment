create table customer (sno int primary key auto_increment,
name varchar(100),
phone_number int,
order_food varchar(100)


);



create table orders_1 (sno int primary key auto_increment,
food_name varchar(100),
customer_name varchar(100),
foreign key (sno) references customer (sno)
);




create table delivery (sno int primary key auto_increment,
food_name varchar (100),
customer_name varchar(100),
foreign key (sno) references orders_1 (sno) );



