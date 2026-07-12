-- Date exploration 

-- First and Last order date with range for first and last order
SELECT 
MAX(order_date) AS Last_order_date,
MIN(order_date) AS First_order_date,
TIMESTAMPDIFF(month,MIN(order_date),MAX(order_date)) AS Range_in_month,
TIMESTAMPDIFF(year,MIN(order_date),MAX(order_date)) AS Range_in_year
FROM fact_sales;

-- Youngest and oldest customer 
SELECT 
'Oldest Customer' As category,
MAX(TIMESTAMPDIFF(YEAR,birthdate,CURDATE())) AS Age
FROM dim_customers
UNION 
SELECT 
'Youngest Customer' As category,
MIN(TIMESTAMPDIFF(YEAR,birthdate,CURDATE())) AS Age
FROM dim_customers;

-- Youngest and oldest customer in specific gender
SELECT 
gender,
'Oldest Customer' As category,
MAX(TIMESTAMPDIFF(YEAR,birthdate,CURDATE())) AS Age
FROM dim_customers
GROUP BY gender
UNION 
SELECT 
gender,
'Youngest Customer' As category,
MIN(TIMESTAMPDIFF(YEAR,birthdate,CURDATE())) AS Age
FROM dim_customers
GROUP BY gender
ORDER BY gender;

-- total number of order per year
SELECT 
YEAR(order_date),
COUNT(*) As Sales_per_year
FROM fact_sales
GROUP BY YEAR(order_date)
ORDER BY YEAR(order_date);

-- total number of order per year quarterly
SELECT 
YEAR(order_date) AS Year,
QUARTER(order_date)AS Quarter,
COUNT(*) As Sales_per_year
FROM fact_sales
GROUP BY YEAR(order_date),QUARTER(order_date)
ORDER BY YEAR(order_date),QUARTER(order_date);