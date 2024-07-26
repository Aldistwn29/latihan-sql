create database perusahaan_elektronik;

use perusahaan_elektronik;

show tables;

-- Buatlah query dengan menggunakan subquery untuk mencari customer 
-- yang melakukan pembelian pertama pada tanggal 25-27 Februari 2024

select * from customers;
select * from products;
select * from orders;

 -- Buatlah query dengan menggunakan subquery untuk mencari customer 
-- yang melakukan pembelian pertama pada tanggal 25-27 Februari 2024

select o.customer_id
from orders as o
where o.order_date between "2/25/20024" and "2/27/2024"
order by o.order_date
limit 1;

select c.customer_id, c.customer_name, c.email
from customers as c 
where c.customer_id in(
select o.customer_id
from orders as o
where o.order_date between "2/25/20024" and "2/27/2024"
group by o.customer_id
order by o.order_date)
limit 1;

-- Buatlah subquery untuk menampilkan order_id yang memiliki lebih dari 1 jenis produk.

SELECT order_id
FROM order_items
GROUP BY order_id
HAVING COUNT(DISTINCT product_id) > 1;

select order_id
from orders
where order_id in (
select order_id
from order_items
group by order_id
having count(distinct product_id) > 1
);

-- Buatlah subquery untuk menampilkan customer dengan total pembelanjaan (total price) paling banyak

-- butuh tabel yg ada cutomer
-- butuh tabel yg ada harga dan quantity

select c.customer_id, c.customer_name, t.total_price
from customers as c
join (
	select o.customer_id, sum(oi.quantity * p.price) as total_price
    from orders as o
    join order_items as oi
    on o.order_id = oi.order_id
    join products as p
    on oi.product_id = p.product_id
    group by o.customer_id
    limit 2
) as t 
  on c.customer_id = t.customer_id
  order by t.total_price desc;
    

-- Buatlah subquery untuk menampilkan jenis produk yang memiliki harga 2x lipat lebih tinggi dari harga Smartphone.
 
 select (2 * p1.price) as harga_2_kali_lipat_smartphone
 from products as p1
 where p1.product_name = "Smartphone";
 
 select product_name, price 
 from products 
 where price = (
	select (2 * price) 
    from products 
    where product_name = "Smartphone"
);



