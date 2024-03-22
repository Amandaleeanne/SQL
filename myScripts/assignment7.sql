SET SQL_SAFE_UPDATES = 0;
USE my_guitar_shop; 
/***************************Problem 1***********************************
Create a view named problemOne_view that joins the Customers, Orders, Order_Items, and Products tables. 

This view should have these columns: 
last_name, 
first_name, 
order_date, 
product_name, 
price: calculated item_price minus discount_amount
quantity
Write select statement that selects all columns from the view.
************************************************************************/
CREATE VIEW problemOne_view AS
SELECT c.last_name, c.first_name, o.order_date, p.product_name, (oi.item_price - oi.discount_amount) AS price, oi.quantity
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id;

SELECT * FROM problemOne_view;
/***************************Problem 2***********************************
Using the view from problem 1, 
write an update statement that updates last_name  of the customer that has first name Allan, 
and answer in comments why it works or doesn't. Use your own last name.
************************************************************************/
UPDATE problemOne_view
SET last_name = 'Schock'
WHERE first_name = 'Allan';
SELECT * FROM problemOne_view;
	/* This works because:
    The problemOne view was created on a join, as opposed to selecting all from one table. Therefore, it is only updating the c.last_name column
    where the c.first_name is Allan.
    */

/***************************Problem 3***********************************
Using the view from problem 1, 
write an update statement that updates price to 123 
for the customer that has the first name Alan,  and answer in comments why it works or doesn't.
************************************************************************/
UPDATE problemOne_view
SET price = 123
WHERE first_name = 'Allan';
SELECT * FROM problemOne_view;
	-- This does not work because the price column is calculated with SUM(), and therefore is not settable to a soemthing.

/***************************Problem 4***********************************
Create a view name problemFour_view that has one row for each customer, that has summary of orders data with these columns:
customer_id: customer id
email_address column from the Customers table
Total_ship_amount column that has a sum of all orders ship amounts per customer
Write a select statement that selects all columns from the view.
************************************************************************/
CREATE VIEW problemFour_view AS
SELECT c.customer_id, c.email_address, SUM(o.ship_amount) AS total_ship_amount
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.email_address;
SELECT * FROM problemFour_view;
/***************************Problem 5***********************************
Using the view from problem 4, 
write an update statement that updates the customer email_address to abc@gmail.com 
for customer_id = 1, and answer in comments why it works or doesn't.
************************************************************************/
UPDATE problemFour_view
SET email_adress = 'abc@gmail.com'
WHERE customer_id = 1;
	-- This does not work because the view has a GROUP BY statement, therefore the view is not updateable.
/***************************Problem 6***********************************
Create a view named problemSix_view 
that selects all fields for records from the Products table where the discount_percent > 10. 
Make sure the view is created with the CHECK OPTION
-Create and execute an update through the view problemSix_view  
	where we update product_id 1's discount_percent value to a value that doesn't exclude it from the view.
In comments, explain why it worked.
-Create an execute an update through the view problemSix_view 
	where we update product_id 1's discount_percent value to a value that does exclude it from the view
In comments, explain why it did NOT work.
************************************************************************/
CREATE VIEW problemSix_view AS
	SELECT * FROM products WHERE discount_percent > 10
    WITH CHECK OPTION;
UPDATE problemSix_view
SET discount_percent = 15
WHERE product_id = 1;
	-- This worked because it does not exclude it from the view, therefore the check option allows it
UPDATE problemSix_view
SET discount_percent = 10
WHERE product_id = 1;
-- This does not work because it excludes it from the view, therefore the check option does not allow it

/* 
In both cases, you are creating a completely new line with a bunch of NULL values exept for the specified
discount_percent. Because there is a WITH CHECK OPTION the only queries that will work are those that pass
the inital condition when creating the view. 
*/


/* Thought provoking questions teacher wants us to answer:

	Write at least a few sentences on what you feel are the main learning points in this assignment?
    
		The main learning points of this assignment are to understand and learn how to use views. Additionally, how views can be different from other tables
        as they have some cavets to them; such as in problem six where you must understand that updating a view is also updating the underlying table
        therefore, if you update outside of a view with a CHECK OPTION it will throw an error at you since you can't see the update.
	Write at least a  few sentences on, what this assignment covered/what you feel you learned, that could be relevant for doing the Final Group Project:
    
		I learned alot about views and the basics of how to use them. I belive they will be the most helpful
        in the final group project to update existing tables for a specific problem instead of re-running the code.
        Initally, i thought they would be useful for subqueries, but after playing with them a bit I can see the issues that might arise from such,
        and therefore they should be used sparingly.

*/