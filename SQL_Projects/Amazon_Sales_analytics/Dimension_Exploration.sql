-- Dimension Exploration 

-- Unique categorical values From Every dimensions 
SELECT DISTINCT
ROW_NUMBER() OVER() AS Serial_no,
 productName,
 COUNT(*) AS Ordered_times
FROM amazon_sales
GROUP BY ProductName;

SELECT DISTINCT 
Category
FROM amazon_sales;

SELECT DISTINCT 
Brand,
Category
FROM amazon_sales
GROUP BY Brand,Category
ORDER BY Brand,Category ;

SELECT DISTINCT
City,
State
FROM amazon_sales;

SELECT DISTINCT country
FROM amazon_sales;

-- Unique sellers 

SELECT DISTINCT 
ROW_NUMBER() OVER() AS Serial_number,
SellerID 
FROM amazon_sales
GROUP BY SellerID;

-- Total Payment methods available for purchase any products

SELECT DISTINCT
paymentMethod
FROM amazon_sales;


