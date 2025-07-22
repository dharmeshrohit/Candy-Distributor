INSERT INTO silver.factories (
    factory,
    latitude,
    longitude
)
SELECT 
    TRIM(Factory) AS factory,
    Latitude,
    Longitude
FROM bronze.factories;

INSERT INTO silver.products (
    division,
    product_name,
    factory,
    product_id,
    Unit_Price,
    Unit_cost
)
SELECT 
    TRIM(Division) AS division,
    TRIM(product_name) AS product_name,
    TRIM(factory) AS factory,
    TRIM(product_id) AS product_id,
    Unit_Price,
    Unit_cost
FROM bronze.products;

INSERT INTO silver.sales (
    row_id,
    order_id,
    order_date,
    ship_date,
    ship_mode,
    customer_id,
    country,
    city,
    state_province,
    postal_code,
    division,
    region,
    product_id,
    product_name,
    sales,
    units,
    gross_profit,
    cost
)
SELECT 
    row_id,
    order_id,
    order_date,
    ship_date,
    TRIM(ship_mode) AS ship_mode,
    Customer_ID,
    TRIM(country) AS country,
    TRIM(city) AS city,
    TRIM(state_province) AS state_province,
    Postal_Code,
    TRIM(Division) AS division,
    TRIM(Region) AS region,
    Product_Id,
    TRIM(Product_Name) AS product_name,
    Sales,
    Units,
    Gross_Profit,
    Cost
FROM bronze.sales
ORDER BY Row_ID ASC;

INSERT INTO silver.targets (
    division,
    target
)
SELECT 
    TRIM(division) AS division,
    target
FROM bronze.targets;

INSERT INTO silver.uszips (
    zip,
    lat,
    lng,
    city,
    state_id,
    state_name,
    zcta,
    parent_zcta,
    population,
    density,
    county_fips,
    county_name,
    county_weights,
    county_names_all,
    county_fips_all,
    imprecise,
    military,
    timezone
)
SELECT 
    zip,
    lat,
    lng,
    TRIM(city) AS city,
    TRIM(state_id) AS state_id,
    TRIM(state_name) AS state_name,
    TRIM(zcta) AS zcta,
    COALESCE(parent_zcta, 'n/a') AS parent_zcta,
    population,
    density,
    county_fips,
    TRIM(county_name) AS county_name,
    TRIM(county_weights) AS county_weights,
    TRIM(county_names_all) AS county_names_all,
    county_fips_all,
    TRIM(imprecise) AS imprecise,
    TRIM(military) AS military,
    TRIM(timezone) AS timezone
FROM bronze.uszips;