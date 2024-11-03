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


-- Loop
CREATE TABLE id_mahasiswa(id INT);

INSERT INTO id_mahasiswa VALUES(0);
DELIMITER //
CREATE PROCEDURE buatIdMahasiswa()
BEGIN
		DECLARE count INT;
        SET count = 1;
        WHILE count <= 10 DO
			INSERT INTO id_mahasiswa(id) VALUES(count);
			SET count = count + 1;
		END WHILE;
END //
DELIMITER ;

CALL buatIdMahasiswa();
SELECT * FROM id_mahasiswa;

-- Conditional (IF THEN)
DELIMITER $$
CREATE PROCEDURE test
(
	IN bilangan INT,
    OUT hasil VARCHAR(100)
)
BEGIN
	IF bilangan <= 50 THEN SET hasil = "Kurang dari sama dengan 50";
    ELSE SET hasil = "Lebih dari 50";
    END IF;
END $$

DELIMITER ;

CALL test(60, @hasil_bilangan);
SELECT @hasil_bilangan;




