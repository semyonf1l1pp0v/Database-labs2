
BEGIN;

drop table if exists "Б20-703-2".product_categories cascade;
drop table if exists "Б20-703-2".products cascade;
drop table if exists "Б20-703-2".orders cascade;
drop table if exists "Б20-703-2".clients cascade;
drop table if exists "Б20-703-2".products_list cascade;
drop table if exists "Б20-703-2".product_sizes cascade;
drop table if exists "Б20-703-2".product_colors cascade;
drop table if exists "Б20-703-2".images cascade;
drop table if exists "Б20-703-2".product_sizes_products cascade;
drop table if exists "Б20-703-2".product_colors_products cascade;
drop table if exists "Б20-703-2".product_categories_products cascade;

drop sequence "Б20-703-2"."seq1";
drop sequence "Б20-703-2"."seq2";
drop sequence "Б20-703-2"."seq3";
drop sequence "Б20-703-2"."seq4";
drop sequence "Б20-703-2"."seq5";

CREATE TABLE IF NOT EXISTS "Б20-703-2".product_categories
(
    name text NOT NULL,
    pos_tree_id integer,
    id integer,
    pos_hor_tree_id integer NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (name),
    UNIQUE (pos_hor_tree_id, pos_tree_id)
);

CREATE TABLE IF NOT EXISTS "Б20-703-2".products
(
    name text NOT NULL,
    sh_desc text NOT NULL,
    full_desc text NOT NULL,
    def_cost integer NOT NULL,
    cost integer NOT NULL,
    count_storage integer NOT NULL,
    product_code text,
    min_count integer NOT NULL,
    PRIMARY KEY (product_code),
    UNIQUE (name)
);

CREATE TABLE IF NOT EXISTS "Б20-703-2".orders
(
    client_ph_number text NOT NULL,
    order_number text,
    payment_type text NOT NULL,
    delivery_type text NOT NULL,
    cost integer NOT NULL,
    total_cost integer NOT NULL,
    order_date date NOT NULL,
    PRIMARY KEY (order_number),
	constraint dl check (delivery_type = 'самовывоз' or delivery_type = 'доставка на дом'),
	constraint pm check (payment_type = 'наличными' or payment_type = 'картой при доставке' or payment_type = 'картой онлайн')
);

CREATE TABLE IF NOT EXISTS "Б20-703-2".clients
(
    name text NOT NULL,
    ph_number text,
    address text NOT NULL,
    email text NOT NULL,
    PRIMARY KEY (ph_number),
    UNIQUE (email)
);

CREATE TABLE IF NOT EXISTS "Б20-703-2".product_sizes
(
    id integer,
    size_name integer NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (size_name)
);

CREATE TABLE IF NOT EXISTS "Б20-703-2".product_colors
(
    id integer,
    color_name text NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (color_name)
);

