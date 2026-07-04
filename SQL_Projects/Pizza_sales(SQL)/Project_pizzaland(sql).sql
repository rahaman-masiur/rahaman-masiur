-- CREATE OUR DATABASE NAMED "pizzaland"
CREATE DATABASE pizzaland;
USE pizzaland;

-- CREATE OUR TABLES 
-- order_details table
CREATE TABLE order_details(
order_details_id INT PRIMARY KEY,
order_id INT NOT NULL,
pizza_id VARCHAR(50) NOT NULL,
quantity INT
);

-- orders table
CREATE TABLE orders (
order_id INT PRIMARY KEY,
date DATE,
time TIME
);

-- pizza types table
CREATE TABLE pizza_types(
pizza_type VARCHAR(50) PRIMARY KEY,
name VARCHAR(50),
category VARCHAR(20),
ingredients VARCHAR(200)
);



-- Adding foreign key constraints

ALTER TABLE order_details
ADD CONSTRAINT fk_orderid
FOREIGN KEY (order_id)
REFERENCES orders(order_id);

ALTER TABLE order_details
ADD CONSTRAINT fk_pizzaid
FOREIGN KEY (pizza_id)
REFERENCES pizzas(pizza_id);

ALTER TABLE pizzas
ADD CONSTRAINT fk_pizzatype
FOREIGN KEY (pizza_type)
REFERENCES pizza_types(pizza_type);



SELECT *
FROM order_details;

SELECT *
FROM orders
LIMIT 10;

SELECT *
FROM pizza_types
LIMIT 10;

SELECT *
FROM pizzas
LIMIT 10;  


-- Retrieve the total number of orders placed.

SELECT COUNT(*) AS Total_orders
FROM orders;

-- Calculate the total revenue generated from pizza sales

SELECT *
FROM pizzas;
SELECT *
FROM order_details;
SELECT *
FROM pizza_types;


SELECT 
SUM(p.price*o.quantity) AS Revenue
FROM order_details o
JOIN pizzas p
ON o.pizza_id=p.pizza_id;

-- Identify the highest-priced pizza.
SELECT 
p1.name,
p2.price
FROM pizza_types p1
JOIN pizzas p2
ON p1.pizza_type=p2.pizza_type
WHERE p2.price=(
SELECT 
MAX(price)
FROM pizzas)
;

-- Identify the most common pizza size ordered.

SELECT 
p.size,
COUNT(p.size) AS size_count
FROM order_details o 
JOIN pizzas p 
ON o.pizza_id=p.pizza_id
GROUP BY p.size
ORDER BY COUNT(p.size) DESC
LIMIT 1;


-- List the top 5 most ordered pizza types along with their quantities.
SELECT 
p.pizza_type,
COUNT(p.pizza_type) AS pizza_count
FROM order_details o 
JOIN pizzas p
ON o.pizza_id=p.pizza_id
GROUP BY p.pizza_type
ORDER BY COUNT(p.pizza_type) DESC
LIMIT 5;

-- Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT 
pt.category,
COUNT(pt.category) AS pizza_count
FROM order_details o 
JOIN pizzas p
ON o.pizza_id=p.pizza_id
JOIN pizza_types pt
ON p.pizza_type=pt.pizza_type
GROUP BY pt.category;

-- 
SELECT 
EXTRACT(hour FROM time) AS Hour,
COUNT(*) AS no_of_orders
FROM orders
GROUP BY EXTRACT(hour FROM time)
ORDER BY EXTRACT(hour FROM time) ;


-- Join relevant tables to find the category-wise distribution of pizzas.

SELECT 
pt.category,
COUNT(pt.category) AS pizza_count
FROM order_details o 
JOIN pizzas p
ON o.pizza_id=p.pizza_id
JOIN pizza_types pt
ON p.pizza_type=pt.pizza_type
GROUP BY pt.category;

-- Group the orders by date and calculate the average number of pizzas ordered per day.

SELECT 
date,
COUNT(*) per_day_sales,
ROUND(AVG(COUNT(*))OVER(),1) AS per_day_avg_sales
FROM orders 
GROUP BY date;


-- Determine the top 3 most ordered pizza types based on revenue
SELECT 
p.pizza_type,
COUNT(*)AS pizza_sales
FROM order_details od
JOIN pizzas p
ON od.pizza_id=p.pizza_id
GROUP BY p.pizza_type
ORDER BY COUNT(*) DESC
LIMIT 3 ;

-- Calculate the percentage contribution of each pizza type to total revenue.

SELECT 
p.pizza_type,
SUM(p.price) AS Revenue,
ROUND(SUM(p.price*od.quantity)/(SELECT 
SUM(p.price*o.quantity)
FROM order_details o
JOIN pizzas p
ON o.pizza_id=p.pizza_id)*100,2) AS total_revenue
FROM order_details od 
JOIN pizzas p 
ON od.pizza_id=p.pizza_id
GROUP BY p.pizza_type;

-- Analyze the cumulative revenue generated over time.
SELECT date,
SUM(revenue)OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cimulative_revenue
FROM 
(SELECT 
o.date,
SUM(p.price*od.quantity) AS revenue
FROM order_details od 
JOIN pizzas p 
ON od.pizza_id=p.pizza_id
JOIN orders o 
ON od.order_id=o.order_id
GROUP BY o.date) AS sales
;

-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.

SELECT * FROM(
SELECT 
pt.category,
pt.name,
SUM(p.price*od.quantity) AS revenue,
RANK()OVER( PARTITION BY pt.category ORDER BY pt.category,pt.pizza_type) AS ranking
FROM order_details od 
JOIN pizzas p 
ON od.pizza_id=p.pizza_id 
JOIN pizza_types pt 
ON p.pizza_type=pt.pizza_type
GROUP BY pt.category,pt.pizza_type
ORDER BY pt.category,pt.pizza_type) AS inner_table
WHERE ranking IN (1,2,3);