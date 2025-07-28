
/*
===============================================================================
Dimensions Exploration
===============================================================================
Purpose:
    - To explore the structure of dimension tables.
	
SQL Functions Used:
    - DISTINCT
    - ORDER BY
===============================================================================
*/

-- Retrieve a list of unique countries, region and states
SELECT DISTINCT 
    country,
    region,
    state_name
FROM gold.dim_location
ORDER BY country;


-- Retrieve a list of unique factories, divisions, and products
SELECT DISTINCT 
    factory, 
    division, 
    product_name 
FROM gold.dim_products
ORDER BY factory, division, product_name;
