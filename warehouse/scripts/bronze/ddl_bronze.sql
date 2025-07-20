create table bronze.factories(
Factory		varchar(50),
Latitude	float,
Longitude	float,
)

create table bronze.products(
Division		varchar(50),
Product_Name	varchar(50),
Factory			varchar(50),
Product_ID		varchar(50),
Unit_Price		float,
Unit_Cost		float,
)


create table bronze.sales(
Row_ID		int,
Order_ID	varchar(50),
Order_Date	date,
Ship_Date	date,
Ship_Mode	varchar(50),
Customer_ID	int,
Country		varchar(50),
City		varchar(50),
State_Province	varchar(50),
Postal_Code		varchar(50),
Division		varchar(50),
Region			varchar(50),
Product_Id		varchar(50),
Product_Name	varchar(50),
Sales			float,
Units			int,
Gross_Profit	float,
Cost			float,
)


create table bronze.targets(
Division	varchar(50),
Target		int,
)

create table bronze.uszips(
zip		varchar(50),
lat		float,
lng		float,
city	varchar(50),
state_id	varchar(50),
state_name	varchar(50),
zcta	varchar(50),
parent_zcta	varchar(50),
population	int,
density		float,
county_fips	int,
county_name	varchar(50),
county_weights varchar(100),
county_names_all	varchar(100),
county_fips_all		varchar(100),
imprecise	varchar(50),
military	varchar(50),
timezone	varchar(50),
)