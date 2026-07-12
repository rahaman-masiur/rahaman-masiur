-- Dimension exploration 

-- Unique values from columns which have categorical values 
-- For dim_customers tables
-- Country wise customer count
SELECT DISTINCT country ,
COUNT(country)
FROM dim_customers
GROUP BY country;

-- Grouping customer based on gender 
SELECT gender,
COUNT(gender)
FROM dim_customers 
GROUP BY gender;

-- Maritial status 
SELECT marital_status,
COUNT(*) AS total_count
FROM dim_customers
GROUP BY marital_status;

-- For dim_products tables 
-- category and products per sub category 
SELECT *
FROM dim_products
WHERE category IS NULL OR subcategory IS NULL;

SELECT category,
subcategory,
COUNT(*) OVER( PARTITION BY category ) AS total_subcategory,
COUNT(*) AS Total_products

FROM dim_products
GROUP BY category,subcategory
ORDER BY category,subcategory;

-- Total products 
SELECT COUNT(product_id) AS total_products
FROM dim_products;

-- Total products per category
SELECT category,
COUNT(*) AS total_products 
FROM dim_products
GROUP BY category;

-- product line category per category
SELECT category,
product_line,
COUNT(*) AS total_product
FROM dim_products
GROUP BY category,product_line;

-- 
