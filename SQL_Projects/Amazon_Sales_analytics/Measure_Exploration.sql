-- Measure Exploration 

-- Total Revenue generated ,Total quantity overall sold 
SELECT 
'Total_quantity_sold' AS Report,
SUM(Quantity) AS Amount
FROM amazon_sales
UNION 
SELECT 
' Total_Price_before_Tax_and_discount' AS Report,
ROUND(SUM(UnitPrice*Quantity)) AS Report
FROM amazon_sales
UNION 
SELECT
'Total_tax' AS Report,
ROUND(SUM(Tax),2) AS Amount
FROM amazon_sales
UNION 
SELECT 
'Total_discount' AS Report,
ROUND(SUM(Quantity*UnitPrice*Discount),2) AS Amount
FROM amazon_sales
UNION 
SELECT 
'Total_shipping_cost' AS Report,
ROUND(SUM(ShippingCost),2) AS Amount
FROM amazon_sales
UNION 
SELECT 
'Total_Revenue_Generated' AS Report,
ROUND(SUM(TotalAmount))AS Amount
FROM amazon_sales;

-- Aggregation based on category,
SELECT 
Category,
ROUND(SUM(TotalAmount),2) AS Total_revenue
FROM amazon_sales
GROUP BY Category;

-- Aggregation based on brand(Total revenue based on brand)
SELECT 
Brand AS Brand_name,
ROUND(SUM(TotalAmount),2) AS Total_Revenue
FROM amazon_sales
GROUP BY Brand
ORDER BY ROUND(SUM(TotalAmount),2);

-- Total Customers and revenue generated per customer
SELECT 
CustomerId,
ROUND(SUM(TotalAmount),2) AS Revenue
FROM amazon_sales
GROUP BY CustomerID
ORDER BY CustomerID;

-- Revenue per product 
SELECT 
ProductID,
ProductName,
ROUND(SUM(TotalAmount),2) AS Revenue
FROM amazon_sales
GROUP BY ProductID,ProductName
ORDER BY ProductID;


SELECT *
FROM amazon_sales;

-- 