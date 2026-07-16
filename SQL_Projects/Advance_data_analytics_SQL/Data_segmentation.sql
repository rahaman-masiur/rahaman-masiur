-- Data segmentation 

-- Total customer by age group 
WITH customer_age_group AS
(
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
FROM dim_customers
)
SELECT age_group,
COUNT(*) AS customer_count,
(
SELECT COUNT(DISTINCT customer_key) FROM dim_customers
) AS Total_customers
FROM customer_age_group
GROUP BY age_group;

-- Segment products into cost range and count how many products fall into each segment,their avg cost and 
WITH cost_segment_cte AS
(
SELECT 
product_key,
product_name,
cost,
CASE 
	WHEN cost<500 THEN 'Below_500'
    WHEN cost>=500 AND cost <1000 THEN 'Between 500 and 1000'
    WHEN cost>=1000 AND cost <=1500 THEN 'Between 1000 and 1500'
    WHEN cost>=1500 THEN 'Above 1500'
END AS Cost_segment
FROM dim_products
ORDER BY cost
)
SELECT 
Cost_segment,
COUNT(*) AS Total_products,
SUM(cost) AS Total_cost,
ROUND(AVG(cost),2) AS Avg_cost_per_product
FROM cost_segment_cte
GROUP BY Cost_segment
ORDER BY COUNT(*);


-- Group customers into three segments based on their spending and total lifespan for order
-- VIP ->12 months of history and spending greater than 5000
-- Regular -> 12 months of history but spending less than 5000
-- New customers -> Less than 12 months of history

WITH customer_details AS 
(
SELECT 
c.customer_key,
CONCAT(first_name,' ',last_name) AS Name,
MIN(s.order_date) AS First_order_date,
MAX(s.order_date) AS Last_order_date,
TIMESTAMPDIFF(month,MIN(s.order_date),MAX(s.order_date)) AS Order_timespan,
SUM(sales_amount) AS Total_spending
FROM fact_sales s 
LEFT JOIN dim_customers c
ON s.customer_key=c.customer_key
GROUP BY c.customer_key
),
Customer_segment AS 
(
SELECT
customer_key,
Name,
CASE 
	WHEN Order_timespan>=12 AND Total_spending >= 5000 THEN 'VIP'
    WHEN Order_timespan>=12 AND Total_spending < 5000 THEN 'Regular'
    WHEN Order_timespan<12 THEN 'New'
    
END AS Customer_segment
FROM customer_details
)


-- Count the customers according to customer segment
SELECT 
Customer_segment,
COUNT(*) AS Total_customers
FROM customer_segment
GROUP BY Customer_segment;



    