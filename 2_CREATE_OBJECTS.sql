
DECLARE
table_count NUMBER(10);
sequence_count NUMBER(10);
trigger_count NUMBER(10);
BEGIN 
    SELECT count(*) into table_count FROM user_tables where table_name = 'TABLE_TRACKER';
    select count(*) into trigger_count from user_tables where table_name='TRIGGER_TRACKER';
    select count(*) into sequence_count from user_tables where table_name='SEQUENCE_TRACKER';
    
    IF(table_count > 0)
    THEN
        DBMS_OUTPUT.PUT_LINE('TABLE TABLE_TRACKER ALREADY EXISTS!');
    ELSE
        EXECUTE IMMEDIATE 'CREATE TABLE TABLE_TRACKER
    (
       TABLE_NAME varchar2(100), 
       TABLE_QUERY varchar2(5000) NOT NULL, 
       CONSTRAINT TRACKER_TABLE_PK PRIMARY KEY(TABLE_NAME)
    )
    ';
    DBMS_OUTPUT.PUT_LINE('TABLE TABLE_TRACKER CREATED SUCCESSFULLY');
    
    EXECUTE IMMEDIATE q'[INSERT INTO TABLE_TRACKER VALUES('CUSTOMER','CREATE TABLE CUSTOMER(
    CUST_ID NUMBER NOT NULL PRIMARY KEY, 
    CUST_USERNAME VARCHAR(50) NOT NULL, 
    CUST_PASSWORD VARCHAR(20) NOT NULL, 
    CUST_FIRST_NAME VARCHAR(50) NOT NULL, 
    CUST_LAST_NAME VARCHAR(50) NOT NULL, 
    CUST_PHONE_NO NUMBER NOT NULL, 
    WALLET_BALANCE NUMBER NOT NULL, 
    APT_NUMBER NUMBER NOT NULL, 
    ZIP_CODE NUMBER NOT NULL,
    STREET_NAME VARCHAR(50)NOT NULL)')]';

    
    EXECUTE IMMEDIATE q'[INSERT INTO TABLE_TRACKER VALUES('DELIVERY_AGENT','CREATE TABLE DELIVERY_AGENT(
    AGENT_ID NUMBER NOT NULL PRIMARY KEY,
    AGENT_USERNAME VARCHAR(50) NOT NULL,
    AGENT_PASSWORD VARCHAR(50) NOT NULL,
    AGENT_RATING DECIMAL(10,2) NOT NULL,
    AGENT_STATUS VARCHAR(30) NOT NULL)')]';
     
    EXECUTE IMMEDIATE q'[INSERT INTO TABLE_TRACKER VALUES('MANAGER','CREATE TABLE MANAGER(
    MANAGER_ID NUMBER NOT NULL PRIMARY KEY,
    MANAGER_USERNAME VARCHAR(50) NOT NULL,
    MANAGER_PASSWORD VARCHAR(50) NOT NULL)')]';
     
    EXECUTE IMMEDIATE q'[INSERT INTO TABLE_TRACKER VALUES('RESTAURANT','CREATE TABLE RESTAURANT(
    RESTAURANT_ID NUMBER NOT NULL PRIMARY KEY,
    MANAGER_ID NUMBER NOT NULL,
    RESTAURANT_CONTACT NUMBER(10) NOT NULL,
    RESTAURANT_NAME VARCHAR(50) NOT NULL,
    CONSTRAINT MANAGER_ID FOREIGN KEY (MANAGER_ID) REFERENCES MANAGER(MANAGER_ID))')]';
     
    EXECUTE IMMEDIATE q'[INSERT INTO TABLE_TRACKER VALUES('ORDERS','CREATE TABLE ORDERS(
    ORDER_ID NUMBER NOT NULL PRIMARY KEY,
    CUST_ID NUMBER NOT NULL,
    RESTAURANT_ID NUMBER NOT NULL,
    ORDER_DATE TIMESTAMP,
    ORDER_STATUS VARCHAR(50) NOT NULL,
    COUPON_NAME VARCHAR(20) NOT NULL,
    DELIVERY_CHARGE NUMBER NOT NULL,
    AMOUNT DECIMAL(10,2) NOT NULL,
    PAYMENT_METHOD VARCHAR(20) NOT NULL,
    PAYMENT_STATUS VARCHAR(20) NOT NULL,
    DELIVERY_AGENT_NAME VARCHAR(50) NOT NULL ,
    DELIVERY_SERVICE_RATING NUMBER NOT NULL,
    RESTAURANT_SERVICE_RATING NUMBER NOT NULL,
    CONSTRAINT CUST_ID FOREIGN KEY (CUST_ID) REFERENCES CUSTOMER(CUST_ID),
    CONSTRAINT RESTAURANT_ID FOREIGN KEY(RESTAURANT_ID) REFERENCES RESTAURANT(RESTAURANT_ID))')]';
    
    EXECUTE IMMEDIATE q'[INSERT INTO TABLE_TRACKER VALUES('DELIVERY','CREATE TABLE DELIVERY(
    ORDER_ID NUMBER NOT NULL,
    RESTAURANT_ID NUMBER NOT NULL,
    CUST_ID NUMBER NOT NULL,
    AGENT_ID NUMBER NOT NULL,
    DELIVERY_STATUS VARCHAR(30) NOT NULL,
    CONSTRAINT ORDER_ID_FK FOREIGN KEY(ORDER_ID) REFERENCES ORDERS(ORDER_ID),
    CONSTRAINT RESTAURANT_ID_FK FOREIGN KEY(RESTAURANT_ID) REFERENCES RESTAURANT(RESTAURANT_ID),
    CONSTRAINT CUST_ID_FK FOREIGN KEY(CUST_ID) REFERENCES CUSTOMER(CUST_ID),
    CONSTRAINT AGENT_ID_FK FOREIGN KEY(AGENT_ID) REFERENCES DELIVERY_AGENT(AGENT_ID))')]';
    
    EXECUTE IMMEDIATE q'[INSERT INTO TABLE_TRACKER VALUES('MENU','CREATE TABLE MENU(
    DISH_ID NUMBER NOT NULL PRIMARY KEY,
    RESTAURANT_ID NUMBER NOT NULL,
    DISH_NAME VARCHAR(30) NOT NULL,
    DISH_STATUS VARCHAR(30) NOT NULL,
    DISH_RATING DECIMAL(10,2) NOT NULL,
    PRICE DECIMAL (10,2) NOT NULL,
    DISH_CATEGORY VARCHAR(30) NOT NULL,
    CONSTRAINT RESTAURANT_IDFK FOREIGN KEY(RESTAURANT_ID) REFERENCES RESTAURANT(RESTAURANT_ID))')]';
     
    EXECUTE IMMEDIATE q'[INSERT INTO TABLE_TRACKER VALUES('COUPON','CREATE TABLE COUPON(
    COUPON_ID NUMBER NOT NULL PRIMARY KEY,
    COUPON_NAME VARCHAR(30) NOT NULL,
    LOWER_RANGE NUMBER NOT NULL,
    UPPER_RANGE NUMBER NOT NULL,
    ACTIVITY_STATUS VARCHAR(30) NOT NULL,
    DISCOUNT DECIMAL(10,2) NOT NULL)')]';
     
    EXECUTE IMMEDIATE q'[INSERT INTO TABLE_TRACKER VALUES ('CART','CREATE TABLE CART(
    LINE_ID NUMBER NOT NULL PRIMARY KEY,
    ORDER_ID NUMBER NOT NULL,
    CUST_ID NUMBER NOT NULL,
    RESTAURANT_ID NUMBER NOT NULL,
    DISH_ID NUMBER NOT NULL,
    DISH_RATING NUMBER,
    UNIT_PRICE DECIMAL(10,2) NOT NULL,
    QUANTITY NUMBER NOT NULL,
    CONSTRAINT ORDERID_FK FOREIGN KEY(ORDER_ID) REFERENCES ORDERS(ORDER_ID),
    CONSTRAINT CUSTID_FK FOREIGN KEY(CUST_ID) REFERENCES CUSTOMER(CUST_ID),
    CONSTRAINT RESTAURANTID_FK FOREIGN KEY(RESTAURANT_ID) REFERENCES RESTAURANT(RESTAURANT_ID),
    CONSTRAINT DISHID_FK FOREIGN KEY(DISH_ID) REFERENCES MENU(DISH_ID))')]';
    END IF;

    IF sequence_count>0 THEN
        DBMS_OUTPUT.PUT_LINE('TABLE SEQUENCE_TRACKER ALREADY EXISTS!');
    ELSE
    EXECUTE IMMEDIATE 'CREATE TABLE SEQUENCE_TRACKER
    (
       SEQUENCE_NAME varchar2(100), 
       SEQUENCE_QUERY varchar2(5000) NOT NULL, 
       CONSTRAINT SEQUENCE_TABLE_PK PRIMARY KEY(SEQUENCE_NAME)
    )
    ';    
    
    DBMS_OUTPUT.PUT_LINE('TABLE SEQUENCE_TRACKER CREATED SUCCESSFULLY');
    
    EXECUTE IMMEDIATE q'[INSERT INTO SEQUENCE_TRACKER VALUES('DELIVERY_AGENT_SEQ','CREATE SEQUENCE  DELIVERY_AGENT_SEQ  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ')]';
    
    EXECUTE IMMEDIATE q'[INSERT INTO SEQUENCE_TRACKER VALUES('MANAGER_SEQ','CREATE SEQUENCE  MANAGER_SEQ  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ')]';
    
    EXECUTE IMMEDIATE q'[INSERT INTO SEQUENCE_TRACKER VALUES('RESTAURANT_SEQ','CREATE SEQUENCE  RESTAURANT_SEQ  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ')]';
    
    EXECUTE IMMEDIATE q'[INSERT INTO SEQUENCE_TRACKER VALUES('CUSTOMER_SEQ','CREATE SEQUENCE  CUSTOMER_SEQ  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ')]';
    
    EXECUTE IMMEDIATE q'[INSERT INTO SEQUENCE_TRACKER VALUES('ORDERS_SEQ','CREATE SEQUENCE  ORDERS_SEQ  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ')]';
    
    EXECUTE IMMEDIATE q'[INSERT INTO SEQUENCE_TRACKER VALUES('MENU_SEQ','CREATE SEQUENCE  MENU_SEQ  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ')]';
    
    EXECUTE IMMEDIATE q'[INSERT INTO SEQUENCE_TRACKER VALUES('CART_SEQ','CREATE SEQUENCE  CART_SEQ  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ')]';
    
    EXECUTE IMMEDIATE q'[INSERT INTO SEQUENCE_TRACKER VALUES('COUPON_SEQ','CREATE SEQUENCE  COUPON_SEQ  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ')]';
    
    END IF;
    
    IF trigger_count>0 THEN
        DBMS_OUTPUT.PUT_LINE('TABLE TRIGGER_TRACKER ALREADY EXISTS!');
    ELSE
    EXECUTE IMMEDIATE 'CREATE TABLE TRIGGER_TRACKER
    (
       TRIGGER_NAME varchar2(100), 
       TRIGGER_QUERY varchar2(5000) NOT NULL, 
       CONSTRAINT TRIGGER_TABLE_PK PRIMARY KEY(TRIGGER_NAME)
    )
    ';    
    
    DBMS_OUTPUT.PUT_LINE('TABLE TRIGGER_TRACKER CREATED SUCCESSFULLY');
    
    EXECUTE IMMEDIATE q'[INSERT INTO TRIGGER_TRACKER VALUES('DELIVERY_AGENT_TRG','create or replace TRIGGER DELIVERY_AGENT_TRG 
    BEFORE INSERT ON DELIVERY_AGENT 
    FOR EACH ROW 
    BEGIN
    <<COLUMN_SEQUENCES>>
    BEGIN
        IF INSERTING AND :NEW.AGENT_ID IS NULL THEN
            SELECT DELIVERY_AGENT_SEQ.NEXTVAL INTO :NEW.AGENT_ID FROM SYS.DUAL;
        END IF;
    END COLUMN_SEQUENCES;
    END;')]';
    
    EXECUTE IMMEDIATE q'[INSERT INTO TRIGGER_TRACKER VALUES('MANAGER_TRG','create or replace TRIGGER MANAGER_TRG 
    BEFORE INSERT ON MANAGER 
    FOR EACH ROW 
    BEGIN
    <<COLUMN_SEQUENCES>>
    BEGIN
        IF INSERTING AND :NEW.MANAGER_ID IS NULL THEN
            SELECT MANAGER_SEQ.NEXTVAL INTO :NEW.MANAGER_ID FROM SYS.DUAL;
        END IF;
    END COLUMN_SEQUENCES;
    END;')]';
    
    EXECUTE IMMEDIATE q'[INSERT INTO TRIGGER_TRACKER VALUES('RESTAURANT_TRG','create or replace TRIGGER RESTAURANT_TRG 
    BEFORE INSERT ON RESTAURANT 
    FOR EACH ROW 
    BEGIN
    <<COLUMN_SEQUENCES>>
    BEGIN
    IF INSERTING AND :NEW.RESTAURANT_ID IS NULL THEN
      SELECT RESTAURANT_SEQ.NEXTVAL INTO :NEW.RESTAURANT_ID FROM SYS.DUAL;
    END IF;
    END COLUMN_SEQUENCES;
    END;')]';
    
    EXECUTE IMMEDIATE q'[INSERT INTO TRIGGER_TRACKER VALUES('CUSTOMER_TRG','create or replace TRIGGER CUSTOMER_TRG 
    BEFORE INSERT ON CUSTOMER 
    FOR EACH ROW 
    BEGIN
    <<COLUMN_SEQUENCES>>
    BEGIN
    IF INSERTING AND :NEW.CUST_ID IS NULL THEN
        SELECT CUSTOMER_SEQ.NEXTVAL INTO :NEW.CUST_ID FROM SYS.DUAL;
    END IF;
    END COLUMN_SEQUENCES;
    END;')]';
    
    EXECUTE IMMEDIATE q'[INSERT INTO TRIGGER_TRACKER VALUES('ORDERS_TRG','create or replace TRIGGER ORDERS_TRG 
    BEFORE INSERT ON ORDERS 
    FOR EACH ROW 
    BEGIN
    <<COLUMN_SEQUENCES>>
    BEGIN
    IF INSERTING AND :NEW.ORDER_ID IS NULL THEN
        SELECT ORDERS_SEQ.NEXTVAL INTO :NEW.ORDER_ID FROM SYS.DUAL;
    END IF;
    END COLUMN_SEQUENCES;
    END;')]';
    
    EXECUTE IMMEDIATE q'[INSERT INTO TRIGGER_TRACKER VALUES('MENU_TRG','create or replace TRIGGER MENU_TRG 
    BEFORE INSERT ON MENU 
    FOR EACH ROW 
    BEGIN
    <<COLUMN_SEQUENCES>>
    BEGIN
    IF INSERTING AND :NEW.DISH_ID IS NULL THEN
        SELECT MENU_SEQ.NEXTVAL INTO :NEW.DISH_ID FROM SYS.DUAL;
    END IF;
    END COLUMN_SEQUENCES;
    END;')]';
    
    EXECUTE IMMEDIATE q'[INSERT INTO TRIGGER_TRACKER VALUES('CART_TRG','create or replace TRIGGER CART_TRG 
    BEFORE INSERT ON CART 
    FOR EACH ROW 
    BEGIN
    <<COLUMN_SEQUENCES>>
    BEGIN
    IF INSERTING AND :NEW.LINE_ID IS NULL THEN
        SELECT CART_SEQ.NEXTVAL INTO :NEW.LINE_ID FROM SYS.DUAL;
    END IF;
    END COLUMN_SEQUENCES;
    END;')]';
    
    EXECUTE IMMEDIATE q'[INSERT INTO TRIGGER_TRACKER VALUES('COUPON_TRG','create or replace TRIGGER COUPON_TRG 
    BEFORE INSERT ON COUPON 
    FOR EACH ROW 
    BEGIN
    <<COLUMN_SEQUENCES>>
    BEGIN
    IF INSERTING AND :NEW.COUPON_ID IS NULL THEN
      SELECT COUPON_SEQ.NEXTVAL INTO :NEW.COUPON_ID FROM SYS.DUAL;
    END IF;
    END COLUMN_SEQUENCES;
    END;')]';
    
    END IF;
END;
/

DECLARE
tableName varchar2(100);
tableQuery varchar2(5000);
check_name number;
CURSOR create_table_cursor IS select TABLE_NAME, TABLE_QUERY from TABLE_TRACKER;
BEGIN
    OPEN create_table_cursor;
    LOOP
        FETCH create_table_cursor into tableName, tableQuery;
        EXIT WHEN create_table_cursor%NOTFOUND;
            select count(*) into check_name from user_tables where TABLE_NAME=tableName;
    
            IF check_name>0 THEN
                dbms_output.put_line(tableName||' Table exists');
            ELSE
                dbms_output.put_line(tableName||' Table does not exist');
                EXECUTE IMMEDIATE tableQuery;
                dbms_output.put_line(tableName||' Table created successfully');
            END IF;
        END LOOP;
    CLOSE create_table_cursor;
END;

/

DECLARE
sequenceName varchar2(100);
sequenceQuery varchar2(5000);
check_name number;
CURSOR create_sequence_cursor IS select SEQUENCE_NAME, SEQUENCE_QUERY from SEQUENCE_TRACKER;
BEGIN
    OPEN create_sequence_cursor;
    LOOP
        FETCH create_sequence_cursor into sequenceName, sequenceQuery;
        EXIT WHEN create_sequence_cursor%NOTFOUND;
            select count(*) into check_name from user_sequences where SEQUENCE_NAME=sequenceName;
    
            IF check_name>0 THEN
                dbms_output.put_line(sequenceName||' Sequence exists');
            ELSE
                dbms_output.put_line(sequenceName||' Sequence does not exist');
                EXECUTE IMMEDIATE sequenceQuery;
                dbms_output.put_line(sequenceName||' Sequence created successfully');
            END IF;
        END LOOP;
    CLOSE create_sequence_cursor;
END;

/

DECLARE
triggerName varchar2(100);
triggerQuery varchar2(5000);
check_name number;
CURSOR create_trigger_cursor IS select TRIGGER_NAME, TRIGGER_QUERY from TRIGGER_TRACKER;
BEGIN
    OPEN create_trigger_cursor;
    LOOP
        FETCH create_trigger_cursor into triggerName, triggerQuery;
        EXIT WHEN create_trigger_cursor%NOTFOUND;
            select count(*) into check_name from user_triggers where TRIGGER_NAME=triggerName;
    
            IF check_name>0 THEN
                dbms_output.put_line(triggerName||' Trigger exists');
            ELSE
                dbms_output.put_line(triggerName||' Trigger does not exist');
                EXECUTE IMMEDIATE triggerQuery;
                dbms_output.put_line(triggerName||' Trigger created successfully');
            END IF;
        END LOOP;
    CLOSE create_trigger_cursor;
END;


/


------------------------------------
--STORED PROCEDURES TO INSERT DATA
------------------------------------

--store procedure to insert data into DELIVERY_AGENT table
create or replace procedure insert_deliveryagent_data(
agentUsername in delivery_agent.agent_username%type,
agentPassword in delivery_agent.agent_password%type,
agentRating in delivery_agent.agent_rating%type,
agentStatus in delivery_agent.agent_status%type
)
IS
BEGIN
dbms_output.put_line('entered procedure');
MERGE INTO DELIVERY_AGENT D
USING (select agentUsername as agent_username, agentPassword as agent_password , agentRating as agent_rating,agentStatus as agent_status from dual) s
ON (D.agent_username = s.agent_username)
WHEN MATCHED THEN
UPDATE SET
D.agent_password = s.agent_password,
D.agent_rating = s.agent_rating,
D.agent_status = s. agent_status
WHEN NOT MATCHED THEN
INSERT(D.agent_username,D.agent_password,D.agent_rating,D.agent_status) VALUES(s.agent_username, s.agent_password, s.agent_rating ,s.agent_status);
END insert_deliveryagent_data;

/

--stored procedure to insert data in MANAGER table
create or replace procedure insert_manager_data(
managerId in Manager.manager_id%type,
managerUsername in Manager.manager_username%type,
managerPassword in Manager.manager_password%type)
AS
BEGIN
MERGE INTO Manager m
USING (select managerId as manager_id, managerUsername as manager_username, managerPassword as manager_password from dual) s
ON (m.manager_id = s.manager_id)
WHEN MATCHED THEN
UPDATE SET
m.manager_username = s.manager_username,
m.manager_password = s.manager_password
WHEN NOT MATCHED THEN
INSERT(m.manager_username, m.manager_password) VALUES(s.manager_username, s.manager_password);
END insert_manager_data;

