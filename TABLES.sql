---NAME: JAN MICHAEL FUENTES

---ASSIGNMENT FOR ERD


--- Creating Customers Table 

CREATE TABLE customers(customer_id VARCHAR2(20) CONSTRAINT pk_customer_id PRIMARY KEY , customer_name VARCHAR2(50), email VARCHAR(50) UNIQUE, PASSWORD VARCHAR2(50) NOT NULL, phone_number VARCHAR2(20), address VARCHAR2(50), date_of_registration DATE DEFAULT sysdate);

CREATE SEQUENCE customers_id_seq;

CREATE OR REPLACE TRIGGER cust_tgr
    BEFORE INSERT ON customers
    REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
    
BEGIN
    IF :NEW.customer_id IS NULL THEN
        SELECT 'C'||TO_CHAR(customers_id_seq.NEXTVAL,'0000000') INTO :NEW.customer_id FROM DUAL;
    END IF;
END;

--- Creating Admin Table

CREATE TABLE admins(admin_id VARCHAR2(20) CONSTRAINT pk_admin_id PRIMARY KEY, email VARCHAR2(50) UNIQUE , PASSWORD VARCHAR2(50) NOT NULL          
);
CREATE SEQUENCE admin_id_seq;

CREATE OR REPLACE TRIGGER adm_tgr
    BEFORE INSERT
    ON admins
    REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
    IF :NEW.admin_id IS NULL THEN
        SELECT 'A'||TO_CHAR(admin_id_seq.NEXTVAL,'0000000') INTO :NEW.admin_id FROM DUAL;
    END IF;
END;

--- Creating Category Table

CREATE TABLE categories(category_id VARCHAR2(20) CONSTRAINT pk_category_id PRIMARY KEY, category_name VARCHAR2(50))

CREATE SEQUENCE category_id_seq;

CREATE OR REPLACE TRIGGER cat_tgr
    BEFORE INSERT
    ON categories
    REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
    IF :NEW.category_id IS NULL THEN
        SELECT 'CAT'||TO_CHAR(category_id_seq.NEXTVAL,'0000000') INTO :NEW.category_id FROM DUAL;
    END IF;
END;

--- Creating Products Table

CREATE TABLE products(product_id VARCHAR2(20) CONSTRAINT pk_product_id PRIMARY KEY , product_name VARCHAR2(50), category_id VARCHAR(20) NOT NULL , product_price NUMBER(12,2), product_image VARCHAR2(20), product_available_qty VARCHAR2(50),
CONSTRAINT fk_category FOREIGN KEY (category_id) REFERENCES categories(category_id));

CREATE SEQUENCE product_id_seq;

CREATE OR REPLACE TRIGGER prod_tgr
    BEFORE INSERT
    ON products
    REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
    IF :NEW.product_id IS NULL THEN
        SELECT 'P'||TO_CHAR(product_id_seq.NEXTVAL,'0000000') INTO :NEW.product_id FROM DUAL;
    END IF;
END;

--- Creating Coupon Table

CREATE TABLE coupons(coupon_id VARCHAR2(20) CONSTRAINT pk_coupon_id PRIMARY KEY , coupon_name VARCHAR2(50), discount_val NUMBER(20) , expiry_date DATE);

CREATE SEQUENCE coupon_id_seq;

CREATE OR REPLACE TRIGGER coup_tgr
    BEFORE INSERT
    ON coupons
    REFERENCING NEW AS NEW OLD AS OLD
    FOR EACH ROW
BEGIN
    IF :NEW.coupon_id IS NULL THEN
        SELECT 'CO'||TO_CHAR(coupon_id_seq.NEXTVAL,'0000000') INTO :NEW.coupon_id FROM DUAL;
    END IF;
END;

--- Creating Cart Table

CREATE TABLE carts(cart_id VARCHAR2(20) CONSTRAINT pk_cart_id PRIMARY KEY , customer_id VARCHAR2(20) NOT NULL,
                  CONSTRAINT fk_cust_id_cart FOREIGN key (customer_id) REFERENCES customers(customer_id)
);

CREATE SEQUENCE cart_id_seq;

