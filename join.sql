-- membuat database baru
create database latihan_join;

-- masuk ke data base
use latihan_join;

-- membuat table 
create table students (
	student_id int auto_increment primary key,
    student_name varchar(100) not null,
    age int
);

create table courses (
course_id int auto_increment primary key,
curse_name varchar(100) not null
);

create table enrollments (
	enrollment_id int auto_increment primary key,
    student_id int,
    course_id int,
    enrollment_date date,
    foreign key (student_id) references students(student_id),
    foreign key (course_id) references courses(course_id)
    );
    
    
    -- mengecek table
    show tables;
    describe courses;
	describe enrollments;
	describe students;
    
    -- menambahkan data table
    insert into courses(curse_name) values 
		('Data Analyst'),
		('Python'),
		('SQL'),
		('Visualisasi');
        
insert into students(student_name, age) values
	('Alice', 20),
    ('Novita', 21),
    ('Hilul', 22),
    ('Ami', 23);
    
insert into enrollments(student_id, course_id, enrollment_date) 
values
(1, 1, '2023-01-15'),
(2, 1, '2023-01-16'),
(2, 2, '2023-01-17'),
(3, 3, '2023-01-18');
    
select * from students;
select * from courses;
select * from enrollments;

-- inner join 
select s.student_name, c.curse_name, e.enrollment_date 
from enrollments as e
inner join students as s on e.student_id = s.student_id
inner join courses as c on e.course_id = c.course_id;

-- left join
select  s.student_name, c.curse_name, e.enrollment_date
from students as s
left join enrollments as e on s.student_id = e.student_id
left join courses as c on e.course_id = c.course_id;

-- Right join
select s.student_name, c.curse_name, e.enrollment_date 
from students as s
right join enrollments as e on s.student_id = e.student_id
right join courses as c on e.course_id = c.course_id;

-- full outer join
select s.student_name, c.curse_name, e.enrollment_date
from students as s
left join enrollments as e on s.student_id = e.student_id
left join courses as c on e.course_id = c.course_id
union
select s.student_name, c.curse_name, e.enrollment_date 
from students as s
right join enrollments as e on s.student_id = e.student_id
right join courses as c on e.course_id = c.course_id;