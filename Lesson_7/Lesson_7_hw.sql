  

/*
Задание 1:
Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
*/


select 
  users.name, count(*) as 'Orders_vol'
from 
  users
join 
  orders
on 
  users.id = orders.user_id
group by users.id;



/*
Задание 2:
Выведите список товаров products и разделов catalogs, который соответствует товару.
*/


select 
  products.name as 'Products_name', catalogs.name as 'Catalogs_name' 
from 
  products 
join 
  catalogs 
on 
  catalogs.id = products.catalog_id; 


/*
Задание 3:
По желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
Поля from, to и label содержат английские названия городов, 
поле name — русское. Выведите список рейсов flights с русскими названиями городов.
*/

drop table if exists flights;
create table flights ( 
  id SERIAL PRIMARY KEY, 
  `from` VARCHAR(255) COMMENT 'Сity source in English', 
  `to` VARCHAR(255) COMMENT 'Сity destination in English' 
);

drop table if exists cities;
create table cities ( 
  id SERIAL PRIMARY KEY, 
  `label` VARCHAR(255) COMMENT 'Cities label in English', 
  `name` VARCHAR(255) COMMENT 'Cities name in Russian' 
);

INSERT INTO flights (`from`, `to`) VALUES
  ('moscow', 'omsk'),
  ('novgorod', 'kazan'),
  ('irkutsk', 'moscow'),
  ('omsk', 'irkutsk'),
  ('moscow', 'kazan');

INSERT INTO cities (`label`, `name`) VALUES
  ('moscow', 'Москва'),
  ('irkutsk', 'Иркутск'),
  ('novgorod', 'Новгород'),
  ('kazan', 'Казань'),
  ('omsk', 'Омск');

select * from flights;
select * from cities;

select 
  flights.id, 
  (select name from cities where flights.from = cities.label) as from_ru, 
  (select name from cities where flights.to = cities.label) as to_ru
from 
  flights
join 
  cities
on 
  flights.from = cities.label 
order by flights.id;
