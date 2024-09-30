use ds;

select * from ds_salaries;

-- 1. mengcek nilai yg null
select *
from ds_salaries
where work_year is null
or experience_level is null
or employment_type is null
or job_title is null
or salary is null
or salary_currency is null
or salary_in_usd is null
or employee_residence is null
or remote_ratio is null
or company_location is null
or company_size is null;

-- 2. Melihat job title apa saja
select distinct job_title
from ds_salaries;

-- 3. job_titile berkaitan data analyst
select distinct job_title
from ds_salaries
where job_title like '%data analyst%';

-- 4. Berapa rata-rata gaji data analyst ?
select 	job_title,
		(avg(salary_in_usd) * 15000/12) as sal_con_rp_monthly
from ds_salaries
group by job_title
having job_title = 'data analyst';

-- 4.1 rata-rata gaji data analyst berdasarkan type hubungan kerja
select 	job_title,
		experience_level,
		(avg(salary_in_usd) * 15000/12) as sal_con_rp_monthly
from ds_salaries
group by job_title, experience_level
having job_title = 'data analyst';

-- 4.2 rata-rata gaji data analyst berdasarkan lokasi perusahaan
select 	job_title,
		company_location,
        experience_level,
		(avg(salary_in_usd) * 15000/12) as sal_con_rp_monthly,
        remote_ratio
from ds_salaries
group by job_title, company_location, experience_level,  remote_ratio
having job_title = 'data analyst'
order by sal_con_rp_monthly desc;

-- 5. negara dengan gaji yang menarik di posisi data analyst, full time, exp kerjanya entry level, dan mengah

select company_location,
		avg(salary_in_usd) as rarata_gaji_usd
from ds_salaries
where job_title like '%data analyst%'
	and employment_type = 'ft'
    and experience_level in ('en', 'min')
group by company_location
having rarata_gaji_usd >= 20000;

-- 6. ditahun berapa kenaikan rata-rata kenaikan gaji yg paling tinggi, dari senior ke menengah
-- untuk pekerjaan data analyst dengan type penuh waktu

with ds_1 as 
(
	select 
		work_year as tahun,
		avg(salary_in_usd) as rarata_in_usd_ex
    from 
		ds_salaries
    where
		employment_type = 'FT'
		and experience_level = 'EX'
        and job_title like '%data analyst%'
	group by 
			tahun
), ds_2 as 
(
	select 
		work_year as tahun,
		avg(salary_in_usd) as rarata_in_usd_mi
    from 
		ds_salaries
    where
		employment_type = 'FT'
		and experience_level = 'MI'
        and job_title like '%data analyst%'
	group by 
			tahun
), t_year as (
	select distinct work_year as tahun
    from ds_salaries)

select t_year.tahun,
	ds_1.rarata_in_usd_ex,
    ds_2.rarata_in_usd_mi,
    (rarata_in_usd_ex - rarata_in_usd_mi) as difference
from 
	t_year 
left join ds_1 
	on t_year.tahun = ds_1.tahun
left join ds_2 
	on t_year.tahun = ds_2.tahun;