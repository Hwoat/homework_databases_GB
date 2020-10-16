  

/*
������� 1:
��������� ������ ������������� users, ������� ����������� ���� �� ���� ����� orders � �������� ��������.
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
������� 2:
�������� ������ ������� products � �������� catalogs, ������� ������������� ������.
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
������� 3:
�� �������) ����� ������� ������� ������ flights (id, from, to) � ������� ������� cities (label, name). 
���� from, to � label �������� ���������� �������� �������, 
���� name � �������. �������� ������ ������ flights � �������� ���������� �������.
*/

drop table if exists flights;
create table flights ( 
  id SERIAL PRIMARY KEY, 
  `from` VARCHAR(255) COMMENT '�ity source in English', 
  `to` VARCHAR(255) COMMENT '�ity destination in English' 
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
  ('moscow', '������'),
  ('irkutsk', '�������'),
  ('novgorod', '��������'),
  ('kazan', '������'),
  ('omsk', '����');

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
