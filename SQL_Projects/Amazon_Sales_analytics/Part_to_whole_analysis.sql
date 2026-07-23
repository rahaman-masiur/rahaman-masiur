-- Part to whole analysis
-- which categories contribute what percentage to the total sales 
SELECT 
Category,
ROUND(SUM(TotalAmount),2) AS Total_categorical_sales,
(SELECT ROUND(SUM(TotalAmount),2) FROM amazon_sales) AS Total_sales,
ROUND((SUM(TotalAmount)/(SELECT SUM(TotalAmount)FROM amazon_sales))*100 ,2) AS 'Total_contribution_to_whole_sales'
FROM amazon_sales
GROUP BY category;

-- which top 20 products contribute most to the total sales 

SELECT 
ProductName,
ROUND(SUM(TotalAmount),2) AS Total_product_sales,
(SELECT ROUND(SUM(TotalAmount),2) FROM amazon_sales) AS Total_sales,
ROUND((SUM(TotalAmount)/(SELECT SUM(TotalAmount)FROM amazon_sales))*100 ,2) AS 'Total_contribution_to_whole_sales'
FROM amazon_sales
GROUP BY ProductName
ORDER BY ROUND((SUM(TotalAmount)/(SELECT SUM(TotalAmount)FROM amazon_sales))*100 ,2) DESC
LIMIT 20;

-- country wise sales contribution 
SELECT 
Country,
ROUND(SUM(TotalAmount),2) AS Total_sales_,
(SELECT ROUND(SUM(TotalAmount),2) FROM amazon_sales) AS Total_overall_sales,
ROUND((SUM(TotalAmount)/(SELECT SUM(TotalAmount)FROM amazon_sales))*100 ,2) AS 'Total_contribution_to_whole_sales'
FROM amazon_sales
GROUP BY Country;

