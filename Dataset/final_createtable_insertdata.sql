CREATE TABLE category
(
  category_id INT NOT NULL,
  category_name VARCHAR(50) NOT NULL,
  PRIMARY KEY (category_id)
);

-- ALTER TABLE item
-- ALTER COLUMN description_4 DROP NOT NULL;
-- ALTER TABLE item
-- ALTER COLUMN list_price TYPE NUMERIC(6, 2);


CREATE TABLE item
(
  product_id INT NOT NULL,
  product_name VARCHAR(100),
  description VARCHAR(150),
  description_1 VARCHAR(150),
  description_2 VARCHAR(150),
  description_3 VARCHAR(150),
  description_4 VARCHAR(150),
  standard_cost NUMERIC(6,2) NOT NULL,
  list_price NUMERIC(6,2) NOT NULL,
  category_id INT NOT NULL,
  PRIMARY KEY (product_id),
  FOREIGN KEY (category_id) REFERENCES category(category_id)
);

CREATE TABLE country
(
  country_id CHAR(2) NOT NULL,
  country_name VARCHAR(50) NOT NULL,
  region_id INT NOT NULL,
  PRIMARY KEY (country_id)
);

CREATE TABLE account
(
  user_id SERIAL PRIMARY KEY,
  username VARCHAR(50) NOT NULL,
  password VARCHAR(50) NOT NULL,
  email VARCHAR(150) NOT NULL,
  phone_number VARCHAR(20) DEFAULT NULL
);

-- ALTER TABLE orders
-- ALTER COLUMN total_amount TYPE NUMERIC(10, 2)

CREATE TABLE orders
(
  order_id SERIAL,
  order_date DATE NOT NULL,
  shipping_address VARCHAR(150) NOT NULL,
  total_amount NUMERIC(12,2) NOT NULL,
  status VARCHAR(15) NOT NULL,
  payment_type CHAR(5) NOT NULL,
  user_id INT NOT NULL,
  PRIMARY KEY (order_id),
  FOREIGN KEY (user_id) REFERENCES account(user_id)
);

CREATE TABLE cart
(
  cart_id SERIAL,
  user_id INT NOT NULL,
  PRIMARY KEY (cart_id),
  FOREIGN KEY (user_id) REFERENCES account(user_id)
);

CREATE TABLE cart_item
(
  quantity INT NOT NULL,
  cart_id INT NOT NULL,
  product_id INT NOT NULL,
  PRIMARY KEY (cart_id, product_id),
  FOREIGN KEY (cart_id) REFERENCES cart(cart_id),
  FOREIGN KEY (product_id) REFERENCES item(product_id)
);

	
-- ALTER TABLE location
-- ALTER COLUMN postal_code TYPE VARCHAR(20);

CREATE TABLE location
(
  location_id INT NOT NULL,
  address VARCHAR(150) NOT NULL,
  postal_code VARCHAR(20) NOT NULL,
  city VARCHAR(50) NOT NULL,
  state VARCHAR(50) NOT NULL,
  country_id CHAR(2) NOT NULL,
  PRIMARY KEY (location_id),
  FOREIGN KEY (country_id) REFERENCES country(country_id)
);

CREATE TABLE warehouse
(
  warehouse_id INT NOT NULL,
  warehouse_name VARCHAR(50) NOT NULL,
  location_id INT NOT NULL,
  PRIMARY KEY (warehouse_id),
  FOREIGN KEY (location_id) REFERENCES location(location_id)
);

CREATE TABLE inventory
(
  quantity INT NOT NULL,
  warehouse_id INT NOT NULL,
  product_id INT NOT NULL,
  PRIMARY KEY (warehouse_id, product_id),
  FOREIGN KEY (warehouse_id) REFERENCES warehouse(warehouse_id),
  FOREIGN KEY (product_id) REFERENCES item(product_id)
);

CREATE TABLE order_item
(
  quantity INT NOT NULL,
  order_id INT NOT NULL,
  warehouse_id INT NOT NULL,
  product_id INT NOT NULL,
  PRIMARY KEY (order_id, warehouse_id, product_id),
  FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
  FOREIGN KEY (warehouse_id, product_id) REFERENCES inventory(warehouse_id, product_id)
);

-- ALTER TABLE order_item
-- DROP CONSTRAINT IF EXISTS FK_order_item_order_id,  -- Drop the existing foreign key constraint if it exists
-- ADD CONSTRAINT FK_order_item_order_id
-- FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE;

computerhardware=# \COPY category(category_id, category_name) FROM '/Users/trinhdiemquynh/Documents/DATABASE/project/git/Computer_Hardware_Database/Dataset/categories.csv' CSV HEADER DELIMITER ',';
COPY 4
computerhardware-# \COPY country(country_id, region_id, country_name) FROM '/Users/trinhdiemquynh/Documents/DATABASE/project/git/Computer_Hardware_Database/Dataset/countries.csv' CSV HEADER DELIMITER ',';
COPY 6
computerhardware-# \COPY item(category_id, product_id, product_name, description, description_1, description_2, description_3, description_4, standard_cost, list_price) FROM '/Users/trinhdiemquynh/Documents/DATABASE/project/git/Computer_Hardware_Database/Dataset/item.txt' WITH DELIMITER E'\t'; 
COPY 208
computerhardware-# \COPY location(country_id, location_id, address, postal_code, city, state)FROM '/Users/trinhdiemquynh/Documents/DATABASE/project/git/Computer_Hardware_Database/Dataset/locations.csv' CSV HEADER DELIMITER ',';
COPY 9
computerhardware-# \COPY warehouse(location_id, warehouse_id, warehouse_name) FROM '/Users/trinhdiemquynh/Documents/DATABASE/project/git/Computer_Hardware_Database/Dataset/warehouse.csv' CSV HEADER DELIMITER ',';
COPY 9
computerhardware-# \COPY inventory(product_id, warehouse_id, quantity)FROM '/Users/trinhdiemquynh/Documents/DATABASE/project/git/Computer_Hardware_Database/Dataset/inventory.csv' CSV HEADER DELIMITER ','; 
COPY 1112
computerhardware-# 
