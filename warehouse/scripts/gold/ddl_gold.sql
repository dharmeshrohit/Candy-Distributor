create view gold.dim_products as
select
	p.product_id,
	p.product_name,
	p.division,
	p.unit_Price,
	p.unit_Cost,
	f.factory,
	t.target
from silver.products p 
left join silver.factories f
on p.factory = f.factory
left join silver.targets t
on p.division = t.division
where p.product_id is not null


create view gold.fact_sales as
select
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
from silver.sales s
left join silver.targets t
on s.division = t.division
where s.order_id is not null