CREATE TABLE IF NOT EXISTS "Б20-703-2".images
(
    id text,
    product_code text NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS "Б20-703-2".product_categories_products
(
    product_categories_name text,
    products_name text
    /*PRIMARY KEY (product_categories_name, products_name)*/
);

CREATE TABLE IF NOT EXISTS "Б20-703-2".product_sizes_products
(
    product_sizes_size_name integer,
    products_product_code text,
    PRIMARY KEY (product_sizes_size_name, products_product_code)
);

CREATE TABLE IF NOT EXISTS "Б20-703-2".product_colors_products
(
    product_colors_color_name text,
    products_product_code text,
    PRIMARY KEY (product_colors_color_name, products_product_code)
);

CREATE TABLE IF NOT EXISTS "Б20-703-2".products_list
(
    orders_order_number text NOT NULL,
    products_product_code text NOT NULL,
    order_cost integer NOT NULL,
    id integer,
    PRIMARY KEY (id)
);

ALTER TABLE IF EXISTS "Б20-703-2".product_categories
    ADD FOREIGN KEY (pos_tree_id)
    REFERENCES "Б20-703-2".product_categories (id) MATCH SIMPLE 
    ON UPDATE NO ACTION
    ON DELETE CASCADE
    NOT VALID;


ALTER TABLE IF EXISTS "Б20-703-2".orders
    ADD FOREIGN KEY (client_ph_number)
    REFERENCES "Б20-703-2".clients (ph_number) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS "Б20-703-2".images
    ADD FOREIGN KEY (product_code)
    REFERENCES "Б20-703-2".products (product_code) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS "Б20-703-2".product_categories_products
    ADD FOREIGN KEY (product_categories_name)
    REFERENCES "Б20-703-2".product_categories (name) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE SET NULL
    NOT VALID;


ALTER TABLE IF EXISTS "Б20-703-2".product_categories_products
    ADD FOREIGN KEY (products_name)
    REFERENCES "Б20-703-2".products (name) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS "Б20-703-2".product_sizes_products
    ADD FOREIGN KEY (product_sizes_size_name)
    REFERENCES "Б20-703-2".product_sizes (size_name) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS "Б20-703-2".product_sizes_products
    ADD FOREIGN KEY (products_product_code)
    REFERENCES "Б20-703-2".products (product_code) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS "Б20-703-2".product_colors_products
    ADD FOREIGN KEY (product_colors_color_name)
    REFERENCES "Б20-703-2".product_colors (color_name) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS "Б20-703-2".product_colors_products
    ADD FOREIGN KEY (products_product_code)
    REFERENCES "Б20-703-2".products (product_code) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS "Б20-703-2".products_list
    ADD FOREIGN KEY (orders_order_number)
    REFERENCES "Б20-703-2".orders (order_number) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS "Б20-703-2".products_list
    ADD FOREIGN KEY (products_product_code)
    REFERENCES "Б20-703-2".products (product_code) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

create sequence "Б20-703-2"."seq1" increment by 1 minvalue 1 start 1 no cycle;
insert into "Б20-703-2".product_categories values
('Мужское',null,nextval('"Б20-703-2"."seq1"'),1),
('Женское',null,nextval('"Б20-703-2"."seq1"'),2),
('Мужская одежда',1,nextval('"Б20-703-2"."seq1"'),1),
('Мужская обувь',1,nextval('"Б20-703-2"."seq1"'),2),
('Мужские аксессуары',1,nextval('"Б20-703-2"."seq1"'),3);
	
insert into "Б20-703-2".products values
('Пальто','Весеннее пальто','Весеннее пальто черное',10000,9000,10,110423,1),
('Футболка','Футболка серая','Футболка серая женская',9000,8500,8,110424,1),
('Кофта','Кофта шерстяная','Кофта шерстяная красная',4000,4000,9,733454,1),
('Джинсы','Джинсы утепленные','Джинсы утепленные мужские',6000,5500,12,734534,1),
('Туфли','Туфли к костюму','Туфли к костюму из крокодила',15000,14000,11,673432,1),
('Сарафан джинсовый','Сарафан джинсовый на пуговицах','Сарафан джинсовый на пуговицах женский',7000,7000,5,902325,1),
('Сарафан ситцевый','Сарафан ситцевый летний','Сарафан ситцевый летний женский',8000,8000,5,643224,1),
('Духи','Духи CK','Духи CK мужские',20000,20000,5,657437,1);

insert into "Б20-703-2".clients values
('Белов Александр Николаевич','+7-999-955-88-61','Москва, Тверская ул., 1с2','beliy@mail.ru'),
('Иванов Петр Владимирович','+7-999-955-88-47','Москва, Моховая ул., 2с4','petr@mail.ru'),
('Иванова Александра Петровна','+7-999-955-88-93','Москва, Неглинная ул., 3к1','sanya@mail.ru'),
('Чернов Николай Александрович','+7-999-955-88-04','Москва, Пушечная ул., 4с2','kolya@mail.ru'),
('Иванов Владислав Иванович','+7-999-955-88-85','Москва, Петровка ул., 5с3','vlad@mail.ru'),
('Иванов Иван Иванович','+7-999-955-89-86','Москва, Петровка ул., 1','3I@mail.ru');

insert into "Б20-703-2".orders values
('+7-999-955-88-61',1111,'наличными','самовывоз',12000,12000,'01.01.2023'),
('+7-999-955-88-47',1112,'наличными','самовывоз',8000,8000,'02.01.2023'),
('+7-999-955-88-93',1113,'наличными','самовывоз',28000,28000,'03.01.2023'),
('+7-999-955-88-04',1114,'картой онлайн','доставка на дом',5500,6000,'04.01.2023'),
('+7-999-955-88-85',1115,'картой при доставке','доставка на дом',17000,18000,'05.01.2023');

create sequence "Б20-703-2"."seq2" minvalue 1;
insert into "Б20-703-2".product_sizes values
(nextval('"Б20-703-2"."seq2"'),48),
(nextval('"Б20-703-2"."seq2"'),50),
(nextval('"Б20-703-2"."seq2"'),52),
(nextval('"Б20-703-2"."seq2"'),54),
(nextval('"Б20-703-2"."seq2"'),56);

create sequence "Б20-703-2"."seq3" minvalue 1;
insert into "Б20-703-2".product_colors values
(nextval('"Б20-703-2"."seq3"'),'красный'),
(nextval('"Б20-703-2"."seq3"'),'черный'),
(nextval('"Б20-703-2"."seq3"'),'белый'),
(nextval('"Б20-703-2"."seq3"'),'синий'),
(nextval('"Б20-703-2"."seq3"'),'серый'),
(nextval('"Б20-703-2"."seq3"'),'желтый');

create sequence "Б20-703-2"."seq4" minvalue 1;
insert into "Б20-703-2".images values
(nextval('"Б20-703-2"."seq4"'),110423),
(nextval('"Б20-703-2"."seq4"'),110424),
(nextval('"Б20-703-2"."seq4"'),733454),
(nextval('"Б20-703-2"."seq4"'),734534),
(nextval('"Б20-703-2"."seq4"'),673432),
(nextval('"Б20-703-2"."seq4"'),902325),
(nextval('"Б20-703-2"."seq4"'),643224);

insert into "Б20-703-2".product_categories_products values
('Мужская одежда','Пальто'),
('Женское','Футболка'),
('Женское','Кофта'),
('Мужская одежда','Джинсы'),
('Мужская обувь','Туфли'),
('Женское','Сарафан ситцевый'),
('Женское','Сарафан джинсовый'),
('Мужское','Духи');

insert into "Б20-703-2".product_sizes_products values
(50,110423),
(48,110424),
(52,733454),
(54,734534),
(50,673432),
(50,902325),
(48,643224);

insert into "Б20-703-2".product_colors_products values
('черный',110423),
('серый',110424),
('красный',733454),
('синий',734534),
('черный',673432),
('синий',902325),
('белый',643224);

create sequence "Б20-703-2"."seq5" minvalue 1;
insert into "Б20-703-2".products_list values
(1111,733454,12000,nextval('"Б20-703-2"."seq5"')),
(1112,733454,8000,nextval('"Б20-703-2"."seq5"')),
(1113,673432,28000,nextval('"Б20-703-2"."seq5"')),
(1114,734534,6000,nextval('"Б20-703-2"."seq5"')),
(1115,110424,18000,nextval('"Б20-703-2"."seq5"'));

select * from "Б20-703-2".product_categories;
select * from "Б20-703-2".products;
select * from "Б20-703-2".clients;
select * from "Б20-703-2".orders;
select * from "Б20-703-2".product_sizes;
select * from "Б20-703-2".product_colors;
select * from "Б20-703-2".images;	
select * from "Б20-703-2".product_categories_products;
select * from "Б20-703-2".product_sizes_products;
select * from "Б20-703-2".product_colors_products;
select * from "Б20-703-2".products_list;

--0
select sum(cost*count_storage) from "Б20-703-2".products as sum_cost;

--1								
/*приведение типов для дробного результата деления*/

select
(select cast ((select count(*) from "Б20-703-2".orders) as float))/
(select cast ((select count(*) from "Б20-703-2".clients) as float))
as avg_orders;

--2 
(select orders_order_number, order_cost/cost as count_of_goods 
from "Б20-703-2".products_list l, "Б20-703-2".products p 
where l.products_product_code = p.product_code order by
count_of_goods asc limit 1)

UNION

(select orders_order_number, order_cost/cost as count_of_goods 
from "Б20-703-2".products_list l, "Б20-703-2".products p 
where l.products_product_code = p.product_code order by
count_of_goods desc limit 1);

--3
/*удаляем категорию, если она родитель и пуста (в ней нет товаров)*/
delete from "Б20-703-2".product_categories d where 
(d.pos_tree_id is NULL and (select count (*) from 
(select * from "Б20-703-2".product_categories_products f
where f.product_categories_name = d.name) as aa) = 0) 

or 												
/*или
если у нее есть пустая категория-потомок*/

(d.id = /*выбираем id родителя*/
(select pos_tree_id from "Б20-703-2".product_categories f
where (f.pos_tree_id is not NULL and 
f.id in (select id from													  
(with t1 as
 
(select a.id, a.name, a.pos_tree_id from "Б20-703-2".product_categories a join 
"Б20-703-2".product_categories b on a.pos_tree_id = b.id) /*выбрали категории-потомки*/
 
select * from t1 where 
(select count (*) from (select * from "Б20-703-2".product_categories_products f
where f.product_categories_name = t1.name) as k) = 0) /*которые пусты*/ as bb))));

--4								
/* по одному выбираем товары со словом сарафан
в названии, если в списке цветов нет желтого
- добавляем, если есть - идем к следующему товару 
ИЗМЕНЕНО: теперь функция возвращает добавляемые в таблицу строки*/

DROP FUNCTION IF EXISTS f1();
CREATE OR REPLACE FUNCTION f1() RETURNS
table(f1 text, f2 text) AS $$ 
DECLARE i int := 0;

BEGIN
WHILE i < (select count (*) from "Б20-703-2".products l 
			where l.name ~ '^Сарафан') LOOP

	IF ('желтый' not in (select product_colors_color_name from
	"Б20-703-2".product_colors_products k where k.products_product_code = 
	(select product_code from "Б20-703-2".products l
	 where l.name ~ '^Сарафан' limit 1 offset i))) THEN
	 
		insert into "Б20-703-2".product_colors_products values
		('желтый',(select product_code from "Б20-703-2".products l
	 	where l.name ~ '^Сарафан' limit 1 offset i));
	ELSE 
		continue;
	END IF;
	i := i + 1;
END LOOP; 
RETURN QUERY 
(select * from	
"Б20-703-2".product_colors_products k 
where k.product_colors_color_name = 'желтый' 
and k.products_product_code in 
(select product_code from "Б20-703-2".products l where l.name ~ '^Сарафан'));
END;
$$ LANGUAGE plpgsql;

select f1();

select * from "Б20-703-2".product_colors_products;

delete from "Б20-703-2".product_colors_products l
where l.products_product_code = '643224' and
l.product_colors_color_name = 'желтый';

--5 
alter table "Б20-703-2".clients drop column
if exists discount;

alter table "Б20-703-2".clients add column
if not exists discount float default 0;

select * from "Б20-703-2".clients;

--6 
alter table "Б20-703-2".clients
drop constraint if exists discount_check;

alter table "Б20-703-2".clients add constraint
discount_check check (discount <= 0.75);

update "Б20-703-2".clients set discount = 0.7;

update "Б20-703-2".clients set discount = 0.8; 


END;
