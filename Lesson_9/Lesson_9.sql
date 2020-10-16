/*
Практическое задание по теме “Транзакции, переменные, представления 
*/

/*
Задание 1:
В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. 
Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте 
транзакции. 
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
Задание 2:
Создайте представление, которое выводит название name товарной позиции из таблицы products 
и соответствующее название каталога name из таблицы catalogs.. 
*/


create view catal as select products.name as product, catalogs.name as catalog from products
join catalogs 
on products.catalog_id = catalogs.id;



/*
 Практическое задание по теме “Хранимые процедуры и функции, триггеры"
*/

/*
Задание 1:
Cоздайте хранимую функцию hello(), которая будет возвращать приветствие, 
в зависимости от текущего времени суток. С 6:00 до 12:00 функция должна 
возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать 
фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".
*/

drop function if exists hello;

DELIMITER //

create function hello()
returns VARCHAR(255) deterministic 
begin 
	declare greet VARCHAR(255) default '';
	if CURRENT_TIME() between '06:00:00' and '11:59:59' then 
		SET greet = "Доброе утро";
	elseif CURRENT_TIME() between '12:00:00' and '17:59:59' then 
		SET greet = "Добрый день";
	elseif CURRENT_TIME() between '18:00:00' and '23:59:59' then 
		SET greet = "Добрый вечер";
	else 
		SET greet = "Доброй ночи";
	end if;
return greet;
end//

select hello();

