create database canada;

use canada;

create table province
	(
	province_id			int,
	province_name		varchar(100),
	official_language	varchar(20)
);
	
insert into province (province_id, province_name, official_language) values (1, 'Alberta', 'English');
insert into province (province_id, province_name, official_language) values (2, 'British Columbia', 'English');
insert into province (province_id, province_name, official_language) values (3, 'Manitoba', 'English');
insert into province (province_id, province_name, official_language) values (4, 'New Brunswick', 'English, French');
insert into province (province_id, province_name, official_language) values (5, 'Newfoundland', 'English');
insert into province (province_id, province_name, official_language) values (6, 'Nova Scotia', 'English');
insert into province (province_id, province_name, official_language) values (7, 'Ontario', 'English');
insert into province (province_id, province_name, official_language) values (8, 'Prince Edward Island', 'English'); 
insert into province (province_id, province_name, official_language) values (9, 'Quebec', 'French');
insert into province (province_id, province_name, official_language) values (10, 'Saskatchewan', 'English');

create table capital_city
	(
	city_id		int,
	city_name	varchar(100),
	province_id	int
	);

insert into capital_city (city_id, city_name, province_id) values (1, 'Toronto', 7);
insert into capital_city (city_id, city_name, province_id) values (2, 'Quebec City', 9);
insert into capital_city (city_id, city_name, province_id) values (3, 'Halifax', 5);
insert into capital_city (city_id, city_name, province_id) values (4, 'Fredericton', 4);
insert into capital_city (city_id, city_name, province_id) values (5, 'Winnipeg', 3);
insert into capital_city (city_id, city_name, province_id) values (6, 'Victoria', 2);
insert into capital_city (city_id, city_name, province_id) values (7, 'Charlottetown', 8);
insert into capital_city (city_id, city_name, province_id) values (8, 'Regina', 10);
insert into capital_city (city_id, city_name, province_id) values (9, 'Edmonton', 1);
insert into capital_city (city_id, city_name, province_id) values (10,'St. Johns', 5);
	
create table tourist_attraction
	(
	attraction_id		int,
	attraction_name		varchar(100),
	attraction_city_id	int,
	open_flag			bool
	);

insert into tourist_attraction (attraction_id, attraction_name, attraction_city_id, open_flag) values (1, 'CN Tower', 1, true);
insert into tourist_attraction (attraction_id, attraction_name, attraction_city_id, open_flag) values (2, 'Old Quebec', 2, true);
insert into tourist_attraction (attraction_id, attraction_name, attraction_city_id, open_flag) values (3, 'Royal Ontario Museum', 1, true);
insert into tourist_attraction (attraction_id, attraction_name, attraction_city_id, open_flag) values (4, 'Place Royale', 2, true);
insert into tourist_attraction (attraction_id, attraction_name, attraction_city_id, open_flag) values (5, 'Halifax Citadel', 3, true);
insert into tourist_attraction (attraction_id, attraction_name, attraction_city_id, open_flag) values (6, 'Garrison District', 4, true);
insert into tourist_attraction (attraction_id, attraction_name, attraction_city_id, open_flag) values (7, 'Confederation Centre of the Arts', 7, true);
insert into tourist_attraction (attraction_id, attraction_name, attraction_city_id, open_flag) values (8, 'Stone Hall Castle', 8, true);
insert into tourist_attraction (attraction_id, attraction_name, attraction_city_id, open_flag) values (9, 'West Edmonton Mall', 9, true);
insert into tourist_attraction (attraction_id, attraction_name, attraction_city_id, open_flag) values (10,'Signal Hill', 10, true);
insert into tourist_attraction (attraction_id, attraction_name, attraction_city_id, open_flag) values (11,'Canadian Museum for Human Rights', 5, true);
insert into tourist_attraction (attraction_id, attraction_name, attraction_city_id, open_flag) values (12,'Royal BC Museum', 6, true);
insert into tourist_attraction (attraction_id, attraction_name, attraction_city_id, open_flag) values (13,'Sunnyside Amusement Park', 1, false);

-- exercicio 6.2 (minha versão)
select t.attraction_name,
	   c.city_name,
       p.province_name
from tourist_attraction t
join capital_city c 
on t.attraction_city_id = c.city_id
and t.open_flag is true
join province p 
on c.province_id = p.province_id
and p.official_language = 'French';

-- resposta
select a.attraction_name,
       c.city_name,
       p.province_name
from   tourist_attraction a
join   capital_city c
  on   c.city_id = a.attraction_city_id
 and   a.open_flag is true
join   province p
  on   p.province_id = c.province_id
 and   p.official_language = 'French';
 
 -- exercicio 6.3(minha versão)
 create temporary table open_tourist_attraction
 select attraction_city_id, attraction_name
 from tourist_attraction
 where open_flag is true;
 
 -- resposta
create temporary table open_tourist_attraction 
as
 select   attraction_city_id,
          attraction_name 
 from     tourist_attraction
 where    open_flag is true;
 
-- exercicio 6.4(minha versão)
select o.attraction_name,
	   c.city_name
from open_tourist_attraction o 
join capital_city c 
on o.attraction_city_id = c.city_id
and c.city_name = 'Toronto';

-- resposta
select    a.attraction_name,
          c.city_name
from      open_tourist_attraction a
join      capital_city c 
  on      c.city_id = a.attraction_city_id
 and      c.city_name = 'Toronto';
 
-- exercicio sub query (6.5)
create database attire;

use attire;

create table employee
	(
	employee_id		int,
	employee_name	varchar(100),
	position_name	varchar(100)
	);
	
insert into employee(employee_id, employee_name, position_name) values (1, 'Benedict', 'Pope');
insert into employee(employee_id, employee_name, position_name) values (2, 'Garth', 'Singer');
insert into employee(employee_id, employee_name, position_name) values (3, 'Francis', 'Pope');

create table wardrobe
	(
	employee_id	int,
	hat_size	numeric(4,2)
	);

insert into wardrobe (employee_id, hat_size) values (1, 8.25);
insert into wardrobe (employee_id, hat_size) values (2, 7.50);
insert into wardrobe (employee_id, hat_size) values (3, 6.75);

-- query corrigida
select 	employee_id,
        hat_size
from    wardrobe
where   employee_id in
(
        select   employee_id
        from     employee
        where    position_name = 'Pope'
);

