CREATE DATABASE DataWarehouseAnalytics ;
USE DataWarehouseAnalytics;


-- Create tables 

CREATE TABLE dim_customers(
	customer_key int,
	customer_id int,
	customer_number nvarchar(50),
	first_name nvarchar(50),
	last_name nvarchar(50),
	country nvarchar(50),
	marital_status nvarchar(50),
	gender nvarchar(50),
	birthdate date,
	create_date date
);

CREATE TABLE dim_products(
	product_key int ,
	product_id int ,
	product_number nvarchar(50) ,
	product_name nvarchar(50) ,
	category_id nvarchar(50) ,
	category nvarchar(50) ,
	subcategory nvarchar(50) ,
	maintenance nvarchar(50) ,
	cost int,
	product_line nvarchar(50),
	start_date date 
);

CREATE TABLE fact_sales(
	order_number nvarchar(50),
	product_key int,
	customer_key int,
	order_date date,
	shipping_date date,
	due_date date,
	sales_amount int,
	quantity tinyint,
	price int 
);

-- Defining key constraints 
-- Add primary keys 
ALTER TABLE dim_customers
ADD CONSTRAINT pk_customer_key 
PRIMARY KEY (customer_key);

ALTER TABLE dim_products
ADD CONSTRAINT pk_product_key 
PRIMARY KEY (product_key);


-- Add foreign keys
ALTER TABLE fact_sales
ADD CONSTRAINT fk_product_key 
FOREIGN KEY (product_key)
REFERENCES dim_products(product_key);

ALTER TABLE fact_sales
ADD CONSTRAINT fk_customer_key
FOREIGN KEY (customer_key)
REFERENCES dim_customers (customer_key);


-- finding the mismatched records
SELECT f.customer_key 
FROM fact_sales f 
LEFT JOIN dim_customers c ON f.customer_key = c.customer_key
WHERE c.customer_key IS NULL;

-- Drop those mismatched records
SET SQL_SAFE_UPDATES=0;

DELETE f 
FROM fact_sales f
LEFT JOIN dim_customers c ON f.customer_key = c.customer_key
WHERE c.customer_key IS NULL;

SET SQL_SAFE_UPDATES=0;
-- Handling missing values 
DELETE  
FROM dim_products
WHERE category ='';

