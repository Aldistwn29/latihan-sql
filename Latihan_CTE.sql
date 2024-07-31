CREATE DATABASE latihan_cte;

USE latihan_cte;

WITH RECURSIVE fibonacci (n, fib_n, next_fib_n) AS 
(
	SELECT 1, 0, 1
    UNION ALL
    SELECT n + 1, next_fib_n, fib_n + next_fib_n
	FROM fibonacci WHERE  n < 10
)
SELECT fib_n FROM fibonacci WHERE n = 8;


-- Membuat table employees

CREATE TABLE employees (
	id INT PRIMARY KEY NOT NULL,
	name VARCHAR(100) NOT NULL,
	manager_id INT NULL, 
	INDEX (manager_id),
	FOREIGN KEY (manager_id) references employees (id)
);

DESCRIBE employees;


-- Mengisi table employees
INSERT INTO employees (id, name, manager_id) VALUES
(333, 'Yasimin', NULL),
(198, 'Jhon', 333),
(692, 'Tarek', 333),
(29, 'Pedro', 198),
(4610, 'Sarah', 29),
(72, 'Pierre', 29),
(123, 'Adil', 692);

SELECT * FROM employees;

WITH RECURSIVE employees_paths (id, name, path) AS
(
	SELECT id, name, CAST(id AS CHAR(20))
	FROM employees
	WHERE manager_id IS NULL
	UNION ALL
	SELECT e.id, e.name, CONCAT(ep.path, ',', e.id)
	FROM employees_paths AS ep 
	JOIN employees AS e
		ON ep.id = e.manager_id
)
SELECT * FROM employees_paths
WHERE id IN (692, 4610)
ORDER BY path;
-- SELECT * FROM employees_paths ORDER BY path;

-- Membuat tabel

CREATE TABLE employee_demographics (
	
	employee_id INT NOT NULL,
	frist_name VARCHAR(50),
	last_name VARCHAR(50),
	age INT,
	gender VARCHAR(10),
	birth_date DATE,
	PRIMARY KEY (employee_id)
);

CREATE TABLE employee_salary (
	
	employee_id INT NOT NULL,
	frist_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	occupation VARCHAR(50),
	salary INT,
	dept_id INT
);

CREATE TABLE parks_departments (
	
	department_id INT NOT NULL AUTO_INCREMENT,
	department_name VARCHAR(50) NOT NULL,
	PRIMARY KEY (department_id)
);

-- Mengisi Nilai pada tabel
INSERT INTO employee_demographics (employee_id, frist_name, last_name, age, gender, birth_date)
VALUES

(1,'Leslie', 'Knope', 44, 'Female','1979-09-25'),
(3,'Tom', 'Haverford', 36, 'Male', '1987-03-04'),
(4, 'April', 'Ludgate', 29, 'Female', '1994-03-27'),
(5, 'Jerry', 'Gergich', 61, 'Male', '1962-08-28'),
(6, 'Donna', 'Meagle', 46, 'Female', '1977-07-30'),
(7, 'Ann', 'Perkins', 35, 'Female', '1988-12-01'),
(8, 'Chris', 'Traeger', 43, 'Male', '1980-11-11'),
(9, 'Ben', 'Wyatt', 38, 'Male', '1985-07-26'),
(10, 'Andy', 'Dwyer', 34, 'Male', '1989-03-25'),
(11, 'Mark', 'Brendanawicz', 40, 'Male', '1983-06-14'),
(12, 'Craig', 'Middlebrooks', 37, 'Male', '1986-07-27');

INSERT INTO  employee_salary (employee_id, frist_name, last_name, occupation, salary, dept_id)
VALUES

(1, 'Leslie', 'Knope', 'Deputy Director of Parks and Recreation', 75000,1),
(2, 'Ron', 'Swanson', 'Director of Parks and Recreation', 70000,1),
(3, 'Tom', 'Haverford', 'Entrepreneur', 50000,1),
(4, 'April', 'Ludgate', 'Assistant to the Director of Parks and Recreation', 25000,1),
(5, 'Jerry', 'Gergich', 'Office Manager', 50000,1),
(6, 'Donna', 'Meagle', 'Office Manager', 60000,1),
(7, 'Ann', 'Perkins', 'Nurse', 55000,4),
(8, 'Chris', 'Traeger', 'City Manager', 90000,3),
(9, 'Ben', 'Wyatt', 'State Auditor', 70000,6),
(10, 'Andy', 'Dwyer', 'Shoe Shiner and Musician', 20000, NULL),
(11, 'Mark', 'Brendanawicz', 'City Planner', 57000, 3),
(12, 'Craig', 'Middlebrooks', 'Parks Director', 65000,1);

INSERT INTO parks_departments (department_name)
VALUES

('Parks and Recreation'),
('Animal Control'),
('Public Works'),
('Healthcare'),
('Library'),
('Finance');

SELECT * FROM employee_demographics;
SELECT * FROM employee_salary;
SELECT * FROM parks_departments;

-- CTE
SELECT gender, SUM(salary) , MIN(salary) , MAX(salary), AVG(salary), COUNT(salary)
FROM employee_demographics AS ed
JOIN employee_salary AS es 
	ON ed.employee_id = es.employee_id
GROUP BY gender;

WITH CTE_Example AS 
(
	SELECT 	gender, SUM(salary), MIN(salary), MAX(salary), AVG(salary), COUNT(salary)
	FROM employee_demographics AS ed
		JOIN employee_salary AS es 
			ON ed.employee_id = es.employee_id
	GROUP BY gender
)
-- Menampilkan hasil dari CTE
SELECT * FROM CTE_Example;

-- Fungsi ini tidak akan berhasil karena, tidak sama dengan syntaxnya
SELECT * FROM CTE_Example;

-- Melakukan Perhitungan di tabel CTE
WITH CTE_Example AS 
(

	SELECT 	gender, SUM(salary), MIN(salary), MAX(salary), AVG(salary), COUNT(salary)
	FROM employee_demographics AS ed
		JOIN employee_salary AS es 
			ON ed.employee_id = es.employee_id
	GROUP BY gender

)
	
	SELECT gender, ROUND(AVG(`SUM(salary)`/`COUNT(salary)`), 2) AS rata_rata_gaji
	FROM CTE_Example
	GROUP BY gender;

-- Membuat beberapa CTE hanya dengan 1 WITH
WITH CTE_Example AS 
(

	SELECT employee_id, gender, birth_date
	FROM employee_demographics AS em
	WHERE em.birth_date > '1985-01-01'
),

CTE_Example2 AS

(

	SELECT employee_id, salary
	FROM employee_salary AS es
	WHERE es.salary >= 10000

)

SELECT *
FROM CTE_Example AS cte1
LEFT JOIN CTE_Example2 AS cte2
	ON cte1.employee_id = cte2.employee_id;
    
-- Mengubah nama kolom dalam CTE
WITH CTE_Example(gender, Jumlah_gaji, gaji_terkecil, gaji_terbesar, rata_gaji, jumlah_baris) AS 
(

	SELECT gender, SUM(salary) AS jumlah_gaji, MIN(salary) AS gaji_terkecil, MAX(salary) AS gaji_terbesar, AVG(salary) AS rata_gaji, COUNT(salary) AS jumlah_baris
    FROM employee_demographics AS ed
    JOIN employee_salary AS es
    ON ed.employee_id = es.employee_id
    GROUP BY gender

)
	SELECT gender, ROUND(AVG(jumlah_gaji/jumlah_baris), 2) AS rata_total_gaji
	FROM CTE_Example
	GROUP BY gender;





