#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "${POSTGRES_USER}" --dbname "${POSTGRES_DB}" <<-EOSQL
    CREATE TABLE manufacturer (
    	id integer PRIMARY KEY,
    	name varchar(50) UNIQUE NOT NULL
    );
    CREATE TABLE product_type (
		id integer PRIMARY KEY,
		name varchar(50) UNIQUE NOT NULL
	);
    CREATE TABLE product (
      id integer PRIMARY KEY,
      name varchar(255) NOT NULL,
      model varchar NOT NULL,
      release_date date NOT NULL,
      manufacturer_id integer NOT NULL,
      product_type_id integer NOT NULL,
      FOREIGN KEY (manufacturer_id)
          REFERENCES manufacturer(id),
      FOREIGN KEY (product_type_id)
          REFERENCES product_type(id)
    );
    CREATE TABLE store (
		id integer PRIMARY KEY,
		name varchar(50) UNIQUE NOT NULL,
		url varchar(100) NOT NULL
	);
    CREATE TABLE product_price (
      id integer PRIMARY KEY NOT NULL,
      product_id integer NOT NULL,
      store_id integer NOT NULL,
      price float NOT NULL,
      date date NOT NULL,
      FOREIGN KEY (product_id)
          REFERENCES product(id),
      FOREIGN KEY (store_id)
          REFERENCES store(id)
    );
    CREATE TABLE user_role (
		id integer PRIMARY KEY,
		role_name varchar(50) NOT NULL
	);
    CREATE TABLE users_table (
		id integer PRIMARY KEY,
		name varchar NOT NULL,
		email varchar(100) UNIQUE NOT NULL,
		password varchar(100) NOT NULL,
		is_active boolean NOT NULL,
		role_id integer NOT NULL,
		FOREIGN KEY (role_id)
			REFERENCES user_role(id)
	);
    CREATE TABLE wishlist (
      id integer PRIMARY KEY,
      product_id integer NOT NULL,
      user_id integer NOT NULL,
      date_added date NOT NULL,
      FOREIGN KEY (product_id)
          REFERENCES product(id),
      FOREIGN KEY (user_id)
          REFERENCES users_table(id)
    );
    CREATE TABLE product_price_history (
    	id integer NOT NULL,
    	product_id integer NOT NULL,
    	date date NOT NULL,
    	price integer NOT NULL,
    	FOREIGN KEY (product_id)
    		REFERENCES product(id)
    );
    INSERT INTO user_role (id, role_name) VALUES (0, 'admin');
    INSERT INTO user_role (id, role_name) VALUES (1, 'visitor');
    INSERT INTO store (id, name, url) VALUES (1, 'altex', 'altex.ro');
EOSQL