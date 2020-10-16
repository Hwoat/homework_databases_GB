/*
������������ ������� �� ���� �����������, ����������, ������������� 
*/

/*
������� 1:
� ���� ������ shop � sample ������������ ���� � �� �� �������, ������� ���� ������. 
����������� ������ id = 1 �� ������� shop.users � ������� sample.users. ����������� 
����������. 
*/

Start transaction;

select * from shop.users where id = 1;
desc shop.users;

insert into sample.users (name, birthday_at)
select name, birthday_at from shop.users
where id = 1;

delete from shop.users where id = 1;

commit;

select * from sample.users order by id;
select * from shop.users order by id;

/*
������� 2:
�������� �������������, ������� ������� �������� name �������� ������� �� ������� products 
� ��������������� �������� �������� name �� ������� catalogs.. 
*/


create view catal as select products.name as product, catalogs.name as catalog from products
join catalogs 
on products.catalog_id = catalogs.id;



/*
 ������������ ������� �� ���� ��������� ��������� � �������, ��������"
*/

/*
������� 1:
C������� �������� ������� hello(), ������� ����� ���������� �����������, 
� ����������� �� �������� ������� �����. � 6:00 �� 12:00 ������� ������ 
���������� ����� "������ ����", � 12:00 �� 18:00 ������� ������ ���������� 
����� "������ ����", � 18:00 �� 00:00 � "������ �����", � 00:00 �� 6:00 � "������ ����".
*/

drop function if exists hello;

DELIMITER //

create function hello()
returns VARCHAR(255) deterministic 
begin 
	declare greet VARCHAR(255) default '';
	if CURRENT_TIME() between '06:00:00' and '11:59:59' then 
		SET greet = "������ ����";
	elseif CURRENT_TIME() between '12:00:00' and '17:59:59' then 
		SET greet = "������ ����";
	elseif CURRENT_TIME() between '18:00:00' and '23:59:59' then 
		SET greet = "������ �����";
	else 
		SET greet = "������ ����";
	end if;
return greet;
end//

select hello();

