set serveroutput on;
--welcome manager page
execute food_ordering_admin.welcome_manager_page;

-- LOGIN PROCEDURE
--INVALID USERNAME
exec food_ordering_admin.LOGIN_MANAGER('abc','FAIDO$1231');
--INVALID PASSWORD
exec food_ordering_admin.LOGIN_MANAGER('HIMANI','1');
--USERNAME NULL
exec food_ordering_admin.LOGIN_MANAGER('','pathak123');
--PASSWORD NULL
exec food_ordering_admin.LOGIN_MANAGER('HIMANI',NULL);
--LOGIN SUCCESSFUL
exec food_ordering_admin.LOGIN_MANAGER('HIMANI','THAKKER@123');

-- UPDATE_MENU: DISH_ID, DISH_NAME, DISH_STATUS, RESTAURANT_ID, PRICE, CATEGORY
--UPDATE_MENU PROCEDURE
-- Null check
execute food_ordering_admin.update_menu(NULL,'Pizza','Available',1,10,'Beverage');
-- Check for dish status in 'available' or 'not available'
execute food_ordering_admin.update_menu(1,'Pizza','Active',1,10,'Appetizer');
-- Check for dish category in APPETIZER, MAIN COURSE, DESSERT, OR BEVERAGE
execute food_ordering_admin.update_menu(1,'Pizza','available',1,10,'Starters');
-- Updating MENU SUCCESSFULLY
execute food_ordering_admin.update_menu(1,'Pizza','available',1,10,'Appetizer');

-- UPDATE_COUPON: COUPON_NAME, LOWER_RANGE, UPPER_RANGE, ACTIVITY_STATUS, DISCOUNT_VALUE
--UPDATE_COUPON PROCEDURE
-- Null check
execute food_ordering_admin.update_coupon(NULL,10,50,'Active',0.4);
execute food_ordering_admin.update_coupon('HAPPY10',NULL,50,'Active',100);

-- updating coupon successfully
execute food_ordering_admin.update_coupon('platinum',120,500,'Active',0.4);

-- adding new coupon
execute food_ordering_admin.update_coupon('BOGO',200,500,'Active',0.5);

-- CHANGE_ORDER_STATUS: MANAGER_ID, ORDER_ID, CHANGED_STATUS

-- REFUND: ORDER_ID, CUST_ID
--invalid order id
execute food_ordering_admin.refund(10,5);
commit;
--successful refund
execute food_ordering_admin.refund(12,1);
commit;

---ASSIGN_DELIVERY_GUY: MANAGER_ID, ORDER_ID
-- ASSIGN A DELIVERY AGENT
EXECUTE food_ordering_admin.assign_delivery_guy(2,18);

-- ORDER STATUS SHOULD BE PREPARING OR DELAY IN DELIVERY
EXECUTE food_ordering_admin.assign_delivery_guy(1,6);

-- INCORRECT MANAGER_ID
EXECUTE food_ordering_admin.assign_delivery_guy(1,18);

-- DELIVERY GUY ALREADY ASSIGNED
EXECUTE food_ordering_admin.assign_delivery_guy(2,1);

-- ORDER NOT YET PLACED
EXECUTE food_ordering_admin.assign_delivery_guy(1,2);

--- UPDATE_MANAGER : MANAGER_ID, MANAGER_USERNAME, MANAGER_PASSWORD
-- SUCCESSFULLY CHANGING THE CUSTOMER PASSWORD
EXECUTE food_ordering_admin.UPDATE_MANAGER(1, 'PRATHAMESH', 'FA$12');

-- INVALID CUSTOMER PASSWORD LENGTH
EXECUTE food_ordering_admin.UPDATE_MANAGER(1, 'PRATHAMESH', 'FAIDO$1231');

-- INVALID MANAGER ID OR USERNAME
EXECUTE food_ordering_admin.UPDATE_MANAGER(1, NULL, 'FAIDO$1231');

