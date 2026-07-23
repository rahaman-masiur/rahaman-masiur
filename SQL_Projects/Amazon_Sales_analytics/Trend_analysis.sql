-- Trend analysis 

-- YoY sales trend analysis and compare it with previous year revenue

SELECT 
YEAR(OrderDate) AS Current_Year,
ROUND(SUM(TotalAmount),2) AS Total_revenue,
LAG(ROUND(SUM(TotalAmount)),1,'N/A') OVER(ORDER BY YEAR(OrderDate)) AS Prev_year_Revenue,
ROUND(SUM(TotalAmount)- LAG(SUM(TotalAmount),1,'N/A') OVER(ORDER BY YEAR(OrderDate)),2) AS Difference_
FROM amazon_sales
GROUP BY YEAR(OrderDate)
ORDER BY YEAR(OrderDate);

-- MOM sales change and difference between current and previous month sales
SELECT 
YEAR(OrderDate) AS Current_Year,
MONTHNAME(OrderDate) AS Current_month,
ROUND(SUM(TotalAmount),2) AS Total_revenue,
LAG(ROUND(SUM(TotalAmount)),1,'N/A') OVER(ORDER BY YEAR(OrderDate),MONTHNAME(OrderDate)) AS Prev_month_Revenue,
ROUND(SUM(TotalAmount)- LAG(SUM(TotalAmount),1,'N/A') OVER(ORDER BY YEAR(OrderDate),MONTHNAME(OrderDate)),2) AS Difference_
FROM amazon_sales
GROUP BY YEAR(OrderDate),MONTHNAME(OrderDate)
ORDER BY YEAR(OrderDate),MONTHNAME(OrderDate);

-- Quarterly sales
SELECT 
YEAR(OrderDate) AS Current_Year,
QUARTER(OrderDate) AS Current_Quarter,
ROUND(SUM(TotalAmount),2) AS Total_revenue,
LAG(ROUND(SUM(TotalAmount)),1,'N/A') OVER(ORDER BY YEAR(OrderDate),QUARTER(OrderDate)) AS Prev_month_Revenue,
ROUND(SUM(TotalAmount)- LAG(SUM(TotalAmount),1,'N/A') OVER(ORDER BY YEAR(OrderDate),QUARTER(OrderDate)),2) AS Difference_
FROM amazon_sales
GROUP BY YEAR(OrderDate),QUARTER(OrderDate)
ORDER BY YEAR(OrderDate),QUARTER(OrderDate);

-- YoY quantity sold 
SELECT 
YEAR(OrderDate) AS Current_Year,
ROUND(SUM(Quantity),2) AS Total_revenue,
LAG(ROUND(SUM(Quantity)),1,'N/A') OVER(ORDER BY YEAR(OrderDate)) AS Prev_year_Revenue,
ROUND(SUM(Quantity)- LAG(SUM(Quantity),1,'N/A') OVER(ORDER BY YEAR(OrderDate)),2) AS Difference_
FROM amazon_sales
GROUP BY YEAR(OrderDate)
ORDER BY YEAR(OrderDate);

-- Quarterly 
SELECT 
YEAR(OrderDate) AS Current_Year,
QUARTER(OrderDate) AS Current_Quarter,
ROUND(SUM(Quantity),2) AS Total_revenue,
LAG(ROUND(SUM(Quantity)),1,'N/A') OVER(ORDER BY YEAR(OrderDate),QUARTER(OrderDate)) AS Prev_month_Revenue,
ROUND(SUM(Quantity)- LAG(SUM(Quantity),1,'N/A') OVER(ORDER BY YEAR(OrderDate),QUARTER(OrderDate)),2) AS Difference_
FROM amazon_sales
GROUP BY YEAR(OrderDate),QUARTER(OrderDate)
ORDER BY YEAR(OrderDate),QUARTER(OrderDate);


-- Change in customers over time 
SELECT DISTINCT 
YEAR(Orderdate) AS Year,
COUNT(CustomerID) AS Total_Customer_placed_an_order
FROM amazon_sales
GROUP BY YEAR(orderDate)
ORDER BY YEAR(OrderDate);

