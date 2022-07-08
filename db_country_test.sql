-- select nazioni che iniziano con P e area > 1000
select *
from countries c 
where name like 'P%' and area >1000;

-- nazioni in cui national day è avvenuto 100+ anni fa
select *
from countries c
where national_day < (date_sub(curdate(),interval 100 year));

-- nazioni nel continente europeo in ordine alfabetico
select c.name, c2.name 
from countries c 
inner join regions r on c.region_id = r.region_id
inner join continents c2 on r.continent_id = c2.continent_id
where c2.continent_id = 4
order by c.name;

-- Contare quante lingue sono parlate in Italia
select count(c.country_id) as lingue_parlate_italia 
from country_languages c
inner join countries c2 
on c.country_id = c2.country_id 
where c2.country_id =107;

-- Selezionare quali nazioni non hanno un national day 
select *
from countries c 
where national_day is null;

-- Per ogni nazione selezionare il nome, la regione e il continente
select c.name, r.name, c2.name 
from countries c 
inner join regions r on c.region_id = r.region_id
inner join continents c2 on r.continent_id = c2.continent_id;

-- Modificare la nazione Italy, inserendo come national day il 2 giugno 1946
update countries 
set national_day = '1946/06/02'
where country_id = 107;

-- Per ogni regione mostrare il valore dell'area totale
select r.name, sum(c.area)  
from regions r  
inner join countries c  on r.region_id = c.region_id
group by r.region_id; 

-- Selezionare le lingue ufficiali dell'Albania
select *
from country_languages c
inner join countries c2 on c.country_id = c2.country_id 
inner join languages l on c.language_id = l.language_id 
where c2.name = 'albania' and c.official = 1;

--  Selezionare il Gross domestic product (GDP) medio 
-- dello United Kingdom tra il 2000 e il 2010
select c.name, avg(gdp) as gdp_average 
from country_stats cs 
inner join countries c on cs.country_id = c.country_id 
where c.country_id = 77 and cs.year >= 2000 and cs.`year` <=2010;

--  Selezionare tutte le nazioni in cui si parla hindi, ordinate 
-- dalla più estesa alla meno estesa
select *
from countries c 
inner join country_languages cl on c.country_id = cl.country_id 
inner join languages l on cl.language_id = l.language_id 
where `language`= 'hindi' 
order by c.area desc;

--  Per ogni continente, selezionare il numero di nazioni con 
-- area superiore ai 10.000 kmq ordinando i risultati a partire dal 
-- continente che ne ha di più
select c2.name, count(c.area) as given_size 
from countries c 
inner join regions r on c.region_id = r.region_id
inner join continents c2 on r.continent_id = c2.continent_id
where c.area >10000
group by c2.name 
order by given_size desc;

