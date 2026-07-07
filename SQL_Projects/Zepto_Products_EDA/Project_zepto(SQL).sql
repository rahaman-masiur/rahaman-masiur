CREATE DATABASE zepto;
USE zepto;

-- CREATE TABLE FOR PRODUCTS 
CREATE TABLE inventory(
SKU_id INT AUTO_INCREMENT PRIMARY KEY,
category VARCHAR(150) NOT NULL,
name VARCHAR(150),
mrp DECIMAL(8,2) NOT NULL,
discountPercent DECIMAL(5,2),
availableQuantity INTEGER,
discountedSellingPrice DECIMAL(8,2),
weightInGrams INTEGER,
outOfStock BOOLEAN,
quantity INTEGER );

SELECT *
FROM inventory;

-- DATA EXPLORATION 
-- Full inventory table
SELECT *
FROM inventory
LIMIT 10000;

-- Total number of items
SELECT COUNT(*) 'Total number of items'
FROM inventory;

-- List of distinct items 
SELECT DISTINCT 
name 
FROM inventory
LIMIT 5000;

-- List of duplicate items 
SELECT 
name,
COUNT(*) AS total_count
FROM inventory
GROUP BY name
HAVING COUNT(*) >1
ORDER BY COUNT(*);

-- other way 
SELECT DISTINCT name,COUNT(*) AS total_count
FROM 
(
SELECT name,
ROW_NUMBER()OVER(PARTITION BY name) AS rank_
FROM inventory) As inner_table
WHERE rank_>1
GROUP BY name 
;

-- Null values 
SELECT * 
FROM inventory
WHERE 
SKU_id IS NULL OR
category IS NULL OR
name IS NULL OR 
mrp IS NULL OR 
discountPercent IS NULL OR 
availableQuantity IS NULL OR 
discountedSellingPrice IS NULL OR 
weightInGrams IS NULL OR 
outOfStock IS NULL OR 
quantity IS NULL;

-- Total inventory worth (in rupee)
SELECT 
ROUND(SUM(availableQuantity*mrp)/100,2) AS total_worth_before_discount,
ROUND(SUM(availableQuantity*discountedSellingPrice)/100,2) AS total_worth_after_discount
FROM inventory;


-- Distinct category names and their total productes
SELECT DISTINCT category, COUNT(*) AS number_of_products ,
SUM(COUNT(*)) OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_total_products
FROM inventory
GROUP BY category;

-- Out of stock product 
SELECT name,
category,
availableQuantity
FROM inventory 
WHERE OutOfStock=1;

-- DATA CLEANING AND PREPARATION 

SELECT *
FROM inventory;
-- change the mrp and discounted selling price from paise to rupee
UPDATE inventory
SET mrp = mrp/100,
discountedSellingPrice = discountedSellingPrice /100
WHERE SKU_id >0;

-- Remove the item that have mrp or discounted selling price is zero 
SELECT *
FROM inventory
WHERE mrp=0 OR 
discountedSellingPrice =0;

CREATE TABLE null_values_id AS
SELECT sku_id
FROM inventory
WHERE mrp=0 OR 
discountedSellingPrice =0;

SET SQL_SAFE_UPDATES=0;
DELETE 
FROM inventory
WHERE mrp=0 OR discountedSellingPrice=0;

-- Q1. Find the top 10 best-value products based on the discount percentage.
SELECT name,
discountpercent AS Discount,
discountedsellingPrice AS Final_price
FROM inventory
ORDER BY discountpercent DESC
LIMIT 10;

-- Q2.What are the Products with High MRP but Out of Stock
SELECT name,
mrp
FROM inventory 
WHERE outOfStock=1
ORDER BY mrp DESC;

-- Q3.Calculate Estimated Revenue for each category
SELECT category,
SUM(discountedSellingPrice*availableQuantity) AS revenue
FROM inventory
GROUP BY category;


-- Q4. Find all products where MRP is greater than ₹500 and discount is less than 10%.
SELECT name,
mrp AS MRP ,
discountPercent AS Discount
FROM inventory
WHERE mrp >500 AND discountPercent <10
ORDER BY mrp;

-- Q5. Identify the top 5 categories offering the highest average discount percentage.
SELECT category,
AVG(discountPercent) AS Avg_discount
FROM inventory
GROUP BY category
ORDER BY AVG(discountPercent) DESC
LIMIT 5 ;

-- Q6. Find the price per gram for products above 100g and sort by best value.
SELECT name,
weightInGrams,
ROUND(mrp/weightInGrams ,2)AS price_per_grams
FROM inventory
WHERE weightInGrams>100
ORDER BY ROUND(mrp/weightInGrams ,2) ;
-- Q7.Group the products into categories like Low, Medium, Bulk.
SELECT * FROM inventory;
SELECT name,
CASE
	WHEN quantity >500 THEN 'BULK'
    WHEN quantity<= 500 AND quantity >200 THEN 'MEDIUM'
    ELSE'LOW'
END AS size_category
FROM inventory;

-- Q8.What is the Total Inventory Weight Per Category 
SELECT 
category,
ROUND(SUM(weightInGrams*availableQuantity) /1000,2) AS category_weight_in_kg
FROM inventory
GROUP BY category
ORDER BY ROUND(SUM(weightInGrams*availableQuantity) /1000,2);