/

--stored procedure to insert data in RESTAURANT table
create or replace procedure insert_restaurant_data(
restaurantId in RESTAURANT.restaurant_id%type,
managerId in RESTAURANT.manager_id%type,
restaurantContact in RESTAURANT.restaurant_contact%type,
restaurantName in RESTAURANT.restaurant_name%type)
AS
BEGIN
MERGE INTO RESTAURANT r
USING (select restaurantId as restaurant_id, managerId as manager_id, restaurantContact as restaurant_contact, restaurantName as restaurant_name
from dual) s
ON (r.restaurant_id = s.restaurant_id)
WHEN MATCHED THEN
UPDATE SET
r.manager_id = s.manager_id,
r.restaurant_contact = s.restaurant_contact,
r.restaurant_name = s.restaurant_name
WHEN NOT MATCHED THEN
INSERT(r.manager_id, r.restaurant_contact, r.restaurant_name) 
VALUES(s.manager_id, s.restaurant_contact, s.restaurant_name);
END insert_restaurant_data;

/

--stored procedure to insert data into CUSTOMER table
create or replace procedure insert_customer_data(
custId in CUSTOMER.cust_id%type,
custUsername in CUSTOMER.cust_username%type,
custPassword in CUSTOMER.cust_password%type,
custFirstName in CUSTOMER.cust_first_name%type,
custLastName in CUSTOMER.cust_last_name%type,
custPhone in CUSTOMER.cust_phone_no%type,
custWalletBalance in CUSTOMER.wallet_balance%type,
custAptNumber in CUSTOMER.apt_number%type,
custZipCode in CUSTOMER.zip_code%type,
custStreet in CUSTOMER.street_name%type)
AS
BEGIN
MERGE INTO CUSTOMER c
USING (select custId as cust_id, custUsername as cust_username, custPassword as cust_password, custFirstName as cust_first_name,
custLastName as cust_last_name, custPhone as cust_phone_no, custWalletBalance as wallet_balance, custAptNumber as apt_number, 
custZipCode as zip_code, custStreet as street_name from dual) s
ON (c.cust_id = s.cust_id)
WHEN MATCHED THEN
UPDATE SET
c.cust_username = s.cust_username,
c.cust_password = s.cust_password,
c.cust_first_name = s.cust_first_name,
c.cust_last_name = s.cust_last_name,
c.cust_phone_no = s.cust_phone_no,
c.wallet_balance= s.wallet_balance,
c.apt_number= s.apt_number,
c.zip_code = s.zip_code,
c.street_name = s.street_name
WHEN NOT MATCHED THEN
INSERT(c.cust_username, c.cust_password, c.cust_first_name, c.cust_last_name, c.cust_phone_no, c.wallet_balance, c.apt_number, c.zip_code, c.street_name) 
VALUES(s.cust_username, s.cust_password, s.cust_first_name, s.cust_last_name, s.cust_phone_no, s.wallet_balance, s.apt_number, s.zip_code, s.street_name);
END insert_customer_data;

/

--stored procedure to insert data in ORDERS table
create or replace procedure insert_orders_data(
orderId in ORDERS.order_id%type,
custId in ORDERS.cust_id%type,
restaurantId in ORDERS.restaurant_id%type,
orderDate in ORDERS.order_date%type,
orderStatus in ORDERS.order_status%type,
couponName in ORDERS.coupon_name%type,
deliveryCharge in ORDERS.delivery_charge%type,
orderAmount in ORDERS.amount%type,
paymentMethod in ORDERS.payment_method%type,
paymentStatus in ORDERS.payment_status%type,
deliveryAgentName in ORDERS.delivery_agent_name%type,
deliveryServiceRating in ORDERS.delivery_service_rating%type,
restaurantServiceRating in ORDERS.restaurant_service_rating%type)
AS
BEGIN
MERGE INTO ORDERS o
USING (select orderId as order_id, custId as cust_id, restaurantId as restaurant_id, orderDate as order_date, orderStatus as order_status,
couponName as coupon_name, deliveryCharge as delivery_charge, orderAmount as amount, paymentMethod as payment_method, paymentStatus as payment_status,
deliveryAgentName as delivery_agent_name, deliveryServiceRating as delivery_service_rating, restaurantServiceRating as restaurant_service_rating from dual) s
ON (o.order_id = s.order_id)
WHEN MATCHED THEN
UPDATE SET
o.cust_id = s.cust_id,
o.restaurant_id = s.restaurant_id,
o.order_date = s.order_date,
o.order_status = s.order_status,
o.coupon_name = s.coupon_name,
o.delivery_charge = s.delivery_charge,
o.amount = s.amount,
o.payment_method = s.payment_method,
o.payment_status = s.payment_status,
o.delivery_agent_name = s.delivery_agent_name,
o.delivery_service_rating = s.delivery_service_rating,
o.restaurant_service_rating = s.restaurant_service_rating
WHEN NOT MATCHED THEN
INSERT(o.cust_id, o.restaurant_id, o.order_date, o.order_status, o.coupon_name, o.delivery_charge, o.amount, o.payment_method, o.payment_status, o.delivery_agent_name, o.delivery_service_rating, o.restaurant_service_rating) 
VALUES(s.cust_id, s.restaurant_id, s.order_date, s.order_status, s.coupon_name, s.delivery_charge, s.amount, s.payment_method, s.payment_status, s.delivery_agent_name, s.delivery_service_rating, s.restaurant_service_rating);
END insert_orders_data;

/

--store procedure to insert data into MENU table
create or replace procedure insert_menu_data(
restaurantID in menu.restaurant_id%type,
dishName in menu.dish_name%type,
dishStatus in menu.dish_status%type,
dishRating in menu.dish_rating%type,
dishPrice in menu.price%type,
dishCategory in menu.dish_category%type
)
IS
BEGIN
dbms_output.put_line('entered procedure');
MERGE INTO MENU D
USING (select restaurantID as restaurant_id, dishName as dish_name , dishStatus as dish_status,dishRating as dish_rating , dishPrice as price , dishCategory as dish_category from dual) s
ON (D.dish_name = s.dish_name)
WHEN MATCHED THEN
UPDATE SET
D.restaurant_id = s.restaurant_id,
D.dish_status = s.dish_status,
D.dish_rating = s.dish_rating,
D.price = s.price,
D.dish_category=s.dish_category
WHEN NOT MATCHED THEN
INSERT(D.restaurant_id,D.dish_name,D.dish_status,D.dish_rating ,D.price, D.dish_category) VALUES(s.restaurant_id,s.dish_name,s.dish_status,s.dish_rating ,s.price, s.dish_category);
END insert_menu_data;

/

--store procedure to insert data into CART table
create or replace procedure insert_cart_data(
orderID in cart.order_id%type,
custID in cart.cust_id%type,
restaurant_ID in cart.restaurant_id%type,
dish_ID in cart.dish_id%type,
dish_Rating in cart.dish_rating%type,
unit_Price in cart.unit_price%type,
quantityValue in cart.quantity%type
)
IS
BEGIN
dbms_output.put_line('entered proc');
MERGE INTO CART C
USING (select orderID as order_id, custID as cust_id , restaurant_ID as restaurant_id,dish_ID as dish_id, dish_Rating as dish_rating , unit_Price as unit_price ,quantityValue as quantity from dual) s
ON (C.order_id = s.order_id and C.dish_id = s.dish_id)
WHEN MATCHED THEN
UPDATE SET
C.cust_id = s.cust_id,
C.restaurant_id = s.restaurant_id,
C.dish_rating = s.dish_rating,
C.unit_price = s.unit_price,
C.quantity = s.quantity
WHEN NOT MATCHED THEN
INSERT(C.order_id,C.cust_id,C.restaurant_id,C.dish_id,C.dish_rating,C.unit_price,C.quantity) VALUES( s.order_id, s.cust_id, s.restaurant_id , s.dish_id,s.dish_rating,s.unit_price,s.quantity);
END insert_cart_data;

/

--store procedure to insert data into DELIVERY table
create or replace procedure insert_delivery_data(
orderID in delivery.order_id%type,
restaurantID in delivery.restaurant_id%type,
custID in delivery.cust_id%type,
agentID in delivery.agent_id%type,
deliveryStatus in delivery.delivery_status%type
)
IS
BEGIN
dbms_output.put_line('entered procedure');
MERGE INTO DELIVERY D
USING (select orderID as order_id, restaurantID as restaurant_id, custID as cust_id , agentID as agent_id,deliveryStatus as delivery_status from dual) s
ON (D.order_id = s.order_id)
WHEN MATCHED THEN
UPDATE SET
D.restaurant_id = s.restaurant_id,
D.cust_id = s.cust_id,
D.agent_id = s.agent_id,
D.delivery_status = s.delivery_status
WHEN NOT MATCHED THEN
INSERT(D.order_id, D.restaurant_id,D.cust_id,D.agent_id,D.delivery_status) VALUES(s.order_id, s.restaurant_id, s.cust_id, s.agent_id ,s.delivery_status);
END insert_delivery_data;

/

--store procedure to insert data into COUPON table
create or replace procedure insert_coupon_data(
couponName in Coupon.coupon_name%type,
lowerRange in Coupon.lower_range%type,
upperRange in Coupon.upper_range%type,
activityStatus in Coupon.activity_status%type,
discountValue in coupon.discount%type
)
IS
BEGIN
dbms_output.put_line('entered proc');
MERGE INTO COUPON C
USING (select couponName as coupon_name, lowerRange as lower_range , upperRange as upper_range,activityStatus as activity_status, discountValue as discount from dual) s
ON (C.coupon_name = s.coupon_name)
WHEN MATCHED THEN
UPDATE SET
C.lower_range = s.lower_range,
C.upper_range = s.upper_range,
C.activity_status = s. activity_status,
C.discount = s.discount
WHEN NOT MATCHED THEN
INSERT(C.coupon_name,C.lower_range,C.upper_range,C.activity_status,C.discount) VALUES( s.coupon_name, s.lower_range, s.upper_range , s.activity_status,s.discount);
END insert_coupon_data;

/

----------------------------
--REPORTS & VIEWS
----------------------------

CREATE OR REPLACE VIEW vw_dish_sales AS
SELECT m.restaurant_id,
(select restaurant_name from restaurant where restaurant_id=m.restaurant_id) as RESTAURANT_NAME,
m.dish_id,m.dish_name  as DISH_NAME,m.dish_category, COALESCE(SUM(c.Quantity),0) AS Sales_Qty,(COALESCE(SUM(c.Unit_Price * c.Quantity),0)||' $') AS Sales_amount
FROM orders o
JOIN cart c
ON o.order_id = c.order_id and o.order_status IN ('Delivered')
RIGHT JOIN menu m
ON m.restaurant_id=o.restaurant_id AND c.dish_id = m.dish_id
GROUP BY m.dish_id, m.restaurant_id, m.dish_name,m.dish_category
order by m.restaurant_id,m.dish_id;

/

CREATE OR REPLACE VIEW vw_top_10_dishes AS
SELECT * FROM(
SELECT restaurant_id,restaurant_name,dish_id,dish_name,dish_category,sales_qty,(sales_amount || ' $') AS sales_amount, dense_rank() over(partition by restaurant_id order by sales_amount desc) as dish_rank 
FROM(SELECT m.restaurant_id,
(SELECT restaurant_name from restaurant where restaurant_id=m.restaurant_id) as RESTAURANT_NAME,
m.dish_id,
m.dish_name  as DISH_NAME,
m.dish_category, 
COALESCE(SUM(c.Quantity),0) AS Sales_Qty,
(COALESCE(SUM(c.Unit_Price * c.Quantity),0)) AS Sales_amount
FROM orders o
JOIN cart c
ON o.order_id = c.order_id and o.order_status IN ('Delivered')
RIGHT JOIN menu m
ON m.restaurant_id=o.restaurant_id AND c.dish_id = m.dish_id
GROUP BY m.dish_id, m.restaurant_id, m.dish_name,m.dish_category))
WHERE dish_rank<11 AND sales_qty<>0;

/

CREATE OR REPLACE VIEW vw_top_10_customers AS
SELECT * FROM(
SELECT c.cust_id, DENSE_RANK() OVER(ORDER BY COUNT(o.order_id) DESC) AS Cust_Rank,c.cust_first_name, c.cust_last_name, COUNT(o.order_id) AS number_of_orders, (sum(amount)||' $') as sales_amount
FROM customer c
JOIN orders o
ON c.cust_id = o.cust_id and o.order_status='Delivered'
GROUP BY c.cust_id, c.cust_first_name, c.cust_last_name);

/

CREATE OR REPLACE VIEW vw_monthly_sales AS
SELECT restaurant_id,
(select restaurant_name from restaurant where restaurant_id=orders.restaurant_id) Restuarant_Name,
TO_CHAR(ORDER_DATE,'MM-YY') AS Month, 
(SUM(amount)||' $') AS Sales,
count(restaurant_id) as total_orders 
FROM orders 
where order_status='Delivered'
GROUP BY TO_CHAR(ORDER_DATE,'MM-YY'), restaurant_id
order by TO_CHAR(ORDER_DATE,'MM-YY');

/

CREATE OR REPLACE VIEW vw_top_delivery_person AS
SELECT agent_id, agent_name, average_rating, total_orders_delivered, AGENT_RANK FROM(
SELECT d.agent_id, (select agent_username from delivery_agent where agent_id=d.agent_id) as Agent_Name,
ROUND(AVG(o.delivery_service_rating),2) AS Average_Rating,
(select count(delivery_agent_name) from orders where delivery_agent_name=(select agent_username from delivery_agent where agent_id=d.agent_id))Total_orders_delivered,
DENSE_RANK() over(order by ROUND(AVG(o.delivery_service_rating),2) DESC) as AGENT_RANK
FROM delivery d
JOIN orders o
ON d.order_id = o.order_id and o.order_status='Delivered'
GROUP BY d.agent_id)
WHERE AGENT_RANK=1
ORDER BY total_orders_delivered desc;

/

CREATE OR REPLACE VIEW vw_delivery_agent_ratings AS
select agent_id, agent_username, agent_rating,
(select count(agent_id) from delivery where agent_id=delivery_agent.agent_id and delivery_status='Delivered') as delivery_count
from delivery_agent;

/

CREATE OR REPLACE VIEW vw_restaurant_service_ratings AS
SELECT r.restaurant_id, r.RESTAURANT_NAME, ROUND(AVG(o.RESTAURANT_SERVICE_RATING),2) AS Average_service_rating
FROM orders o
JOIN RESTAURANT r
ON r.restaurant_id = o.restaurant_id and o.order_status='Delivered'
GROUP BY r.RESTAURANT_ID, r.restaurant_name;

/

CREATE OR REPLACE VIEW vw_menu AS
SELECT * FROM MENU;

/

CREATE OR REPLACE VIEW vw_coupons AS
SELECT coupon_name, lower_range, upper_range, discount
From coupon
Where activity_status = 'ACTIVE';

/

CREATE OR REPLACE VIEW vw_restaurants AS
SELECT *
FROM restaurant;

/

CREATE OR REPLACE VIEW vw_cancelled_orders AS
SELECT cust_id, order_id, amount, to_char(order_date, 'DD-MON-YY') as order_date, payment_method, payment_status, order_status
FROM orders
WHERE order_status = 'Cancelled';

/

CREATE OR REPLACE VIEW vw_all_orders AS
SELECT order_id,cust_id,  restaurant_id, amount, payment_method, payment_status, order_date, order_status, delivery_agent_name
FROM orders
WHERE order_status NOT IN ('N/A');

/

CREATE OR REPLACE VIEW vw_customer_order_address AS
SELECT CUST_ID, CUST_FIRST_NAME, CUST_LAST_NAME, 
(STREET_NAME || ', '|| ZIP_CODE || ', ' || APT_NUMBER) AS ADDRESS
FROM CUSTOMER;

/

CREATE OR REPLACE VIEW vw_delivery_agent_status AS
SELECT agent_id, agent_username, agent_status
FROM delivery_agent;

/

CREATE OR REPLACE VIEW vw_completed_orders AS
SELECT *
FROM orders
WHERE order_status = 'Delivered';

/

CREATE OR REPLACE VIEW vw_active_orders AS
SELECT *
FROM orders
WHERE order_status IN ('Placed Successfully','Confirmed','Preparing','Out for delivery','Delay In Delivery');

/

create or replace FUNCTION numberCheck (v IN VARCHAR2) 
RETURN NUMBER 
IS 
num1 NUMBER; 
BEGIN 
    num1 := TO_NUMBER(v); 
        RETURN 0; 
EXCEPTION 
WHEN VALUE_ERROR THEN 
    RETURN 1; 
END numberCheck; 

/

create or replace procedure welcome_customer_page
as
begin
dbms_output.put_line('-------------------------------------------------------------------------------------');
dbms_output.put_line('                           WELCOME TO FOOD ORDERING SYSTEM!                          ');
dbms_output.put_line('-------------------------------------------------------------------------------------');
dbms_output.put_line('WE HAVE 2 RESTAURANTS IN OUR SYSTEM AS OF NOW. RESTAURANTS ARE AS GIVEN BELOW : ');
dbms_output.put_line('-------------------------------------');
dbms_output.put_line(rpad('RESTAURANT ID',13)||' | '|| rpad('RESTAURANT NAME', 20));
dbms_output.put_line('-------------------------------------');
dbms_output.put_line(rpad('       1',13) ||' | '|| rpad('INDIAN SPICE',20) || '|');
dbms_output.put_line(rpad('       2',13) ||' | '|| rpad('TASTY BITES',20) || '|');
dbms_output.put_line('-------------------------------------');
dbms_output.put_line('*********************************FOR CUSTOMERS*****************************************');
dbms_output.put_line('* ALL NEW CUSTOMERS HAVE TO REGISTER USING BELOW REGISTER_CUSTOMER PROCEDURE :');
dbms_output.put_line('  NOTE: ');
dbms_output.put_line('  -> CUSTOMER_USERNAME SHOULD NOT BE GREATER THAN 15');
dbms_output.put_line('  -> CUSTOMER_PASSWORD SHOULD BE 8 CHARACTER LONG');
dbms_output.put_line('  -> CUSTOMER_USERNAME CANNOT BE CHANGED LATER!');
dbms_output.put_line('-------------------------------------------------------------------------------------');
dbms_output.put_line('* AFTER REGISTERING, LOGIN USING LOGIN_CUSTOMER PROCEDURE');
dbms_output.put_line('-------------------------------------------------------------------------------------');
dbms_output.put_line('* CHECK RESTAURANTS USING SELECT * FROM VW_RESTAURANTS');
dbms_output.put_line('-------------------------------------------------------------------------------------');
dbms_output.put_line('* CHECK RESTAURANT SERVICE RATINGS USING SELECT * FROM VW_RESTAURANT_SERVICE_RATINGS');
dbms_output.put_line('-------------------------------------------------------------------------------------');
dbms_output.put_line('* YOU CAN CREATE A NEW ORDER USING CREATE_ORDER PROCEDURE');
dbms_output.put_line('-------------------------------------------------------------------------------------');
dbms_output.put_line('* YOU CAN GET MENU FOR YOUR CHOICE OF RESTAURANT USING GET_MENU PROCEDURE');
dbms_output.put_line('-------------------------------------------------------------------------------------');
dbms_output.put_line('* YOU CAN GET YOUR CART USING GET_MYCART PROCEDURE');
dbms_output.put_line('-------------------------------------------------------------------------------------');
dbms_output.put_line('* ADD ITEMS TO YOUR CART USING ADD_TO_CART PROCEDURE');
dbms_output.put_line('-------------------------------------------------------------------------------------');
dbms_output.put_line('* REMOVE ITEMS FROM YOUR CART USING REMOVE_ITEM_FROM_CART PROCEDURE');
dbms_output.put_line('-------------------------------------------------------------------------------------');
dbms_output.put_line('* CLEAR YOUR CART USING CLEAR_CART PROCEDURE');
dbms_output.put_line('-------------------------------------------------------------------------------------');
dbms_output.put_line('* GET YOUR ORDER ESTIMATED BILL USING GET_BILL PROCEDURE');
dbms_output.put_line('-------------------------------------------------------------------------------------');
dbms_output.put_line('* YOU CAN VIEW COUPONS USING SELECT *  FROM VW_COUPONS ');
dbms_output.put_line('-------------------------------------------------------------------------------------');
dbms_output.put_line('* YOU CAN VIEW DELIVERY AGENT RATINGS USING SELECT *  FROM VW_DELIVERY_AGENT_RATINGS');
dbms_output.put_line('-------------------------------------------------------------------------------------');
dbms_output.put_line('* YOU CAN APPLY COUPONS USING APPLY_COUPONS PROCEDURE');
dbms_output.put_line('-------------------------------------------------------------------------------------');
dbms_output.put_line('* YOU CAN REMOVE COUPONS USING REMOVE_COUPONS PROCEDURE');
dbms_output.put_line('-------------------------------------------------------------------------------------');
dbms_output.put_line('* YOU CAN CHECK YOUR ORDER STATUS USING CHECK_ORDER_STATUS PROCEDURE');
dbms_output.put_line('-------------------------------------------------------------------------------------');
dbms_output.put_line('* YOU CAN MAKE PAYMENT USING MAKE_PAYMENT PROCEDURE');
dbms_output.put_line('-------------------------------------------------------------------------------------');
dbms_output.put_line('* TO GIVE FEEDBACK CHECK THE FEEDBACK_PAGE PROCEDURE');
dbms_output.put_line('-------------------------------------------------------------------------------------');
dbms_output.put_line('* GIVE DELIVERY SERVICE FEEDBACK USING DELIVERY_SERVICE_FEEDBACK PROCEDURE');
dbms_output.put_line('-------------------------------------------------------------------------------------');
dbms_output.put_line('* GIVE RESTAURANT SERVICE FEEDBACK USING  RESTAURANT_SERVICE_FEEDBACK PROCEDURE');
dbms_output.put_line('-------------------------------------------------------------------------------------');
dbms_output.put_line('* GIVE DISH FEEDBACK USING GIVE_DISH_RATING PROCEDURE');
dbms_output.put_line('-------------------------------------------------------------------------------------');
dbms_output.put_line('* UPDATE CUSTOMER DETAILS USING UPDATE_CUSTOMER PROCEDURE');
dbms_output.put_line('-------------------------------------------------------------------------------------');
dbms_output.put_line('* CANCEL ORDER USING CANCEL_ORDER PROCEDURE');
dbms_output.put_line('-------------------------------------------------------------------------------------');

