drop schema sales;
create schema sales;
-- CUSTOMER TABLE 
Create table
 sales.salesinfo
 (customerID int primary key
 , email varchar(30) Not Null
 , address text
 , phone char(10) not null
 , age int not null
 , dob date
 );
 select * from sales.salesinfo;
 INSERT INTO sales.salesinfo ( customerID, email, address, phone, age, dob) 
 values ( '11', 'abc@gmail.com', 'cbe', '51547', '19', '1996-09-09');
 Alter table sales.salesinfo engine = 'InnoDB';
 INSERT INTO sales.salesinfo (customerID, email, address, phone, age, dob)
 VALUES
  (1, 'abc@gmail.com', 'chennai',  '123456', 25, '1998-05-10'),
  (2, 'cde@gmail.com', 'chennai', '542163', 26,'1997-02-15'),
  (3, 'efg@gmail.com', 'coimbatore', '784596', 27, '1996-11-20'),
  (4, 'ghi@gmail.com', 'madurai', '541268', 28, '1995-08-25'),
  (5, 'ijk@gmail.com', 'trichy', '985475', 29, '1994-04-30'),
  (6, 'lmn@gmail.com', 'trichy', '875485', 30, '1993-09-05'),
  (7, 'nop@gmail.com', 'tirupur', '685965', 31, '1992-06-10'),
  (8, 'pqr@gmail.com', 'tirupur', '758469', 32, '1991-03-15'),
  (9, 'rst@gmail.com', 'coimbatore', '362541', 33, '1990-12-20'),
  (10, 'uvw@gmail.com', 'madurai', '587458', 34, '1989-07-25');
 Select * from information_schema.columns where table_name = 'salesinfo' and table_schema = 'sales' ;
 
 -- PRODUCT TABLE 
 
 create table
 sales.productsinfo
 (ProductID int primary key
 , ProductName varchar(30) Not Null
 , Price decimal(10,2)
 , Description Text
 , CategoryorProductType varchar(30) Not Null
 );
 insert into sales.productsinfo ( ProductID, productname, price, description, categoryorproducttype)
values ('1', 'dress', '599', 'greatquality', 'clothing');
select * from sales.productsinfo;
insert into sales.productsinfo
values
 ( '101', 'SportHelmet', '20.18', 'savelife', 'Accessories')
,( '102', 'Sport Helmet', '40.37', 'saveslife', 'Accessories')
,( '103', 'Sport Helmet', '80.74', 'saveslife', 'Accessories')
,( '104', 'AWC Cap', '5.18', 'great fit', 'Clothing')
,( '105', 'AWC Cap', '10.37', 'great fit', 'Clothing')
,( '106', 'AWC Cap','5.18', 'great fit', 'Clothing')
,( '107', 'Long-Sleeve Jersey', '27.87', 'great quality', 'Clothing')
,( '108', 'Long-Sleeve Jersey', '55.75', 'great quality', 'Clothing')
,( '109', 'Long-Sleeve Jersey', '111.48', 'great quality', 'Clothing')
,( '110', 'Long-Sleeve Jersey', '83.61', 'great quality', 'Clothing');
 
-- Order Table

create table
sales.orderinfo
(orderID int primary key auto_increment
, customerID int
, ProductID int
, OrderDate timestamp
, Status varchar(20)
, ShippingAddress text 
, PaymentMethod varchar(30)
, PaymentStatus varchar(20)
, ShippingMethod varchar(30) 
, TrackingNumber varchar(50));

insert into sales.orderinfo ( orderID, customerID, ProductID, OrderDate, status, ShippingAddress, 
PaymentMethod, PaymentStatus, ShippingMethod, TrackingNumber)
values ( '1101', '11', '1', '2023-06-01', 'delivered', 'cbe', 'COD',
 'Paid', 'Standard Shipping', '12345');
select * from sales.orderinfo;
insert into sales.orderinfo 
values 
( '1102', '1', '101', '2023-06-03', 'delivered', 'chennai', 'COD',
'paid', 'Standard Shipping', '12346')
,( '1103', '2', '102', '2023-06-05', 'delivered', 'chennai', 'cod',
'paid', 'Standard Shipping', '12347')
,( '1104', '3', '103', '2023-06-06', 'delivered', 'coimbatore', 'COD',
'paid', 'Standard Shipping', '12356')
,( '1105', '4', '104', '2023-07-02', 'delivered', 'Madurai', 'COD', 
'paid', 'Express Shipping', '12358')
,( '1106', '5', '105', '2023-07-05', 'delivered', 'Trichy', 'GPAY',
'paid', 'Express Shipping', '12349')
,( '1107', '6', '106', '2023-07-22', 'delivered', 'Trichy', 'Credit Card',
'paid', 'Standard Shipping', '13456')
,( '1108', '7', '107', '2023-08-10', 'delivered', 'Tirupur', 'GPAY',
'paid', 'Standard Shipping', '13467')
,( '1109', '8', '108', '2023-09-15', 'delivered', 'Tirupur', 'COD',
'paid', 'Express Shipping', '13458')
,( '1110', '9', '109', '2023-09-18', 'shipped', 'Coimbatore', 'COD',
'pending', 'Standard Shipping', '14521')
,( '1111', '10', '110', '2023-09-18', 'shipped', 'Madurai', 'GPAY',
'paid', 'Express Shipping', '15462');
 
 use sales;
 drop table sales.orderinfo;
-- Adding a foreign key constraint
ALTER TABLE sales.orderinfo
ADD CONSTRAINT fk_customerid FOREIGN KEY (customerID) REFERENCES salesinfo(customerID);
ALTER TABLE sales.orderinfo
ADD CONSTRAINT fk_productid FOREIGN KEY (ProductID) REFERENCES productsinfo(ProductID);
 