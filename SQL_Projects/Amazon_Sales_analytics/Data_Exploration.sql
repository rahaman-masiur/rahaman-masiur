-- Exploring database and data preprocessing 

-- All table details from the database
SELECT * 
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA='AMAZON_DB';

-- All columns details from the database
SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA='AMAZON_DB';


-- Data preprocessing 

-- Find NuLL values 
SELECT *
FROM amazon_sales
WHERE 
OrderID IS NULL OR 
OrderDate IS NULL OR 
CustomerID IS NULL OR 
CustomerName IS NULL OR 
ProductID IS NULL OR  
ProductName IS NULL OR  
Category IS NULL OR 
Brand IS NULL OR 
Quantity IS NULL OR  
UnitPrice IS NULL OR  
Discount IS NULL OR  
Tax IS NULL OR 
ShippingCost IS NULL OR 
TotalAmount IS NULL OR  
PaymentMethod IS NULL OR  
OrderStatus IS NULL OR 
City IS NULL OR  
state IS NULL OR 
Country IS NULL OR 
SellerID IS NULL  ;  -- There is no null values 

-- Check for any zeroes in the numerical columns 
SELECT *
FROM amazon_sales
WHERE 
Quantity =0 OR
UnitPrice =0 OR   
ShippingCost =0 ; -- everything is fine with the numerical values 

-- Check for any missing categorical or descriptive values from the columns 
SELECT *
FROM amazon_sales
WHERE 
OrderID =' ' OR
CustomerID =' ' OR 
CustomerName =' ' OR 
ProductID =' ' OR  
ProductName =' ' OR   
Category =' ' OR  
Brand =' ' OR  
PaymentMethod =' ' OR  
OrderStatus =' ' OR  
City =' ' OR 
state =' ' OR  
Country =' ' OR  
SellerID =' ' ;  -- There is no missing valus are in the columns 
