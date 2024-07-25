use umkm;

select * from umkm_jawa_barat;

-- berapa jumlah baris pada tabel umkm jawa barat

select count(*) as jumlah_baris from umkm_jawa_barat;
select count(distinct nama_kabupaten_kota) from umkm_jawa_barat;

-- Bagaimana trend jumlah umkm di kabupaten bandung dari tahun 2017 sd 2022?

select nama_kabupaten_kota, sum(proyeksi_jumlah_umkm) as total_umkm
from umkm_jawa_barat
where tahun >= 2017 and tahun <= 2022
group by nama_kabupaten_kota
order by total_umkm desc;

--  Nilai Minimun dan Maksimun dari kolom jumlah_umkm?

select nama_kabupaten_kota, min(proyeksi_jumlah_umkm) as minimum, max(proyeksi_jumlah_umkm) as maximum
from umkm_jawa_barat
group by nama_kabupaten_kota;

-- Berapa Jumlah rata-rata umkm 
-- di jawa barat setiap kategori usaha per kabupaten/kota pada tahun 2021?

select tahun, kategori_usaha, nama_kabupaten_kota, avg(proyeksi_jumlah_umkm) as rata_rata_jumlah_umkm 
from umkm_jawa_barat 
where tahun = 2021
group by tahun, kategori_usaha, nama_kabupaten_kota
order by rata_rata_jumlah_umkm desc;

-- kabupaten atau kota apa yang memiliki jumlah umkm kurang dari 100.000 pada tahun 2022?

select tahun, nama_kabupaten_kota, sum(proyeksi_jumlah_umkm) as total_umkm
from umkm_jawa_barat
where tahun = 2022
group by tahun, nama_kabupaten_kota
having total_umkm < 100000
order by total_umkm;

