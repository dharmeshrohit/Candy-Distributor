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


-- ====================================================================
-- Checking 'silver.sales'
-- ====================================================================
-- Check for Invalid Date Orders (Order Date > Shipping/Due Dates)
-- Expectation: No Results
SELECT 
    * 
FROM silver.sales
WHERE order_date > ship_date 

-- Check Data Consistency: Sales = Quantity * Price
-- Expectation: No Results
SELECT DISTINCT 
    s.sales,
    s.units,
    p.unit_price 
FROM silver.sales s
LEFT JOIN silver.products p
on s.product_id = p.product_id
WHERE sales != (s.units * p.unit_price) 
   OR s.sales IS NULL 
   OR s.Units IS NULL 
   OR p.unit_price IS NULL
   OR s.sales <= 0 
   OR s.units <= 0 
   OR p.unit_price <= 0
ORDER BY s.sales, s.units, p.unit_price;