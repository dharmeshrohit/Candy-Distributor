/*
===============================================================================
Stored Procedure: Load Silver Layer (Bronze -> Silver)
===============================================================================
Script Purpose:
    This stored procedure performs the ETL (Extract, Transform, Load) process to 
    populate the 'silver' schema tables from the 'bronze' schema.
	Actions Performed:
		- Truncates Silver tables.
		- Inserts transformed and cleansed data from Bronze into Silver tables.
		
Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC Silver.load_silver;
===============================================================================
*/

CREATE OR ALTER PROCEDURE silver.load_silver AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME; 
    BEGIN TRY
        SET @batch_start_time = GETDATE();
        PRINT '================================================';
        PRINT 'Loading Silver Layer';
        PRINT '================================================';

		-- Loading silver.factories
        SET @start_time = GETDATE();
		PRINT '>> Truncating Table: silver.factories';
		TRUNCATE TABLE silver.factories;
		PRINT '>> Inserting Data Into: silver.factories';
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
        SET @end_time = GETDATE();
    PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
    PRINT '>> -------------';
    
		
        -- Loading silver.products
    SET @start_time = GETDATE();
		PRINT '>> Truncating Table: silver.products';
		TRUNCATE TABLE silver.products;
		PRINT '>> Inserting Data Into: silver.products';
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
    SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';


        -- Loading silver.sales
    SET @start_time = GETDATE();
		PRINT '>> Truncating Table: silver.sales';
		TRUNCATE TABLE silver.sales;
		PRINT '>> Inserting Data Into: silver.sales';
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
    SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';


         -- Loading targets
    SET @start_time = GETDATE();
		PRINT '>> Truncating Table: silver.targets';
		TRUNCATE TABLE silver.targets;
		PRINT '>> Inserting Data Into: silver.targets';
		INSERT INTO silver.targets (
            division,
            target
        )
        SELECT 
            TRIM(division) AS division,
            target
        FROM bronze.targets;
    SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';

        -- Loading uszips
    SET @start_time = GETDATE();
		PRINT '>> Truncating Table: silver.uszips';
		TRUNCATE TABLE silver.uszips;
		PRINT '>> Inserting Data Into: silver.uszips';
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
    SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';

		SET @batch_end_time = GETDATE();
		PRINT '=========================================='
		PRINT 'Loading Silver Layer is Completed';
        PRINT '   - Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
		PRINT '=========================================='
		
	END TRY
	BEGIN CATCH
		PRINT '=========================================='
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '=========================================='
	END CATCH
END