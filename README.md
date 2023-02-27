# <p align = 'center'> FOOD ORDER DELIVERY SYSTEM </p>


## OBJECTIVES

1. To increase efficiency and improve services provided by the restaurant by streamlining the process of online ordering and delivery.
2. Will allow restaurant owners to edit and display a restaurant's menu using the Food ordering system.
3. Keeping track of customer orders and deliveries.
4. To keep track of restaurant sales for analysis purposes.
5. To analyze the most popular dishes in the restaurant.
6. To keep track of regular customers.
7. To enable customers to have visual confirmation that the order was placed correctly.
8. Eliminate paperwork and increase accuracy, speed of service, sales volume, and customer satisfaction.


## PROBLEM STATEMENT

1. The restaurant finds it difficult to quickly manage online orders, further causing a discrepancy in data.
2. There is a need for an automated food ordering system to ease the process of handling customer orders, tracking restaurant sales, and checking on food deliveries, which will, in turn, help the restaurant manage online orders efficiently.

## PROPOSED SOLUTION

1. Whenever a new customer is registered a new CUST_ID will be generated to uniquely identify that customer. Likewise, we have separate tables MANAGER and DELIVERY_AGENT which will be specific to manager and delivery agent respectively.
2. Using our database design, the Manager can obtain all the Customer order details, Menu details and Feedback details which we have defined as separate entities. Thus, the Manager can retrieve all the Customer and Menu details and update them with ease.
3. We have defined the entities in a way that whenever a transaction in PAYMENT table is complete, order data is inserted into ORDERS table with a PRIMARY key ORDER_ID that uniquely identifies each order.
4. The 3 entities – ORDER, DELIVERY and DELIVERY_AGENT are linked in such a way that whenever an order is placed, ORDER_STATUS field is updated in ORDER table, and a delivery agent is assigned to that order in the DELIVERY table.
5. Once the food is delivered, Delivery Agent has access to change DELIVERY_STATUS in Delivery table which in turn will update ORDER_STATUS to “Completed” in ORDER table. This is possible by using keys
ORDER_ID and DELIVERY_ID.
6. We have used the ORDER_ID as a PRIMARY key in Payments table and as FOREIGN key in the ORDERS
table to find sales of restaurant effectively.
7. The entity CUST_WALLET is introduced to enhance the Payment functionality. Along with regular card
payment, customers can use points in the CUST_WALLET as and when required.


## VIEWS

We have created 16 views out of which the top 5 are shown below:

1. VW_DISH_SALES:
This view will show the sales of all dishes made by the restaurant.

2. VW_TOP_10_DISHES:
This view will show the top 10 most selling dishes.

3. VW_TOP_10_CUSTOMERS:
This view will show the restaurant's 10 most frequent customers.

4. VW_MONTHLY_SALES:
This view will show the monthly sales of the restaurant.

5. VW_TOP_DELIVERY_PERSON:
This view will show the delivery person with the highest delivery rating.


## ENTITY RELATIONSHIP (ER) DIAGRAM

![image](https://i.imgur.com/WH6GLRd.png)
