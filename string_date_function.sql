-- Membuat database
create database Manipulasi_String_Date;

-- Mengakses database Manipulasi_String_Date
use Manipulasi_String_Date;

-- menghapus tabel 
drop table employees;
drop table departments;

-- mengecek tabel yg ada di database Manipulasi_String_Date
show tables;

-- Membuat tabel employees
create table employees (
	employee_id int primary key,
    first_name varchar(50),
    last_name varchar(50),
    birth_date date,
    hire_date date,
    salary decimal(10, 2),
    department_id int,
    foreign key (department_id) references departments(department_id)
);

create table departments (
	department_id int primary key,
    department_name varchar(50)
);

show tables;
-- mengisi nilai di masing-masing table

insert into departments(department_id, department_name)
values
(1, 'IT'),
(2, 'HR'),
(3, 'Finance'),
(4, 'Marketing');
insert into manipulasi_string_date.employees()
value 
(1, 'John', 'Smith', '1980-05-15', '2015-02-28', 60000, 1),
(2, 'Jane', 'Doe', '1985-08-22', '2018-07-15', 70000, 2),
(3, 'Robert', 'Johnson', '1990-12-10', '2020-10-01', 80000, 1),
(4, 'Alice', 'Brown', '1982-03-05', '2016-09-20', 65000, 3),
(5, 'Emily', 'Davis', '1988-7-30', '2017-12-11', 75000, 2);

select * from employees;
select * from departments;

DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

create table departments (
	department_id int primary key,
    department_name varchar(50)
);

insert into manipulasi_string_date.departments()
values
(1, 'IT'),
(2, 'HR'),
(3, 'Finance'),
(4, 'Marketing');

select * from departments;

create table employees (
	employee_id int primary key,
    first_name varchar(50),
    last_name varchar(50),
    birth_date date,
    hire_date date,
    salary decimal(10, 2),
    department_id int,
    foreign key (department_id) references departments(department_id)
);

insert into manipulasi_string_date.employees()
value 
(1, 'John', 'Smith', '1980-05-15', '2015-02-28', 60000, 1),
(2, 'Jane', 'Doe', '1985-08-22', '2018-07-15', 70000, 2),
(3, 'Robert', 'Johnson', '1990-12-10', '2020-10-01', 80000, 1),
(4, 'Alice', 'Brown', '1982-03-05', '2016-09-20', 65000, 3),
(5, 'Emily', 'Davis', '1988-7-30', '2017-12-11', 75000, 2);

select * from employees;


-- mengubah format text ke datetime
SET SQL_SAFE_UPDATES = 0;

ALTER TABLE employees ADD birth_date_date DATE;

UPDATE employees
SET birth_date_date = STR_TO_DATE(birth_date, '%m/%d/%Y');

-- MENAMPILKAN HASIL 
SELECT birth_date, birth_date_date
FROM employees;

-- menghapus kolom brith_date
ALTER TABLE employees DROP COLUMN birth_date;
ALTER TABLE employees DROP COLUMN birth_date_temp;

-- mengganti nama kolom
ALTER TABLE emplOyees CHANGE COLUMN birth_date_date birth_date DATE;


-- Mengganti type data hire_date dari text ke date
ALTER TABLE employees ADD hire_date_temp DATE;

-- Menambabkan data hire_date_date dari hire_date
UPDATE employees
SET hire_date_temp = STR_TO_DATE(hire_date, '%m/%d/%Y');
SELECT hire_date, hire_date_temp 
FROM employees;

-- menghapus kolom hire_date
ALTER TABLE employees DROP COLUMN hire_date;
-- Mengganti nama hire_date_date menjadi hire_date type date
ALTER TABLE employees CHANGE COLUMN hire_date_temp hire_date DATE;






-- Buatlah query untuk membuat kolom tahun dan bulan secara terpisah untuk setiap record.
-- memisahkan tanggal di tabel birth date dengan format year , month, day
SELECT 
	birth_date,
	YEAR(birth_date) AS year,
    MONTH(birth_date) AS month,
    DAY(birth_date) AS day
FROM employees;

-- memisahkan tanggal di tabel hire date dengan format year , month, day
SELECT 
	hire_date,
	YEAR(hire_date) AS year,
	MONTH(hire_date) AS month,
	DAY(hire_date) AS day
FROM employees;

-- Buatlah query untuk memunculkan karyawan dengan masa kerja 5-10 tahun.
SELECT first_name, last_name
FROM employees
WHERE YEAR(CURDATE()) - YEAR(hire_date) BETWEEN 5 AND 10;

SELECT first_name, last_name
FROM employees
WHERE DATEDIFF(CURDATE(), hire_date) BETWEEN 5 * 365 AND 10 * 365;

SELECT * FROM employees;

-- Buatlah query untuk memunculkan nama dan department dari masing-masing karyawan dengan format “Last Name, First Name_Department”
select e.first_name, e.last_name, d.department_name
from employees as e
join departments as d on e.department_id = d.department_id;

select concat(e.first_name, '_', e.last_name, '_', d.department_name) as first_last_department_name
from employees as e
join departments as d on e.department_id = d.department_id;

-- Buatlah query untuk memunculkan karyawan yang berulang tahun pada bulan ini
select first_name, last_name, birth_date
from employees
where extract(month from birth_date) = extract(month from current_date);

select * from departments;
    

