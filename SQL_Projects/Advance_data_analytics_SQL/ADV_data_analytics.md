# Advanced SQL Data Analytics Project

An end-to-end SQL analytics project built on the **AdventureWorks-style "Gold Layer"** dataset (customers, products, and sales facts). The project covers database setup and data cleaning, exploratory analysis, and advanced analytical techniques — cumulative trends, performance benchmarking, part-to-whole contribution, customer/product segmentation, and a final consolidated customer report.

---

## 📂 Dataset Overview

The dataset follows a simple **star schema**: one fact table (sales transactions) surrounded by two dimension tables (customers and products).

| File | Table | Rows | Description |
|---|---|---|---|
| `gold_dim_customers.csv` | `dim_customers` | ~18,484 | Customer master data — name, country, marital status, gender, birthdate, account creation date |
| `gold_dim_products.csv` | `dim_products` | ~295 | Product master data — product name, category, subcategory, cost, maintenance flag, product line |
| `gold_fact_sales.csv` | `fact_sales` | ~60,398 | Sales transactions — order number, product/customer keys, order/shipping/due dates, sales amount, quantity, price |

**Schema relationships:**
- `fact_sales.product_key` → `dim_products.product_key`
- `fact_sales.customer_key` → `dim_customers.customer_key`

---

## 🗂️ Project Files

### `table_and_dataset.sql`
Sets up the database (`AdvanceDataAnalytics`), creates the three tables (`dim_customers`, `dim_products`, `fact_sales`) with appropriate data types, and defines primary/foreign key constraints. Also includes data cleaning steps: identifying and removing orphaned sales records (sales referencing non-existent customers), removing products with blank categories, and partitioning `fact_sales` by year for performance.

### `Trend_analysis.sql`
**Change-over-time analysis.** Examines how sales behave across different time granularities:
- Daily, monthly, quarterly, and yearly sales totals
- Monthly quantity sold trends
- Distinct customer counts over time (monthly and yearly)
- Quarterly order counts with yearly totals using window functions

### `Cumulative_analysis.sql`
**Running totals and moving averages.** Uses window functions to track how metrics accumulate over time:
- Monthly sales with a running cumulative total
- Moving average of price over time
- Cumulative quantity sold by month

### `Performance_analysis.sql`
**Year-over-year (YOY) and month-over-month (MOM) performance benchmarking.** Compares current performance against historical baselines:
- Product-level YOY revenue vs. its own average and vs. the previous year (using `LAG`)
- Monthly revenue vs. yearly average, and MOM comparison
- Average order value by country

### `Part_to_whole_analysis.sql`
**Contribution analysis.** Uses window functions (`SUM() OVER()`) to calculate what percentage each part contributes to the whole:
- Revenue contribution by product category
- Revenue contribution by individual product
- Revenue contribution by country
- Revenue contribution by customer age group

### `Data_segmentation.sql`
**Grouping records into meaningful buckets.**
- Customers segmented into age groups (≤20, 21–40, 41–60, 60+)
- Products segmented into cost ranges (Below 500, 500–1000, 1000–1500, Above 1500) with count, total cost, and average cost per segment
- Customers segmented into **VIP / Regular / New** based on order lifespan (≥12 months) and total spending (≥5000)

### `Report.sql`
**Final consolidated customer report.** Builds a `Base_table` view joining sales, products, and customers, then a `Customer_profile` view summarizing each customer's:
- Last order date, total spend, total quantity purchased, total distinct products purchased
- Order lifespan (in months) and average monthly spending
- Average order value
- Customers ranked by total spend

---

## 🛠️ Tools & Concepts Used
MySQL · Views · CTEs (including multi-CTE chains) · Window functions (`SUM() OVER`, `AVG() OVER`, `LAG()`) · `CASE` expressions · Aggregate functions · Table partitioning · Joins (`LEFT`/`INNER`) · Data cleaning & referential integrity checks

---

## 📌 How to Use
1. Run `table_and_dataset.sql` first to create the database, tables, and load/clean the data.
2. Run the remaining `.sql` files in any order — each is self-contained and builds its own views as needed.
3. See `key_questions.txt` for the full list of business questions this project answers.
