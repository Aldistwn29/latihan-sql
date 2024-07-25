-- membuat database
create database umkm;

-- menggunakan database
use umkm;

-- melihat deskripsi table
describe umkm_jabar;

-- cek data di table 
select * from umkm_jawa_barat;
select * from umkm_jabar;


-- tunjukan data yg berasal dari kabupaten sukabumi
select * from umkm_jawa_barat where nama_kabupaten_kota = "KABUPATEN SUKABUMI";

-- tunjukan data dari tahun 2019 dan disusun berdasarkan kategori usaha
SELECT * FROM umkm_jawa_barat WHERE tahun >= 2019 ORDER BY kategori_usaha, tahun;

-- batasi barisnya sd 10
SELECT * FROM umkm_jawa_barat WHERE tahun >= 2019 ORDER BY kategori_usaha, tahun LIMIT 10;

-- Kategori usaha apa aja ada dalam dataset tidak ada duplikat?

SELECT DISTINCT kategori_usaha FROM umkm_jawa_barat;

-- Tunjukan seluruh data dari kategori usaha hanya makanan dan fashion

SELECT * FROM umkm_jawa_barat WHERE kategori_usaha IN("MAKANAN", "FASHION");
SELECT * FROM umkm_jawa_barat WHERE kategori_usaha = "MAKANAN" OR kategori_usaha = "FASHION";

-- Tunjukan seluruh data kategori usaha FASHION DAN KABUPATEN SUKABUMI

SELECT * FROM umkm_jawa_barat WHERE kategori_usaha = "FASHION" AND nama_kabupaten_kota = "KABUPATEN SUKABUMI";

-- Tunjukan seluruh data selain kategori usaha KULINER, MAKANAN, DAN MINUMAN
SELECT * FROM umkm_jawa_barat WHERE kategori_usaha NOT IN("KULINER", "MAKANAN", "MINUMAN");

-- Dari tahun 2019 sd 2022,
-- bagaiman trend jumlah umkm di KABUPATEN SUKABUMI untuk kategori usaha BATIK?

SELECT nama_kabupaten_kota, kategori_usaha, proyeksi_jumlah_umkm, satuan, tahun  FROM umkm_jawa_barat WHERE tahun >= 2019 AND tahun <= 2022 
AND nama_kabupaten_kota = "KABUPATEN SUKABUMI" 
AND kategori_usaha = "BATIK";

-- Diantara Kota Bandung, Kabupaten Bandung Dan Kabupaten Bandung Barat
-- Dimanakah umkm kuliner terpusat di tahun 2021

SELECT nama_kabupaten_kota, kategori_usaha, proyeksi_jumlah_umkm, tahun FROM umkm_jawa_barat WHERE nama_kabupaten_kota LIKE "%BANDUNG%" 
AND kategori_usaha = "KULINER"
AND tahun = 2021;

-- Kabupaten/Kota mana saja yang memiliki angka 7 pada digit terakhir

SELECT DISTINCT kode_kabupaten_kota, nama_kabupaten_kota FROM umkm_jawa_barat 
WHERE kode_kabupaten_kota LIKE "__7%";