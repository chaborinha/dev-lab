create database accounting;

use accounting;

-- Create a table for account payable data for a company
create table payable
	(
	payable_id	int,
	company		varchar(100),
	amount		numeric(8,2),
	service		varchar(100)
	);
	
insert into payable
	(
	payable_id,
	company,
	amount,
	service
	)
values
	(1, 'Acme HVAC', 		 	 123.32,	'Repair of Air Conditioner'),
	(2, 'Initech Printers',		1459.00,	'New Printers'),
	(3, 'Hooli Cleaning',		4398.55,	'Janitorial Services');
	
-- Create the payable_audit table that will track changes to the payable table
create table payable_audit
	(
	audit_datetime	datetime,
	audit_user		varchar(50),
	audit_change	varchar(500)
	);
    
-- triggers após inserir
drop trigger if exists tr_payable_ai;

delimiter //

create trigger tr_payable_audit
	after insert on payable
    for each row
    begin
    insert into payable_audit
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
		  'New row for payable_id ',
          new.payable_id,
          '. Company: ',
          new.company,
          '. Amount: ',
          new.amount,
          '. Service: ',
          new.service
        )
    );
end//
    
delimiter ;

-- fazendo insert e testando gatilho
insert into payable
	(
	  payable_id,
      company,
      amount,
      service
    )
values
	(
	  4,
	  'Sirius Painting',
      451.45,
      'Painting the lobby'
    );

select * from payable_audit;

-- triggers após deletar
use accounting;

drop trigger if exists tr_payable_ad;

delimiter //

create trigger tr_payable_ad
	after delete on payable
    for each row
begin
	insert into payable_audit
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
			'Deleted row for payable_id ',
            old.payable_id,
            '. Company: ',
            old.company,
            '. Amount: ',
            old.amount,
            '. Service: ',
            old.service
        )
    );

end//

delimiter ;

-- deletando campo da tabela e testando trigger
SET SQL_SAFE_UPDATES=0;
delete from payable where company = 'Sirius Painting';
select * from payable_audit;

-- triggers após atualizar

drop trigger if exists tr_payable_au;

delimiter //

create trigger tr_payable_au
	after update on payable
    for each row
begin
	set @change_msg =
		concat(
			'Updated row for payable_id ',
            old.payable_id
        );
        
	if (old.company != new.company) then
		set @change_msg =
			concat(
				@change_msg,
				'. Company changed from ',
                old.company,
                ' to ',
                new.company
            );
	end if;
    
    if (old.amount != new.amount) then
		set @change_msg = 
			concat(
				@change_msg,
                '. Amount changed from ',
                old.amount,
                ' to ',
                new.amount
            );
	end if;
    
    if (old.service != new.service) then
		set @change_msg = 
			concat(
				@change_msg,
                '. Service changed from ',
                old.service,
                ' to ',
                new.service
            );
	end if;
    
    insert into payable_audit
    (
		audit_datetime,
        audit_user,
        audit_change
    )
    values
    (
		now(),
        user(),
        @change_msg
    );
    
end//

delimiter ;

-- atualizando tabela e testando trigger
update payable
set amount = 200000,
	company = 'House of Harry'
where payable_id = 3;

select * from payable_audit;

-- triggers que afetam os dados
create database bank;
use bank;

create table credit
(
	customer_id int,
    customer_name varchar(100),
    credit_score int
);

-- triggers antes de inserir

drop trigger if exists tr_credit_bi;
delimiter //

create trigger tr_credit_bi
	before insert on credit
    for each row
begin
	if (new.credit_score < 300) then
		set new.credit_score = 300;
	end if;
    
    if (new.credit_score > 850) then
		set new.credit_score = 850;
	end if;
    
end//

delimiter ;

insert into credit
(
	customer_id,
    customer_name,
    credit_score
)
values
(1, 'Milton Megabucks', 987),
(2, 'Patty Po', 145),
(3, 'Vinny Middle-Class', 702);

select * from credit;

-- triggers antes de atualizar

drop trigger if exists tr_credit_bu;

delimiter //

create trigger tr_credit_bu
	before update on credit
    for each row
begin
	if (new.credit_score < 300) then
		set new.credit_score = 300;
	end if;
    
    if (new.credit_score > 800) then
		set new.credit_score = 800;
	end if;
    
end//

delimiter ;

SET SQL_SAFE_UPDATES=0;
update credit
set credit_score = 1111
where customer_id = 3;

select * from credit;

-- triggers antes de deletar

drop trigger if exists tr_credit_bd;

delimiter //

create trigger tr_credit_bd
	before delete on credit
    for each row
begin
	if (old.credit_score > 750) then
		signal sqlstate '45000'
        set message_text = 'Cannot delete scores over 750';
	end if;
    
end//

delimiter ;

delete from credit where customer_id = 1;
delete from credit where customer_id = 2;