CREATE DATABASE AMAZON_DB;
USE AMAZON_DB;

-- Creating table and inserting data into table
CREATE TABLE amazon_sales(
    OrderID VARCHAR(15) PRIMARY KEY,
	OrderDate DATE,
    CustomerID VARCHAR(15) NOT NULL,
	CustomerName VARCHAR(30),
	ProductID VARCHAR(15) NOT NULL,
    ProductName	VARCHAR(100) ,
    Category VARCHAR(50),	
    Brand VARCHAR(50),
    Quantity INT NOT NULL,
	UnitPrice FLOAT,
	Discount FLOAT,
    Tax	FLOAT ,
    ShippingCost FLOAT,
	TotalAmount FLOAT,
	PaymentMethod VARCHAR(50),
	OrderStatus	VARCHAR(50),
    City VARCHAR(50),
    state VARCHAR(50),
    Country	VARCHAR(50),
    SellerID VARCHAR(15) NOT NULL );


