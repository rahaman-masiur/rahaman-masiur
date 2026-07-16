-- Customer report 

-- BASE TABLE(AS VIEW)
  -- order_no | order_date| prod_key|prod_name| sales_amount | quantity | Customer_id| first_name|last name| birthday
  -- combine all the table
  DROP VIEW Base_table;
  CREATE VIEW Base_table AS
  SELECT
  s.order_number,
  s.order_date,
  s.product_key,
  p.product_name,
  s.sales_amount,
  s.quantity,
  c.customer_id,
  CONCAT(first_name,' ',last_name) AS Customer_name,
  TIMESTAMPDIFF(YEAR,c.birthdate,CURDATE()) AS Age
  FROM fact_sales s 
  LEFT JOIN dim_products p
  ON s.product_key=p.product_key
  JOIN dim_customers c 
  ON s.customer_key=c.customer_key;
  
  
  SELECT * FROM Base_table;
  
  CREATE VIEW Customer_profile AS 
  SELECT 
  customer_id,
  customer_name,
  Age,
  MAX(order_date)AS Last_order_date,
  SUM(sales_amount) AS Total_amount,
  SUM(quantity) AS Total_quantity_brought,
  COUNT(product_name) AS Total_product_brought,
  TIMESTAMPDIFF(Month,MIN(order_date),MAX(order_date)) AS Users_order_duration,
  CASE 
		WHEN TIMESTAMPDIFF(Month,MIN(order_date),MAX(order_date)) = 0 THEN SUM(sales_amount)
        ELSE SUM(sales_amount)/TIMESTAMPDIFF(Month,MIN(order_date),MAX(order_date))
  END AS Avg_monthly_spending,
  ROUND(AVG(sales_amount),2) AS avg_order_value
  FROM Base_table
  GROUP BY customer_id,customer_name,Age;
  
  
  -- Rank the customer based on Total_spending
  
  SELECT *
  FROM Customer_profile
  ORDER BY Total_amount DESC;
  
