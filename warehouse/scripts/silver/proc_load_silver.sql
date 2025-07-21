insert into silver.sales (
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
cost)


select 
row_id,
order_id,
order_date,
ship_date,
trim(ship_mode) as Ship_Mode,
Customer_ID,
trim(country) as Country,
trim(city) as City,
trim(state_province) as State_Province,
Postal_Code,
trim(Division) as Division,
trim(Region) as Region,
Product_Id,
trim(Product_Name) as Product_Name,
Sales,
Units,
Gross_Profit,
Cost
from bronze.sales
order by Row_ID asc