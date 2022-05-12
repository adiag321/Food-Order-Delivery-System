set serveroutput on;
--welcome customer page
execute food_ordering_admin.welcome_customer_page;

--register customer with following parameters : username, password, firstname, lastname, phone, apt_no, zip code, street
--wallet balance is assigned as 0 by default
execute food_ordering_admin.register_customer('farhan_akhtar','passiton', 'Farhan', 'Akhtar', 9872826171, 210, 21020, 'Tremont Street');

--user name cannot be a number
execute food_ordering_admin.register_customer(23, 'passiton', 'Phoebe', 'Buffay', 88888885555, 210, 502020, 'Boylston Street');

--phone no length less or more
execute food_ordering_admin.register_customer('phoebe75', 'passiton', 'Phoebe', 'Buffay', 8485555, 210, 502020, 'Boylston Street');
execute food_ordering_admin.register_customer('phoebe75', 'passiton', 'Phoebe', 'Buffay', 848555555555, 210, 502020, 'Boylston Street');

--password length invalid
execute food_ordering_admin.register_customer('phoebe75', 'passiton2022', 'Phoebe', 'Buffay', 8888899555, 210, 502020, 'Park Street');

--zip code length invalid
execute food_ordering_admin.register_customer('phoebe52', 'passiton', 'Phoebe', 'Buffay', 8888899555, 210, 502020, 'Park Street');

--------------------------------
---Login 
--invalid credentials 
execute food_ordering_admin.login_customer(2,'paasiton');
--unsuccessful login
execute food_ordering_admin.login_customer('aditya_sharma','123');
--successful login
execute food_ordering_admin.login_customer('aditya_sharma','sharma123');

--------------------------------
--view restaurants
select * from food_ordering_admin.vw_restaurants;

--------------------------------
--GET MENU
--get menu for restaurant 1
execute food_ordering_admin.get_menu(1);

--get menu for restaurant 2
execute food_ordering_admin.get_menu(2);

--get menu when restaurant input is invalid
execute food_ordering_admin.get_menu(11);

------------------------------------------
--CREATE ORDER : CUSTE_ID, RESTUARANT_ID
execute food_ordering_admin.create_order(1,2);

--rerun for same custID and restuarantID
execute food_ordering_admin.create_order(1,2);

--invalid customed id
execute food_ordering_admin.create_order(111,2);

--invalid restaurant id
execute food_ordering_admin.create_order(1,22);

--create order for a customer who has order in confirmed state
execute food_ordering_admin.create_order(12,1);
-------------------------------------
--ADD_TO_CART : ORDER_ID, CUST_ID, DISH_ID, QUANTITY
--order id cannot be null
EXECUTE food_ordering_admin.ADD_TO_CART('',3,1,3);

--customer id cannot be null
EXECUTE food_ordering_admin.ADD_TO_CART(2,'',1,3);

--dish id cannot be null
EXECUTE food_ordering_admin.ADD_TO_CART(2,3,'',3);

--order id incorrect
EXECUTE food_ordering_admin.ADD_TO_CART(233,3,1,3);

--cannot add this order to cart as order status is other than confirmed
EXECUTE food_ordering_admin.ADD_TO_CART(3,7,1,3);

--dish does not exists
EXECUTE food_ordering_admin.ADD_TO_CART(2,3,55,3);

--trying to add dish with dish status is not available
EXECUTE food_ordering_admin.ADD_TO_CART(2,3,11,3);

--item cannot be added to cart with quantity more than 15
EXECUTE food_ordering_admin.ADD_TO_CART(2,3,10,33);

--quantity cannot be negative
EXECUTE food_ordering_admin.ADD_TO_CART(2,3,10,-33);

--add to cart executed successfully
EXECUTE food_ordering_admin.ADD_TO_CART(27,1,2,3);
commit;

--checking items in cart using GET CART
EXECUTE food_ordering_admin.GET_MYCART(27,1);

--adding more quantity in cart for same dish
EXECUTE food_ordering_admin.ADD_TO_CART(27,1,2,2);
commit;

--checking items in cart using GET CART : quantity incremented
EXECUTE food_ordering_admin.GET_MYCART(27,1);

--REMOVE_CART_ITEM: ORDER_ID, CUST_ID, REST_ID, DISH_ID, QUANTITY
EXECUTE food_ordering_admin.REMOVE_CART_ITEM(27,1,2,2,1);

