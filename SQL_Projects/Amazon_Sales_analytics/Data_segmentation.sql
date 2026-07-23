 -- Data segmentation 
 
 -- Categorize products based on their unit price into 3 category
 CREATE VIEW Product_Description AS 
 SELECT 
 ProductID,
 ProductName,
 ROUND(AVG(UnitPrice),2) AS Avg_product_price
 FROM amazon_sales
 GROUP BY ProductID, ProductName
 ORDER BY ProductID,ProductName;
 
 -- Classify order below and above 300 rupees and labelled them as cheap and Expensive
 SELECT 
 ProductID,
 ProductName,
 CASE 
	WHEN Avg_product_price<300 THEN "Cheap"
    WHEN Avg_product_price>=300 THEN "Expensive"
END AS product_classification 
FROM Product_Description;

-- Categorize customers based on their total order value
	-- spending 2500 or more and using amazon for at least 12 months(VIP customers)
	-- spending less than 2500 and using amazon for 12 months or more(regular customers)
	-- spending less than 1000 or using amazon for less than 12 months 

-- require first order,date last order date, 
CREATE VIEW customer_details AS 
SELECT 
CustomerID,
CustomerName,
MIN(OrderDate) AS First_order_date,
MAX(OrderDate) AS Last_order_date,
TIMESTAMPDIFF(Month,MIN(OrderDate),MAX(OrderDate)) AS Months_active,
ROUND(SUM(TotalAmount),2) AS Total_spending
FROM amazon_sales
GROUP BY CustomerID,CustomerName
ORDER BY CustomerID,CustomerName;

SELECT 
CustomerID,
CustomerName,
Total_spending,
CASE 
	WHEN Total_spending>2500 AND Months_active>=12 THEN 'VIP'
    WHEN Total_spending<2500 AND Total_spending>=1000 AND Months_active<=12 THEN 'Regular'
    WHEN Total_spending<1000 OR  Months_active<12 THEN 'New'
END AS Classification 
FROM customer_details;

