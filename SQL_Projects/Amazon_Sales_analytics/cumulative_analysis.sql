-- Cumulative analysis 


-- Monthly total sales over years 
CREATE VIEW sales_monthly AS
SELECT 
YEAR(Orderdate) AS Year,
MONTH(OrderDate) AS Month,
MONTHNAME(OrderDate) AS Month_name,
ROUND(SUM(TotalAmount),2) AS Total_revenue
FROM amazon_sales
GROUP BY YEAR(Orderdate),MONTH(OrderDate),MONTHNAME(OrderDate) 
ORDER BY YEAR(Orderdate),MONTH(OrderDate),MONTHNAME(OrderDate) ;

SELECT 
Year,
Month_name,
Total_revenue,
ROUND(SUM(Total_revenue)OVER(PARTITION BY YEAR ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW),2) AS Running_sales_total,
ROUND(SUM(Total_revenue)OVER(PARTITION BY Year),2) AS Yearly_sales
FROM sales_monthly;

-- Quarterly sales over time 
CREATE VIEW sales_quarterly AS
SELECT 
YEAR(Orderdate) AS Year,
QUARTER(OrderDate) AS Quarter_,
ROUND(SUM(TotalAmount),2) AS Total_revenue
FROM amazon_sales
GROUP BY YEAR(Orderdate),QUARTER(OrderDate)
ORDER BY YEAR(Orderdate),QUARTER(OrderDate) ;

SELECT 
Year,
Quarter_,
Total_revenue,
ROUND(SUM(Total_revenue)OVER(PARTITION BY YEAR ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW),2) AS Running_sales_total,
ROUND(SUM(Total_revenue)OVER(PARTITION BY Year),2) AS Yearly_sales
FROM sales_quarterly;