-- 1. Selezionare tutte le nazioni il cui nome inizia con la P e la cui area è maggiore di 1000 kmq 
select name,area
from countries c 
where name like 'P%' and area > 1000
-- 2. Selezionare le nazioni il cui national day è avvenuto più di 100 anni fa
select name, national_day 
from countries c2 
where timestampdiff(year, national_day, curdate()) > 100
-- 3. Selezionare il nome delle regioni del continente europeo, in ordine alfabetico 
SELECT r.name
FROM `regions` r
INNER JOIN `continents` c
ON r.continent_id = c.continent_id
WHERE c.continent_id = 4
ORDER BY r.name;
-- 4. Contare quante lingue sono parlate in Italia 
select c.name as nazione, count(l.language_id) as numero_lingue_parlate
from countries c join country_languages cl 
on c.country_id = cl.country_id 
inner join languages l 
on l.language_id = cl.language_id 
where c.name like 'italy'
group by c.name;
-- 5. Selezionare quali nazioni non hanno un national day
select name as nazioni_senza_national_day
from countries c 
where national_day is null;
-- 6. Per ogni nazione selezionare il nome, la regione e il continente 
select c.name as nazione, r.name as regione, c.name as continente
from countries c
inner join regions r 
on c.region_id = r.region_id 
inner join continents c2 
on c2.continent_id = r.continent_id 
group by nazione, regione, continente
order by nazione;
-- 7. Modificare la nazione Italy, inserendo come national day il 2  giugno 1946 
UPDATE countries c SET c.national_day = '1946-06-02' WHERE c.name LIKE 'Italy';
-- 8. Per ogni regione mostrare il valore dell'area totale 
select r.name as regione, sum(c.area) as area_totale
from regions r 
inner join countries c 
on r.region_id = c.region_id 
group by regione
order by area_totale desc;
-- 9. Selezionare le lingue ufficiali dell'Albania 
select  c.name, l.`language`,cl.official
from languages l 
inner join country_languages cl on cl.language_id = l.language_id 
inner join countries c on cl.country_id = c.country_id
where c.name = 'Albania' and official = 1;
-- 10. Selezionare il Gross domestic product (GDP) medio dello United Kingdom tra il 2000 e il 2010
SELECT c.name as nazione, AVG(cs.gdp) as media_gdp_2000_2010
FROM `countries` c
INNER JOIN `country_stats` cs 
ON c.country_id = cs.country_id
WHERE c.name LIKE 'United Kingdom' AND cs.`year` >= 2000 and cs.`year` <= 2010
GROUP BY nazione;
-- 11. Selezionare tutte le nazioni in cui si parla hindi, ordinate dalla più estesa alla meno estesa 
SELECT *
FROM `countries` c
INNER JOIN `country_languages` cl
ON c.country_id = cl.country_id
INNER JOIN `languages` l 
ON l.language_id = cl.language_id
WHERE l.`language` LIKE 'Hindi'
ORDER BY c.area DESC;
-- 12. Per ogni continente, selezionare il numero di nazioni con area superiore ai 10.000 kmq ordinando i risultati a partire 
--     dal continente che ne ha di più 
SELECT c.name as continente, count(c2.country_id) as numero_nazioni_con_area_over_10k
from continents c 
inner join regions r 
on c.continent_id = r.continent_id 
inner join countries c2 
on c2.region_id = r.region_id 
where c2.area > 10000
group by continente
order by numero_nazioni_con_area_over_10k desc;