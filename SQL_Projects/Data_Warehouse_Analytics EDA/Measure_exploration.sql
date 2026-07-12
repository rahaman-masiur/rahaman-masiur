-- Measure Exploration 

-- Total Total revenue
SELECT 
SUM(sales_amount) AS Total_revenue
FROM fact_sales;

-- How many items are sold
SELECT 
COUNT(DISTINCT p.product_name) AS Total_items_sold
FROM fact_sales s
JOIN dim_products p
ON s.product_key=p.product_key;

-- AVG selling price per category
SELECT 
p.category,
SUM(s.sales_amount)  AS Revenue
FROM fact_sales s
JOIN dim_products p 
ON s.product_key=p.product_key
GROUP BY p.category
UNION 
SELECT 
'Total_Revenue' AS category,
SUM(sales_amount) AS Revenue
FROM fact_sales ;

-- Total number of order per product
SELECT 
p.product_name,
COUNT(*) AS NumberOf_sales
FROM fact_sales s 
JOIN dim_products p 
ON s.product_key=p.product_key
GROUP BY p.product_name;

-- Total number of customers 
SELECT 
COUNT(DISTINCT customer_id) AS Total_customer 
FROM dim_customers;



