-- Change over time Analysis(Trends)

USE advancedataanalytics;


-- Sales over time

-- Per day sales
SELECT order_date,
SUM(sales_amount) AS Total_sales
FROM fact_sales
GROUP BY order_date;

-- Sales by month
SELECT MONTHNAME(order_date) AS Month,
SUM(sales_amount) AS Total_Monthly_sales
FROM fact_sales
GROUP BY MONTHNAME(order_date)
ORDER BY MONTHNAME(order_date);

-- Quarterly sales over year
SELECT 
YEAR(order_date) AS Year,
QUARTER(order_date) AS Quarter,
SUM(sales_amount) AS Total_sales
FROM fact_sales
GROUP BY YEAR(order_date), QUARTER(order_date)
ORDER BY YEAR(order_date), QUARTER(order_date);

-- Yearly 
SELECT 
YEAR(order_date) AS Year,
SUM(sales_amount) AS Yearly_revenue 
FROM fact_sales
GROUP BY YEAR(order_date)
ORDER BY YEAR(order_date);

-- Sales Quantity over time
-- monthly sales over the year
SELECT 
YEAR(order_date) AS Year,
MONTHNAME(order_date) AS Month,
SUM(quantity) AS Total_quantity_sold
FROM fact_sales
GROUP BY YEAR(order_date), MONTHNAME(order_date)
ORDER BY YEAR(order_date), MONTHNAME(order_date);

-- Total customer over time

SELECT 
YEAR(order_date) AS Year,
MONTHNAME(order_date) AS Month,
COUNT(DISTINCT customer_key) AS Total_customer_ordered
FROM fact_sales
GROUP BY YEAR(order_date), MONTHNAME(order_date)
ORDER BY YEAR(order_date), MONTHNAME(order_date);

SELECT 
YEAR(order_date) AS Year,
COUNT(DISTINCT customer_key) AS Total_customer_ordered
FROM fact_sales
GROUP BY YEAR(order_date)
ORDER BY YEAR(order_date);

-- Total number of orders over the time and total order quarterly
WITH cte1 AS (
SELECT 
YEAR(order_date) AS Year,
QUARTER(order_date) AS Quarter,
COUNT(DISTINCT order_number) AS No_of_orders
FROM fact_sales
GROUP BY YEAR(order_date),QUARTER(order_date)
ORDER BY YEAR(order_date),QUARTER(order_date))

SELECT 
Year,
Quarter,
No_of_orders,
SUM(No_of_orders)OVER(PARTITION BY Year) AS Yearly_sales
FROM cte1;


