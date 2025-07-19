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
