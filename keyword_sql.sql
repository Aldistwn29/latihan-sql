-- Membuat database
-- create database ngulik_data;
use ngulik_data;

-- Soal 1
-- -- Soal 1
-- Buatlah query untuk memunculkan jenis produk yang memiliki kuantitas penjualan yang lebih besar dari rerata penjualan

-- DI BANTU CHAT GPT
-- WITH rerata AS (
--   SELECT AVG(total_quantity) AS rerata_quantity
--     FROM (
--       -- Menghitung total kuantiti per produk
--       SELECT product_id, SUM(quantity) AS total_quantity
--         FROM data_sales
--         GROUP BY product_id
--     ) AS product_total
-- )
-- SELECT p.product_name
--   FROM data_sales AS s
--   JOIN data_products AS p
--     ON s.product_id = p.product_id
-- -- memilih nama produk dengan total kuantitas lebih dari rata rata 
-- GROUP BY p.product_name
-- HAVING SUM(s.quantity) > (SELECT rerata_quantity FROM rerata)
-- LIMIT 1;

-- ------------ lATIHAN SENDIRI------------

-- -- Mencari rata-rata quantity
-- SELECT AVG(quantity) AS rata_rata_quantity 
-- FROM data_sales AS s;

-- -- Menggabungakn 2 tabel 
-- SELECT p.product_name, SUM(s.quantity) AS total_penjualan_per_quantity
-- FROM data_sales AS s
-- JOIN data_products AS p
-- ON s.product_id = p.product_id
-- GROUP BY p.product_name
-- ORDER BY total_penjualan_per_quantity DESC;


-- -- Membuat tabel baru
-- WITH rata_rata AS (
--   -- Mencari rata-rata-quantity
--   SELECT AVG(quantity) AS rata_rata_quantity 
--   FROM data_sales AS s
-- )
-- -- Mengabungkan tabel sales dan product
-- SELECT p.product_name, SUM(s.quantity) AS total_penjualan_per_quantity
-- FROM data_sales AS s
-- JOIN data_products AS p
-- ON s.product_id = p.product_id
-- -- Mencari nama product yg melebihi rata-rata
-- GROUP BY p.product_name
-- HAVING total_penjualan_per_quantity > (SELECT rata_rata_quantity FROM rata_rata)
-- ORDER BY total_penjualan_per_quantity DESC;

-- -- soal 2
-- -- Dengan menggunakan RANK() tentukan customer dengan total amount terbanyak pada setiap kota

-- -- SELECT * FROM data_sales;
-- -- SELECT * FROM data_products;
-- -- SELECT * FROM data_customers;

-- -- SELECT c.customer_name AS nama_pegawai, c.country, SUM(s.total_amount) AS total_pembelian
-- -- FROM data_sales AS s
-- -- JOIN data_customers AS c
-- -- ON s.customer_id = c.customer_id
-- -- GROUP BY c.customer_name, c.country;

-- WITH Customers_sales AS (
-- SELECT c.customer_name AS nama_pegawai, c.country, SUM(s.total_amount) AS total_pembelian
-- FROM data_sales AS s
-- JOIN data_customers AS c
-- ON s.customer_id = c.customer_id
-- GROUP BY c.customer_name, c.country
-- ),
-- -- Rank customers
-- Ranked_Customers AS (
-- SELECT 
-- 	nama_pegawai,
--     country,
--     total_pembelian,
-- 	row_number() OVER (PARTITION BY country ORDER BY total_pembelian DESC) AS peringkat
-- FROM Customers_sales
-- )
-- -- mengambil nama
-- SELECT 
-- 	nama_pegawai,
--     country,
--     total_pembelian
-- FROM Ranked_Customers
-- WHERE peringkat = 1
-- ORDER BY total_pembelian DESC;

-- with total_spent as (
-- select c.customer_name as nama, sum(s.total_amount) as total
-- from data_sales as s
-- join data_customers as c
-- on s.customer_id = c.customer_id
-- group by nama
-- )
-- Menggunakan row_number()
-- select 
-- 	nama,
--     total,
--     row_number() over(order by total desc) as nomer_baris
-- from 
-- 	total_spent;

-- menggunakan rank()
-- select 
-- 	nama,
--     total,
--     rank() over(order by total desc) as peringkat
-- from 
-- 	total_spent;

-- menggunakan dense_rank 
-- select 
-- 	nama,
--     total,
--     dense_rank() over(order by total desc) as dense
-- from 
-- 	total_spent;

-- menggunakan nitle 
-- select 
-- 	nama,
--     total,
--     ntile(3) over(order by total desc) as ntli
-- from 
-- 	total_spent;

-- Soal 3
-- Buat kategori customer berdasarkan total quantity dan amountnya sebagai berikut :
	-- Low 	: total quantity 1-2 dan total amount <=100
-- 	Medium 	: total quantity 3-5 dan total amount 101-300
-- 	High	: total quantity >5 dan total amount >300

-- SELECT
-- 	quantity,
--     total_amount,
-- CASE
-- 	WHEN quantity <= 2 AND total_amount <= 100 THEN 'low'
--     WHEN quantity <= 5 AND total_amount <= 300 THEN 'medium'
--     ELSE 'high'
-- END AS kategori
-- FROM 
-- 	data_sales
-- ORDER BY kategori DESC;

-- Soal 4
	-- Buatlah query dengan SELECT, SUM(), and the window function SUM() OVER () 
	-- untuk menghitung kontribusi penjualan per produk terhadap keseluruhan penjualan,
	--  baik dari segi kuantitas maupun amount.

SELECT * FROM data_sales;
SELECT * FROM data_customers;
SELECT * FROM data_products;


with total_penjualan_peroduct as (
select p.product_name as nama_produk, sum(s.quantity) as total_produk, sum(s.total_amount) as total_penjualan
from data_sales as s
join data_products as p
on s.product_id = p.product_id
group by nama_produk
order by total_produk desc
)
select nama_produk, total_produk, total_penjualan,
-- menghitung total peroduk global
sum(total_produk) over() as total_penjualan_produk_global,
-- menghitung total pendapatan global
sum(total_penjualan) over() as total_penjualan_global,
-- kontribusi kuantitas
round(total_produk * 100 / sum(total_produk) over(), 2) as persetasi_penjualan_produk,
-- kontribusi penjualan
round(total_penjualan * 100 / sum(total_penjualan) over(), 2) as persentasi_penjualan
from total_penjualan_peroduct;
