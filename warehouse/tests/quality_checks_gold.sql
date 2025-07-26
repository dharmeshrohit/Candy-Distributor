/*
===============================================================================
Quality Checks
===============================================================================
Script Purpose:
    This script performs quality checks to validate the integrity, consistency, 
    and accuracy of the Gold Layer. These checks ensure:
    - Referential integrity between fact and dimension tables.
    - Validation of relationships in the data model for analytical purposes.

Usage Notes:
    - Investigate and resolve any discrepancies found during the checks.
===============================================================================
*/

-- ====================================================================
-- Checking 'gold.dim_products'
-- ====================================================================
-- Check for Uniqueness of product id in gold.dim_produts
-- Expectation: No results 
SELECT 
    product_id,
    COUNT(*) AS duplicate_count
FROM gold.dim_products
GROUP BY product_id
HAVING COUNT(*) > 1;


-- ====================================================================
-- Checking 'gold.fact_sales'
-- ====================================================================
-- Check the data model connectivity between fact and dimensions
SELECT * 
FROM gold.fact_sales f
LEFT JOIN gold.dim_location l
ON l.customer_id = f.customer_id
LEFT JOIN gold.dim_products p
ON p.product_id = f.product_id
WHERE p.product_id IS NULL OR l.customer_id IS NULL  
