-- Membuat database
create database ds;

use ds;
use universitas;

-- 1. Menampilkan semua data Menggunakan Strreced_Procedure

delimiter $$
create procedure getAllData()
begin
	select * from ds.students_performance;
end $$
delimiter ;

call getAllData();
drop procedure getAllData;

-- 2.a. Buatlah stored procedure untuk memberikan nilai math rata-rata seluruh data!

delimiter $$
create procedure avgNilaiMth(
	out rata_rata_math float
)
begin
	select AVG(ds.students_performance.math_score) into rata_rata_math from ds.students_performance;
end $$
delimiter ;

SHOW PROCEDURE STATUS;
drop procedure avgNilaiMth;
call avgNilaiMth(@rata_rata_math);
select @rata_rata_math;

select avg(ds.students_performance.math_score) as rata_rata
from ds.students_performance;

-- Dapatkah Anda menampilkan seluruh data yang
-- memiliki nilai math lebih dari rata-rata menggunakan output
select *
from ds.students_performance where reading_score > @rata_rata;

-- Buatlah stored procedure untuk memunculkan seluruh data dengan memasukkan race_or_ethnicity

delimiter $$
create procedure get_all_data_by_race (in race_group varchar(100))
begin
	select * from ds.students_performance where race_or_ethnicity = race_group;
end $$
delimiter ;

drop procedure get_all_data_by_race;
set @race = 'group B';
call get_all_data_by_race(@race);

-- Buatlah query yang menghasilkan rata-rata nilai, berdasarkan jenis gender
delimiter $$
create procedure rata_rata_data_by_gender (in jenis_gender varchar(100), out rata_rata_nilai_math float)
begin
	select AVG(ds.students_performance.math_score) into rata_rata_nilai_math from ds.students_performance where gender = jenis_gender;
end $$
delimiter ;

set @jenis_gender = 'male';
call rata_rata_data_by_gender(@jenis_gender, @rata_rata_nilai_math);
-- drop procedure rata_rata_data_by_gender2;
-- drop procedure rata_rata_data_by_gender;

select @jenis_gender, @rata_rata_nilai_math;

-- membuat tabel id_buku, selanjutanya membuat SP untuk mengisi id secara otomatis berdasarkan hasil looping
drop table if exists id_buku;
drop procedure if exists buatidbuku;

create table id_buku(id int);
delimiter $$
create procedure buatidbuku ()
begin
	declare counter int;
    set counter = 0;
    while counter <= 6 do insert into id_buku(id) values (counter);
    set counter = counter + 1;
    end while;
end $$
delimiter ;

drop procedure buatidbuku;
call buatidbuku();
select * from ds.id_buku;

-- Membuat perhitungan bidang 2 d
delimiter $$
create procedure perhitung_bangun_datar
(in jenis varchar(255),
in x float,
in y float,
out hasil float,
out keterangan varchar(255)
)
begin
	case 
		when jenis='Segitiga' then set hasil=0.5*x*y, keterangan='Perhitungan Berhasil!!';
        when jenis='persegi Panjang' then set hasil=x*y, keterangan='Perhitungan Berhasil!!';
		else set hasil=Null; set keterangan='Perhitungan Gagal. Bangun datar tidak ditemukan';
	end case;
    end $$
delimiter ;

show procedure status;
-- Segitiga
set @jenis_bangun_datar ='Segitiga';
set @x = 5;
set @y = 6;
call perhitung_bangun_datar(@jenis_bangun_datar, @x, @y, @luas, @keterangan);
select @jenis_bangun_datar, @x, @y, @luas, @keterangan;

-- Persegi panjang
set @jenis_bangun_datar = 'Persegi Panjang';
set @x = 10;
set @y= 20;
call perhitung_bangun_datar(@jenis_bangun_datar, @x, @y, @luas, @keterangan);
select @jenis_bangun_datar, @x, @y, @luas, @keterangan;

-- Lingkaran
set @jenis_bangun_datar = 'Lingkaran';
set @x = 10;
set @y= 20;
call perhitung_bangun_datar(@jenis_bangun_datar, @x, @y, @luas, @keterangan);
select @jenis_bangun_datar, @x, @y, @luas, @keterangan;

