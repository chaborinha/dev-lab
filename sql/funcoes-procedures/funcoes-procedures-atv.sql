create database diet;

use diet;

create table calorie
	(
	food			varchar(100),
	calorie_count	int
	);
	
insert into calorie
	(
	food,
	calorie_count
	)
values
	('banana', 110),
	('pizza', 700),
	('apple', 185);

delimiter //
    
create function f_get_calorie_count(
	food_param varchar(100)
)
returns int
deterministic
reads sql data
begin
	declare calorie_var int;
    
    select calorie_count
    into calorie_var
    from calorie
    where food = food_param;
    
    return(calorie_var);

end//

delimiter ;

select f_get_calorie_count('apple');

-- atividades procedures
create database age;

use age;

create table family_member_age
	(
	person	varchar(100),
	age		int
	);
	
insert into family_member_age
values
('Junior',	7),
('Ricky',	16),
('Grandpa',	102);

--
drop procedure if exists p_get_age_group;

delimiter //

create procedure p_get_age_group(
	in name_param varchar(100)
)
begin
	declare age_var int;
    
    select age
    into age_var
    from family_member_age
    where person = name_param;
    
    case
    when age_var < 21 then select 'Teenager';
    when age_var < 13 then select 'Child';
    else select 'Adult';
    end case;
    
end//

delimiter ;

call p_get_age_group('Junior');

-- exercicio 11.3
use diet;
drop procedure if exists p_get_food;
delimiter //

create procedure p_get_food()
begin
	select food,
		   calorie_count
	from calorie
    order by calorie_count desc;
end//

delimiter ;

call p_get_food();
