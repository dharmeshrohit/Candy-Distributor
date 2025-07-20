/*
===============================================================================
DDL Script: Create Bronze Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'bronze' schema, dropping existing tables 
    if they already exist.
	  Run this script to re-define the DDL structure of 'bronze' Tables
===============================================================================
*/

-- Create the factories table
IF OBJECT_ID('bronze.factories', 'U') IS NOT NULL
    DROP TABLE bronze.factories;
GO
CREATE TABLE bronze.factories (
    Factory   VARCHAR(50),
    Latitude  FLOAT,
    Longitude FLOAT
);


-- Create the products table
IF OBJECT_ID('bronze.products', 'U') IS NOT NULL
    DROP TABLE bronze.products;
GO
CREATE TABLE bronze.products (
    Division      VARCHAR(50),
    Product_Name  VARCHAR(50),
    Factory       VARCHAR(50),
    Product_ID    VARCHAR(50),
    Unit_Price    FLOAT,
    Unit_Cost     FLOAT
);


-- Create the sales table
IF OBJECT_ID('bronze.sales', 'U') IS NOT NULL
    DROP TABLE bronze.sales;
GO
CREATE TABLE bronze.sales (
    Row_ID          INT,
    Order_ID        VARCHAR(50),
    Order_Date      DATE,
    Ship_Date       DATE,
    Ship_Mode       VARCHAR(50),
    Customer_ID     INT,
    Country         VARCHAR(50),
    City            VARCHAR(50),
    State_Province  VARCHAR(50),
    Postal_Code     VARCHAR(50),
    Division        VARCHAR(50),
    Region          VARCHAR(50),
    Product_Id      VARCHAR(50),
    Product_Name    VARCHAR(50),
    Sales           FLOAT,
    Units           INT,
    Gross_Profit    FLOAT,
    Cost            FLOAT
);


-- Create the targets table
IF OBJECT_ID('bronze.targets', 'U') IS NOT NULL
    DROP TABLE bronze.targets;
GO
CREATE TABLE bronze.targets (
    Division VARCHAR(50),
    Target   INT
);


-- Create the uszips table
IF OBJECT_ID('bronze.uszips', 'U') IS NOT NULL
    DROP TABLE bronze.uszips;
GO
CREATE TABLE bronze.uszips (
    zip                 VARCHAR(50),
    lat                 FLOAT,
    lng                 FLOAT,
    city                VARCHAR(50),
    state_id            VARCHAR(50),
    state_name          VARCHAR(50),
    zcta                VARCHAR(50),
    parent_zcta         VARCHAR(50),
    population          INT,
    density             FLOAT,
    county_fips         INT,
    county_name         VARCHAR(50),
    county_weights      VARCHAR(100),
    county_names_all    VARCHAR(100),
    county_fips_all     VARCHAR(100),
    imprecise           VARCHAR(50),
    military            VARCHAR(50),
    timezone            VARCHAR(50)
);
