use wine;

-- PALAVRA CHAVE LIMIT
create table best_wine_contest
(
	wine_name  varchar(100),
    place		int
);

insert into best_wine_contest (wine_name, place) values ('Riesling',1);
insert into best_wine_contest (wine_name, place) values ('Pinot Grigio',2);
insert into best_wine_contest (wine_name, place) values ('Zinfandel',3);
insert into best_wine_contest (wine_name, place) values ('Malbec',4);
insert into best_wine_contest (wine_name, place) values ('Verdejo',5);

select *
from best_wine_contest
order by place;

-- SE QUISERMOS VER APENAS OS TRÊS MELHORES
select *
from best_wine_contest
order by place
limit 3;

-- TABELAS TEMPORÁRIAS
create temporary table wp1
(
	winery_name varchar(40),
    vitticultural_area_id int
);

-- criando tabela temporaria com base no resultado de uma query
create temporary table winery_portfolio
select w.winery_name,
	   w.viticultural_area_id
from winery w
join portfolio p
on w.winery_id = p.winery_id
and w.offering_tours_flag is true
and p.in_season_flag is true
join wine_type t
on p.wine_type_id = t.wine_type_id
and t.wine_type_name = 'Merlot';

-- consultando essa tabela temporaria
select * from winery_portfolio;

-- executando join com a tabela temporaria
select c.country_name,
	   r.region_name,
       v.viticultural_area_name
from country c
join region r 
on c.country_id = r.country_id
and c.country_name = 'USA'
join viticultural_area v
on r.region_id = v.region_id
join winery_portfolio w 
on v.viticultural_area_id = w.viticultural_area_id;

-- expressoes de tabelas comuns(CTEs)
with winery_portfolio_cte as
(
    select w.winery_name,
           w.viticultural_area_id
    from   winery w
    join   portfolio p
      on   w.winery_id = p.winery_id
     and   w.offering_tours_flag is true
     and   p.in_season_flag is true
    join   wine_type t
      on   p.wine_type_id = t.wine_type_id
     and   t.wine_type_name = 'Merlot'
 )

select c.country_name,
       r.region_name,
       v.viticultural_area_name,
       wp.winery_name
from   country c
join   region r
  on   c.country_id = r.country_id
 and   c.country_name = 'USA'
join   viticultural_area v
  on   r.region_id = v.region_id
join   winery_portfolio_cte wp
  on   v.viticultural_area_id = wp.viticultural_area_id;