end;

/

create or replace procedure welcome_manager_page
as
begin
dbms_output.put_line('-------------------------------------------------------------------------------------');
dbms_output.put_line('                          WELCOME TO FOOD ORDERING SYSTEM! ');
dbms_output.put_line('-------------------------------------------------------------------------------------');
dbms_output.put_line('WE HAVE 2 RESTAURANTS IN OUR SYSTEM AS OF NOW. RESTAURANTS ARE AS GIVEN BELOW : ');
dbms_output.put_line('-------------------------------------');
dbms_output.put_line(rpad('RESTAURANT ID',13)||' | '|| rpad('RESTAURANT NAME', 20));
dbms_output.put_line('-------------------------------------');
dbms_output.put_line(rpad(' 1',13) ||' | '|| rpad('INDIAN SPICE',20) || '|');
dbms_output.put_line(rpad(' 2',13) ||' | '|| rpad('TASTY BITES',20) || '|');
dbms_output.put_line('-------------------------------------');
dbms_output.put_line('*********************************FOR MANAGERS*****************************************');
dbms_output.put_line('-------------------------------------------------------------------------------------');
dbms_output.put_line('* MANAGER CAN LOGIN USING LOGIN_MANAGER PROCEDURE');
dbms_output.put_line('-------------------------------------------------------------------------------------');
dbms_output.put_line('* MANAGER CAN CHANGE ORDER STATUS USING CHANGE_ORDER_STATUS PROCEDURE');
dbms_output.put_line('-------------------------------------------------------------------------------------');
dbms_output.put_line('* MANAGER CAN ASSIGN DELIVERY GUY USING ASSIGN_DELIVERY_GUY PROCEDURE');
dbms_output.put_line('-------------------------------------------------------------------------------------');
dbms_output.put_line('* MANAGER CAN UPDATE MENU USING UPDATE_MENU PROCEDURE');
dbms_output.put_line('-------------------------------------------------------------------------------------');
dbms_output.put_line('* MANAGER CAN UPDATE MENU USING UPDATE_COUPON PROCEDURE');
dbms_output.put_line('-------------------------------------------------------------------------------------');
dbms_output.put_line('* MANAGER CAN UPDATE DETAILS USING UPDATE_MANAGER PROCEDURE');
dbms_output.put_line('-------------------------------------------------------------------------------------');
dbms_output.put_line('* MANAGER CAN UPDATE CUSTOMER WALLET FOR REFUNDS USING REFUND PROCEDURE');
dbms_output.put_line('-------------------------------------------------------------------------------------');
dbms_output.put_line('* CHECK DISH SALES USING SELECT * FROM VW_DISH_SALES');
dbms_output.put_line('-------------------------------------------------------------------------------------');
dbms_output.put_line('* CHECK TOP 10 SELLING DISHES USING SELECT * FROM VW_TOP_10_DISHES');
dbms_output.put_line('-------------------------------------------------------------------------------------');
dbms_output.put_line('* CHECK TOP 10 CUSTOMERS USING SELECT * FROM VW_TOP_10_CUSTOMERS');
dbms_output.put_line('-------------------------------------------------------------------------------------');
dbms_output.put_line('* CHECK MONTHLY SALES USING SELECT * FROM VW_MONTHLY_SALES');
dbms_output.put_line('-------------------------------------------------------------------------------------');
dbms_output.put_line('* CHECK TOP DELIVERY PERSON USING SELECT * FROM VW_TOP_DELIVERY_PERSON');
dbms_output.put_line('-------------------------------------------------------------------------------------');
dbms_output.put_line('* CHECK DELIVERY AGENT RATINGS USING SELECT * FROM VW_DELIVERY_AGENT_RATINGS');
dbms_output.put_line('-------------------------------------------------------------------------------------');
dbms_output.put_line('* CHECK RESTAURANT SERVICE RATINGS USING SELECT * FROM VW_RESTAURANT_SERVICE_RATINGS');
dbms_output.put_line('-------------------------------------------------------------------------------------');
dbms_output.put_line('* CHECK ACTIVE ORDERS USING SELECT * FROM VW_ACTIVE_ORDERS');
dbms_output.put_line('-------------------------------------------------------------------------------------');
dbms_output.put_line('* CHECK COMPLETED ORDERS USING SELECT * FROM VW_COMPLETED_OREDRS');
dbms_output.put_line('-------------------------------------------------------------------------------------');
dbms_output.put_line('* CHECK CANCELLED ORDERS USING SELECT * FROM VW_CANCELLED_OREDRS');
dbms_output.put_line('-------------------------------------------------------------------------------------');
dbms_output.put_line('* CHECK ALL ORDERS USING SELECT * FROM VW_ALL_ORDERS');
dbms_output.put_line('-------------------------------------------------------------------------------------');
dbms_output.put_line('* CHECK RESTAURANT MENU USING SELECT * FROM VW_MENU');
dbms_output.put_line('-------------------------------------------------------------------------------------');
dbms_output.put_line('* CHECK RESTAURANTS USING SELECT * FROM VW_RESTAURANTS');
dbms_output.put_line('-------------------------------------------------------------------------------------');
dbms_output.put_line('* CHECK DELIVERY AGENT STATUS USING SELECT * FROM VW_DELIVERY_AGENT_STATUS');
dbms_output.put_line('-------------------------------------------------------------------------------------');
end;

/

create or replace procedure welcome_delivery_agent_page
as
begin
dbms_output.put_line('-------------------------------------------------------------------------------------');
dbms_output.put_line('                           WELCOME TO FOOD ORDERING SYSTEM! ');
dbms_output.put_line('-------------------------------------------------------------------------------------');
dbms_output.put_line('WE HAVE 2 RESTAURANTS IN OUR SYSTEM AS OF NOW. RESTAURANTS ARE AS GIVEN BELOW : ');
dbms_output.put_line('-------------------------------------');
dbms_output.put_line(rpad('RESTAURANT ID',13)||' | '|| rpad('RESTAURANT NAME', 20));
dbms_output.put_line('-------------------------------------');
dbms_output.put_line(rpad(' 1',13) ||' | '|| rpad('INDIAN SPICE',20) || '|');
dbms_output.put_line(rpad(' 2',13) ||' | '|| rpad('TASTY BITES',20) || '|');
dbms_output.put_line('-------------------------------------');
dbms_output.put_line('********************************FOR DELIVERY AGENT************************************');
dbms_output.put_line('-------------------------------------------------------------------------------------');
dbms_output.put_line('* DELIVERY AGENT CAN LOGIN USING LOGIN_DELIVERY_AGENT PROCEDURE');
dbms_output.put_line('-------------------------------------------------------------------------------------');
dbms_output.put_line('* DELIVERY AGENT CAN UPDATE DELIVERY STATUS USING UPDATE_DELIVERY_DATA PROCEDURE');
dbms_output.put_line('-------------------------------------------------------------------------------------');
dbms_output.put_line('* DELIVERY AGENT CAN UPDATE OWN DETAILS USING UPDATE_DELIVERY_AGENT PROCEDURE');
dbms_output.put_line('-------------------------------------------------------------------------------------');
dbms_output.put_line('* CHECK CUSTOMER DELIVERY ADDRESS USING SELECT * FROM VW_CUSTOMER_ORDER_ADDRESS');
dbms_output.put_line('-------------------------------------------------------------------------------------');
end;

/

create or replace PROCEDURE REGISTER_CUSTOMER(
customer_username IN CUSTOMER.cust_username%TYPE, 
customer_password IN CUSTOMER.cust_password%TYPE, 
customer_first_name IN CUSTOMER.cust_first_name%TYPE,
customer_last_name IN CUSTOMER.cust_last_name%TYPE, 
customer_phone_no IN varchar2, 
apt_no IN CUSTOMER.apt_number%TYPE, 
customer_zip_code IN CUSTOMER.zip_code%TYPE, 
customer_street_name IN CUSTOMER.street_name%TYPE)
IS
username_null EXCEPTION;
username_exists EXCEPTION;
username_length_exceeded EXCEPTION;
password_length_null EXCEPTION;
password_length_exceeded EXCEPTION;
customer_first_name_null EXCEPTION;
customer_last_name_null EXCEPTION;
customer_name_length_exceeded EXCEPTION;
customer_first_name_is_number EXCEPTION;
customer_last_name_is_number EXCEPTION;
invalid_phone_number EXCEPTION;
invalid_zip_code EXCEPTION;
cust_username_count number;
customer_username_is_number EXCEPTION;
BEGIN

 select count(cust_username) into cust_username_count from CUSTOMER where cust_username=customer_username;
 IF customer_username IS NULL THEN
    RAISE username_null; 
 ELSIF (cust_username_count>0) THEN
    RAISE username_exists;
 ELSIF length(customer_username)>15 THEN
    RAISE username_length_exceeded;
 ELSIF customer_password IS NULL THEN
    RAISE password_length_null;
 ELSIF length(customer_password)>8 THEN
    RAISE password_length_exceeded;
 ELSIF customer_first_name IS NULL THEN
    RAISE customer_first_name_null;
 ELSIF customer_last_name IS NULL THEN
    RAISE customer_last_name_null;
 ELSIF (numberCheck(customer_first_name)=0) THEN
    RAISE customer_first_name_is_number;
 ELSIF (numberCheck(customer_username)=0) THEN
    RAISE customer_username_is_number;
 ELSIF (numberCheck(customer_last_name)=0) THEN
    RAISE customer_last_name_is_number;
 ELSIF length(customer_phone_no)<10 THEN
    RAISE invalid_phone_number;
 ELSIF (numberCheck(customer_phone_no)=1) THEN
    RAISE invalid_phone_number;
 ELSIF (length(customer_zip_code)>5 and length(customer_zip_code)<5) THEN
    RAISE invalid_zip_code;
 ELSE
    INSERT INTO CUSTOMER(cust_username, cust_password, cust_first_name, cust_last_name, cust_phone_no, wallet_balance, apt_number, zip_code, street_name) 
    VALUES(customer_username, customer_password, customer_first_name, customer_last_name, customer_phone_no, 0, apt_no, customer_zip_code, customer_street_name); 
 dbms_output.put_line('---------------------------------------');
 dbms_output.put_line('CUSTOMER REGISTERED SUCCESSFULLY!');
 dbms_output.put_line('---------------------------------------');
 
 END IF;
EXCEPTION 
 WHEN username_null THEN 
    raise_application_error (-20091,'USERNAME CANNNOT BE NULL OR ZERO LENGTH'); 
 WHEN username_exists THEN 
    raise_application_error (-20092,'THIS USERNAME ALREADY EXISTS! ENTER A NEW USERNAME'); 
 WHEN customer_username_is_number THEN 
    raise_application_error (-20092,'USERNAME CANNOT BE A NUMBER'); 
 WHEN username_length_exceeded THEN 
    raise_application_error (-20093,'USERNAME LENGTH CANNOT BE GREATER THAN 15'); 
 WHEN customer_first_name_null THEN 
    raise_application_error (-20094,'FIRST NAME CANNNOT BE NULL OR ZERO LENGTH');
 WHEN customer_last_name_null THEN 
    raise_application_error (-20095,'LAST NAME CANNNOT BE NULL OR ZERO LENGTH'); 
 WHEN customer_first_name_is_number THEN
    raise_application_error (-20096, 'FIRST NAME CANNOT BE NUMBER');
 WHEN customer_last_name_is_number THEN
    raise_application_error (-20096, 'LAST NAME CANNOT BE NUMBER');
 WHEN invalid_phone_number THEN
    raise_application_error (-20097, 'INVALID PHONE NUMBER');
 WHEN invalid_zip_code THEN
    raise_application_error (-20097, 'INVALID ZIP CODE');
 WHEN password_length_null THEN
    raise_application_error (-20098, 'PASSWORD CANNOT BE NULL');
 WHEN password_length_exceeded THEN
    raise_application_error (-20099, 'PASSWORD LENGTH CANNOT BE MORE THAN 8');
END;

/

create or replace PROCEDURE LOGIN_CUSTOMER(
customer_username IN CUSTOMER.cust_username%TYPE,
customer_password IN CUSTOMER.cust_password%TYPE)
IS

invalid_username EXCEPTION;
invalid_password EXCEPTION;
username_null EXCEPTION;
password_null EXCEPTION;
cust_username_temp NUMBER;
cust_password_temp VARCHAR(40);
BEGIN

 Select COUNT(cust_username) into cust_username_temp from CUSTOMER Where cust_username=customer_username;
 IF customer_password IS NULL THEN
 raise password_null;
  ELSIF customer_username IS NULL THEN
        RAISE username_null;
 ELSIF cust_username_temp=0 THEN
    RAISE invalid_username; 
ELSE
SELECT cust_password into cust_password_temp from CUSTOMER where cust_username=customer_username;
    IF (cust_password_temp!=customer_password) THEN
    RAISE invalid_password;
    ELSE
     DBMS_OUTPUT.PUT_LINE('Login Successfull!!!');
    END IF;
  END IF;
EXCEPTION 
 WHEN invalid_username THEN 
    raise_application_error (-20091,'Invalid username!!!'); 
     WHEN invalid_password THEN 
    raise_application_error (-20092,'Invalid password!!!'); 
    WHEN username_null THEN 
    raise_application_error (-20092,'username cannot be null!!!'); 
    WHEN password_null THEN 
    raise_application_error (-20092,'password cannot be null!!!'); 
END;

/

CREATE OR REPLACE PROCEDURE get_menu(
restaurantId menu.restaurant_id%TYPE
)
IS
dish_id NUMBER;
dish_name VARCHAR(40);
dish_rating NUMBER;
price NUMBER;
dish_category VARCHAR(40);
r_count number;
restuarant_not_exist exception;
CURSOR menu_cursor IS SELECT dish_id, dish_name , dish_rating, price, dish_category FROM menu  where restaurant_id=restaurantId ;
BEGIN
select count(*) into r_count from restaurant where restaurant_id=restaurantId;
if r_count=1 then
dbms_output.put_line (rpad('DISH_ID',10) || ' ' || rpad('DISH_NAME',35)|| ' ' || rpad('DISH_PRICE',20) || ' ' || rpad('DISH_RATING',20) || ' ' || rpad('DISH_CATEGORY',20));
OPEN menu_cursor;
LOOP
FETCH menu_cursor INTO dish_id, dish_name, dish_rating, price, dish_category;
EXIT WHEN menu_cursor%NOTFOUND;
DBMS_OUTPUT.PUT_LINE('-----------------------------------------------------------------------------------------------------');
DBMS_OUTPUT.PUT_LINE(rpad(DISH_ID,10) || ' ' || rpad(DISH_NAME,35)|| ' ' || rpad(PRICE,20) || ' ' || rpad(DISH_RATING,20) || ' ' ||rpad(DISH_CATEGORY,20));
END LOOP;
CLOSE menu_cursor;
else
raise restuarant_not_exist;
end if;
EXCEPTION
when restuarant_not_exist then
raise_application_error(-20196, 'THIS RESTAURANT DOES NOT EXIST! RE-ENTER RESTAUARANT ID');
END get_menu;

/

create or replace PROCEDURE CREATE_ORDER(CUSTID IN VARCHAR2, RESTAURANTID IN VARCHAR2)
IS
ORDID NUMBER;
order_already_exists exception;
input_ids_null exception;
invalid_restaurant exception;
invalid_customer exception;
cust_count number;
BEGIN
select count(*) into cust_count from customer where cust_id=CUSTID;
IF (CUSTID=null or RESTAURANTID=null) then
raise input_ids_null;
elsif numberCheck(CUSTID)=1 then
raise invalid_customer;
elsif numberCheck(RESTAURANTID)=1 then
raise invalid_restaurant;
elsif RESTAURANTID not in (1 ,2) then
raise invalid_restaurant;
elsif cust_count=0 then
raise invalid_customer;
else
SELECT count(*) INTO ORDID
FROM ORDERS
WHERE CUST_ID = CUSTID AND ORDER_STATUS='N/A';
if ((ORDID = Null) OR (ORDID = 0))
THEN
-- UPDATING ORDERS FOR CUSTOMERS
INSERT INTO ORDERS (CUST_ID, RESTAURANT_ID, ORDER_DATE, ORDER_STATUS, COUPON_NAME, DELIVERY_CHARGE, AMOUNT, PAYMENT_METHOD, PAYMENT_STATUS,
DELIVERY_AGENT_NAME, DELIVERY_SERVICE_RATING, RESTAURANT_SERVICE_RATING)
VALUES (CUSTID, RESTAURANTID, to_date(sysdate,'DD/MM/YYYY'), 'N/A', 'N/A', 2, 0, 'N/A', 'Pending', 'N/A', 0, 0);
select order_id into ORDID from orders where cust_id=CUSTID and order_status='N/A';
dbms_output.put_line('----------------------------------------------');
dbms_output.put_line('ORDER WITH ORDER_ID : '||ORDID||' IS CREATED!');
dbms_output.put_line('----------------------------------------------');
else
select order_id into ORDID from orders where cust_id=CUSTID and order_status='N/A';
dbms_output.put_line('----------------------------------------------');
dbms_output.put_line('ORDER WITH ORDER_ID : '|| ORDID ||' ALREADY EXISTS!');
dbms_output.put_line('----------------------------------------------');
raise order_already_exists;
END IF;
end if;
EXCEPTION
WHEN order_already_exists THEN
raise_application_error(-20091,'YOU ALREADY HAVE AN ORDER WHICH IS NOT COMPLETE');
WHEN input_ids_null THEN
raise_application_error(-20092,'INVALID INPUT');
WHEN invalid_restaurant THEN
raise_application_error(-20093,'INVALID RESTAURANT');
WHEN invalid_customer THEN
raise_application_error(-20095,'INVALID CUSTOMER');
END;

/

CREATE OR REPLACE PROCEDURE get_mycart(
orderId in cart.order_id%TYPE,
custId in cart.cust_id % TYPE
)
IS
dish_name VARCHAR(30);
dish_price DECIMAL(10,2);
dish_quantity NUMBER;
order_id_temp Number;
cust_id_temp Number;
incorrect_orderID EXCEPTION;
incorrect_custID EXCEPTION;
orderid_null EXCEPTION;
custid_null EXCEPTION;
CURSOR mycart_cursor IS SELECT b.dish_name, a.unit_price, a.quantity from cart a, menu b where
a.dish_id=b.dish_id and a.order_id=orderId;
BEGIN
DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------------');
DBMS_OUTPUT.PUT_LINE(RPAD('DISH NAME',25) || ' | ' || RPAD('UNIT PRICE',10) || ' | ' || RPAD('QUANTITY',8));
DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------------');
OPEN mycart_cursor;
LOOP
Select COUNT(order_id) into order_id_temp from cart Where order_id=orderId; 
IF orderId is null then
raise orderid_null;
ELSIF custId is null then
raise custid_null;
ELSIF order_id_temp=0 THEN
    RAISE incorrect_orderID; 
