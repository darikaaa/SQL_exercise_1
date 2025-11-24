CREATE TABLE table_goods_types(
    id SERIAL NOT NULL PRIMARY KEY,
    type TEXT NOT NULL CHECK ( type != '' )
);

CREATE TABLE table_producers(
    id SERIAL NOT NULL PRIMARY KEY,
    producer TEXT NOT NULL CHECK ( producer != '' )
);

CREATE TABLE table_goods(
    id SERIAL NOT NULL PRIMARY KEY,
    goods_type_id INT NOT NULL,
    producer_id INT NOT NULL,
    goods TEXT NOT NULL CHECK ( goods!='' ),
    buying_price NUMERIC NOT NULL,
    selling_price NUMERIC NOT NULL,
    in_stock INT NULL,
    FOREIGN KEY (goods_type_id) REFERENCES table_goods_types(id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    FOREIGN KEY (producer_id) REFERENCES table_producers(id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);

CREATE TABLE table_persons(
    id SERIAL NOT NULL PRIMARY KEY,
    last_name TEXT NOT NULL,
    first_name TEXT NOT NULL,
    patronymic TEXT NULL,
    gender TEXT NOT NULL CHECK ( gender == 'f' OR gender == 'm')
);

CREATE TABLE table_workers(
    id SERIAL NOT NULL PRIMARY KEY,
    person_id INT NOT NULL,
    salary INT NULL,
    job_title TEXT NOT NULL,
    hiring_date DATE NOT NULL,
    FOREIGN KEY (person_id) REFERENCES table_persons(id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);

CREATE TABLE table_telephone_types(
    id SERIAL NOT NULL PRIMARY KEY,
    type TEXT NOT NULL CHECK ( type != '' )
);

CREATE TABLE table_customers(
    id SERIAL NOT NULL PRIMARY KEY,
    person_id INT NOT NULL,
    telephone_type_id INT NOT NULL,
    phone_number TEXT NOT NULL  ,
    email TEXT NOT NULL,
    personal_discount INT NULL DEFAULT 0,
    is_subscribed BOOLEAN NOT NULL DEFAULT False,
    FOREIGN KEY (person_id) REFERENCES table_persons(id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    FOREIGN KEY (telephone_type_id) REFERENCES table_telephone_types(id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);

CREATE TABLE table_sales(
    id SERIAL NOT NULL PRIMARY KEY,
    goods_id INT NOT NULL,
    worker_id INT NOT NULL,
    customer_id INT NULL,
    amount INT NOT NULL,
    sale_date DATE NOT NULL,
    FOREIGN KEY (goods_id) REFERENCES table_goods(id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    FOREIGN KEY (worker_id) REFERENCES table_workers(id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    FOREIGN KEY (customer_id) REFERENCES table_customers(id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);

CREATE TABLE table_orders_history(
    id SERIAL NOT NULL PRIMARY KEY,
    customer_id INT NOT NULL,
    sale_id INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES table_customers(id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    FOREIGN KEY (sale_id) REFERENCES table_sales(id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
)




