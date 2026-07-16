-- Cumulative analysis

-- Total sales each month and running total of sales over time

CREATE VIEW monthly_sales AS 
SELECT 
YEAR(order_date) As Year,
MONTHNAME(order_date) AS Month,
SUM(sales_amount) AS Monthly_sales
FROM fact_sales 
GROUP BY YEAR(order_date),MONTHNAME(order_date)
ORDER BY YEAR(order_date),MONTHNAME(order_date);

-- Total monthly sales and cumulative sales over time
SELECT 
YEAR,
Month,
Monthly_sales,
SUM(Monthly_sales)OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS Cumulative_total
FROM monthly_sales;

-- Moving avg price over time(monthly)

CREATE VIEW avg_price_monthly AS 
SELECT 
YEAR(order_date) AS Year,
MONTHNAME(order_date) AS Month,
ROUND(AVG(price),2) AS Avg_price
FROM fact_sales
GROUP BY YEAR(order_date),MONTHNAME(order_date)
ORDER BY YEAR(order_date),MONTHNAME(order_date);

-- Moving avg price
SELECT 
Year,
Month,
Avg_price,
ROUND(AVG(Avg_price)OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW),2) AS Moving_avg
FROM avg_price_monthly;

-- cumulative total sales over time by month
SELECT 
Year,
Month,
Total_quantity_sold,
SUM(Total_quantity_sold) OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS Cumulative_sales_quantity
FROM(
SELECT 
YEAR(order_date) AS Year,
MONTHNAME(order_date) AS Month,
SUM(quantity) AS Total_quantity_sold
FROM fact_sales
GROUP BY YEAR(order_date),MONTHNAME(order_date)
ORDER BY YEAR(order_date),MONTHNAME(order_date)) AS total_sales_quantity;