CREATE OR REPLACE TRIGGER cart_tgr
    BEFORE INSERT
    ON carts
    REFERENCING NEW AS NEW OLD AS OLD
    FOR EACH ROW
BEGIN
    IF :NEW.cart_id IS NULL THEN
        SELECT 'CA'||TO_CHAR(cart_id_seq.NEXTVAL,'0000000') INTO :NEW.cart_id FROM DUAL;
    END IF;
END;

--- Creating Cart Items Table

CREATE TABLE cart_items(cart_item_id VARCHAR2(20) CONSTRAINT pk_cart_item_id PRIMARY KEY ,cart_id VARCHAR2(20) NOT NULL, customer_id VARCHAR2(20) NOT NULL, product_id VARCHAR2(20) NOT NULL, product_qty NUMBER(20),
                  CONSTRAINT fk_cart_to_cart_items FOREIGN KEY (cart_id) REFERENCES carts(cart_id), CONSTRAINT fk_cust_to_cart_items FOREIGN KEY (customer_id) REFERENCES customers(customer_id), CONSTRAINT fk_prod_to_cart_items FOREIGN KEY (product_id) REFERENCES products(product_id));

CREATE SEQUENCE cart_items_id_seq;

CREATE OR REPLACE TRIGGER cart_items_tgr
    BEFORE INSERT
    ON cart_items
    REFERENCING NEW AS NEW OLD AS OLD
    FOR EACH ROW
BEGIN
    IF :NEW.cart_item_id IS NULL THEN
        SELECT 'CI'||TO_CHAR(cart_items_id_seq.NEXTVAL,'0000000') INTO :NEW.cart_item_id FROM DUAL;
    END IF;
END;

--- Creating Order Details 

CREATE TABLE orders(order_id VARCHAR2(20) CONSTRAINT pk_order_id PRIMARY KEY ,cart_id VARCHAR2(20) NOT NULL, customer_id VARCHAR2(20) NOT NULL, order_date DATE DEFAULT sysdate, delivery_date DATE DEFAULT sysdate + 7, coupon_id VARCHAR2(20) NOT NULL, bill_amount NUMBER(12,2), payment_method VARCHAR2(2),
                  CONSTRAINT fk_cart_to_order FOREIGN KEY (cart_id) REFERENCES carts(cart_id), CONSTRAINT fk_cust_to_order FOREIGN KEY (customer_id) REFERENCES customers(customer_id), CONSTRAINT fk_coupon_order FOREIGN KEY (coupon_id) REFERENCES coupons(coupon_id), CONSTRAINT ck_pay_meth CHECK(payment_method IN ('COD', 'CREDIT', 'DEBIT', 'E-WALLET')));

CREATE SEQUENCE orders_id_seq;

CREATE OR REPLACE TRIGGER order_tgr
    BEFORE INSERT
    ON orders
    REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
    IF :NEW.order_id IS NULL THEN
        SELECT 'O'||TO_CHAR(orders_id_seq.NEXTVAL,'0000000') INTO :NEW.order_id FROM DUAL;
    END IF;
END;

--- Insert Into Admin 

INSERT INTO admins(email, PASSWORD)  VALUES('fuentesmichael1@gmail.com', 'atos123$');
INSERT INTO admins(email, PASSWORD)  VALUES('fuentesmichael2@gmail.com', 'atos123$');
INSERT INTO admins(email, PASSWORD)  VALUES('fuentesmichael3@gmail.com', 'atos123$');
INSERT INTO admins(email, PASSWORD)  VALUES('fuentesmichael4@gmail.com', 'atos123$');
INSERT INTO admins(email, PASSWORD)  VALUES('fuentesmichael5@gmail.com', 'atos123$');

SELECT * FROM admins

---- Insert Into Category

INSERT INTO categories (category_name) VALUES ('Electronics');
INSERT INTO categories (category_name) VALUES ('Appliances');
INSERT INTO categories (category_name) VALUES ('Toys');
INSERT INTO categories (category_name) VALUES ('Fashion');
INSERT INTO categories (category_name) VALUES ('Groceries');

SELECT * FROM categories;




