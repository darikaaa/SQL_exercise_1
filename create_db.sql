CREATE TABLE table_goods_types(
    id SERIAL NOT NULL PRIMARY KEY,
    type TEXT NOT NULL CHECK ( type != '' )
);

CREATE TABLE table_producers(
    id SERIAL NOT NULL PRIMARY KEY,
    producer_name TEXT NOT NULL CHECK ( producer_name != '' ),
    producer_country TEXT NOT NULL CHECK ( producer_country != '' ),
    address TEXT NOT NULL CHECK ( address != '' ),
    site TEXT NULL CHECK ( site != '' )
);

CREATE TABLE table_goods(
    id SERIAL NOT NULL PRIMARY KEY,
    goods_type_id INT NOT NULL,
    producer_id INT NOT NULL,
    goods_name TEXT NOT NULL CHECK ( goods_name !='' ),
    description TEXT NOT NULL CHECK ( description != '' ),
    buying_price NUMERIC NOT NULL CHECK ( buying_price >= 0 ),
    selling_price NUMERIC NOT NULL CHECK ( selling_price >= 0 ),
    in_stock INT NOT NULL,
    FOREIGN KEY (goods_type_id) REFERENCES table_goods_types(id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    FOREIGN KEY (producer_id) REFERENCES table_producers(id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);

CREATE TABLE table_persons(
    id SERIAL NOT NULL PRIMARY KEY,
    last_name TEXT NOT NULL CHECK ( last_name != '' ),
    first_name TEXT NOT NULL CHECK ( first_name!='' ),
    patronymic TEXT NULL CHECK ( patronymic != '' ),
    gender TEXT NOT NULL CHECK ( gender == 'f' OR gender == 'm')
);

CREATE TABLE table_work_positions(
    id SERIAL NOT NULL PRIMARY KEY,
    job_title TEXT NOT NULL CHECK ( job_title!= '' )
);

CREATE TABLE table_workers(
    id SERIAL NOT NULL PRIMARY KEY,
    position_id INT NOT NULL,
    person_id INT NOT NULL,
    salary INT NOT NULL CHECK ( salary >= 0 ),
    hiring_date DATE NOT NULL,
    FOREIGN KEY (person_id) REFERENCES table_persons(id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    FOREIGN KEY (position_id) REFERENCES table_work_positions(job_title)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);

CREATE TABLE table_customers(
    id SERIAL NOT NULL PRIMARY KEY,
    person_id INT NOT NULL,
    phone_number TEXT NOT NULL CHECK ( phone_number != '' ),
    email TEXT NOT NULL CHECK (email SIMILAR TO 'A%'),
    personal_discount INT NULL DEFAULT 0 CHECK ( personal_discount >= 0 ),
    is_subscribed BOOLEAN NOT NULL DEFAULT False,
    FOREIGN KEY (person_id) REFERENCES table_persons(id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);

CREATE TABLE table_payment_methods(
    id SERIAL NOT NULL PRIMARY KEY,
    payment_method TEXT NOT NULL CHECK ( payment_method != '' )
);

CREATE TABLE table_sales(
    id SERIAL NOT NULL PRIMARY KEY,
    goods_id INT NOT NULL,
    worker_id INT NOT NULL,
    customer_id INT NULL,
    payment_method_id INT NOT NULL,
    quantity INT NOT NULL CHECK ( quantity >= 0 ),
    sale_date DATE NOT NULL,
    FOREIGN KEY (goods_id) REFERENCES table_goods(id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    FOREIGN KEY (worker_id) REFERENCES table_workers(id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    FOREIGN KEY (customer_id) REFERENCES table_customers(id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    FOREIGN KEY (payment_method_id) REFERENCES table_payment_methods(id)
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