ELSE
SELECT COUNT(cust_id) into cust_id_temp from cart where cust_id=custId;
    IF cust_id_temp=0 THEN
    RAISE incorrect_custID;
    END IF;
END IF;
FETCH mycart_cursor INTO  dish_name,dish_price,dish_quantity;
EXIT WHEN mycart_cursor%NOTFOUND;
DBMS_OUTPUT.PUT_LINE(RPAD(dish_name,25) || ' | ' || RPAD(dish_price,10) || ' * ' || RPAD(dish_quantity,8) );
END LOOP;
EXCEPTION 
 WHEN incorrect_orderID THEN 
    raise_application_error (-20091,'Invalid ORDERID!!!'); 
     WHEN incorrect_custID THEN 
    raise_application_error (-20092,'Invalid CUSTID!!!'); 
    
    WHEN orderid_null THEN 
    raise_application_error (-20091,' ORDERID cannot be null!!!'); 
     WHEN custid_null THEN 
    raise_application_error (-20092,' CUSTID cannot be null!!!'); 
    
CLOSE mycart_cursor;
END get_mycart;

/

create or replace PROCEDURE ADD_TO_CART(ORDID IN NUMBER, CUSTID IN NUMBER, DISHID IN NUMBER, QTY IN NUMBER) IS
ORDID_TEMP NUMBER;
DISHID_TEMP NUMBER;
ostat VARCHAR(30);
dish_count NUMBER;
incorrect_oid exception;
no_edit_order exception;
incorrect_dish exception;
dish_unavailable exception;
rid NUMBER;
dishstat VARCHAR(30);
prc NUMBER;
CURRENT_QTY NUMBER;
orderid_null exception;
custid_null exception;
dishid_null exception;
quantity_notvalid exception;
BEGIN
    SELECT COUNT(ORDER_ID) INTO ORDID_TEMP FROM ORDERS WHERE CUST_ID=CUSTID AND ORDER_ID=ORDID;
    IF ORDID IS NULL THEN
        RAISE orderid_null;
    ELSIF CUSTID IS NULL THEN
        RAISE custid_null;
    ELSIF DISHID IS NULL THEN
        RAISE dishid_null;
    ELSE
        IF ORDID_TEMP>0 THEN
            SELECT ORDER_STATUS INTO  OSTAT FROM ORDERS WHERE CUST_ID=CUSTID AND ORDER_ID=ORDID;
            IF ostat != 'N/A' THEN
                RAISE no_edit_order;
            ELSE
                SELECT RESTAURANT_ID INTO RID FROM ORDERS WHERE ORDER_ID=ORDID;
                SELECT COUNT(DISH_ID) INTO DISHID_TEMP FROM MENU WHERE RESTAURANT_ID=RID AND DISH_ID=DISHID; 
                IF DISHID_TEMP>0 THEN
                    SELECT DISH_STATUS INTO DISHSTAT FROM MENU WHERE DISH_ID=DISHID;
                    IF DISHSTAT = 'available' THEN
                        IF QTY<=0 OR QTY>15 THEN
                                RAISE quantity_notvalid;
                        ELSE
                            SELECT COUNT(*) INTO dish_count FROM CART WHERE DISH_ID=DISHID AND ORDER_ID=ORDID;
                            IF dish_count=0 THEN
                                SELECT PRICE INTO PRC FROM MENU WHERE RESTAURANT_ID=RID AND DISH_ID=DISHID;
                                INSERT INTO CART (ORDER_ID, CUST_ID, RESTAURANT_ID, DISH_ID, DISH_RATING, UNIT_PRICE, QUANTITY)
                                VALUES (ORDID, CUSTID, RID, DISHID, 0, PRC, QTY);
                                DBMS_OUTPUT.PUT_LINE('Item(s) added to your cart sucessfully!');
                            ELSE
                            
                                SELECT QUANTITY INTO CURRENT_QTY FROM CART WHERE DISH_ID=DISHID AND ORDER_ID=ORDID;
                                CURRENT_QTY:=QTY+CURRENT_QTY;
                                if CURRENT_QTY >15 then
                                raise quantity_notvalid;
                                else
                                UPDATE CART SET QUANTITY = CURRENT_QTY WHERE DISH_ID = DISHID AND CUST_ID = CUSTID AND ORDER_ID=ORDID;
                                DBMS_OUTPUT.PUT_LINE('Item(s) added to your cart sucessfully!');
                                END IF;
                            END IF;
                        END IF;
                    ELSE
                        RAISE dish_unavailable;
                    END IF;
                ELSE
                    RAISE incorrect_dish;
                END IF;
            END IF;      
        ELSE
            RAISE incorrect_oid;   
        END IF;
    END IF;
EXCEPTION
WHEN orderid_null
THEN
    raise_application_error(-20091,'ORDER ID cannot be null.');
WHEN custid_null
THEN
    raise_application_error(-20091,'CUSTOMER ID cannot be null.');
WHEN dishid_null
THEN
    raise_application_error(-20091,'DISH ID cannot be null.');
WHEN incorrect_oid
THEN
    raise_application_error(-20091,'This ORDER ID is incorrect. Please enter valid ORDER ID.');
WHEN no_edit_order
THEN 
    raise_application_error(-20091,'You cannot add items to this order. Please create a new order.');
WHEN incorrect_dish
THEN 
    raise_application_error(-20091,'This dish does not exists. Please choose another dish.');
WHEN dish_unavailable
THEN 
    raise_application_error(-20091,'This dish is currently unavailable. Please choose another dish.');
WHEN quantity_notvalid
THEN
    raise_application_error(-20091,'Item cannot be added for this quantity.');
END;

/

CREATE OR REPLACE PROCEDURE CLEAR_CART(ORDID IN NUMBER, CUSTID IN NUMBER) IS
ORDID_TEMP NUMBER;
orderid_null EXCEPTION;
custid_null EXCEPTION;
OSTAT VARCHAR(30);
no_edit_cart EXCEPTION;
CART_COUNT NUMBER;
no_items EXCEPTION;
incorrect_oid EXCEPTION;
BEGIN
    SELECT COUNT(ORDER_ID) INTO ORDID_TEMP FROM ORDERS WHERE CUST_ID=CUSTID AND ORDER_ID=ORDID;
    IF ORDID IS NULL THEN
        RAISE orderid_null;
    ELSIF CUSTID IS NULL THEN
        RAISE custid_null;
    ELSE
        IF ORDID_TEMP>0 THEN
            SELECT ORDER_STATUS INTO OSTAT FROM ORDERS WHERE CUST_ID=CUSTID AND ORDER_ID=ORDID;
            IF ostat != 'N/A' THEN
                RAISE no_edit_cart;
            ELSE
                SELECT COUNT(*) INTO CART_COUNT FROM CART WHERE ORDER_ID=ORDID AND CUST_ID=CUSTID;
                IF CART_COUNT = 0 THEN
                    RAISE no_items;
                ELSE
                    DELETE FROM CART WHERE ORDER_ID=ORDID;
                    DBMS_OUTPUT.PUT_LINE('Cart cleared sucessfully!');
                END IF;
            END IF;
        ELSE    
            RAISE incorrect_oid;
        END IF;  
    END IF;
EXCEPTION
WHEN orderid_null
THEN
    raise_application_error(-20091,'ORDER ID cannot be null.');
WHEN custid_null
THEN
    raise_application_error(-20091,'CUSTOMER ID cannot be null.');
WHEN no_edit_cart
THEN 
    raise_application_error(-20091,'Cart cannot be emptied for this order.');
WHEN no_items
THEN 
    raise_application_error(-20091,'There are no items for this order in your cart.');
WHEN incorrect_oid
THEN
    raise_application_error(-20091,'This ORDER ID is incorrect. Please enter valid ORDER ID.');
END;

/

CREATE OR REPLACE PROCEDURE REMOVE_CART_ITEM(ORDERID IN NUMBER, CUSTID IN NUMBER, RESTID IN NUMBER, DISHID IN NUMBER, QUANT IN NUMBER)
IS
TEMP_QUANT NUMBER;
ROW_COUNT NUMBER;
-- DECLARING EXCEPTION
WRONG_ENTRY EXCEPTION;
INVALID_QUANTITY EXCEPTION;
orderid_null EXCEPTION;
custid_null EXCEPTION;
restid_null EXCEPTION;
dishid_null EXCEPTION;
quant_null EXCEPTION;
BEGIN
SELECT COUNT(*) INTO ROW_COUNT
FROM CART
WHERE ORDER_ID = ORDERID AND CUST_ID = CUSTID AND RESTAURANT_ID = RESTID AND DISH_ID = DISHID;
IF ORDERID IS NULL THEN
    RAISE orderid_null;
    
    ELSIF CUSTID IS NULL THEN
    RAISE custid_null;
    
    ELSIF RESTID IS NULL THEN
    RAISE restid_null;
    
    ELSIF DISHID IS NULL THEN
    RAISE dishid_null;
       
    ELSIF QUANT IS NULL THEN
    RAISE quant_null;
       
    ELSIF ROW_COUNT = 0 THEN
    RAISE WRONG_ENTRY;
    
ELSE
    SELECT QUANTITY INTO TEMP_QUANT
    FROM CART
    WHERE ORDER_ID = ORDERID AND CUST_ID = CUSTID AND RESTAURANT_ID = RESTID AND DISH_ID = DISHID;
    
    IF TEMP_QUANT = 1 AND QUANT = 1 THEN
        DELETE 
        FROM CART
        WHERE ORDER_ID = ORDERID AND CUST_ID = CUSTID AND RESTAURANT_ID = RESTID AND DISH_ID = DISHID;

    ELSIF TEMP_QUANT > QUANT THEN
        TEMP_QUANT := TEMP_QUANT - QUANT;
        
        IF TEMP_QUANT > 0 THEN
            UPDATE CART
            SET QUANTITY = TEMP_QUANT
            WHERE ORDER_ID = ORDERID AND CUST_ID = CUSTID AND RESTAURANT_ID = RESTID AND DISH_ID = DISHID;
        
        ELSE
            DELETE 
            FROM CART
            WHERE ORDER_ID = ORDERID AND CUST_ID = CUSTID AND RESTAURANT_ID = RESTID AND DISH_ID = DISHID;
        END IF;
        
    ELSE
        RAISE INVALID_QUANTITY;
END IF;
END IF;
EXCEPTION
    WHEN WRONG_ENTRY THEN
        raise_application_error (-20091,'EITHER THE CUST_ID, ORDER_ID, RESTAURANT_ID OR DISH_ID DOES NOT EXISTS');
    WHEN INVALID_QUANTITY THEN
        raise_application_error (-20091,'INVALID NUMBER  OF QUANTITY');  
    WHEN orderid_null THEN
        raise_application_error (-20091,'orderid cannot be null!!');      
    WHEN custid_null THEN
        raise_application_error (-20091,'custid cannot be null');   
    WHEN restid_null THEN
        raise_application_error (-20091,'restaurant id cannot be null');
    WHEN dishid_null THEN
        raise_application_error (-20091,'dishid cannot be null');
    WHEN quant_null THEN
        raise_application_error (-20091,'quantity cannot be null');
END;

/

create or replace PROCEDURE calculate_bill(orderId in ORDERS.order_id%TYPE)
IS
temp_order_cost DECIMAL(10,2):=0;
temp_dish_cost DECIMAL(10,2);
dish_name VARCHAR(30);
orderStatus VARCHAR(20);
dish_price DECIMAL(10,2);
dish_quantity NUMBER;
DELIVERY_CHARGE NUMBER;
COUPON VARCHAR(30);
DISCOUNT DECIMAL(10,2);
COUPON_DISCOUNT DECIMAL(10,2);
TAX DECIMAL(10,2);
order_count NUMBER;
order_id_does_not_exist EXCEPTION;
CURSOR calculate_bill_cursor IS SELECT b.dish_name, a.unit_price, a.quantity FROM cart a, menu b WHERE
a.dish_id=b.dish_id AND a.order_id=orderId;

BEGIN
    SELECT order_status INTO orderStatus FROM orders WHERE order_id=orderId;
    SELECT COUPON_NAME INTO COUPON FROM ORDERS WHERE ORDER_ID=orderId;
    OPEN calculate_bill_cursor;
        LOOP
            FETCH calculate_bill_cursor INTO  dish_name, dish_price, dish_quantity;
            EXIT WHEN calculate_bill_cursor%NOTFOUND;
            temp_dish_cost:=dish_price*dish_quantity;
            temp_order_cost:=temp_order_cost+temp_dish_cost;
        END LOOP;
    CLOSE calculate_bill_cursor;
    TAX:=temp_order_cost*0.01;
    temp_order_cost:=temp_order_cost+TAX;

    IF COUPON!='N/A' THEN
        SELECT DISCOUNT INTO DISCOUNT FROM COUPON WHERE COUPON_NAME=COUPON AND ACTIVITY_STATUS='ACTIVE';
        COUPON_DISCOUNT:=DISCOUNT*temp_order_cost;
        temp_order_cost:=temp_order_cost-COUPON_DISCOUNT;
    ELSE
        COUPON_DISCOUNT:=0;
    END IF;

    IF temp_order_cost>10 THEN
        DELIVERY_CHARGE:=0;
	    update orders set delivery_charge=0 where order_id=orderId;
    ELSE
        DELIVERY_CHARGE:=2;
        temp_order_cost:=temp_order_cost+DELIVERY_CHARGE;
    END IF;

    UPDATE orders SET amount=temp_order_cost WHERE order_id=OrderId;

END calculate_bill;

/

CREATE OR REPLACE PROCEDURE get_bill(orderId in ORDERS.order_id%TYPE)
IS
temp_order_cost decimal(10,2):=0;
temp_dish_cost decimal(10,2);
dish_name VARCHAR(30);
dish_price DECIMAL(10,2);
dish_quantity NUMBER;
DELIVERY_CHARGE NUMBER;
COUPON VARCHAR(30);
DISCOUNT DECIMAL(10,2);
COUPON_DISCOUNT DECIMAL(10,2);
TAX DECIMAL(10,2);
ORDID_TEMP NUMBER;
no_order EXCEPTION;
CURSOR bill_cursor IS SELECT b.dish_name, a.unit_price, a.quantity from cart a, menu b where
a.dish_id=b.dish_id and a.order_id=orderId;

BEGIN
SELECT COUNT(ORDER_ID) INTO ORDID_TEMP FROM ORDERS WHERE ORDER_ID=orderId;
IF ORDID_TEMP=0 THEN
RAISE no_order;
ELSE
SELECT COUPON_NAME INTO COUPON FROM ORDERS WHERE ORDER_ID=orderId;
DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------------');
DBMS_OUTPUT.PUT_LINE(RPAD('DISH',25) || ' | ' || RPAD('UNIT PRICE',10) || ' | ' || RPAD('QUANTITY',8)|| ' | ' || 'DISH_TOTAL');
DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------------');
OPEN bill_cursor;
LOOP
FETCH bill_cursor INTO  dish_name, dish_price, dish_quantity;
EXIT WHEN bill_cursor%NOTFOUND;
temp_dish_cost:=dish_price*dish_quantity;
temp_order_cost:=temp_order_cost+temp_dish_cost;
DBMS_OUTPUT.PUT_LINE(RPAD(dish_name,25) || ' | ' || RPAD(dish_price,10) || ' | ' || RPAD(dish_quantity,8) || ' | ' ||  temp_dish_cost);
END LOOP;
DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------------');

CLOSE bill_cursor;
DBMS_OUTPUT.PUT_LINE(RPAD(' ',43) || 'TOTAL  | ' || temp_order_cost||' $');
DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------------');

TAX:=temp_order_cost*0.01;
temp_order_cost:=temp_order_cost+tax;

IF COUPON!='N/A' THEN
SELECT DISCOUNT INTO DISCOUNT FROM COUPON WHERE COUPON_NAME=COUPON AND ACTIVITY_STATUS='ACTIVE';
COUPON_DISCOUNT:=DISCOUNT*temp_order_cost;
temp_order_cost:=temp_order_cost-COUPON_DISCOUNT;
ELSE
COUPON_DISCOUNT:=0;
END IF;

IF temp_order_cost>10 THEN
DELIVERY_CHARGE:=0;
ELSE
DELIVERY_CHARGE:=2;
temp_order_cost:=temp_order_cost+DELIVERY_CHARGE;
END IF;


DBMS_OUTPUT.PUT_LINE(RPAD(' ', 34)||'COUPON APPLIED  | -' || COUPON_DISCOUNT||' $');
DBMS_OUTPUT.PUT_LINE(RPAD(' ', 34)||'DELIVERY CHARGE | +' || DELIVERY_CHARGE||' $');
DBMS_OUTPUT.PUT_LINE(RPAD(' ', 34)||'TAX             | +' || TAX||' $');
DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------------');
DBMS_OUTPUT.PUT_LINE(RPAD(' ', 34)||'TOTAL BILL      |  ' || temp_order_cost||' $');
END IF;
EXCEPTION
WHEN no_order THEN 
raise_application_error (-20091,'This ORDER does not exists');
END get_bill;

/

create or replace PROCEDURE APPLY_COUPON(ORDID IN NUMBER, COUPONNAME IN COUPON.COUPON_NAME%TYPE) IS
LR coupon.lower_range%TYPE;
UR coupon.upper_range%TYPE;
ACTIVITYSTATUS coupon.activity_status%TYPE;
AMT DECIMAL(10,2);
ORDID_TEMP NUMBER;
COUPON_TEMP NUMBER;
orderid_null EXCEPTION;
coupon_null EXCEPTION;
coupon_not_in_range EXCEPTION;
coupon_not_exists EXCEPTION;
invalid_orderid EXCEPTION;
notactive_coupon EXCEPTION;
coupon_not_applicable EXCEPTION;
OSTAT VARCHAR(30);
BEGIN
    SELECT COUNT(ORDER_ID) INTO ORDID_TEMP FROM ORDERS WHERE ORDER_ID=ORDID;


    SELECT COUNT(COUPON_NAME) INTO COUPON_TEMP FROM COUPON WHERE COUPON_NAME=COUPONNAME;


    IF ORDID IS NULL THEN
        RAISE orderid_null;
    ELSIF COUPONNAME IS NULL THEN
        RAISE coupon_null;
    ELSE
        IF ORDID_TEMP>0 THEN
            CALCULATE_BILL(ORDID);
            commit;
            SELECT AMOUNT INTO AMT FROM ORDERS WHERE ORDER_ID=ORDID;
            SELECT ORDER_STATUS INTO OSTAT FROM ORDERS WHERE ORDER_ID=ORDID;
            IF OSTAT!='N/A' THEN
                RAISE coupon_not_applicable;
            ELSE
                IF COUPON_TEMP>0 THEN
                    IF ACTIVITYSTATUS != 'ACTIVE' THEN
                        RAISE notactive_coupon;
                    ELSE
                        SELECT LOWER_RANGE, UPPER_RANGE, ACTIVITY_STATUS INTO LR, UR, ACTIVITYSTATUS
                        FROM COUPON WHERE COUPON_NAME = COUPONNAME;
                        IF (AMT> LR) AND (AMT<UR) THEN
                            UPDATE ORDERS SET COUPON_NAME=COUPONNAME WHERE ORDER_ID=ORDID;
                            DBMS_OUTPUT.PUT_LINE('Coupon successfully applied!');
                            CALCULATE_BILL(ORDID);
                            commit;
                        ELSE
                            RAISE coupon_not_in_range;
                        END IF;
                    END IF;
                ELSE    
                    RAISE coupon_not_exists;
                END IF;
            END IF;
        ELSE
            RAISE invalid_orderid;
        END IF;
    END IF;
EXCEPTION 
WHEN orderid_null
THEN raise_application_error (-20091,'ORDER ID cannot be NULL');
WHEN coupon_null
THEN raise_application_error (-20091,'COUPON NAME cannot be NULL');
WHEN coupon_not_in_range
THEN raise_application_error (-20091,'This coupon is out of range for your order amount. Please select any other coupon or add items to your order to avail this coupon!');
WHEN coupon_not_exists
THEN raise_application_error (-20091,'This coupon does not exists');
WHEN invalid_orderid
THEN raise_application_error (-20091,'Please enter valid ORDER ID');
WHEN notactive_coupon
THEN raise_application_error (-20091,'This coupon is currently inactive!');
WHEN coupon_not_applicable
THEN raise_application_error (-20091,'Coupon cannot be applied for this order');

END APPLY_COUPON;  


/

