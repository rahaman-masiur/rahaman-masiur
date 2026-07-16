-- Performance analysis
-- 
CREATE VIEW product_sales_y AS
SELECT 
p.product_name,
YEAR(s.order_date) As Year,
SUM(sales_amount) AS Total_revenue
FROM fact_sales s 
LEFT JOIN dim_products p 
ON s.product_key=p.product_key
GROUP BY p.product_name, YEAR(s.order_date)
ORDER BY p.product_name, YEAR(s.order_date);

-- YOY analysis, avg sales and compare with previous sale
SELECT 
product_name,
Year,
Total_revenue,
ROUND(AVG(Total_revenue) OVER(PARTITION BY product_name),2) AS AVG_revenue_y,
-- comparing with avg 
CASE 
	WHEN Total_revenue< ROUND(AVG(Total_revenue) OVER(PARTITION BY product_name),2) THEN 'Below Avg'
    WHEN Total_revenue >=ROUND(AVG(Total_revenue) OVER(PARTITION BY product_name),2) THEN 'Above Avg'
END AS performane_avg,
-- performane compared to previous year sales
LAG(Total_revenue,1,0)OVER(PARTITION BY product_name) AS prev_year_revenue,
CASE 
	WHEN Total_revenue< LAG(Total_revenue,1,0)OVER(PARTITION BY product_name) THEN 'Below'
    WHEN Total_revenue >=LAG(Total_revenue,1,0)OVER(PARTITION BY product_name)  THEN 'Above'
END AS performane_YOY
FROM product_sales_y;

-- Sales analysis YOY and MOM
CREATE VIEW yearly_sales AS 
SELECT
YEAR(order_date) AS Year,
SUM(sales_amount) AS Total_revenue
FROM fact_sales
GROUP BY YEAR(order_date)
ORDER BY YEAR(order_date);

CREATE VIEW Monthly_sales2 AS 
SELECT
YEAR(order_date) AS Year,
MONTHNAME(order_date) AS Month,
SUM(sales_amount) AS Total_revenue
FROM fact_sales
GROUP BY YEAR(order_date),MONTHNAME(order_date)
ORDER BY YEAR(order_date),MONTHNAME(order_date)
;

-- Compare monthly sales with the avg sales per year
SELECT 
Year,
Month,
Total_revenue,
ROUND(AVG(Total_revenue)OVER(PARTITION BY Year),2) AS Avg_sales_yearly,
CASE 
	WHEN Total_revenue<ROUND(AVG(Total_revenue)OVER(PARTITION BY Year),2) THEN 'Below Avgerage'
    WHEN Total_revenue>=ROUND(AVG(Total_revenue)OVER(PARTITION BY Year),2) THEN 'Above Avgerage'
END AS Performane_avg,
-- Comparison with previous month
CASE 
	WHEN Total_revenue< LAG(Total_revenue,1,0)OVER(PARTITION BY Year) THEN 'Below'
    WHEN Total_revenue >=LAG(Total_revenue,1,0)OVER(PARTITION BY Year)THEN 'Above'
END AS performane_MOM
FROM Monthly_sales2;

-- Avg order value per country 
SELECT 
c.country,
ROUND(AVG(s.sales_amount),2) AS Avg_sales_amount
FROM fact_sales s 
LEFT JOIN dim_customers c 
ON s.customer_key=c.customer_key
GROUP BY c.country;