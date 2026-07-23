-- Date Exploration

--
SELECT 
'First order' AS Order_,
MIN(OrderDate) AS Date
FROM amazon_sales
UNION
SELECT 
'Last order' AS Order_,
MAX(OrderDate) AS Date
FROM amazon_sales
;

-- Total timespan for sales report
SELECT 
MAX(OrderDate) AS Last_order,
MIN(OrderDate) AS First_date,
TIMESTAMPDIFF(YEAR,MIN(OrderDate),MAX(OrderDate)) AS Range_in_years,
TIMESTAMPDIFF(MONTH,MIN(OrderDate),MAX(OrderDate)) AS Range_in_months,
TIMESTAMPDIFF(DAY,MIN(OrderDate),MAX(OrderDate)) AS Range_in_days
FROM amazon_sales;

-- Timespan for all customers first and last orders 
WITH Customer_orders_date AS 
(
SELECT 
CustomerID,
MIN(OrderDate) AS First_order_date,
MAX(OrderDate) AS Last_order_date,
TIMESTAMPDIFF(MONTH,MIN(OrderDate),MAX(OrderDate)) AS Range_in_months
FROM amazon_sales
GROUP BY CustomerID
ORDER BY CustomerID
)
SELECT c1.CustomerId,
c2.CustomerName,
c1.First_order_date,
c1.Last_order_date,
c1.Range_in_months
FROM Customer_orders_date c1 
JOIN amazon_sales c2 
ON c1.CustomerId=c2.CustomerID
ORDER BY c1.CustomerId;  -- same customerId with different customer name 

SELECT *
FROM amazon_sales
WHERE CustomerId='CUST000006';

-- Distinct sales year
SELECT
DISTINCT YEAR(Orderdate) AS Year
FROM amazon_sales
ORDER BY YEAR(Orderdate);