CREATE OR REPLACE PROCEDURE REMOVE_COUPON(ORDERID IN NUMBER, CUSTID IN NUMBER)
IS
-- COUPON_VALUE VARCHAR(20);
ROW_COUNT NUMBER;
TEMP_COUNT NUMBER;
CNAME VARCHAR(30);

-- DECLARING EXCEPTION
WRONG_ENTRY EXCEPTION;
INVALID_ORDER_STATUS EXCEPTION;
coupon_not_exist EXCEPTION;
BEGIN
SELECT COUNT(*) INTO ROW_COUNT
FROM ORDERS
WHERE ORDER_ID = ORDERID AND CUST_ID = CUSTID;
SELECT COUNT(*) INTO TEMP_COUNT FROM ORDERS WHERE ORDER_ID = ORDERID AND ORDER_STATUS = 'N/A'; 
IF ROW_COUNT = 0 THEN
    RAISE WRONG_ENTRY;   
ELSE
    SELECT COUPON_NAME INTO CNAME FROM ORDERS WHERE ORDER_ID = ORDERID AND CUST_ID = CUSTID;
    IF CNAME='N/A' THEN
        RAISE coupon_not_exist;
    ELSE
    
        IF TEMP_COUNT > 0 THEN
    
            UPDATE ORDERS
            SET COUPON_NAME = 'N/A'
            WHERE ORDER_ID = ORDERID AND CUST_ID = CUSTID; 
            dbms_output.put_line('COUPON REMOVED SUCCESSFULLY');   
            CALCULATE_BILL(ORDERID);    
        ELSE
            RAISE INVALID_ORDER_STATUS;
        END IF;
    END IF;
END IF;
EXCEPTION
    WHEN WRONG_ENTRY THEN
        raise_application_error (-20091,'EITHER THE CUST_ID OR ORDER_ID DOES NOT EXISTS');
    WHEN INVALID_ORDER_STATUS THEN
        raise_application_error (-20091,'YOU CANNOT REMOVE THE COUPON ONCE THE ORDER IS PLACED!');
    WHEN coupon_not_exist THEN
        raise_application_error (-20091,'There exists no coupon.');
END;

/

create or replace PROCEDURE make_payment(orderId IN Orders.order_id%TYPE, mode_of_payment Orders.payment_method%TYPE)
IS
order_id_does_not_exist EXCEPTION;
order_id_null EXCEPTION;
payment_already_done EXCEPTION;
insufficient_wallet_balance EXCEPTION;
invalid_mode_of_payment EXCEPTION;
o_id number;
walletBalance decimal(10,2);
order_amount decimal(10,2);
pay_status varchar(20);
custId number;
cust_username_count number;
BEGIN
 select count(*) into o_id from orders where order_id=OrderId;
 IF o_id=0 then
    raise order_id_does_not_exist;
 ELSE
    select payment_status into pay_status from Orders where order_id=orderId;
    if pay_status='PAID' THEN
        raise payment_already_done;
    else
        calculate_bill(orderId);
        if mode_of_payment='WALLET' then
            select cust_id into custId from Orders where order_id=orderId;
            select wallet_balance into walletBalance from customer where cust_id=custId;
            select amount into order_amount from orders where order_id=orderId;
            if walletBalance>=order_amount then
                walletBalance:=walletBalance-order_amount;
                update customer set wallet_balance=walletBalance where cust_id=custId;
                update orders set payment_method='WALLET', payment_status='PAID', order_status='Placed Successfully' where order_id=orderId;               
            else
                raise insufficient_wallet_balance;
            end if;
        elsif mode_of_payment in ('CREDIT CARD', 'DEBIT CARD') then
            update orders set payment_method='WALLET', payment_status='PAID', order_status='Placed Successfully' where order_id=orderId;
        else
            raise invalid_mode_of_payment;
        end if;
    end if;
 END IF;
 EXCEPTION
 WHEN order_id_does_not_exist THEN
    raise_application_error(-20083, 'ORDER ID DOES NOT EXIST!');
 when payment_already_done then
    raise_application_error(-20084, 'PAYMENT ALREADY DONE FOR THIS ORDER');
 when insufficient_wallet_balance then
    raise_application_error(-20085, 'WALLET BALANCE NOT SUFFICIENT! TRY ANOTHER MODE OF PAYMENT');
 when invalid_mode_of_payment then
    raise_application_error(-20085, 'INAVLID MODE OF PAYMENT. SELECT FROM FOLLOWING (WALLET, CREDIT CARD, DEBIT CARD)');
END make_payment;

/

create or replace procedure change_order_status(restaurantId in VARCHAR2, orderId in VARCHAR2, changedStatus in VARCHAR2)
as
temp_count NUMBER;
O VARCHAR2(100);
C VARCHAR2(100);
R VARCHAR2(100);
orderStatus VARCHAR2(30);
agent_count NUMBER;
not_number EXCEPTION;
wrong_input EXCEPTION;
input_null EXCEPTION;
order_not_placed EXCEPTION;
order_already_confirmed EXCEPTION;
cancelled_or_refunded EXCEPTION;
order_already_in_preparing EXCEPTION;
order_not_confirmed EXCEPTION;
order_already_out_for_delivery EXCEPTION;
order_is_delivered EXCEPTION;
order_not_yet_prepared EXCEPTION;
agents_are_available EXCEPTION;
invalid_status EXCEPTION;
agent_not_available EXCEPTION;
BEGIN
dbms_output.put_line('entered proc');
O:=numberCheck(orderId);
C:=numberCheck(restaurantId);
R:=numberCheck(changedStatus);
IF (orderId=null or restaurantId=null) THEN
    raise input_null;
ELSIF (O=1 or C=1) then
    raise not_number;
ELSIF (initcap(changedStatus) not in ('Confirmed', 'Delivered', 'Placed Successfully', 'Refunded', 'Cancelled', 'Preparing', 'Out For Delivery', 'Delay In Delivery')) then
    raise invalid_status;
ELSE
    select count(*) into temp_count from orders where order_id=orderId and restaurant_id=restaurantId;
    if temp_count>0 then
        select initcap(order_status) into orderStatus from orders where order_id=orderId;
        select count(*) into agent_count from delivery_agent where agent_status='AVAILABLE';
            if initcap(changedStatus)='Confirmed' then
                if orderStatus='N/A' then
                    raise order_not_placed;
                elsif orderStatus in ('Confirmed', 'Preparing', 'Out For Delivery', 'Delay In Delivery', 'Delivered') then
                    raise order_already_confirmed;
                elsif orderStatus in ('Refunded', 'Cancelled') then
                    raise cancelled_or_refunded;
                elsif orderStatus='Placed Successfully' then
                    update orders set order_status='Confirmed' where order_id=orderId;
                    dbms_output.put_line('-------------------------------------------');
                    dbms_output.put_line('Order status of '|| orderId ||' updated successfully!');
                    dbms_output.put_line('-------------------------------------------');
                end if;

            elsif initcap(changedStatus)='Preparing' then
                if orderStatus='N/A' then
                    raise order_not_placed;
                elsif orderStatus in ('Preparing', 'Out For Delivery', 'Delay In Delivery', 'Delivered') then
                    raise order_already_in_preparing;
                elsif orderStatus='Placed Successfully' then
                    raise order_not_confirmed;
                elsif orderStatus in ('Refunded', 'Cancelled') then
                    raise cancelled_or_refunded;
                elsif orderStatus='Confirmed' then
                    update orders set order_status='Preparing' where order_id=orderId;
                    dbms_output.put_line('-------------------------------------------');
                    dbms_output.put_line('Order status of '|| orderId ||' updated successfully!');
                    dbms_output.put_line('-------------------------------------------');
                end if;

            elsif initcap(changedStatus)='Out For Delivery' then
                if orderStatus='N/A' then
                    raise order_not_placed;
                elsif orderStatus='Out For Delivery' then
                    raise order_already_out_for_delivery;
                elsif orderStatus='Placed Successfully' then
                    raise order_not_confirmed;
                elsif orderStatus in ('Refunded', 'Cancelled') then
                    raise cancelled_or_refunded;
                elsif orderStatus = 'Delivered' then
                    raise order_is_delivered;
                elsif orderStatus='Confirmed' then
                    raise order_not_yet_prepared;
                elsif orderStatus in ('Delay In Delivery', 'Preparing') then
                    if agent_count=0 then
                        raise agent_not_available;
                    else
                        update orders set order_status='Out For Delivery' where order_id=orderId;
                        update delivery set delivery_status='Out For Delivery' where order_id=orderId;
                        dbms_output.put_line('-------------------------------------------');
                        dbms_output.put_line('Order status of '|| orderId ||' updated successfully!');
                        dbms_output.put_line('-------------------------------------------');   
                    end if;
                end if;

            elsif initcap(changedStatus)='Delivered' then
                    dbms_output.put_line('Order status can be changed to Delivered using procedure only');

            elsif initcap(changedStatus)='Refunded' then
                    dbms_output.put_line('Order status can be changed to Refunded using procedure only');

            elsif initcap(changedStatus)='Cancelled' then
                    dbms_output.put_line('Order status can be changed to Cancelled using procedure only');  

            elsif initcap(changedStatus)='Delay In Delivery' then
            dbms_output.put_line('entered delay');
                if orderStatus='N/A' then
                    raise order_not_placed;
                elsif orderStatus='Out For Delivery' then
                    raise order_already_out_for_delivery;
                elsif orderStatus='Placed Successfully' then
                    raise order_not_confirmed;
                elsif orderStatus in ('Refunded', 'Cancelled') then
                    raise cancelled_or_refunded;
                elsif orderStatus = 'Delivered' then
                    raise order_is_delivered;
                elsif orderStatus='Confirmed' then
                    raise order_not_yet_prepared;
                elsif orderStatus in ('Delay In Delivery', 'Preparing') then
--                    update orders set order_status='Out For Delivery' where order_id=orderId;
                    if agent_count=0 then
                        update orders set order_status='Delay In Delivery' where order_id=orderId;
                        dbms_output.put_line('-------------------------------------------');
                        dbms_output.put_line('Order status of '|| orderId ||' updated successfully!');
                        dbms_output.put_line('-------------------------------------------');
                    else
                        raise agents_are_available;
                    end if;        
                end if;
            end if;
        else
            raise wrong_input;
        end if;
END IF;
EXCEPTION
when not_number then
    raise_application_error(-20191, 'PLEASE ENTER NUMERIC INPUT FOR ORDER_ID AND MANAGER_ID');
when order_not_placed then
    raise_application_error(-20192, 'THIS ORDER IS NOT PLACED!');
when wrong_input then
    raise_application_error(-20197, 'EITHER ORDER_ID OR MANAGER_ID IS WRONG!');
when input_null then
    raise_application_error(-20193, 'INPUT CANNOT BE NULL! PLEASE ENTER CORRECT ORDER_ID AND MANAGER_ID');
when order_already_confirmed then
    raise_application_error(-20194, 'THIS ORDER IS ALREADY CONFIRMED');
when cancelled_or_refunded then
    raise_application_error(-20195, 'THIS ORDER IS CANCELLED OR REFUNDED');
when order_already_in_preparing then
    raise_application_error(-20196, 'THIS ORDER IS ALREADY IN PREPARING STATUS');
when order_not_confirmed then
    raise_application_error(-20190, 'THIS ORDER IS NOT CONFIRMED');
when order_already_out_for_delivery then
    raise_application_error(-20174, 'THIS ORDER IS OUT FOR DELIVERY');
when order_is_delivered then
    raise_application_error(-20173, 'THIS ORDER IS DELIVERED!');
when order_not_yet_prepared then
    raise_application_error(-20164, 'THIS ORDER IS NOT YET IN PREPARING STATUS');
when agents_are_available then
    raise_application_error(-20154, 'AGENTS ARE AVAILABLE FOR ASSIGNMENT!');
when invalid_status then
    raise_application_error(-20134, 'THE STATUS ENTERED IS INVALID. PLEASE ENTER ANY OF THE FOLLOWING STATUS (Confirmed, Delivered, Placed Successfully, Refunded, Cancelled, Preparing, Out For Delivery, Delay In Delivery)');
when agent_not_available then
    raise_application_error(-20134, 'NO DELIVERY AGENT AVAILABLE AT THE MOMENT');

END change_order_status;

/

create or replace procedure assign_delivery_guy(managerId in Manager.manager_id%type, orderId in Orders.order_id%type)
is
o_count number;
delivery_check varchar2(30);
manager_check number;
agentId number;
agentName varchar(30);
agentCount number;
order_check varchar2(30);
restaurantId number;
custId number;
invalid_order_id exception;
order_id_null exception;
wrong_manager exception;
delivery_cannot_be_assigned_now exception;
delivery_guy_already_assigned exception;
order_not_placed_yet exception;
no_agent_available exception;
begin

IF orderId=null then
    raise order_id_null;
ELSE
    select count(*) into o_count from orders where order_id=orderId;
    if (o_count=0) then
        raise invalid_order_id;
    else
        select manager_id into manager_check from restaurant where restaurant_id in(select restaurant_id from orders where order_id=orderId);
        if manager_check=managerId then
            select delivery_agent_name into delivery_check from orders where order_id=orderId;
            if delivery_check='N/A' then
                --assign guy
                select order_status into order_check from orders where order_id=orderId;
                if order_check='N/A' then
                    raise order_not_placed_yet;
                elsif initcap(order_check) in ('Placed Successfully', 'Confirmed', 'Delivered', 'Out For Delivery', 'Cancelled', 'Refunded') then
                    raise delivery_cannot_be_assigned_now;
                elsif initcap(order_check) in ('Preparing', 'Delay In Delivery') then
                    select count(*) into agentCount from delivery_agent where agent_status='AVAILABLE';
                    if agentCount>0 then
                        select agent_id into agentId from delivery_agent where agent_status='AVAILABLE' fetch first 1 row only;
                        select agent_username into agentName from delivery_agent where agent_id=agentId;
                        update delivery_agent set agent_status='NOT AVAILABLE' where agent_id=agentId;
                        update orders set delivery_agent_name=agentName where order_id=orderId;
                        select restaurant_id, cust_id into restaurantId, custId from orders where order_id=orderId;
                        insert_delivery_data(orderId, restaurantId, custId, agentId,'N/A');
--                        merge into delivery d
--                        using orders o
--                        on(d.order_id = orderId)
--                        when matched then
--                        update set
--                        d.restaurant_id=o.restaurant_id,
--                        d.cust_id=o.cust_id,
--                        d.agent_id=agentId
--                        when not matched then
--                        insert values(orderId, o.restaurant_id, o.cust_id, agentId, 'N/A');
                    else
                        raise no_agent_available;
                    end if;
                end if;
            else
                raise delivery_guy_already_assigned;
            end if;

        else
            raise wrong_manager;
        end if;
    end if;
end if;
exception
when invalid_order_id then
raise_application_error(-20099, 'PLEASE RE-ENTER ORDERID. THIS ORDERID DOES NOT EXIST');
when order_id_null then
raise_application_error(-20001, 'PLEASE RE-ENTER ORDERID. ORDERID CANNOT BE NULL');
when order_not_placed_yet then
raise_application_error(-20092, 'ORDER IS NOT YET PLACED. CANNOT ASSIGN DELIVERY AGENT TO THIS ORDER ID');
when delivery_cannot_be_assigned_now then
raise_application_error(-20093, 'ORDER STATUS SHOULD BE PREPARING OR DELAY IN DELIVERY TO ASSIGN DELIVERY AGENT');
when no_agent_available then
raise_application_error(-20094, 'NO DELIVERY AGENT AVAILABLE AT THE MOMENT');
WHEN delivery_guy_already_assigned THEN
raise_application_error(-20098,'DELIVERY GUY ALREADY ASSIGNED TO THIS ORDER. RE-ENTER CORRECT ORDERID');
WHEN wrong_manager THEN
raise_application_error(-20096,'INCORRECT MANAGER ID');
END assign_delivery_guy;

/

set serveroutput on;
CREATE OR REPLACE PROCEDURE CHECK_ORDER_STATUS(CUSTID IN ORDERS.CUST_ID%TYPE, ORDID IN ORDERS.ORDER_ID%TYPE) IS
temp NUMBER;
OSTAT VARCHAR(30);
agentId VARCHAR(30); 
restaurant VARCHAR(30);
dishId VARCHAR(30);
dishname VARCHAR(30);
contact NUMBER;
payment VARCHAR(30);
coupon VARCHAR(30);
orderid_null EXCEPTION;
custid_null EXCEPTION;
order_not_present EXCEPTION;
order_in_cart EXCEPTION;
CURSOR dishes IS SELECT a.dish_id, b.dish_name FROM cart a, menu b WHERE a.dish_id=b.dish_id and order_id=ordid;
BEGIN
SELECT COUNT(ORDER_ID) INTO temp FROM ORDERS WHERE CUST_ID=CUSTID AND ORDER_ID=ORDID;

    IF ORDID IS NULL THEN
        RAISE orderid_null;
    ELSIF CUSTID IS NULL THEN
        RAISE custid_null;
    ELSE
        IF TEMP>0 THEN
            SELECT ORDER_STATUS INTO OSTAT FROM ORDERS WHERE ORDER_ID=ORDID AND CUST_ID=CUSTID;
      
            
            IF OSTAT!='N/A' THEN
            select agent_id into agentId from delivery_agent where agent_username in (select delivery_agent_name from orders where order_id=ORDID);
            select restaurant_name into restaurant from restaurant where restaurant_id IN (SELECT restaurant_id FROM ORDERS WHERE ORDER_ID=ORDID);
            select restaurant_contact into contact from restaurant where restaurant_id IN (SELECT restaurant_id FROM ORDERS WHERE ORDER_ID=ORDID);
            select coupon_name into coupon from orders where order_id=ordid;
            select payment_method into payment from orders where order_id=ordid;
                
                OPEN dishes;
                dbms_output.put_line('------------------------------------------------------------------------------------------------------------------------------------');
                dbms_output.put_line('ORDER ID: '|| rpad(ordid,5) || ' | ' || 'ORDER STATUS: '|| rpad(ostat,20) || ' | ' || 'CUSTOMER ID: '|| rpad(custId,5) || ' | ' || 'RESTAURANT: ' || rpad(restaurant,12) || ' | ' || 'DELIVERY AGENT ID: ' || rpad(agentId,5) || ' | ');
                dbms_output.put_line('------------------------------------------------------------------------------------------------------------------------------------');
                dbms_output.put_line('Here is what you ordered...');
                dbms_output.put_line('------------------------------------------------');
                dbms_output.put_line(RPAD('DISH ID', 8) || ' | ' || RPAD('DISH NAME', 35));
                dbms_output.put_line('------------------------------------------------');
                LOOP
                    FETCH dishes INTO dishId, dishName;
                    EXIT WHEN dishes%NOTFOUND;
                    dbms_output.put_line(RPAD(dishId, 8) || ' | ' || RPAD(dishName, 35)||' | ' );
                    END LOOP;
                    dbms_output.put_line('-------------------------------------------------------------------------------------------------------------------------------------');
                    dbms_output.put_line('Contact '|| restaurant || ' on +91-'||contact||' if you need any assistance with your order!');
                    dbms_output.put_line('*************************************************************************************************************************************');
                    CLOSE dishes;   
            ELSE
                RAISE order_in_cart;
            END IF;
        ELSE
            RAISE order_not_present;
        END IF;
    END IF;
EXCEPTION
WHEN orderid_null
THEN
    raise_application_error(-20091,'ORDER ID cannot be null.');
WHEN custid_null
THEN
    raise_application_error(-20091,'CUSTOMER ID cannot be null.');
WHEN order_not_present
THEN 
    raise_application_error(-20091,'This order does not exists.');
WHEN order_in_cart
THEN raise_application_error(-20091,'This order is still in CART');
END;

/

create or replace PROCEDURE update_delivery_data(
orderID in delivery.order_id%type,
agentID in delivery.agent_id%type)
IS

invalid_orderid EXCEPTION;
orderid_null EXCEPTION;
orderid_temp NUMBER;
agentid_temp NUMBER;
deliverystatus_temp varchar(40);
BEGIN
IF orderID is null THEN
    RAISE orderid_null; 
ELSE
 Select COUNT(order_id) into orderid_temp from delivery Where order_id=orderID and agent_id=agentID;
 
 IF orderid_temp >0 THEN
UPDATE Delivery
SET delivery_status='Delivered' WHERE order_id=orderID;

UPDATE Orders
set order_status='Delivered' where order_id=orderID;

UPDATE Delivery_agent
set agent_status='AVAILABLE' where agent_id=agentID;
else 
RAISE invalid_orderid;
  END IF;
  END IF;
EXCEPTION 
 WHEN invalid_orderid THEN 
    raise_application_error (-20091,'Invalid orderID and delivery agent !!!'); 
    