-- Growth of customer over time 
WITH Customer2020 AS 
(
SELECT DISTINCT
CustomerID,
YEAR(OrderDate) AS Year
FROM amazon_sales
WHERE YEAR(OrderDate)=2020
),
Customer2021 AS 
(
SELECT DISTINCT
CustomerID,
YEAR(OrderDate) AS Year
FROM amazon_sales
WHERE YEAR(OrderDate)=2021
),
Customer2022 AS 
(
SELECT DISTINCT
CustomerID,
YEAR(OrderDate) AS Year
FROM amazon_sales
WHERE YEAR(OrderDate)=2022
),
Customer2023 AS 
(
SELECT DISTINCT
CustomerID,
YEAR(OrderDate) AS Year
FROM amazon_sales
WHERE YEAR(OrderDate)=2023
),
Customer2024 AS 
(
SELECT DISTINCT
CustomerID,
YEAR(OrderDate) AS Year
FROM amazon_sales
WHERE YEAR(OrderDate)=2024
),
-- Customers from 2020
Total_unique_customers AS
(
SELECT 
c1.CustomerID,
c1.Year,
COUNt(*)OVER() AS Total_unique_customers
FROM Customer2020 c1
WHERE c1.CustomerID NOT IN 
(SELECT CustomerID FROM Customer2021)
AND c1.CustomerID NOT IN 
(SELECT CustomerID FROM Customer2022)
AND c1.CustomerID NOT IN 
(SELECT CustomerID FROM Customer2023)
AND c1.CustomerID NOT IN 
(SELECT CustomerID FROM Customer2024)
UNION 
-- Customers from 2021
SELECT
c2.CustomerID,
c2.Year,
COUNt(*)OVER() AS Total_unique_customers
FROM Customer2021 c2
WHERE c2.CustomerID NOT IN 
(SELECT CustomerID FROM Customer2020)
AND c2.CustomerID NOT IN 
(SELECT CustomerID FROM Customer2022)
AND c2.CustomerID NOT IN 
(SELECT CustomerID FROM Customer2023)
AND c2.CustomerID NOT IN 
(SELECT CustomerID FROM Customer2024)
UNION
-- Customers from 2022
SELECT
c3.CustomerID,
c3.Year,
COUNt(*)OVER() AS Total_unique_customers
FROM Customer2022 c3
WHERE c3.CustomerID NOT IN 
(SELECT CustomerID FROM Customer2020)
AND c3.CustomerID NOT IN 
(SELECT CustomerID FROM Customer2021)
AND c3.CustomerID NOT IN 
(SELECT CustomerID FROM Customer2023)
AND c3.CustomerID NOT IN 
(SELECT CustomerID FROM Customer2024)
UNION 
SELECT
c4.CustomerID,
c4.Year,
COUNt(*)OVER() AS Total_unique_customers
FROM Customer2023 c4
WHERE c4.CustomerID NOT IN 
(SELECT CustomerID FROM Customer2020)
AND c4.CustomerID NOT IN 
(SELECT CustomerID FROM Customer2021)
AND c4.CustomerID NOT IN 
(SELECT CustomerID FROM Customer2022)
AND c4.CustomerID NOT IN 
(SELECT CustomerID FROM Customer2024)
UNION 
-- Customers from 2024
SELECT
c5.CustomerID,
c5.Year,
COUNt(*)OVER() AS Total_unique_customers
FROM Customer2024 c5
WHERE c5.CustomerID NOT IN 
(SELECT CustomerID FROM Customer2020)
AND c5.CustomerID NOT IN 
(SELECT CustomerID FROM Customer2021)
AND c5.CustomerID NOT IN 
(SELECT CustomerID FROM Customer2022)
AND c5.CustomerID NOT IN 
(SELECT CustomerID FROM Customer2023)
)

SELECT * 
FROM Total_unique_customers;