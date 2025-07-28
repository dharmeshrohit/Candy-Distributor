/*
===============================================================================
Ranking Analysis
===============================================================================
Purpose:
    - To rank items (e.g., products, customers) based on performance or other metrics.
    - To identify top performers or laggards.

SQL Functions Used:
    - Window Ranking Functions: RANK(), DENSE_RANK(), ROW_NUMBER(), TOP
    - Clauses: GROUP BY, ORDER BY
===============================================================================
*/

-- Which 5 products Generating the Highest Revenue?
-- Simple Ranking
SELECT TOP 5
    p.product_name,
    SUM(f.sales) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
    ON p.product_id = f.product_id
GROUP BY p.product_name
ORDER BY total_revenue DESC;

-- Complex but Flexibly Ranking Using Window Functions
SELECT *
FROM (
    SELECT
        p.product_name,
        SUM(f.sales) AS total_revenue,
        RANK() OVER (ORDER BY SUM(f.sales) DESC) AS rank_products
    FROM gold.fact_sales f
    LEFT JOIN gold.dim_products p
        ON p.product_id = f.product_id
    GROUP BY p.product_name
) AS ranked_products
WHERE rank_products <= 5;

-- What are the 5 worst-performing products in terms of sales?
SELECT TOP 5
    p.product_name,
    SUM(f.sales) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
    ON p.product_id = f.product_id
GROUP BY p.product_name
ORDER BY total_revenue;

-- Find the top 10 customers who have generated the highest revenue
SELECT TOP 10
    c.customer_id,
    SUM(f.sales) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_location c
    ON c.customer_id = f.customer_id
GROUP BY 
    c.customer_id
ORDER BY total_revenue DESC;

-- The 3 customers with the fewest orders placed
SELECT TOP 3
    c.customer_id,
    COUNT(DISTINCT order_id) AS total_orders
FROM gold.fact_sales f
LEFT JOIN gold.dim_location c
    ON c.customer_id = f.customer_id
GROUP BY 
    c.customer_id
ORDER BY total_orders ;