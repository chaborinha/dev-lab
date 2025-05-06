create database jail;

use jail;

create table alcatraz_prisoner
	(
	prisoner_id		int,
	prisoner_name	varchar(100)
	);
	
insert into alcatraz_prisoner
	(
	prisoner_id,
	prisoner_name
	)
values
	(85,	'Al Capone'),
	(594,	'Robert Stroud'),
	(1476, 	'John Anglin');

-- Exercise 12-1: Create the audit table
create table alcatraz_prisoner_audit
	(
	audit_datetime	datetime,
	audit_user		varchar(100),
	audit_change	varchar(200)
	);
    
drop trigger if exists tr_alcatraz_prisoner_ai;

delimiter //

create trigger tr_alcatraz_prisoner_ai
	after insert on alcatraz_prisoner
    for each row
    begin
    insert into alcatraz_prisoner_audit
    (
		audit_datetime,
		audit_user,
		audit_change
    )
    values
    (
		now(),
    user(),
    concat(
      'New row for Prisoner ID ',
      new.prisoner_id,
      '. Prisoner Name: ',
      new.prisoner_name
    )
  );
end//

delimiter ;

-- inserindo e testando trigger
insert into alcatraz_prisoner
  (
    prisoner_id,
    prisoner_name
  )
values
  (
    117,
    'Machine Gun Kelly'
  );
  
select * from alcatraz_prisoner;

select * from alcatraz_prisoner_audit;
    