WHEN orderid_null THEN 
    raise_application_error (-20091,'orderid cannot be null !!!'); 
    
END update_delivery_data;

/

create or replace procedure feedback_page(custId in VARCHAR2, orderId in VARCHAR2)
is
CURSOR feedback_details IS SELECT a.dish_id, b.dish_name, a.dish_rating FROM cart a, menu b WHERE a.dish_id=b.dish_id and order_id=orderId;
O VARCHAR2(100);
C VARCHAR2(100);
R VARCHAR2(100);
temp_count number;
dishId number;
rating number;
restaurantId number;
--custId number;
orderStatus varchar2(30);
agentId varchar2(30);
dishName varchar2(50);
custName varchar2(50);
not_number exception;
input_null exception;
cannot_give_rating_now exception;
wrong_input exception;
BEGIN
IF (orderId=null or custId=null OR rating=NULL) then
    raise input_null;
ELSIF (O=1 or C=1 or R=1) then
    raise not_number;
ELSE
    select count(*) into temp_count from orders where order_id=orderId and cust_id=custId;
    if temp_count>0 then
        select order_status into orderStatus from orders where order_id=orderId;
        select agent_id into agentId from delivery_agent where agent_username in (select delivery_agent_name from orders where order_id=4);
        select restaurant_id into restaurantId from orders where order_id=orderId;
        if orderStatus='Delivered' then
            OPEN feedback_details;
            select cust_first_name into custName from customer where cust_id = custId;
            dbms_output.put_line('------------------------------------------------------------------------------------------------------------------------------------');
            dbms_output.put_line('ORDER ID: '|| rpad(orderId,5) || ' | ' || 'CUSTOMER ID: '|| rpad(custId,5) || ' | ' || 'RESTAURANT ID: ' || rpad(restaurantId,5) || ' | ' || 'DELIVERY AGENT ID: ' || rpad(agentId,5) || ' | ');
            dbms_output.put_line('------------------------------------------------------------------------------------------------------------------------------------');
            dbms_output.put_line( 'Thank you for ordering ' || rpad(custName, 15));
            dbms_output.put_line( 'Could you please provide ratings for below dishes that you ordered?');
            dbms_output.put_line( 'Your feedback will help us to serve you better :)');
            dbms_output.put_line('------------------------------------------------');
            dbms_output.put_line(RPAD('DISH ID', 8) || ' | ' || RPAD('DISH NAME', 35)); 
            dbms_output.put_line('------------------------------------------------');
            LOOP
                FETCH feedback_details INTO  dishId, dishName, rating;
                EXIT WHEN feedback_details%NOTFOUND;
                dbms_output.put_line(RPAD(dishId, 8) || ' | ' || RPAD(dishName, 35)||' | ' ); 
            END LOOP;
            dbms_output.put_line('-------------------------------------------------------------------------------------------------------------------------------------');
            dbms_output.put_line( 'Please use below procedures to provide your rating for each dish you ordered, restaurant_service_rating and delivery service rating');
            dbms_output.put_line('Procedure name to give dish ratings : dish_rating(cust_id, order_id, dish_id, dish_rating)');
            dbms_output.put_line('Procedure name to give delivery service rating : delivery_service_feedback(customer_id, order_id, rating)');
            dbms_output.put_line('Procedure name to give restaurant service rating : restaurant_service_feedback(customer_id, order_id, rating)');
            dbms_output.put_line('--------------------------------------------------------------------------------------------------------------------------------------');
            dbms_output.put_line( 'Please enter numeric input for ratings on a scale of 1 to 5 :');
            dbms_output.put_line( '1: Not Satisfied');
            dbms_output.put_line( '2: Okay');
            dbms_output.put_line( '3: Good');
            dbms_output.put_line( '4: Very Good');
            dbms_output.put_line( '5: Excellent');
            dbms_output.put_line('*******Ignore if already given feedback*******');
            CLOSE feedback_details;
        else
            raise cannot_give_rating_now;
        END IF;
    ELSE 
        RAISE wrong_input;
    END IF;
END IF;
exception
when cannot_give_rating_now then
raise_application_error(-20192, 'YOU CAN PROVIDE RATING ONLY AFTER ORDER IS DELIVERED!');
when wrong_input then
raise_application_error(-20197, 'EITHER ORDER_ID OR CUST_ID IS WRONG!');
when input_null then
raise_application_error(-20194, 'INPUT CANNOT BE NULL! PLEASE ENTER CORRECT ORDER_ID AND CUST_ID');
when not_number then
raise_application_error(-20199, 'ORDER_ID, CUST_ID, RATING SHOULD BE A NUMBER INPUT');
END feedback_page;

/

create or replace procedure delivery_service_feedback(custId in VARCHAR2, orderId in VARCHAR2, rating in VARCHAR2)
as
O VARCHAR2(100);
C VARCHAR2(100);
R VARCHAR2(100);
d_rating decimal(10,2);
check_rating number;
agentId number;
agentName varchar2(30);
orderStatus varchar2(30);
temp_count number;
wrong_input EXCEPTION;
input_null exception;
rating_not_in_range exception;
cannot_give_rating_now exception;
rating_already_given exception;
not_number exception;
begin
O:=numberCheck(orderId);
C:=numberCheck(custId);
R:=numberCheck(rating);
if (orderId=null or custId=null OR rating=NULL) then
    raise input_null;
ELSIF (O=1 or C=1 or R=1) then
    raise not_number;
else
    select count(*) into temp_count from orders where order_id=orderid and cust_id=custId;
    if temp_count>0 then
        select order_status, delivery_agent_name, delivery_service_rating into orderStatus, agentName, check_rating from orders where order_id=orderId;
        if check_rating=0 then
            if orderStatus='Delivered' then
                if (rating>=0 and rating<6) then
                    update orders set delivery_service_rating=rating where order_id=orderId;
                    select round(avg(delivery_service_rating),2) into d_rating from orders where order_status='Delivered' and delivery_agent_name=agentName group by delivery_agent_name;
                    update delivery_agent set agent_rating=d_rating where agent_username=agentName;
                    dbms_output.put_line('------------------------------------------------');
                    dbms_output.put_line('Thank you for your feedback!' );
                    dbms_output.put_line('Your rating for delivery agent ' ||agentName||' is ' || rating);
                    dbms_output.put_line('Your rating will help us to serve you better :)' );
                    dbms_output.put_line('------------------------------------------------');
                else
                    raise rating_not_in_range;
                end if;
            else
                raise cannot_give_rating_now;
            end if;
        else
            raise rating_already_given;
        end if;
    else
        raise wrong_input;
    end if;
end if;
exception
when rating_not_in_range then
raise_application_error(-20191, 'PLEASE ENTER NUMBER INPUT IN RANGE 1 TO 5');
when cannot_give_rating_now then
raise_application_error(-20192, 'YOU CAN PROVIDE RATING ONLY AFTER ORDER IS DELIVERED!');
when wrong_input then
raise_application_error(-20197, 'EITHER ORDER_ID OR CUST_ID IS WRONG!');
when input_null then
raise_application_error(-20194, 'INPUT CANNOT BE NULL! PLEASE ENTER CORRECT ORDER_ID AND CUST_ID');
when rating_already_given then
raise_application_error(-20195, 'AGENT RATING FOR THIS ORDER_ID IS ALREADY GIVEN');
when not_number then
raise_application_error(-20199, 'ORDER_ID, CUST_ID, RATING SHOULD BE A NUMBER INPUT');
END;

/

create or replace procedure restaurant_service_feedback(custId in VARCHAR2, orderId in VARCHAR2, rating in VARCHAR2)
as
O VARCHAR2(100);
C VARCHAR2(100);
R VARCHAR2(100);
check_rating number;
restId number;
orderStatus varchar2(30);
temp_count number;
wrong_input EXCEPTION;
input_null exception;
rating_not_in_range exception;
cannot_give_rating_now exception;
rating_already_given exception;
not_number exception;
begin
O:=numberCheck(orderId);
C:=numberCheck(custId);
R:=numberCheck(rating);
if (orderId=null or custId=null OR RATING=NULL) then
    raise input_null;
ELSIF (O=1 or C=1 or R=1) then
    raise not_number;
else
    select count(*) into temp_count from orders where order_id=orderid and cust_id=custId;
    if temp_count>0 then
        select order_status, restaurant_id, restaurant_service_rating into orderStatus, restId, check_rating from orders where order_id=orderId;
        if check_rating=0 then
            if orderStatus='Delivered' then
                if (rating>=0 and rating<6) then
                    update orders set restaurant_service_rating=rating where order_id=orderId;
--                    select avg(restaurant_service_rating) into r_rating from orders where order_status='Delivered' and restaurant_id=restId group by restaurant_id;

                else
                    raise rating_not_in_range;
                end if;
            else
                raise cannot_give_rating_now;
            end if;
        else
            raise rating_already_given;
        end if;
    else
        raise wrong_input;
    end if;
end if;
exception
when rating_not_in_range then
raise_application_error(-20191, 'PLEASE ENTER NUMBER INPUT IN RANGE 1 TO 5');
when cannot_give_rating_now then
raise_application_error(-20192, 'YOU CAN PROVIDE RATING ONLY AFTER ORDER IS DELIVERED!');
when wrong_input then
raise_application_error(-20193, 'EITHER ORDER_ID OR CUST_ID IS WRONG!');
when input_null then
raise_application_error(-20194, 'INPUT CANNOT BE NULL! PLEASE ENTER CORRECT ORDER_ID AND CUST_ID');
when rating_already_given then
raise_application_error(-20195, 'RATING FOR THIS ORDER_ID IS ALREADY GIVEN');
when not_number then
raise_application_error(-20199, 'ORDER_ID, CUST_ID, RATING SHOULD BE A NUMBER INPUT');
END;

/

create or replace procedure give_dish_rating(custId in VARCHAR2, orderId in VARCHAR2, dishId in varchar2, rating in VARCHAR2)
as
O VARCHAR2(100);
C VARCHAR2(100);
R VARCHAR2(100);
D VARCHAR2(100);
dishName varchar2(50);
d_rating decimal(10,2);
check_rating number;
agentId number;
agentName varchar2(30);
orderStatus varchar2(30);
temp_count number;
wrong_input EXCEPTION;
input_null exception;
rating_not_in_range exception;
cannot_give_rating_now exception;
rating_already_given exception;
not_number exception;
begin
O:=numberCheck(orderId);
C:=numberCheck(custId);
R:=numberCheck(rating);
D:=numberCheck(dishId);
if (orderId=null or custId=null OR rating=NULL OR dishId=null) then
    raise input_null;
ELSIF (O=1 or C=1 or R=1 or D=1) then
    raise not_number;
else
    select count(*) into temp_count from cart where order_id=orderid and cust_id=custId and dish_id=dishId;
    if temp_count>0 then
        select dish_rating into check_rating from cart where dish_id=dishId and order_id=orderId;
        select order_status into orderStatus from orders where order_id=orderId;
        select dish_name into dishName from menu where dish_id=dishId;
        if check_rating=0 then
            if orderStatus='Delivered' then
                if (rating>=0 and rating<6) then
                    update cart set dish_rating=rating where order_id=orderId and dish_id=dishId;
                    select round(avg(c.dish_rating),2) into d_rating from cart c join orders o on c.order_id=o.order_id and o.order_status='Delivered' and c.dish_id=dishId group by c.dish_id;
                    update menu set dish_rating=d_rating where dish_id=dishId;
                    dbms_output.put_line('------------------------------------------------');
                    dbms_output.put_line('Thank you for your feedback!' );
                    dbms_output.put_line('Your dish rating for dish ' ||dishName||' is ' || rating);
                    dbms_output.put_line('Your rating will help us to serve you better :)' );
                    dbms_output.put_line('------------------------------------------------');
                else
                    raise rating_not_in_range;
                end if;
            else
                raise cannot_give_rating_now;
            end if;
        else
            raise rating_already_given;
        end if;
    else
        raise wrong_input;
    end if;
end if;
exception
when rating_not_in_range then
raise_application_error(-20191, 'PLEASE ENTER NUMBER INPUT IN RANGE 1 TO 5');
when cannot_give_rating_now then
raise_application_error(-20192, 'YOU CAN PROVIDE RATING ONLY AFTER ORDER IS DELIVERED!');
when wrong_input then
raise_application_error(-20197, 'EITHER ORDER_ID OR CUST_ID IS WRONG!');
when input_null then
raise_application_error(-20194, 'INPUT CANNOT BE NULL! PLEASE ENTER CORRECT ORDER_ID AND CUST_ID');
when rating_already_given then
raise_application_error(-20195, 'DISH RATING FOR THIS DISH_ID IS ALREADY GIVEN');
when not_number then
raise_application_error(-20199, 'ORDER_ID, CUST_ID, DISH_ID, RATING SHOULD BE A NUMBER INPUT');
END give_dish_rating;

/

create or replace PROCEDURE refund(
orderID in orders.order_id%type,
custID in orders.cust_id%type
)
IS
invalid_orderid EXCEPTION;
orderid_null EXCEPTION;
orderid_temp NUMBER;
wallet_temp NUMBER;
order_amount_temp NUMBER;
deliverystatus_temp varchar(40);

BEGIN
IF orderID is null THEN
    RAISE orderid_null; 
ELSE
 Select COUNT(order_id) into orderid_temp from orders Where order_id=orderID and order_status='Cancelled';
 
 IF orderid_temp > 0 THEN
-- select wallet_balance into wallet_temp from customer where cust_id=custID;
 select amount into order_amount_temp from orders where order_id=orderID ;
 
UPDATE customer 
SET wallet_balance = wallet_balance + order_amount_temp  WHERE cust_id=custID;

UPDATE Orders
set order_status='Refunded' where order_id=orderID;
--UPDATE Orders set order_status='Cancelled' where order_id=1;
else 
RAISE invalid_orderid;
  END IF;
  END IF;
  
EXCEPTION 
 WHEN invalid_orderid THEN 
    raise_application_error (-20091,'Invalid orderID and customerId !!!');    
WHEN orderid_null THEN 
    raise_application_error (-20091,'orderid cannot be null !!!');    
END refund;

/

SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE UPDATE_CUSTOMER(custId in CUSTOMER.cust_id%type,
custUsername in CUSTOMER.cust_username%type,
custPassword in CUSTOMER.cust_password%type,
custFirstName in CUSTOMER.cust_first_name%type,
custLastName in CUSTOMER.cust_last_name%type,
custPhone in CUSTOMER.cust_phone_no%type,
custAptNumber in CUSTOMER.apt_number%type,
custZipCode in CUSTOMER.zip_code%type,
custStreet in CUSTOMER.street_name%type) IS
usercount NUMBER;

-- EXCEPTION
incorrect_user EXCEPTION;
username_null EXCEPTION;
username_length_exceeded EXCEPTION;
password_length_null EXCEPTION;
password_length_exceeded EXCEPTION;
customer_first_name_null EXCEPTION;
customer_last_name_null EXCEPTION;
customer_name_length_exceeded EXCEPTION;
customer_first_name_is_number EXCEPTION;
customer_last_name_is_number EXCEPTION;
invalid_phone_number EXCEPTION;
invalid_zip_code EXCEPTION;

BEGIN
SELECT COUNT(CUST_USERNAME) INTO usercount FROM CUSTOMER WHERE CUST_ID=CUSTID AND CUST_USERNAME=custUsername;
 IF custUsername IS NULL THEN
    RAISE username_null; 
 ELSIF length(custUsername)>15 THEN
    RAISE username_length_exceeded;
 ELSIF custPassword IS NULL THEN
    RAISE password_length_null;
 ELSIF length(custPassword)>8 THEN
    RAISE password_length_exceeded;
 ELSIF custFirstName IS NULL THEN
    RAISE customer_first_name_null;
 ELSIF custLastName IS NULL THEN
    RAISE customer_last_name_null;
 ELSIF (numberCheck(custFirstName)=0) THEN
    RAISE customer_first_name_is_number;
 ELSIF (numberCheck(custLastName)=0) THEN
    RAISE customer_last_name_is_number;
 ELSIF length(custPhone)<10 THEN
    RAISE invalid_phone_number;
 ELSIF (length(custZipCode)>5 and length(custZipCode)<5) THEN
    RAISE invalid_zip_code;
 ELSE
 --encrpyt password
    IF usercount>0 THEN
    UPDATE CUSTOMER SET 
    cust_password=custpassword, 
    cust_first_name=custfirstname, 
    cust_last_name=custlastname, 
    cust_phone_no = custphone, 
    apt_number=custaptnumber, 
    zip_code=custzipcode, 
    street_name=custstreet
    WHERE CUST_ID=CUSTID AND CUST_USERNAME=CUSTUSERNAME;
    DBMS_OUTPUT.PUT_LINE('Customer details updated sucessfully!');
    ELSE
        RAISE incorrect_user;
    END IF;
 END IF;
EXCEPTION 
 WHEN username_null THEN 
    raise_application_error (-20091,'USERNAME CANNNOT BE NULL OR ZERO LENGTH');  
 WHEN username_length_exceeded THEN 
    raise_application_error (-20093,'USERNAME LENGTH CANNOT BE GREATER THAN 15'); 
 WHEN customer_first_name_null THEN 
    raise_application_error (-20094,'FIRST NAME CANNNOT BE NULL OR ZERO LENGTH');
 WHEN customer_last_name_null THEN 
    raise_application_error (-20095,'LAST NAME CANNNOT BE NULL OR ZERO LENGTH'); 
 WHEN customer_first_name_is_number THEN
    raise_application_error (-20096, 'FIRST NAME CANNOT BE NUMBER');
 WHEN customer_last_name_is_number THEN
    raise_application_error (-20096, 'LAST NAME CANNOT BE NUMBER');
 WHEN invalid_phone_number THEN
    raise_application_error (-20097, 'INVALID PHONE NUMBER');
 WHEN invalid_zip_code THEN
    raise_application_error (-20097, 'INVALID ZIP CODE');
 WHEN password_length_null THEN
    raise_application_error (-20098, 'PASSWORD CANNOT BE NULL');
 WHEN password_length_exceeded THEN
    raise_application_error (-20099, 'PASSWORD LENGTH CANNOT BE MORE THAN 8');
 WHEN incorrect_user THEN 
    raise_application_error(-20091,'Please enter correct Customer ID and/or Username. Username and Customer ID cannot be changed.');
END;

/

SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE UPDATE_DELIVERYAGENT(AGENTID in DELIVERY_AGENT.AGENT_id%type,
AGENTUsername in DELIVERY_AGENT.AGENT_username%type,
AGENTPassword in DELIVERY_AGENT.AGENT_password%type,
AGENTSTATUS in DELIVERY_AGENT.AGENT_STATUS%TYPE
) IS

-- EXCEPTION
usercount NUMBER;
incorrect_user EXCEPTION;
username_null EXCEPTION;
username_length_exceeded EXCEPTION;
password_length_null EXCEPTION;
password_length_exceeded EXCEPTION;
status_error EXCEPTION;

BEGIN
SELECT COUNT(AGENT_USERNAME) INTO usercount FROM DELIVERY_AGENT WHERE AGENT_ID=AGENTID AND AGENT_USERNAME=AGENTUsername;
 IF AGENTUsername IS NULL THEN
    RAISE username_null; 
 ELSIF length(AGENTUsername)>15 THEN
    RAISE username_length_exceeded;
 ELSIF AGENTPassword IS NULL THEN
    RAISE password_length_null;
 ELSIF length(AGENTPassword)>8 THEN
    RAISE password_length_exceeded;
 ELSIF UPPER(AGENTSTATUS) NOT IN ('AVAILABLE','NOT AVAILABLE') THEN
    RAISE status_error;
 ELSE
 --encrpyt password
    IF usercount>0 THEN
        MERGE INTO DELIVERY_AGENT c
        USING (select AGENTID as agent_id, AGENTUsername as agent_username, AGENTPassword as agent_password, AGENTSTATUS as agent_status from dual) s
        ON (c.agent_id = s.agent_id)
        WHEN MATCHED THEN
        UPDATE SET
        c.agent_password = s.agent_password,
        c.agent_status = s.agent_status
        WHEN NOT MATCHED THEN
        INSERT(c.agent_id, c.agent_username, c.agent_password, c.agent_status) 
        VALUES(s.agent_id, s.agent_username, s.agent_password, s.agent_status);

        DBMS_OUTPUT.PUT_LINE('Delivery Agent details updated sucessfully!');
        ELSE
            RAISE incorrect_user;
        END IF;
    END IF;
    
