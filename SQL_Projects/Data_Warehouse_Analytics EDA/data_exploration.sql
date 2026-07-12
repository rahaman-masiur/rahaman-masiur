-- DATABASE Exploration 
USE datawarehouseanalytics;


-- Explore all the tables 
SELECT *
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA= 'datawarehouseanalytics';

-- Explore all the columns
SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA='datawarehouseanalytics';

use datawarehouseanalytics;
-- Columns from each table 
SHOW COLUMNS 
FROM dim_customers;

SHOW COLUMNS 
FROM dim_products;

SHOW COLUMNS 
FROM fact_sales;

-- Show 10 records from each table 
SELECT *
FROM dim_customers
LIMIT 10;

SELECT *
FROM dim_products
LIMIT 10;

SELECT *
FROM fact_sales
LIMIT 1000;