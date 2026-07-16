CREATE DATABASE AdvanceDataAnalytics ;
USE AdvanceDataAnalytics;


-- Create tables 

CREATE TABLE dim_customers(
	customer_key INT NOT NULL,
	customer_id INT NOT NULL ,
	customer_number VARCHAR(50),
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	country VARCHAR(50),
	marital_status VARCHAR(50),
	gender VARCHAR(50),
	birthdate DATE,
	create_date DATE
);

CREATE TABLE dim_products(
	product_key INT NOT NULL ,
	product_id INT NOT NULL,
	product_number VARCHAR(50) ,
	product_name VARCHAR(50)  ,
	category_id VARCHAR(50)  ,
	category VARCHAR(50)  ,
	subcategory VARCHAR(50)  ,
	maintenance VARCHAR(50)  ,
	cost INT NOT NULL,
	product_line VARCHAR(50) ,
	start_date DATE 
);

CREATE TABLE fact_sales(
	order_number VARCHAR(50) ,
	product_key INT,
	customer_key INT,
	order_date DATE,
	shipping_date DATE,
	due_date DATE,
	sales_amount INT,
	quantity INT,
	price INT 
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

-- foreign key
ALTER TABLE fact_sales
ADD CONSTRAINT fk_customer_key
FOREIGN KEY (customer_key)
REFERENCES dim_customers (customer_key);

SET SQL_SAFE_UPDATES=0;
-- Handling missing values 
DELETE  
FROM dim_products
WHERE category ='';

-- Partitioning data based on Year
SELECT 
DISTINCT YEAR(order_date)
FROM fact_sales;
ALTER TABLE fact_sales
PARTITION BY RANGE (YEAR(order_date))(
PARTITION p2010 VALUES LESS THAN (2011),
PARTITION p2011 VALUES LESS THAN (2012),
PARTITION p2012 VALUES LESS THAN (2013),
PARTITION p2013 VALUES LESS THAN (2014),
PARTITION p2014 VALUES LESS THAN (2015)
)
;

