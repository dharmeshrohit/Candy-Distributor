/*
===============================================================================
DDL Script: Create Gold Views
===============================================================================
Script Purpose:
    This script creates views for the Gold layer in the data warehouse. 
    The Gold layer represents the final dimension and fact tables (Star Schema)

    Each view performs transformations and combines data from the Silver layer 
    to produce a clean, enriched, and business-ready dataset.

Usage:
    - These views can be queried directly for analytics and reporting.
===============================================================================
*/

-- =============================================================================
-- Create Dimension: gold.dim_products
-- =============================================================================
IF OBJECT_ID('gold.dim_products', 'V') IS NOT NULL
    DROP VIEW gold.dim_products;
GO
CREATE VIEW gold.dim_products AS
SELECT
    p.product_id,
    p.product_name,
    p.division,
    p.unit_Price,
    p.unit_Cost,
    f.factory,
    t.target
FROM silver.products p
LEFT JOIN silver.factories f ON p.factory = f.factory
LEFT JOIN silver.targets t ON p.division = t.division
WHERE p.product_id IS NOT NULL;
GO

-- =============================================================================
-- Create Fact Table: gold.fact_sales
-- =============================================================================
IF OBJECT_ID('gold.fact_sales', 'V') IS NOT NULL
    DROP VIEW gold.fact_sales;
GO
CREATE VIEW gold.fact_sales AS
SELECT
    s.order_id,
    s.customer_id,
    s.order_date,
    s.ship_date,
    s.ship_mode,
    s.product_id,
    s.product_name,
    s.division,
    s.sales,
    s.units,
    s.gross_profit,
    s.cost,
    t.target
FROM silver.sales s
LEFT JOIN silver.targets t ON s.division = t.division
WHERE s.order_id IS NOT NULL;
GO

-- =============================================================================
-- Create Fact Table: gold.dim_location
-- =============================================================================
IF OBJECT_ID('gold.dim_location', 'V') IS NOT NULL
    DROP VIEW gold.dim_location;
GO
CREATE VIEW gold.dim_location AS
SELECT
    l.zip,
    s.customer_id,
    l.lat AS latitude,
    l.lng AS longitude,
    l.city,
    l.state_name,
    l.zcta,
    l.population,
    l.density,
    l.county_fips,
    l.county_name,
    s.country,
    s.region,
    l.imprecise,
    l.military,
    l.timezone
FROM silver.uszips l
LEFT JOIN silver.sales s ON l.zip = s.postal_code
WHERE s.customer_id IS NOT NULL
  AND l.zip IS NOT NULL;
GO

