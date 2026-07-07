# Zepto Inventory SQL Analysis

Exploratory data analysis of a Zepto (quick-commerce grocery) product inventory dataset using SQL. The project covers data exploration, data cleaning, and business-driven analysis using MySQL.

## Dataset

The dataset contains 3,732 product records from Zepto's inventory with the following columns:

| Column | Description |
|---|---|
| SKU_id | Unique identifier for each product (auto-increment primary key) |
| category | Product category (e.g. Fruits & Vegetables, Snacks, Beverages) |
| name | Product name |
| mrp | Maximum retail price (originally in paise, converted to rupees) |
| discountPercent | Discount percentage offered on the product |
| availableQuantity | Quantity available in stock |
| discountedSellingPrice | Final selling price after discount (originally in paise, converted to rupees) |
| weightInGrams | Weight of the product in grams |
| outOfStock | Stock status (1 = out of stock, 0 = in stock) |
| quantity | Order quantity/pack size |

## Tools Used

- MySQL
- SQL concepts: aggregation, window functions, CASE statements, subqueries, GROUP BY/HAVING

## Project Workflow

**1. Database Setup**
Created the `zepto` database and `inventory` table with appropriate data types and constraints.

**2. Data Exploration**
- Counted total records and identified distinct products
- Found duplicate product entries using GROUP BY and window functions
- Checked for null values across all columns
- Calculated total inventory worth before and after discount
- Reviewed category-wise product counts with running totals
- Identified out-of-stock products

**3. Data Cleaning**
- Converted `mrp` and `discountedSellingPrice` from paise to rupees
- Identified and removed records with zero MRP or zero selling price

## Business Questions Answered

1. Find the top 10 best-value products based on discount percentage
2. Identify products with high MRP that are out of stock
3. Calculate estimated revenue for each category
4. Find products where MRP is greater than ₹500 but discount is less than 10%
5. Identify the top 5 categories offering the highest average discount percentage
6. Calculate price per gram for products above 100g and sort by best value
7. Group products into Low, Medium, and Bulk categories based on order quantity
8. Calculate total inventory weight per category

## Files

- `Project_zepto(SQL).sql` — Full SQL script covering table creation, data exploration, cleaning, and analysis queries
- `zepto_products.csv` — Raw dataset used to populate the inventory table

## Key Insights

- Several high-MRP products were found to be out of stock, indicating potential lost revenue opportunities
- Discount percentages vary significantly across categories, with some categories consistently offering deeper discounts
- Price-per-gram analysis reveals which products offer the best value relative to their weight
