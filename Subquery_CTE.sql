-- Membuat database
create database subquery_cte;

-- Masuk ke database
use subquery_cte;

-- Membuat tabel product dan
create table orders (
	id int auto_increment primary key ,
    id_pembelian int not null,
    tanggal date not null,
    total_pembelian int not null
);

create table products (
	id int primary key,
	nama_produk varchar(50) not null,
    harga int not null,
    terjual int not null,
    foreign key (id) references orders(id) 
);

show tables;
drop tables if exists products;
describe orders;
describe products;

-- Mengisi Nilai di tabel orders dan Products
INSERT INTO orders (id, id_pembelian, tanggal, total_pembelian) VALUES
(1, 1, '2023-11-01', 100000),
(2, 2, '2023-11-02', 150000),
(3, 1, '2023-11-03', 200000),
(4, 3, '2023-11-04', 250000);
insert into products(id, nama_produk, harga, terjual)
values 
(1, 'Sabun Mandi', 10000, 100),
(2, 'Pasta Gigi', 15000, 80),
(3, 'Shampo', 20000, 120),
(4, 'Deterjen', 25000, 90);

select * from orders;
select * from products;

-- Subquery
-- Pada tabel products berikut, dengan menggunakan subquery, 
-- temukan produk dengan harga lebih tinggi dari rata-rata harga semua produk!

select nama_produk
from products
where harga > (select avg(harga) as rata_harga from products);
-- menampilkan nama produk dan harga
select nama_produk, harga from products;
-- menampilkan rata-rata harga
select avg(harga) as rata_harga
from products;

-- Dari tabel orders berikut, dengan menggunakan Common Table Expression, 
-- temukan total pembelian untuk setiap pelanggan dan urutkan berdasarkan total pembelian dari tertinggi ke terendah!

select * from orders;

with TotalPembelianPerPelanggan as(
	select id_pembelian, sum(total_pembelian) as totalPembelian
	from orders
    group by id_pembelian
)
-- Pilih dari data yg berasal dari CTE "Total_pembelian" selanjutnya urutkna dari terbesar ke terkecil
select id_pembelian, totalPembelian
from TotalPembelianPerPelanggan
order by totalPembelian desc
limit 1;

select id_pembelian, total_pembelian
from(select id_pembelian, sum(total_pembelian) as total_Pembelian 
	 from orders 
     group by id_pembelian) as subquery
order by total_pembelian desc
limit 1;

-- pada soal ke tiga : 
-- Tahap Pertama: Menggunakan CTE untuk membuat tabel total pembelian per negara dengan kolom customer_country dan total pembelian dari tabel orders.
-- Revisi Pernyataan: "Menggunakan CTE untuk membuat tabel total_pembelian_per_negara dengan kolom customer_country dan total_pembelian yang dihitung dari tabel orders."
-- Tahap Kedua: Menggabungkan tabel customers dan CTE total_pembelian_per_negara untuk menemukan nama pelanggan dari negara dengan total pembelian terbesar.
-- Revisi Pernyataan: "Menggunakan CTE kedua untuk menggabungkan tabel customers dengan total_pembelian_per_negara, mengurutkan hasil berdasarkan total pembelian terbesar, 
-- dan mengambil nama pelanggan dan negara dari pelanggan yang berasal dari negara dengan total pembelian tertinggi."
-- Kesimpulan
-- Query ini menampilkan nama pelanggan dan negara dari pelanggan yang paling banyak total pembeliannya dari negara dengan total pembelian tertinggi. 
-- Penjelasan dan pernyataan yang kamu buat sudah hampir merepresentasikan CTE di atas dengan tepat, dengan sedikit penyesuaian agar lebih spesifik dan sesuai dengan detail dari query SQL yang diberikan