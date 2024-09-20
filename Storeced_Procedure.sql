use umkm;
use universitas;
-- Memanggil tabel dari database umkm jawa barat
SELECT * FROM umkm.umkm_jawa_barat;

-- Membuat Stored Procedure Sederhana
DELIMITER $$
CREATE PROCEDURE getAll()
BEGIN
		SELECT * FROM umkm.umkm_jawa_barat;
END $$
DELIMITER ;

-- Memanggil Stored Procedure
CALL getAll();

-- Mengecek Stored Procedure
SHOW PROCEDURE STATUS;

-- Menghapus Stroced Procedure
DROP PROCEDURE getAll;

-- Membuat Stroced Procedure
-- 1.1. Menggunakan prameter IN
DELIMITER //
CREATE PROCEDURE getDataUmkm
(
	IN nama_kab_kota VARCHAR(100)
)
BEGIN
		SELECT * FROM umkm_jawa_barat WHERE nama_kabupaten_kota = nama_kab_kota;
END //
DELIMITER ;

-- Memanggil
CALL getDataUmkm("Kabupaten Sukabumi");
-- 1.2. Menggunakan paramter OUT
-- Variabel digunakan untuk menyimpan/menampung nilai yang diberikan oleh stored procedure
DELIMITER //
CREATE PROCEDURE getTotalRow
(
	OUT jumlah_raw INT
)
BEGIN
		SELECT COUNT(*) INTO jumlah_raw FROM umkm_jawa_barat;
END //
DELIMITER ;

-- Memanggil SP
CALL getTotalRow(@jumlah_raw);
SELECT @jumlah_raw;


-- membuat variabel
-- SET @panjang = 10;
-- SELECT @panjang;

-- 1.3. Menggunakan paramter INOUT
DELIMITER //
CREATE PROCEDURE getTotalRow2
(
	INOUT kode_kab INT
)
BEGIN
		SELECT COUNT(*) INTO kode_kab FROM umkm_jawa_barat WHERE kode_kabupaten_kota = kode_kab;
END //
DELIMITER ;

SET @kode_kab_kota = 3201;

CALL getTotalRow2(@kode_kab_kota);

SELECT @kode_kab_kota;

SELECT COUNT(*) FROM umkm_jawa_barat WHERE kode_kabupaten_kota = 3201;    