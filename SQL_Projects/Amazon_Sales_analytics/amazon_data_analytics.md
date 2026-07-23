

Readme · MD
# Advanced SQL Data Analytics
 
SQL-based analytics project on a sales dataset (customers, products, sales facts), covering trends, cumulative metrics, performance benchmarking, part-to-whole contribution, segmentation, and a final customer report.
 
## Dataset
 
| Table | Source File | Description |
|---|---|---|
| `dim_customers` | `gold_dim_customers.csv` | Customer details — name, country, gender, birthdate |
| `dim_products` | `gold_dim_products.csv` | Product details — category, subcategory, cost, product line |
| `fact_sales` | `gold_fact_sales.csv` | Sales transactions — order, dates, sales amount, quantity, price |
 
`fact_sales` connects to both dimension tables via `product_key` and `customer_key`.
 
## Files
 
| File | What it covers |
|---|---|
| `table_and_dataset.sql` | Database & table setup, keys, data cleaning, partitioning |
| `Trend_analysis.sql` | Sales trends over time — daily, monthly, quarterly, yearly |
| `Cumulative_analysis.sql` | Running totals and moving averages |
| `Performance_analysis.sql` | YoY / MoM performance vs. average and previous period |
| `Part_to_whole_analysis.sql` | Revenue contribution by category, product, country, age group |
| `Data_segmentation.sql` | Customer age & spend segments, product cost segments |
| `Report.sql` | Consolidated customer profile & ranking report |
 
## Tools
 
MySQL · Views · CTEs · Window Functions · Joins
 
## How to Run
 
1. Run `table_and_dataset.sql` to create and clean the schema.
2. Run any other file — each is self-contained.
 