--checking items in cart using GET CART : quantity decreased
EXECUTE food_ordering_admin.GET_MYCART(27,1);

--test case with invalid orderid
EXECUTE food_ordering_admin.GET_MYCART(67,3);

--test case with invalid custid
EXECUTE food_ordering_admin.GET_MYCART(7,33);

--test case with order id cannot be null
EXECUTE food_ordering_admin.GET_MYCART('',33);

--test case with cust id cannot be null
EXECUTE food_ordering_admin.GET_MYCART(7,'');

-- test case to remove item quantity from the cart
EXECUTE food_ordering_admin.REMOVE_CART_ITEM(5,2,2,2,1);

-- test case to check if user tries to remove items more than item quantity from the cart
EXECUTE food_ordering_admin.REMOVE_CART_ITEM(5,2,2,2,4);

-- test case to check orderid cannot be null
EXECUTE food_ordering_admin.REMOVE_CART_ITEM('',2,2,2,4);

-- test case to check custid cannot be null
EXECUTE food_ordering_admin.REMOVE_CART_ITEM(5,'',2,2,4);

--test case to check dishid cannot be null
EXECUTE food_ordering_admin.REMOVE_CART_ITEM(5,2,'',2,4);

--test case to check dishid cannot be null
EXECUTE food_ordering_admin.REMOVE_CART_ITEM(5,2,2,'',4);

--test case to check quantity cannot be null
EXECUTE food_ordering_admin.REMOVE_CART_ITEM(5,2,2,2,'');

-- CLEAR_CART: ORDER_ID, CUST_ID
----clear cart for this order id and cust id
execute food_ordering_admin.CLEAR_CART(2,3);
SELECT * FROM food_ordering_admin.CART WHERE CUST_ID=3;

--cart with no items then this will show exception
execute food_ordering_admin.CLEAR_CART(2,3);

--order id cannot be null
execute food_ordering_admin.CLEAR_CART('',3);

--customer id cannot be null
execute food_ordering_admin.CLEAR_CART(2,'');

--cart cannot be emptied as order is confirmed and gone ahead with the processesing
execute food_ordering_admin.CLEAR_CART(1,1);

--order id cannot be incorrect
execute food_ordering_admin.CLEAR_CART(1,2);

----------------------------------------------------
-- APPLYING & REMOVING COUPON
-- APPLY_COUPON: ORDER_ID, COUPON_NAME
SELECT * FROM food_ordering_admin.VW_COUPONS;
-- APPLYING COUPON FOR N/A ORDER
UPDATE food_ordering_admin.ORDERS
SET COUPON_NAME = 'N/A'
WHERE ORDER_ID = 2;
select * from food_ordering_admin.orders;
EXECUTE food_ordering_admin.APPLY_COUPON(2, 'SILVER');

-- COUPON ALREADY APPLIED
EXECUTE food_ordering_admin.APPLY_COUPON(2, 'GOLD');

-- COUPON IS NULL
EXECUTE food_ordering_admin.APPLY_COUPON(3, '');

-- COUPON CANNOT BE APPLIED (ORDER IS PLACED)
EXECUTE food_ordering_admin.APPLY_COUPON(5, 'GOLD');

-- INVALID COUPON
EXECUTE food_ordering_admin.APPLY_COUPON(2, 'GOLD_1');

-- COUPON OUT OF RANGE
EXECUTE food_ordering_admin.APPLY_COUPON(5, 'PLATINUM');

----------------------------------------------
-- REMOVE_COUPON PROCEDURE : ORDER_ID, CUST_ID
-- for COUPON ='N/A'
EXECUTE food_ordering_admin.REMOVE_COUPON(2,3);

-- REMOVING COUPON SUCCESSFULLY
EXECUTE food_ordering_admin.REMOVE_COUPON(1,1);

-- REMOVING COUPON FOR DELIVERED ORDER
EXECUTE food_ordering_admin.REMOVE_COUPON(7,3);
select * from food_ordering_admin.orders;

----------------------------
--GET BILL : ORDER ID
--GET BILL TEST CASE
--get bill for order_id=1
EXECUTE food_ordering_admin.GET_BILL(1);
--invalid order id
EXECUTE food_ordering_admin.GET_BILL(89);

