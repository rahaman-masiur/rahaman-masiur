-- Magnitude analysis 

-- Total sales by country

SELECT 
c.country,
SUM(s.sales_amount) AS Sales
FROM fact_sales s 
JOIN dim_customers c 
ON s.customer_key=c.customer_key
GROUP by c.country;

-- Total Quantity by category 
SELECT
p.category,
SUM(s.quantity) AS Total_quantity
FROM fact_sales s 
JOIN dim_products p 
ON s.product_key=p.product_key
GROUP by p.category
UNION 
SELECT 'Total quantity' As category, 
SUM(quantity) AS Total_quantity
FROM fact_sales;

-- Avg price per
SELECT
p.product_name,
SUM(s.quantity) AS Total_quantity,
SUM(s.sales_amount) AS total_sales_amount,
ROUND(AVG(s.sales_amount),2) AS avg_price_per_product
FROM fact_sales s 
JOIN dim_products p 
ON s.product_key=p.product_key
GROUP BY p.product_name;

-- Total number of customer that place any order 
SELECT 
COUNT(DISTINCT s.customer_key) AS 'Total_customer_that place an order',
COUNT(DISTINCT c.customer_key) AS 'Total Customers'
FROM fact_sales s 
JOIN dim_customers c 
ON s.customer_key=c.customer_key;

-- Total number of order placed by all customers and revenue from per customer
SELECT 
c.customer_id,
CONCAT(c.first_name,' ',c.last_name) AS Name,
COUNT(*) AS Total_order_placed,
SUM(s.sales_amount) As Revenue
FROM fact_sales s 
JOIN dim_customers c 
ON s.customer_key=c.customer_key
GROUP BY c.customer_key;
