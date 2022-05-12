set serveroutput on;
--welcome manager page
execute food_ordering_admin.welcome_delivery_agent_page;

-- LOGIN PROCEDURE
--successfull login
exec food_ordering_admin.LOGIN_DELIVERY_AGENT('RAJ','RAJ@123');

--invalid username
exec food_ordering_admin.LOGIN_DELIVERY_AGENT('dd','ffdf');

--null username
exec food_ordering_admin.LOGIN_DELIVERY_AGENT('','ffdf');

--null password
exec food_ordering_admin.LOGIN_DELIVERY_AGENT('RAJ','');

-- UPDATE_DELIVERY_DATE: ORDER_ID, AGENT_ID
-- execute statement for updating delivery status
--
exec food_ordering_admin.update_delivery_data(3,8);
COMMIT;

SELECT * FROM food_ordering_admin.DELIVERY

--orderid cannot be null
exec food_ordering_admin.update_delivery_data('',8);

--invalid orderid and delivery agent
exec food_ordering_admin.update_delivery_data(12,45);

--UPDATE_DELIVERYAGENT: AGENT_ID, AGENT_USERNAME, AGENT_PASSWORD, AGENT_STATUS
-- SUCCESSFULLY UPDATING THE DELIVERY_AGENT STATUS
EXECUTE food_ordering_admin.UPDATE_DELIVERYAGENT(1, 'RAJ', 'RAJ@123', 'AVAILABLE');

-- INVALID AGENT_ID OR USERNAME
EXECUTE food_ordering_admin.UPDATE_DELIVERYAGENT(12, 'RAJ', 'RAJ@123', 'AVAILABLE');

-- INVALID AGENT_STATUS
EXECUTE food_ordering_admin.UPDATE_DELIVERYAGENT(12, 'RAJ', 'RAJ@123', 'AVAILABLE ');

-- VIEW: CHECK CUSTOMER ORDER ADDRESS
SELECT * FROM food_ordering_admin.VW_CUSTOMER_ORDER_ADDRESS;