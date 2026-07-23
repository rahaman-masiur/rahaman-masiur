-- Performance analytics 

-- YoY sales analysis 
WITH sales_details_yearly AS
(
SELECT 
YEAR(OrderDate) AS Current_Year,
ROUND(SUM(TotalAmount),2) AS Total_revenue,
LAG(ROUND(SUM(TotalAmount)),1,0) OVER(ORDER BY YEAR(OrderDate)) AS Prev_year_Revenue,
ROUND(SUM(TotalAmount)- LAG(SUM(TotalAmount),1,'N/A') OVER(ORDER BY YEAR(OrderDate)),2) AS Difference_

FROM amazon_sales
GROUP BY YEAR(OrderDate)
ORDER BY YEAR(OrderDate)
)
SELECT 
Current_year,
Total_revenue AS Current_year_revenue,
Prev_year_revenue,
ROUND(((Total_revenue-Prev_year_revenue)/Prev_year_revenue)*100,2) AS 'Revenue_change(%)',
-- ROUND(AVG(Total_revenue)OVER(),2) AS Avg_sales,
-- report
CASE
	WHEN Total_revenue<ROUND(AVG(Total_revenue)OVER(),2) THEN 'Below_avg'
    WHEN Total_revenue>=ROUND(AVG(Total_revenue)OVER(),2) THEN 'Above_avg'
END AS Performane_avg
FROM sales_details_yearly;


-- Quantity analysis 

WITH sales_details_yearly AS
(
SELECT 
YEAR(OrderDate) AS Current_Year,
ROUND(SUM(Quantity),2) AS Total_quantity,
LAG(ROUND(SUM(Quantity)),1,0) OVER(ORDER BY YEAR(OrderDate)) AS Prev_Year_quantity_sold,
ROUND(SUM(Quantity)- LAG(SUM(Quantity),1,'N/A') OVER(ORDER BY YEAR(OrderDate)),2) AS Difference_

FROM amazon_sales
GROUP BY YEAR(OrderDate)
ORDER BY YEAR(OrderDate)

)
SELECT 
Current_year,
Total_quantity AS Current_year_quantity_sold,
Prev_year_quantity_sold,
ROUND(((Total_quantity-Prev_year_quantity_sold)/Prev_year_quantity_sold)*100,2) AS 'quantity_change_in_sales(%)',
-- ROUND(AVG(Quantity)OVER(),2) AS Avg_sales,
-- report
CASE
	WHEN Total_quantity<ROUND(((Total_quantity-Prev_year_quantity_sold)/Prev_year_quantity_sold)*100,2) THEN 'Below_avg'
    WHEN Total_quantity>=ROUND(((Total_quantity-Prev_year_quantity_sold)/Prev_year_quantity_sold)*100,2) THEN 'Above_avg'
END AS Performane_avg
FROM sales_details_yearly;


