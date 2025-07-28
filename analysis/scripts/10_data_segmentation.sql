/*
===============================================================================
Data Segmentation Analysis
===============================================================================
Purpose:
    - To group data into meaningful categories for targeted insights.
    - For customer segmentation, product categorization, or regional analysis.

SQL Functions Used:
    - CASE: Defines custom segmentation logic.
    - GROUP BY: Groups data into segments.
===============================================================================
*/

/*Segment products into cost ranges and 
count how many products fall into each segment*/
WITH product_segments AS (
    SELECT
        product_id,
        product_name,
        unit_Cost,
        CASE 
            WHEN unit_Cost < 1 THEN 'Below 1'
            WHEN unit_Cost BETWEEN 1 AND 5 THEN '1-5'
            WHEN unit_Cost BETWEEN 5 AND 10 THEN '5-10'
            ELSE 'Above 10'
        END AS cost_range
    FROM gold.dim_products
)
SELECT 
    cost_range,
    COUNT(product_id) AS total_products
FROM product_segments
GROUP BY cost_range
ORDER BY total_products DESC;

/*Group customers into three segments based on their spending behavior:
	- VIP: Customers with at least 12 months of history and spending more than 1,000.
	- Regular: Customers with at least 12 months of history but spending 1,000 or less.
	- New: Customers with a lifespan less than 12 months.
And find the total number of customers by each group
*/
WITH customer_spending AS (
    SELECT
        l.customer_id,
        SUM(f.sales) AS total_spending,
        MIN(order_date) AS first_order,
        MAX(order_date) AS last_order,
        DATEDIFF(month, MIN(order_date), MAX(order_date)) AS lifespan
    FROM gold.fact_sales f
    LEFT JOIN gold.dim_location l
        ON f.customer_id = l.customer_id
    GROUP BY l.customer_id
)
SELECT 
    customer_segment,
    COUNT(customer_id) AS total_customers
FROM (
    SELECT 
        customer_id,
        CASE 
            WHEN lifespan >= 12 AND total_spending > 1000 THEN 'VIP'
            WHEN lifespan >= 12 AND total_spending <= 1000 THEN 'Regular'
            ELSE 'New'
        END AS customer_segment
    FROM customer_spending
) AS segmented_customers
GROUP BY customer_segment
ORDER BY total_customers DESC;