BEGIN;

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
    constraint pm check 
	(payment_type = 'наличными' or payment_type = 'картой при доставке' or payment_type = 'картой онлайн')
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
    products_name text,
    PRIMARY KEY (product_categories_name, products_name)
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

CREATE TABLE IF NOT EXISTS "Б20-703-2".orders_products
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
    ON DELETE NO ACTION
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
    ON DELETE NO ACTION
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


ALTER TABLE IF EXISTS "Б20-703-2".orders_products
    ADD FOREIGN KEY (orders_order_number)
    REFERENCES "Б20-703-2".orders (order_number) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS "Б20-703-2".orders_products
    ADD FOREIGN KEY (products_product_code)
    REFERENCES "Б20-703-2".products (product_code) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

END;