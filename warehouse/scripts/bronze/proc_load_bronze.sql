/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/


CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME; 
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '================================================';
		PRINT 'Loading Bronze Layer';
		PRINT '================================================';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.factories';
		TRUNCATE TABLE bronze.factories;
		
		PRINT '>> Inserting Data Into: bronze.factories';
        BULK INSERT bronze.factories
        FROM 'D:\Candy-Distributor\datasets\Candy_Factories.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';

    SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.products';
		TRUNCATE TABLE bronze.products;

		PRINT '>> Inserting Data Into: bronze.products';
		BULK INSERT bronze.products
        FROM 'D:\Candy-Distributor\datasets\Candy_Products.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';

    SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.sales';
		TRUNCATE TABLE bronze.sales;
		PRINT '>> Inserting Data Into: bronze.sales';
		BULK INSERT bronze.sales
		FROM 'D:\Candy-Distributor\datasets\Candy_Sales.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';

	SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.targets';
		TRUNCATE TABLE bronze.targets;
		PRINT '>> Inserting Data Into: bronze.targets';
		BULK INSERT bronze.targets
		FROM 'D:\Candy-Distributor\datasets\Candy_Targets.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';

	SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.uszips';
		TRUNCATE TABLE bronze.uszips;
		PRINT '>> Inserting Data Into: bronze.uszips';
		BULK INSERT bronze.uszips
		FROM 'D:\Candy-Distributor\datasets\uszips.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '\n',
			CODEPAGE = '65001', -- For UTF-8 encoding
			FORMAT = 'CSV'
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';

	SET @batch_end_time = GETDATE();
		PRINT '=========================================='
		PRINT 'Loading Bronze Layer is Completed';
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
