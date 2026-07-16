-- Part to whole analysis

-- Which categories contribute the most to the overall sales
WITH sales_category AS 
(
SELECT 
p.category,
SUM(sales_amount) AS Revenue
FROM fact_sales s
LEFT JOIN dim_products p 
ON s.product_key=p.product_key
GROUP BY p.category)

SELECT category,
Revenue,
SUM(Revenue)OVER() AS Total_revenue,
(Revenue/SUM(Revenue)OVER())*100 AS Sales_weight
FROM sales_category;

-- Product contribution in total sales
WITH product_sales_details AS 
(
SELECT 
p.product_name,
SUM(sales_amount) AS Revenue
FROM fact_sales s
LEFT JOIN dim_products p 
ON s.product_key=p.product_key
GROUP BY p.product_name)

SELECT 
product_name,
Revenue,
SUM(Revenue)OVER() AS Total_revenue,
(Revenue/SUM(Revenue)OVER())*100 AS Revenue_percentage
FROM product_sales_details
ORDER BY Revenue/SUM(Revenue)OVER() DESC;

-- Sales Per Country 
CREATE VIEW country_sales_details AS
SELECT 
c.country,
SUM(s.sales_amount) AS Revenue
FROM fact_sales s 
JOIN dim_customers c 
ON s.customer_key=c.customer_key
GROUP BY c.country;

SELECT country,
Revenue,
SUM(Revenue)OVER() AS Total_revenue,
(Revenue/SUM(Revenue)OVER())*100 AS Revenue_percentage
FROM country_sales_details
ORDER BY Revenue/SUM(Revenue)OVER() DESC;

-- Group the customer based on age and show the Revenue proportion
-- first group the customers based on age
CREATE VIEW Customer_age_group AS 
SELECT 
customer_key,
CONCAT(first_name,' ',last_name) AS Name,
TIMESTAMPDIFF(YEAR,birthdate,CURDATE()) AS Age,
CASE 
	WHEN TIMESTAMPDIFF(YEAR,birthdate,CURDATE()) <=20 THEN 'Less than 20'
    WHEN TIMESTAMPDIFF(YEAR,birthdate,CURDATE()) >20 AND TIMESTAMPDIFF(YEAR,birthdate,CURDATE()) <=40 THEN 'Between 20 and 40'
    WHEN TIMESTAMPDIFF(YEAR,birthdate,CURDATE()) >40 AND TIMESTAMPDIFF(YEAR,birthdate,CURDATE()) <=60 THEN 'Between 40 and 60'
    WHEN TIMESTAMPDIFF(YEAR,birthdate,CURDATE()) >60 THEN 'More than 60'
END AS age_group
FROM dim_customers;

-- Find Which age group contibut how muct to the rotal revenue

SELECT 
vw.age_group,
COUNT(vw.age_group) AS customer_count,
SUM(s.sales_amount) AS Revenue,
(SELECT SUM(sales_amount) FROM fact_sales) AS Total_revenue,
SUM(s.sales_amount)/ (SELECT SUM(sales_amount) FROM fact_sales)*100 AS sales_percentage
FROM fact_sales s 
LEFT JOIN customer_age_group vw
ON s.customer_key=vw.customer_key
GROUP BY vw.age_group;

SELECT * 
FROM customer_age_group
WHERE age_group='Less than 20';

