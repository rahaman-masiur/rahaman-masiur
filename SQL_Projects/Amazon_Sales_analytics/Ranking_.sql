-- Magnitude analysis

-- Total sales by country and state
SELECT 
Country,
state,
ROUND(SUM(TotalAmount),2) AS Revenue
FROM amazon_sales
GROUP BY Country,state
ORDER BY Country;

-- Sales per Year
SELECT 
YEAR(orderDate) AS Year,
ROUND(SUM(TotalAmount),2) AS Revenue
FROM amazon_sales
GROUP BY YEAR(OrderDate)
ORDER BY YEAR(OrderDate);

-- Sales per month 
SELECT 
MONTHNAME(OrderDate) AS Month,
ROUND(SUM(TotalAmount),2) AS Revenue
FROM amazon_sales
GROUP BY MONTHNAME(OrderDate);

-- Total Quantity sold per category 
SELECT 
Category,
SUM(Quantity) AS Total_quantity
FROM amazon_sales
GROUP BY Category;

-- Avg Price per category
SELECT 
Category,
ROUND(AVG(TotalAmount),2) AS Average_price_category,
(SELECT ROUND(AVG(TotalAmount),2) FROM amazon_sales) AS Average_price 
FROM amazon_sales
GROUP BY category;

SELECT 
DISTINCT 
Country,
state,
ROUND(SUM(TotalAmount)OVER(PARTITION BY Country),2) AS Total_sales_country,
ROUND(SUM(TotalAmount)OVER(PARTITION BY Country,state),2) AS Total_sales_country_state
FROM amazon_sales;

-- Ranking Top 10 Products based on total sales 
SELECT
ROW_NUMBER()OVER( ORDER BY SUM(TotalAmount) DESC) AS Rank_,
ProductId,
ProductName,
ROUND(SUM(TotalAmount),2) AS Total_amount
FROM amazon_sales
GROUP BY ProductID,ProductName
ORDER BY SUM(TotalAmount) DESC
LIMIT 10;

-- TOP 100 Customers based on Total order value 
SELECT 
ROW_NUMBER()OVER(ORDER BY ROUND(SUM(TotalAmount),2) DESC) AS Rank_,
CustomerID,
ROUND(SUM(TotalAmount),2) AS Total_Ordered_amount
FROM amazon_sales
GROUP BY CustomerID
ORDER BY ROUND(SUM(TotalAmount),2) DESC
LIMIT 100;

-- 