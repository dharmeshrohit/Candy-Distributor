-- ====================================================================
-- Checking 'silver.products'
-- ====================================================================
-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results
SELECT 
    Product_ID,
    COUNT(*) 
FROM silver.products
GROUP BY product_id
HAVING COUNT(*) > 1 OR product_id IS NULL;

-- Check for Unwanted Spaces
-- Expectation: No Results
SELECT 
    product_name
FROM silver.products
WHERE product_name != TRIM(product_name);

-- Check for NULLs or Negative Values in Cost
-- Expectation: No Results
SELECT 
    unit_price 
FROM silver.products
WHERE unit_price < 0 OR unit_price IS NULL;