EXCEPTION 
 WHEN username_null THEN 
    raise_application_error (-20091,'USERNAME CANNNOT BE NULL OR ZERO LENGTH');  
 WHEN username_length_exceeded THEN 
    raise_application_error (-20093,'USERNAME LENGTH CANNOT BE GREATER THAN 15'); 
 WHEN password_length_null THEN
    raise_application_error (-20098, 'PASSWORD CANNOT BE NULL');
 WHEN password_length_exceeded THEN
    raise_application_error (-20099, 'PASSWORD LENGTH CANNOT BE MORE THAN 8');
 WHEN incorrect_user THEN 
    raise_application_error(-20091,'Please enter correct Agent ID and/or Username. Username and Agent ID cannot be changed.');
 WHEN status_error THEN
    raise_application_error(-20091,'Agent Status can either be AVAILABLE or NOT AVAILABLE');
END;

/

SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE UPDATE_MANAGER(MANAGERID in MANAGER.MANAGER_id%type,
MANAGERUsername in MANAGER.MANAGER_username%type,
MANAGERPassword in MANAGER.MANAGER_password%type
) IS
usercount NUMBER;
incorrect_user EXCEPTION;
username_null EXCEPTION;
username_length_exceeded EXCEPTION;
password_length_null EXCEPTION;
password_length_exceeded EXCEPTION;


BEGIN
SELECT COUNT(MANAGER_USERNAME) INTO usercount FROM MANAGER WHERE MANAGER_ID=MANAGERID AND MANAGER_USERNAME=MANAGERUsername;
 IF MANAGERUsername IS NULL THEN
    RAISE username_null; 
 ELSIF length(MANAGERUsername)>15 THEN
    RAISE username_length_exceeded;
 ELSIF MANAGERPassword IS NULL THEN
    RAISE password_length_null;
 ELSIF length(MANAGERPassword)>8 THEN
    RAISE password_length_exceeded;
 ELSE
 --encrpyt password
    IF usercount>0 THEN
    UPDATE MANAGER SET 
    MANAGER_password=MANAGERpassword
    WHERE MANAGER_ID=MANAGERID AND MANAGER_USERNAME=MANAGERUSERNAME;
    DBMS_OUTPUT.PUT_LINE('Manager details updated sucessfully!');
    ELSE
        RAISE incorrect_user;
    END IF;
 END IF;
EXCEPTION 
 WHEN username_null THEN 
    raise_application_error (-20091,'USERNAME CANNNOT BE NULL OR ZERO LENGTH');  
 WHEN username_length_exceeded THEN 
    raise_application_error (-20093,'USERNAME LENGTH CANNOT BE GREATER THAN 15'); 
 WHEN password_length_null THEN
    raise_application_error (-20098, 'PASSWORD CANNOT BE NULL');
 WHEN password_length_exceeded THEN
    raise_application_error (-20099, 'PASSWORD LENGTH CANNOT BE MORE THAN 8');
 WHEN incorrect_user THEN 
    raise_application_error(-20091,'Please enter correct Manager ID and/or Username. Username and Manager ID cannot be changed.');
END;

/

--store procedure for update coupon
CREATE or REPLACE PROCEDURE update_coupon(
COUPONNAME IN coupon.coupon_name%TYPE,
LOWERRANGE IN coupon.lower_range%TYPE,
UPPERRANGE IN coupon.upper_range%TYPE,
ACTIVITYSTATUS IN coupon.activity_status%TYPE,
DISCOUNTVALUE IN coupon.discount%TYPE
)
IS
invalid_couponid EXCEPTION;
invalid_couponname EXCEPTION;
null_entry EXCEPTION;
BEGIN
IF COUPONNAME is null THEN
RAISE null_entry;
ELSIF LOWERRANGE is null THEN
RAISE null_entry;
ELSIF UPPERRANGE is null THEN
RAISE null_entry;
ELSIF ACTIVITYSTATUS is null THEN
RAISE null_entry;
ELSIF DISCOUNTVALUE is null THEN
RAISE null_entry;
ELSE   
MERGE INTO COUPON C
USING (select UPPER(COUPONNAME) as coupon_name, LOWERRANGE as lower_range ,
UPPERRANGE as upper_range, UPPER(ACTIVITYSTATUS) as activity_status, DISCOUNTVALUE as discount from dual) s
ON(C.coupon_name= s.coupon_name)
WHEN MATCHED THEN
UPDATE SET
C.lower_range =s.lower_range,
C.upper_range =s.upper_range,
C.activity_status =s.activity_status,
C.discount =s.discount
WHEN NOT MATCHED THEN
INSERT( C.coupon_name, C.lower_range, C.upper_range,C.activity_status,
C.discount)
VALUES (s.coupon_name, s.lower_range, s.upper_range,s.activity_status,
s.discount);
END IF;
EXCEPTION
WHEN invalid_couponname THEN
raise_application_error (-20091,'coupon name cannot be null !!!');
WHEN null_entry THEN
raise_application_error (-20091,'Null entry encountered. Please add all values to update coupon!');
END update_coupon;

/

--stored procedure for update menu
CREATE or REPLACE PROCEDURE update_menu(
DISHID IN menu.dish_id%TYPE,
DISHNAME IN menu.dish_name%TYPE,
DISHSTATUS IN menu.dish_status%TYPE,
RESTAURANTID IN menu.restaurant_id%TYPE,
PRICE IN menu.price%TYPE,
DISHCATEGORY IN menu.dish_category%TYPE
)
IS
invalid_ENTRY EXCEPTION;
dish_id_not_found Exception;
invalid_category EXCEPTION;
invalid_status EXCEPTION;
temp_dishid number;
BEGIN
select count(dish_id) into temp_dishid from menu where DISHID=dish_id;
if temp_dishid=0 then 
raise dish_id_not_found;
ELSIF DISHID is null THEN
RAISE invalid_ENTRY;
ELSIF RESTAURANTID is null THEN
RAISE invalid_ENTRY;
ELSIF DISHNAME IS NULL THEN
RAISE invalid_ENTRY;
ELSIF DISHSTATUS IS NULL THEN
RAISE invalid_ENTRY;
ELSIF INITCAP(DISHSTATUS) NOT IN ('Available','Not Available') THEN
RAISE invalid_status;
ELSIF PRICE IS NULL THEN
RAISE invalid_ENTRY;
ELSIF DISHCATEGORY IS NULL THEN
RAISE invalid_ENTRY;
ELSIF INITCAP(DISHCATEGORY) NOT IN ('Appetizer','Main Course','Dessert','Beverage') THEN
RAISE invalid_category;
ELSE
MERGE INTO MENU D
USING (select DISHID as dish_id, UPPER(DISHNAME) as dish_name, RESTAURANTID as restaurant_id , INITCAP(DISHSTATUS) as dish_status,
PRICE as price , INITCAP(DISHCATEGORY) as dish_category from dual) s
ON(D.dish_id = s.dish_id)
WHEN MATCHED THEN
UPDATE SET
 D.dish_name =s.dish_name,
 D.restaurant_id =s.restaurant_id,
 D.dish_status=s.dish_status,
 D.price =s.price,
 D.dish_category =s.dish_category
WHEN NOT MATCHED THEN
INSERT( D.dish_name, D.restaurant_id, D.dish_status, D.price,  D.dish_category)
VALUES (s.dish_name, s.restaurant_id,INITCAP(s.dish_status), s.price, INITCAP(s. dish_category));
END IF;
EXCEPTION
WHEN invalid_ENTRY THEN
raise_application_error (-20091,'Invaild entry performed');
when dish_id_not_found then
raise_application_error (-20091,'DISHID not found !!!');
WHEN invalid_category THEN
raise_application_error (-20091,'DISH CATEGORY CAN BE APPETIZER, MAIN COURSE, DESSERT, OR BEVERAGE');
WHEN invalid_status THEN
raise_application_error (-20091,'DISH STATUS CAN BE AVAILABLE OR NOT AVAILABLE');
END update_menu;

/

CREATE OR REPLACE PROCEDURE cancel_order(
custID in orders.cust_id%type,
orderID in orders.order_id%type)
IS
invalid_orderid EXCEPTION;
cannot_change_orderstatus EXCEPTION;
nomatch EXCEPTION;
orderid_null EXCEPTION;
orderid_temp NUMBER;
orderstatus VARCHAR(30);
CUSTid_null EXCEPTION;
BEGIN
SELECT count(order_id) into orderid_temp from orders where order_id=orderID and cust_id=custID;
IF orderid IS NULL THEN
RAISE orderid_null;
ELSIF custid IS NULL THEN
RAISE custid_null;
ELSE
IF orderid_temp>0 THEN
SELECT order_status into orderstatus from orders where order_id=orderID;
IF (orderstatus='Confirmed' OR orderstatus='Placed Successfully') THEN
UPDATE orders
set order_status='Cancelled' where order_id=orderID;
DBMS_OUTPUT.PUT_LINE('Order cancelled successfully');
ELSE
raise cannot_change_orderstatus;
END IF;
ELSE
raise nomatch;
END IF;
END IF;
EXCEPTION
WHEN cannot_change_orderstatus THEN
raise_application_error (-20091,'Order cannot be cancelled at this stage');
WHEN orderid_null THEN
raise_application_error (-20091,'Order ID cannot be null !!!');
WHEN CUSTid_null THEN
raise_application_error (-20091,'CUSTOEMR ID cannot be null !!!');
WHEN nomatch THEN
raise_application_error (-20091,'orderid and custId are not valid !!!');
END cancel_order;

/


CREATE OR REPLACE PROCEDURE LOGIN_MANAGER(
man_username IN MANAGER.manager_username%TYPE,
man_password IN MANAGER.manager_password%TYPE)
IS

invalid_username EXCEPTION;
invalid_password EXCEPTION;
username_null EXCEPTION;
password_null EXCEPTION;
man_username_temp NUMBER;
man_password_temp VARCHAR(40);
BEGIN


 Select COUNT(manager_username) into man_username_temp from MANAGER Where manager_username=man_username; 
 
  IF man_username IS NULL THEN
 raise username_null;
  ELSIF man_password IS NULL THEN
        RAISE password_null;
 
 ELSIF man_username_temp=0 THEN
    RAISE invalid_username; 
ELSE
SELECT manager_password into man_password_temp from MANAGER where manager_username=man_username;
    IF (man_password_temp!=man_password) THEN
    RAISE invalid_password;
    ELSE
     DBMS_OUTPUT.PUT_LINE('Login Successfull!!!');
    END IF;
  END IF;
EXCEPTION 
 WHEN invalid_username THEN 
    raise_application_error (-20091,'Invalid username!!!'); 
     WHEN invalid_password THEN 
    raise_application_error (-20092,'Invalid password!!!'); 
    WHEN username_null THEN 
    raise_application_error (-20092,'username cannot be null!!!'); 
    WHEN password_null THEN 
    raise_application_error (-20092,'password cannot be null!!!'); 
END;

/

SET SERVEROUTPUT ON;

--store procedure for login functionality
CREATE OR REPLACE PROCEDURE LOGIN_DELIVERY_AGENT(
Delivery_username IN DELIVERY_AGENT.agent_username%TYPE,
Delivery_password IN DELIVERY_AGENT.agent_password%TYPE)
IS

invalid_username EXCEPTION;
invalid_password EXCEPTION;
username_null EXCEPTION;
password_null EXCEPTION;
agent_username_temp NUMBER;
agnet_password_temp VARCHAR(40);
BEGIN


 Select COUNT(agent_username) into agent_username_temp from DELIVERY_AGENT Where agent_username=Delivery_username;
    IF Delivery_username IS NULL THEN
        raise username_null;
    ELSIF Delivery_password IS NULL THEN
        RAISE password_null;
 
    ELSIF agent_username_temp=0 THEN
        RAISE invalid_username; 
    ELSE
        SELECT agent_password into agnet_password_temp from DELIVERY_AGENT where agent_username=Delivery_username;
        IF (agnet_password_temp!=Delivery_password) THEN
            RAISE invalid_password;
        ELSE
            DBMS_OUTPUT.PUT_LINE('Login Successfull!!!');
        END IF;
    END IF;
EXCEPTION 
    WHEN invalid_username THEN 
        raise_application_error (-20091,'Invalid username!!!'); 
    WHEN invalid_password THEN 
        raise_application_error (-20092,'Invalid password!!!'); 
    WHEN username_null THEN 
        raise_application_error (-20092,'username cannot be null!!!'); 
    WHEN password_null THEN 
        raise_application_error (-20092,'password cannot be null!!!'); 
END;

/


-- INSERTING DATA INTO DELIVERY_AGENT ENTITY
EXECUTE insert_deliveryagent_data('RAJ', 'RAJ@123', 3.0, 'AVAILABLE');
EXECUTE insert_deliveryagent_data('PUNIT', 'PUNIT_SHETTY@981', 2.6, 'NOT AVAILABLE');
EXECUTE insert_deliveryagent_data('KARTIK', 'KARTIKMOHAN_121', 4.6, 'NOT AVAILABLE');
EXECUTE insert_deliveryagent_data('ADITI', 'ADITI_MISHRA@123', 1.9, 'AVAILABLE');
EXECUTE insert_deliveryagent_data('AHUSHKA', 'MOHANTY_AUSHKA@123', 5.0, 'NOT AVAILABLE');
EXECUTE insert_deliveryagent_data('RAJVEER', 'VEER_RAJ@123', 3.8, 'AVAILABLE');
EXECUTE insert_deliveryagent_data('ADITYA', 'AG_ADI@123', 4.2, 'NOT AVAILABLE');
EXECUTE insert_deliveryagent_data('SARTHAK', 'SARTHAK@1875', 1.5, 'AVAILABLE');
EXECUTE insert_deliveryagent_data('MOHAN', 'MOHAN@RAJ', 2.2, 'NOT AVAILABLE');
EXECUTE insert_deliveryagent_data('JANVHI', 'JANVHI_SHETTY@123', 4.7, 'AVAILABLE');
EXECUTE insert_deliveryagent_data('PRASAD', 'PRASAD@321', 4.1, 'AVAILABLE');
EXECUTE insert_deliveryagent_data('RASHMI', 'RASHMI@123', 3.9, 'NOT AVAILABLE');
EXECUTE insert_deliveryagent_data('KRITIKA', 'KRITIKA@123', 2.9, 'AVAILABLE');
EXECUTE insert_deliveryagent_data('NEHA', 'GUPTA_NEHA@123', 5.0, 'AVAILABLE');
EXECUTE insert_deliveryagent_data('AYAN', 'AYAN@123', 4.4, 'NOT AVAILABLE');


-----------------------------------------------------------------------------------------------

-- INSERTING DATA INTO MANAGER ENTITY
EXECUTE insert_manager_data(1,'PRATHAMESH', 'FAIDO$1231');
EXECUTE insert_manager_data (2,'HIMANI', 'THAKKER@123');


-----------------------------------------------------------------------------------------------

-- INSERTING DATA INTO RESTAURANT ENTITY
EXECUTE insert_restaurant_data (1, 1, 8579814056, 'INDIAN SPICE');
EXECUTE insert_restaurant_data (2, 2, 8163273945, 'TASTY BITES');


-----------------------------------------------------------------------------------------------

-- INSERTING DATA INTO CUSOTMERS ENTITY
EXECUTE insert_customer_data(1, 'maurya_ramteke','ramteke123','Maurya','Ramteke',5677766666,20,166,02115,'st botolph');
EXECUTE insert_customer_data(2, 'sharvika_barapatre','barapatre123','Sharvika','Barapatre',7585583333,300,1567,02120,'Tremont street');
EXECUTE insert_customer_data(3, 'prasad_pathak','pathak123','Prasad','Pathak',7585444333,10,415,02120,'alphonsus street');
EXECUTE insert_customer_data(4, 'aditya_bhabhe','bhabhe123','Aditya','Bhabhe',4444433333,0,507,02120,'alphonsus street');
EXECUTE insert_customer_data(5, 'girish_pillai','pillai123','Girish','Pillai',6666633333,10,908,02120,'smiths street');
EXECUTE insert_customer_data(6, 'sahil_mattoo','mattoo123','Sahil','Mattoo',6667788844,60,76,02122,'bolyston street');
EXECUTE insert_customer_data(7, 'aditya_arvind','arvind123','Aditya','Arvind',1366678112,0,431,02121,'Park Drive');
EXECUTE insert_customer_data(8, 'aditya_sharma','sharma123','Aditya','Sharma',8598315033,0,37,02215,'Downtown');
EXECUTE insert_customer_data(9, 'kartik_mohan','mohan123','Kartik','Mohan',7262924823,0,3,02121,'Park Drive');
EXECUTE insert_customer_data(10, 'pragya_mishra','mishra123','Pragya','Mishra',8938912804,0,19,02215,'Downtown');
EXECUTE insert_customer_data(11, 'vivek_oberio','oberio123','Vivek','Oberio',7948911423,0,5,02115,'st botolph');
EXECUTE insert_customer_data(12, 'shubham_patidar','Patidar123','Shubham','Patidar',8728375092,0,45, 02120, 'Tremont street');
EXECUTE insert_customer_data(13, 'yash_neema','Neema123','Yash','Neema',9827282038,0,14, 02115, 'Sachem Street');
EXECUTE insert_customer_data(14, 'shibhu_verma','Verma123','Shibhu','Verma', 8286379274,0, 11, 02121, 'Park Drive');
EXECUTE insert_customer_data(15, 'dakshit_shetty','Shetty123','Dakshit','Shetty', 8172384092,0, 18, 02115, 'Downtown');


-----------------------------------------------------------------------------------------------

-- INSERTING DATA INTO ORDERS ENTITY


