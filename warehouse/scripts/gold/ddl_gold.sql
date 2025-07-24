create view gold.dim_products as
select
	p.product_id,
	p.product_name,
	p.division,
	p.unit_Price,
	p.unit_Cost,
	f.factory
from silver.products p 
left join silver.factories f
on p.factory = f.factory