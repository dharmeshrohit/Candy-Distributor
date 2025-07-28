/*
===============================================================================
Measures Exploration (Key Metrics)
===============================================================================
Purpose:
    - To calculate aggregated metrics (e.g., totals, averages) for quick insights.
    - To identify overall trends or spot anomalies.

SQL Functions Used:
    - COUNT(), SUM(), AVG()
===============================================================================
*/

-- Find the Total Sales
SELECT SUM(sales) AS total_sales FROM gold.fact_sales

-- Find how many items are sold
SELECT SUM(units) AS total_quantity FROM gold.fact_sales

-- Find the average selling price
SELECT AVG(unit_price) AS avg_price FROM gold.fact_sales

-- Find the Total number of Orders
SELECT COUNT(order_id) AS total_orders FROM gold.fact_sales
SELECT COUNT(DISTINCT order_id) AS total_orders FROM gold.fact_sales

-- Find the total number of products
SELECT COUNT(product_name) AS total_products FROM gold.dim_products

-- Find the total number of customers
SELECT COUNT(customer_id) AS total_customers FROM gold.dim_location;

-- Find the total number of customers that has placed an order
SELECT COUNT(DISTINCT customer_id) AS total_customers FROM gold.fact_sales;

-- Generate a Report that shows all key metrics of the business
SELECT 'Total Sales' AS measure_name, SUM(sales) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Quantity', SUM(units) FROM gold.fact_sales
UNION ALL
SELECT 'Average Price', AVG(unit_price) FROM gold.fact_sales
UNION ALL
SELECT 'Total Orders', COUNT(DISTINCT order_id) FROM gold.fact_sales
UNION ALL
SELECT 'Total Products', COUNT(DISTINCT product_name) FROM gold.dim_products
UNION ALL
SELECT 'Total Customers', COUNT(customer_id) FROM gold.dim_location;