EXECUTE insert_orders_data(1, 1, 2, (TO_TIMESTAMP('2022-01-03 06:14:00', 'YYYY-MM-DD HH24:MI:SS')), 'Preparing', 'PLATINUM', 0, 116.65, 'DEBIT CARD', 'Paid', 'RAJ', 0, 0);
EXECUTE insert_orders_data(2, 3, 1, (TO_TIMESTAMP('2022-02-17 13:34:32', 'YYYY-MM-DD HH24:MI:SS')), 'N/A', 'N/A', 0, 53.03, 'WALLET BALANCE', 'Pending', 'N/A', 0, 0);
EXECUTE insert_orders_data(3, 7, 2, (TO_TIMESTAMP('2022-04-09 12:14:37', 'YYYY-MM-DD HH24:MI:SS')), 'Out for delivery', 'SILVER', 0, 38.64, 'CREDIT CARD', 'Paid', 'SARTHAK', 0, 0);
EXECUTE insert_orders_data(4, 5, 2, (TO_TIMESTAMP('2022-02-27 01:24:00', 'YYYY-MM-DD HH24:MI:SS')), 'Delivered', 'GOLD', 0, 181.8, 'CREDIT CARD', 'Paid', 'JANVHI', 0, 4);
EXECUTE insert_orders_data(5, 2, 2, (TO_TIMESTAMP('2022-01-21 17:18:19', 'YYYY-MM-DD HH24:MI:SS')), 'Refunded', 'SILVER', 0, 23.18, 'DEBIT CARD', 'Paid', 'N/A', 0, 0);
EXECUTE insert_orders_data(6, 1, 1, (TO_TIMESTAMP('2022-03-14 14:17:09', 'YYYY-MM-DD HH24:MI:SS')), 'Placed Successfully', 'N/A', 0, 75.25, 'WALLET BALANCE', 'Paid', 'N/A', 0, 0);
EXECUTE insert_orders_data(7, 3, 1, (TO_TIMESTAMP('2022-04-20 20:56:00', 'YYYY-MM-DD HH24:MI:SS')), 'Delivered', 'SILVER', 0, 43.63, 'DEBIT CARD', 'Paid', 'RAJ', 3.0, 3);
EXECUTE insert_orders_data(8, 6, 2, (TO_TIMESTAMP('2022-03-26 04:13:31', 'YYYY-MM-DD HH24:MI:SS')), 'Out for delivery', 'GOLD', 0, 110.7, 'DEBIT CARD', 'Paid', 'RAJVEER', 0, 0);
EXECUTE insert_orders_data(9, 7, 1, (TO_TIMESTAMP('2022-02-19 22:39:41', 'YYYY-MM-DD HH24:MI:SS')), 'Delay in delivery', 'SILVER', 0, 39.09, 'DEBIT CARD', 'Paid', 'N/A', 0, 0);
EXECUTE insert_orders_data(10, 5, 2, (TO_TIMESTAMP('2022-02-22 17:28:37', 'YYYY-MM-DD HH24:MI:SS')), 'Preparing', 'N/A', 0, 10.1, 'WALLET BALANCE', 'Paid', 'NEHA', 0, 0);
EXECUTE insert_orders_data(11, 5, 2, (TO_TIMESTAMP('2022-01-31 12:15:38', 'YYYY-MM-DD HH24:MI:SS')), 'Delivered', 'PLATINUM', 0, 86.25, 'WALLET BALANCE', 'Paid', 'RAJ', 5, 2);
EXECUTE insert_orders_data(12, 1, 1, (TO_TIMESTAMP('2022-04-15 13:29:13', 'YYYY-MM-DD HH24:MI:SS')), 'Cancelled', 'GOLD', 0, 79.18, 'DEBIT CARD', 'Paid', 'N/A', 0, 0);
EXECUTE insert_orders_data(13, 3, 2, (TO_TIMESTAMP('2022-01-12 03:18:28', 'YYYY-MM-DD HH24:MI:SS')), 'Delivered', 'GOLD', 0, 71.91, 'DEBIT CARD', 'Paid', 'JANVHI', 2, 5);
EXECUTE insert_orders_data(14, 10, 2, (TO_TIMESTAMP('2022-02-14 09:11:08', 'YYYY-MM-DD HH24:MI:SS')), 'Out for delivery', 'N/A', 0, 38.38, 'WALLET BALANCE', 'Paid', 'ADITI', 0, 0);
EXECUTE insert_orders_data(15, 9, 1, (TO_TIMESTAMP('2022-03-04 16:19:00', 'YYYY-MM-DD HH24:MI:SS')), 'Delivered', 'GOLD', 0, 59.79, 'DEBIT CARD', 'Paid', 'RAJVEER', 5, 1);
EXECUTE insert_orders_data(16, 6, 1, (TO_TIMESTAMP('2022-03-18 18:12:49', 'YYYY-MM-DD HH24:MI:SS')), 'Cancelled', 'N/A', 0, 12.12, 'WALLET BALANCE', 'Paid', 'N/A', 0, 0);
EXECUTE insert_orders_data(17, 10, 1, (TO_TIMESTAMP('2022-04-17 08:46:27', 'YYYY-MM-DD HH24:MI:SS')), 'Delivered', 'PLATINUM', 0, 74.23, 'DEBIT CARD', 'Paid', 'RAJVEER', 3, 4);
EXECUTE insert_orders_data(18, 1, 2, (TO_TIMESTAMP('2022-02-16 03:18:58', 'YYYY-MM-DD HH24:MI:SS')), 'Delay in delivery', 'PLATINUM', 0, 102.51, 'WALLET BALANCE', 'Paid', 'N/A', 0, 0);
EXECUTE insert_orders_data(19, 4, 2, (TO_TIMESTAMP('2022-03-26 23:22:15', 'YYYY-MM-DD HH24:MI:SS')), 'Refunded', 'N/A', 0, 51.51, 'DEBIT CARD', 'Paid', 'N/A', 0, 0);
EXECUTE insert_orders_data(20, 10, 1, (TO_TIMESTAMP('2022-02-24 15:45:26', 'YYYY-MM-DD HH24:MI:SS')), 'Delivered', 'SILVER', 0, 35.45, 'WALLET BALANCE', 'Paid', 'RAJ', 3, 4);
EXECUTE insert_orders_data(21, 11, 2, (TO_TIMESTAMP('2022-01-19 16:24:49', 'YYYY-MM-DD HH24:MI:SS')), 'Out for delivery', 'SILVER', 0, 30.91, 'WALLET BALANCE', 'Paid', 'NEHA', 0, 0);
EXECUTE insert_orders_data(22, 12, 1, (TO_TIMESTAMP('2022-02-13 11:12:12', 'YYYY-MM-DD HH24:MI:SS')), 'Delay in delivery', 'N/A', 0, 28.79, 'CREDIT CARD', 'Paid', 'NEHA', 0, 0);
EXECUTE insert_orders_data(23, 13, 1, (TO_TIMESTAMP('2022-04-04 13:40:18', 'YYYY-MM-DD HH24:MI:SS')), 'Confirmed', 'SILVER', 0, 39.09, 'CREDIT CARD', 'Paid', 'ADITI', 0, 0);
EXECUTE insert_orders_data(24, 14, 2, (TO_TIMESTAMP('2022-03-29 21:13:30', 'YYYY-MM-DD HH24:MI:SS')), 'Preparing', 'GOLD', 0, 57.37, 'CREDIT CARD', 'Paid', 'SARTHAK', 0, 0);
EXECUTE insert_orders_data(25, 15, 1, (TO_TIMESTAMP('2022-03-25 06:11:42', 'YYYY-MM-DD HH24:MI:SS')), 'Preparing', 'GOLD', 0, 50.10, 'DEBIT CARD', 'Paid', 'NEHA', 0, 0);
EXECUTE insert_orders_data(26, 12, 2, (TO_TIMESTAMP('2022-02-27 01:42:11', 'YYYY-MM-DD HH24:MI:SS')), 'Confirmed', 'N/A', 2,  10.61, 'DEBIT CARD', 'Paid', 'SARTHAK', 0, 0);

-----------------------------------------------------------------------------------------------

-- INSERTING DATA INTO MENU ENTITY
-- ADDING APPERTIZERS TO THE MENU
EXECUTE insert_menu_data(1,'SMOKED NACHOS','available',4.5,7.50,'Appetizer');
EXECUTE insert_menu_data(2,'BUFFALLO SHRIMP SKEWERS','available',4.1,8.50,'Appetizer');
EXECUTE insert_menu_data(2,'CHILI CHEESE TOTS','available',4.0,9.50,'Appetizer');
EXECUTE insert_menu_data(1,'CHICKEN FINGERS','available',3.5,6.50,'Appetizer');
EXECUTE insert_menu_data(1,'FOUR CHEESE GARLIC BREAD','available',4.5,13,'Appetizer');
EXECUTE insert_menu_data(1,'STUFFED MSHROOMS','available',4.5,12,'Appetizer');

-- ADDING MAIN COURSE TO THE MENU
EXECUTE insert_menu_data(2,'GRILLED SALMON WITH DILL SAUCE','available',4.5,17,'Main Course');
EXECUTE insert_menu_data(1,'ROAST BEEF WITH VEGETABLES','available',4.0,18,'Main Course');
EXECUTE insert_menu_data(1,'CHICKEN AND MUSHROOM PIE','available',3.5,15,'Main Course');
EXECUTE insert_menu_data(1,'MARRAKESH VEGETERIAN CURRY','available',4.7,22,'Main Course');
EXECUTE insert_menu_data(1,'EGGPLANT LASAGNE','not available',4.0,25,'Main Course');
EXECUTE insert_menu_data(2,'RAMEN','available',2,15,'Main Course');

--ADDING DESSERTS TO THE MENU TABLE
EXECUTE insert_menu_data(2,'APPLE PIE WITH CREAM','available',4.8,18,'DESSERT');
EXECUTE insert_menu_data(1,'FRUIT SALAD','available',3,13,'DESSERT');
EXECUTE insert_menu_data(1,'STRAWBERRY PIE','available',4,25,'DESSERT');
EXECUTE insert_menu_data(2,'GULAB JAMUN','available',5,10,'DESSERT');
EXECUTE insert_menu_data(1,'WAFFLE ','available',4,15,'DESSERT');
EXECUTE insert_menu_data(1,'CHOCOLATE CHEESECAKE','not available',4.5,15,'DESSERT');

--ADDING BEVERAGE TO THE MENU TABLE
EXECUTE insert_menu_data(1,'SPARKLING WATER','available',4.2,18,'BEVERAGE');
EXECUTE insert_menu_data(1,'SODA','available',4.8,18,'BEVERAGE');
EXECUTE insert_menu_data(2,'DIET SODA','available',4.8,18,'BEVERAGE');
EXECUTE insert_menu_data(2,'ENERGY DRINK','available',4.8,18,'BEVERAGE');
EXECUTE insert_menu_data(1,'ESPRESSO','available',4.5,20,'BEVERAGE');
EXECUTE insert_menu_data(1,'HOT CHOCOLATE','not available',4.0,8,'BEVERAGE');


-----------------------------------------------------------------------------------------------

-- INSERTING DATA INTO CART ENTITY
EXECUTE insert_cart_data(2, 3, 1, 1, 0, 7.5, 2);
EXECUTE insert_cart_data(5, 2, 2, 2, 0, 8.5, 3);
EXECUTE insert_cart_data(18, 1, 2, 16, 0, 10, 4);
EXECUTE insert_cart_data(1, 1, 2, 7, 0, 17, 1);
EXECUTE insert_cart_data(15, 9, 1, 14, 3, 13, 4);
EXECUTE insert_cart_data(16, 6, 1, 6, 0, 12, 1);
EXECUTE insert_cart_data(17, 10, 1, 20, 5, 18, 5);
EXECUTE insert_cart_data(9, 7, 1, 4, 0, 6.5, 2);
EXECUTE insert_cart_data(7, 3, 1, 6, 4, 12, 1);
EXECUTE insert_cart_data(12, 1, 1, 19, 0, 18, 4);
EXECUTE insert_cart_data(18, 1, 2, 21, 0, 18, 1);
EXECUTE insert_cart_data(8, 6, 2, 16, 0, 10, 3);
EXECUTE insert_cart_data(2, 3, 1, 4, 0, 6.5, 3);
EXECUTE insert_cart_data(18, 1, 2, 13, 0, 18, 2);
EXECUTE insert_cart_data(1, 1, 2, 16, 0, 10, 4);
EXECUTE insert_cart_data(2, 3, 1, 19, 0, 18, 1);
EXECUTE insert_cart_data(3, 7, 2, 2, 0, 8.5, 3);
EXECUTE insert_cart_data(19, 4, 2, 7, 0, 17, 3);
EXECUTE insert_cart_data(17, 10, 1, 1, 4, 7.5, 2);
EXECUTE insert_cart_data(8, 6, 2, 7, 0, 17, 1);
EXECUTE insert_cart_data(11, 5, 2, 22, 2, 18, 3);
EXECUTE insert_cart_data(4, 5, 2, 21, 4, 18, 6);
EXECUTE insert_cart_data(4, 5, 2, 12, 2, 15, 2);
EXECUTE insert_cart_data(8, 6, 2, 22, 0, 18, 5);
EXECUTE insert_cart_data(1, 1, 2, 21, 0, 18, 4);
EXECUTE insert_cart_data(1, 1, 2, 13, 0, 18, 2);
EXECUTE insert_cart_data(13, 3, 2, 21, 5, 18, 4);
EXECUTE insert_cart_data(24, 14, 2, 22, 4, 18, 2);
EXECUTE insert_cart_data(24, 14, 2, 13, 4, 18, 1);
EXECUTE insert_cart_data(14, 10, 2, 3, 0, 9.5, 4);
EXECUTE insert_cart_data(15, 9, 1, 10, 1, 22, 1);
EXECUTE insert_cart_data(12, 1, 1, 14, 0, 13, 2);
EXECUTE insert_cart_data(18, 1, 2, 7, 0, 17, 3);
EXECUTE insert_cart_data(3, 7, 2, 7, 0, 17, 1);
EXECUTE insert_cart_data(6, 1, 1, 1, 0, 7.5, 3);
EXECUTE insert_cart_data(11, 5, 2, 7, 3, 17, 4);
EXECUTE insert_cart_data(4, 5, 2, 7, 4, 17, 3);
EXECUTE insert_cart_data(22, 12, 1, 4, 4, 6.5, 1);
EXECUTE insert_cart_data(23, 13, 1, 15, 3, 15, 2);
EXECUTE insert_cart_data(24, 14, 2, 2, 3, 8.5, 2);
EXECUTE insert_cart_data(6, 1, 1, 14, 0, 13, 4);
EXECUTE insert_cart_data(22, 12, 1, 20, 3, 18, 1);
EXECUTE insert_cart_data(23, 13, 1, 4, 5, 6.5, 2);
EXECUTE insert_cart_data(13, 3, 2, 2, 4, 8.5, 2);
EXECUTE insert_cart_data(25, 15, 1, 14, 4, 13, 1);
EXECUTE insert_cart_data(25, 15, 1, 19, 2, 18, 2);
EXECUTE insert_cart_data(4, 5, 2, 13, 5, 18, 2);
EXECUTE insert_cart_data(9, 7, 1, 17, 0, 15, 2);
EXECUTE insert_cart_data(10, 5, 2, 16, 0, 10, 1);
EXECUTE insert_cart_data(7, 3, 1, 8, 3, 18, 2);
EXECUTE insert_cart_data(20, 10, 1, 5, 3, 13, 3);
EXECUTE insert_cart_data(21, 11, 2, 2, 4, 8.5, 4);
EXECUTE insert_cart_data(25, 15, 1, 5, 3, 13, 1);
EXECUTE insert_cart_data(22, 12, 1, 17, 2, 4, 1);
EXECUTE insert_cart_data(26, 12, 2, 2, 3, 8.5, 1);


-----------------------------------------------------------------------------------------------

-- INSERTING INTO DELIVERY ENTITY
EXECUTE insert_delivery_data(3, 2, 7, 8, 'Out For Delivery');
EXECUTE insert_delivery_data(13, 2, 3, 10, 'Delivered');
EXECUTE insert_delivery_data(11, 2, 5, 1, 'Delivered');
EXECUTE insert_delivery_data(14, 2, 10, 4, 'Out For Delivery');
EXECUTE insert_delivery_data(7, 1, 3, 1, 'Delivered');
EXECUTE insert_delivery_data(8, 2, 6, 6, 'Out For Delivery');
EXECUTE insert_delivery_data(17, 1, 10, 6, 'Delivered');
EXECUTE insert_delivery_data(4, 2, 5, 10, 'Delivered');
EXECUTE insert_delivery_data(15, 1, 9, 6, 'Delivered');
EXECUTE insert_delivery_data(19, 1, 10, 1, 'Delivered');
EXECUTE insert_delivery_data(21, 2, 11, 14, 'Out For Delivery');



-----------------------------------------------------------------------------------------------

-- INSERTING INTO COUPON ENTITY
EXECUTE insert_coupon_data('SILVER', 30, 50, 'ACTIVE', 0.1);
EXECUTE insert_coupon_data('GOLD', 50, 100, 'ACTIVE', 0.2);
EXECUTE insert_coupon_data('PLATINUM', 100, 300, 'ACTIVE', 0.3);


/*
 SELECT * FROM DELIVERY_AGENT;
 SELECT * FROM MANAGER;
 SELECT * FROM RESTAURANT;
 SELECT * FROM CUSTOMER;
 SELECT * FROM ORDERS;
 SELECT * FROM MENU;
 SELECT * FROM CART;
 SELECT * FROM DELIVERY;
 SELECT * FROM COUPON;
*/



/*
select * from vw_dish_sales;
select * from vw_top_10_dishes;
select * from vw_top_10_customers;
select * from vw_monthly_sales;
select * from vw_top_delivery_person;
select * from vw_delivery_agent_ratings;
select * from vw_restaurant_service_ratings;
select * from vw_delivery_agent_status;
select * from vw_active_orders;
select * from vw_completed_orders;
select * from vw_cancelled_orders;
select * from vw_all_orders;
select * from vw_customer_order_address;
select * from vw_menu;
select * from vw_coupons;
select * from vw_restaurants;
*/

grant create session to CUSTOMER_USER;
grant create session to MANAGER_USER;
grant create session to DELIVERY_AGENT_USER;

--customer table
grant select, insert, update on food_ordering_admin.customer to CUSTOMER_USER;
grant select on food_ordering_admin.menu to CUSTOMER_USER;
grant select, update on food_ordering_admin.cart to CUSTOMER_USER;
grant select, insert, update on food_ordering_admin.orders to CUSTOMER_USER;
grant select on food_ordering_admin.coupon to CUSTOMER_USER;

--customer views
grant select on food_ordering_admin.vw_restaurants to CUSTOMER_USER;
grant select on food_ordering_admin.vw_coupons to CUSTOMER_USER;
grant select on food_ordering_admin.vw_restaurant_service_ratings to CUSTOMER_USER;
grant select on food_ordering_admin.vw_delivery_agent_ratings to CUSTOMER_USER;


--customer procedures
grant execute on food_ordering_admin.welcome_customer_page to CUSTOMER_USER;
grant execute on food_ordering_admin.get_menu to CUSTOMER_USER;
grant execute on food_ordering_admin.get_mycart to CUSTOMER_USER;
grant execute on food_ordering_admin.get_bill to CUSTOMER_USER;
grant execute on food_ordering_admin.register_customer to CUSTOMER_USER;
grant execute on food_ordering_admin.delivery_service_feedback to CUSTOMER_USER;
grant execute on food_ordering_admin.restaurant_service_feedback to CUSTOMER_USER;
grant execute on food_ordering_admin.feedback_page to CUSTOMER_USER;
grant execute on food_ordering_admin.give_dish_rating to CUSTOMER_USER;
grant execute on food_ordering_admin.make_payment to CUSTOMER_USER;
grant execute on food_ordering_admin.numbercheck to CUSTOMER_USER;
grant execute on food_ordering_admin.login_customer to CUSTOMER_USER;
grant execute on food_ordering_admin.create_order to CUSTOMER_USER;
grant execute on food_ordering_admin.add_to_cart to CUSTOMER_USER;
grant execute on food_ordering_admin.remove_cart_item to CUSTOMER_USER;
grant execute on food_ordering_admin.clear_cart to CUSTOMER_USER;
grant execute on food_ordering_admin.remove_coupon to CUSTOMER_USER;
grant execute on food_ordering_admin.calculate_bill to CUSTOMER_USER;
grant execute on food_ordering_admin.check_order_status to CUSTOMER_USER;
grant execute on food_ordering_admin.apply_coupon to CUSTOMER_USER;
grant execute on food_ordering_admin.remove_coupon to CUSTOMER_USER;
grant execute on food_ordering_admin.update_customer to CUSTOMER_USER;
grant execute on food_ordering_admin.cancel_order to CUSTOMER_USER;


--manager table
grant select, insert, update on food_ordering_admin.menu to MANAGER_USER;
grant select, insert, update on food_ordering_admin.coupon to MANAGER_USER;
grant select, insert, update on food_ordering_admin.restaurant to MANAGER_USER;
grant select, insert, update on food_ordering_admin.orders to MANAGER_USER;
grant select, insert, update on food_ordering_admin.delivery to MANAGER_USER;

--manager views
grant select on food_ordering_admin.vw_dish_sales to MANAGER_USER;
grant select on food_ordering_admin.vw_top_10_dishes to MANAGER_USER;
grant select on food_ordering_admin.vw_top_10_customers to MANAGER_USER;
grant select on food_ordering_admin.vw_monthly_sales to MANAGER_USER;
grant select on food_ordering_admin.vw_top_delivery_person to MANAGER_USER;
grant select on food_ordering_admin.vw_delivery_agent_ratings to MANAGER_USER;
grant select on food_ordering_admin.vw_restaurant_service_ratings to MANAGER_USER;
-----
grant select on food_ordering_admin.vw_delivery_agent_status to MANAGER_USER;
grant select on food_ordering_admin.vw_active_orders to MANAGER_USER;
grant select on food_ordering_admin.vw_completed_orders to MANAGER_USER;
grant select on food_ordering_admin.vw_cancelled_orders to MANAGER_USER;
grant select on food_ordering_admin.vw_all_orders to MANAGER_USER;
grant select on food_ordering_admin.vw_menu to MANAGER_USER;
grant select on food_ordering_admin.vw_restaurants to MANAGER_USER;

--manager procedures
grant execute on food_ordering_admin.assign_delivery_guy to MANAGER_USER;
grant execute on food_ordering_admin.change_order_status to MANAGER_USER;

grant execute on food_ordering_admin.refund to MANAGER_USER;
grant execute on food_ordering_admin.update_menu to MANAGER_USER;
grant execute on food_ordering_admin.update_coupon to MANAGER_USER;

----------
grant execute on food_ordering_admin.welcome_manager_page to MANAGER_USER;
grant execute on food_ordering_admin.update_manager to MANAGER_USER;
grant execute on food_ordering_admin.login_manager to MANAGER_USER;

--delivery agent table
grant select, update, insert on food_ordering_admin.delivery_agent to DELIVERY_AGENT_USER;
grant select, update on food_ordering_admin.delivery to DELIVERY_AGENT_USER;

--delivery agent views
grant select on food_ordering_admin.vw_customer_order_address to DELIVERY_AGENT_USER;

------ delivery_agent procedures
grant execute on food_ordering_admin.welcome_delivery_agent_page to DELIVERY_AGENT_USER;
grant execute on food_ordering_admin.update_delivery_data to DELIVERY_AGENT_USER;
grant execute on food_ordering_admin.update_deliveryagent to DELIVERY_AGENT_USER;
grant execute on food_ordering_admin.login_delivery_agent to DELIVERY_AGENT_USER;