--------------
--MAKE PAYMENT: ORDERID, MODE OF PAYMENT
--- MAKE PAYMENT
-- CHANGE PAYMENT STATUS, rerun for payment already done
EXECUTE food_ordering_admin.make_payment(10, 'CREDIT CARD');

SELECT * FROM food_ordering_admin.ORDERS WHERE ORDER_ID=10;

-- ORDER ID DOES NOT EXISTS
EXECUTE food_ordering_admin.make_payment(287, 'WALLET');

-- WALLET BALANCE NOT SUFFICIENT
EXECUTE food_ordering_admin.make_payment(3, 'WALLET');

-- INVALID PAYMENT SELECTED
EXECUTE food_ordering_admin.make_payment(7, 'DEBIT');

------------------------------------
--CHECK ORDER STATUS :  CUST_ID, ORDER_ID
--order id null
EXECUTE food_ordering_admin.CHECK_ORDER_STATUS(NULL,1);

-- customer id null
EXECUTE food_ordering_admin.CHECK_ORDER_STATUS(1,NULL);

-- order does not exists
EXECUTE food_ordering_admin.CHECK_ORDER_STATUS(27,27);

-- check order status for order in cart
EXECUTE food_ordering_admin.CHECK_ORDER_STATUS(1,1);

-- check order status
EXECUTE food_ordering_admin.CHECK_ORDER_STATUS(3,7);

----------------------------------------
--FEEDBACK : CUST ID, ORDER ID
SELECT  * FROM FOOD_ORDERING_ADMIN.orders;
---successful feedback page
EXECUTE food_ordering_admin.feedback_page(3,7);

---wrong input
EXECUTE food_ordering_admin.feedback_page(null,3);

-------------------------------
--DELIVERY_SERVICE_FEEDBACK : CUST_ID, ORDER_ID, RATING
-- GIVING RATING FOR OUT FOR DELIVERY ORDER
EXECUTE food_ordering_admin.delivery_service_feedback(5, 4, 3);

-- RATING ONLY AFTER ORDER IS DELIVERED
EXECUTE food_ordering_admin.delivery_service_feedback(1, 1, 3);

-- INVALID RATING
EXECUTE food_ordering_admin.delivery_service_feedback(5, 4, 10);

-- RATING IS ALREADY GIVEN
EXECUTE food_ordering_admin.delivery_service_feedback(3, 13, 1);

-- RATING SHOULD BE A NUMBER INPUT
EXECUTE food_ordering_admin.delivery_service_feedback(11, 21, 'A');

---------------------------------------------
--RESTUARANT_SERVICE_FEEDBACK : CUST_ID, ORDER_ID, RATING
--SUCCESSFUL RATING
EXECUTE food_ordering_admin.RESTAURANT_SERVICE_FEEDBACK(5, 4, 3);
SELECT * FROM food_ordering_admin.ORDERS;

-- RATING ONLY AFTER ORDER IS DELIVERED
EXECUTE food_ordering_admin.RESTAURANT_SERVICE_FEEDBACK(1, 1, 3);

-- INVALID RATING
EXECUTE food_ordering_admin.RESTAURANT_SERVICE_FEEDBACK(5, 4, 10);

-- RATING IS ALREADY GIVEN
EXECUTE food_ordering_admin.RESTAURANT_SERVICE_FEEDBACK(3, 13, 1);

-- RATING SHOULD BE A NUMBER INPUT
EXECUTE food_ordering_admin.RESTAURANT_SERVICE_FEEDBACK(11, 21, 'A');

---------------------------
---- GIVE DISH RATING : CUST_ID, ORDER_ID, DISH_ID, RATING
-- RATING FOR THIS DISH_ID IS ALREADY GIVEN
EXECUTE food_ordering_admin.give_dish_rating(9, 15, 10, 1);

-- PROVIDE RATING ONLY AFTER ORDER DELIVERED
EXECUTE food_ordering_admin.give_dish_rating(1, 1, 21, 1);

-- GIVE RATING FOR DELIVERED ORDERS
EXECUTE food_ordering_admin.give_dish_rating(7, 9, 17, 3);

-- INVALID DISH RATING
EXECUTE food_ordering_admin.give_dish_rating(9, 15, 10, ' ');

-- SHOULD BE NUMBER INPUT
EXECUTE food_ordering_admin.give_dish_rating(9, 15, 10, 'O');

SELECT * FROM food_ordering_admin.CART
--------------------------------