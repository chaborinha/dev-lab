create database mysqlview;

use mysqlview;

create table course
	(
	course_name		varchar(100),
	course_level	varchar(50)
	);
	
insert into course values ('Introduction to Python', 'beginner');
insert into course values ('Introduction to HTML', 'beginner');
insert into course values ('React Full-Stack Web Development', 'advanced');
insert into course values ('Object-Oriented Design Patterns in Java', 'advanced');
insert into course values ('Practical Linux Administration', 'advanced');
insert into course values ('Learn JavaScript', 'beginner');
insert into course values ('Advanced Hardware Security', 'advanced');

create view v_course_beginner as 
select  *
from    course
where   course_level = 'beginner';

select * from v_course_beginner;

create view v_course_advanced as 
select  *
from    course
where   course_level = 'advanced';

select * from v_course_advanced;

create table company
	(
    company_id			int,
    company_name 		varchar(200),
    owner				varchar(100),
    owner_phone_number	varchar(20)
    );

create table complaint
	(
       complaint_id		int,
       company_id		int,
       complaint_desc	varchar(200)
    );

insert into company values (1, 'Cattywampus Cellular', 'Sam Shady', '784-785-1245');
insert into company values (2, 'Wooden Nickel Bank', 'Oscar Opossum', '719-997-4545');
insert into company values (3, 'Pitiful Pawn Shop', 'Frank Fishy', '917-185-7911');

insert into complaint  values (1, 1, "Phone doesn't work");
insert into complaint  values (2, 1, 'Wiki is on the blink');
insert into complaint  values (3, 1, 'Customer Service is bad');
insert into complaint  values (4, 2, 'Bank closes too early');
insert into complaint  values (5, 3, 'My iguana died');
insert into complaint  values (6, 3, 'Police confiscated my purchase');

-- --------------------------------------------------------------------

-- exemplo de join para inserir na view
select a.company_name,
	   a.owner,
	   a.owner_phone_number,
       count(*) as reclamation
from company a 
join complaint b
on a.company_id = b.company_id
group by a.company_name,
	     a.owner,
	     a.owner_phone_number;
         
-- agora criando resultado da query em uma view
create view v_complaint as
select a.company_name,
	   a.owner,
	   a.owner_phone_number,
       count(*) as reclamation
from company a 
join complaint b
on a.company_id = b.company_id
group by a.company_name,
	     a.owner,
	     a.owner_phone_number;
         
-- a mesma view, porem agora ocultando informações privadas do propietario
create view v_complaint_public as
select a.company_name,
       count(*) as reclamation
from company a 
join complaint b
on a.company_id = b.company_id
group by a.company_name;

select * from v_complaint_public;