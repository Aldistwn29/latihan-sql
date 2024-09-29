use ds;

select * from sales;
select * from product;
select * from region;
select * from categoris;

-- Buatlah query untuk menghitung cost, revenue dan profit per product!
WITH keuntungan_per_produk AS 
(
	SELECT p.product_name AS nama_produk,
			s.cost,
            s.revenue,
            (s.revenue - s.cost) AS profit
	FROM sales AS s
    INNER JOIN product AS p
    ON s.product_id = p.product_id
    ORDER BY profit DESC
)

select *
from keuntungan_per_produk;

-- Buatlah ARPU (Averge Revenue Per User) untuk membandingkan setiap bulannya.
select sale_date,
		sum(revenue) as revenue,
        count(distinct customer_id ) as users
from sales
group by sale_date;

witH kpis as 
(
	select sale_date,
		sum(revenue) as revenue,
        count(distinct customer_id ) as users
from sales
group by sale_date
)
select  sale_date,
		round(revenue/users, 2) arpu 
from kpis;

-- Buat query untuk menghitung Daily Active user dan Monthly aktive user

with daily_active_user as
(
	select date(sale_date) days,
		count(distinct customer_id) as dayly_users
from sales
group by days
order by dayly_users desc
),

monthly_active_user as
(
	select 	date_format(sale_date, '%Y-%M') periode,
		count(distinct customer_id) as monthly_users
	from sales
	group by periode
	order by monthly_users desc
)

select 
		'Daily aktive user' as user_type,
        days as periode,
		dayly_users as active_users
from daily_active_user

union all

select 
		'monthly aktive user' as user_type,
        periode,
        monthly_users as active_users
from monthly_active_user

order by active_users desc;

-- Daily 
with dayly_active_user as 
(
select date(sale_date) days,
		count(distinct customer_id) as dayly_users,
        
from sales
group by days
order by dayly_users desc
)

select  from dayly_active_user;

-- Monthly
with mon as 
(
select 	date_format(sale_date, '%Y-%M') periode,
		count(distinct customer_id) as monthly_users
from sales
group by periode
)

select periode
		monthly_users,
        lag(monthly_users) over (order by periode asc) as las_mau
from mon
order by periode;

-- buatlah untuk menghitung dari jumlah order(total quantity sold)
-- per customer
-- min
-- quartel 1 (Q1)
-- quartel 2 (Q2)
-- quartel 3 (Q3)
-- max

with jumlah_pembelian as
(
	select 	
			customer_id as users,
            count(distinct quantity_sold) as jumlah_order
	from sales
    group by users
),

quartiles as 
(
	select 
			jumlah_order,
            ntile(4) over (order by jumlah_order) as quartile
	from 
			jumlah_pembelian
)

select 
		min(jumlah_order) as min_order,
        round((select jumlah_order
			   from quartiles
               where quartile = 1
               order by jumlah_order desc
               limit 1), 2) as orders_p25,
		round((select jumlah_order
			   from quartiles
               where quartile = 2
               order by jumlah_order desc
               limit 1), 2) as orders_p50,
		round((select jumlah_order
				from quartiles
                where quartile = 3
                order by jumlah_order desc
                limit 1), 2) as orders_75,
		max(jumlah_order) as max_order
from jumlah_pembelian;