SET SQL_SAFE_UPDATES= 1;
USE my_guitar_shop; 
-- **********************Problem 1********************************
-- Write an INSERT statement that adds this row to the Category table:
-- category_name:	Brass
-- Code the INSERT statement so MySQL automatically generates the category_id column.
-- ***************************************************************
INSERT INTO categories (category_name) VALUES ('Brass');
-- ************************Problem 2********************************
-- Write an UPDATE statement that modifies the row with category_id 3 in the Categories table. 
-- This statement should change the category_name column to “Tambourines”, 
-- and it should use the category_id column to identify the row.
-- ******************************************************************
UPDATE categories SET category_name = 'Tambourines' WHERE category_id = 3;
-- **************************Problem 3***********************************
-- Write a DELETE statement that deletes the row you added to the Categories table in exercise 1.
-- ***********************************************************************
DELETE FROM categories WHERE category_name = 'Brass' AND category_id = LAST_INSERT_ID();
-- *******************************Problem 4****************************
-- Write an INSERT statement that adds this row to the Administrator table:
-- admin_id:	The next automatically generated ID 
-- email_address:	admin@guitar.com
-- password:	abc1272321abcd823
-- first_name:	John
-- last_name:	Admin.
-- Use a column list for this statement.
-- **********************************************************************
INSERT INTO administrators (email_address, password, first_name, last_name) 
VALUES ('admin@guitar.com', 'abc1272321abcd823', 'John', 'Admin');
-- ***************************Problem 5******************************
-- Write an UPDATE statement that modifies the admin record you added in exercise 4. 
-- This statement should change the last_name column from Admin to Jordan
-- ****************************************************************
UPDATE administrators SET last_name = 'Jordan' WHERE admin_id = LAST_INSERT_ID();
-- ********************Problem 6*****************************
-- Write an INSERT statement that adds this row to the Orders table:
-- customer_id:	2
-- order_date:	'2020-05-04 11:11:11'
-- ship_amount:	5
-- tax_amount:	10
-- ship_date: 	2020-05-06
-- ship_address_id	1
-- card_type	Visa
-- card_number	4111111111111111
-- card_expires	04/2022
-- billing_address_id 	2
-- ***********************************************************
INSERT INTO orders (customer_id, order_date, ship_amount, tax_amount, ship_date, ship_address_id, card_type, card_number, card_expires,billing_address_id)
VALUES (2, '2020-05-04 11:11:11', 5, 10, '2020-05-06', 1, 'Visa', '4111111111111111', '04/2022', 2);
-- ********************Problem 7*****************************
-- Write an UPDATE statement that modifies the Orders table. 
-- Update record by using order_id from record created in #6, 
-- to find that record, update credit card number to 1234567890 and card type to MasterCard
-- ***********************************************************
UPDATE orders
SET card_number = '1234567890', card_type = 'MasterCard'
WHERE order_id = 10;
-- ********************Problem 8*****************************
-- Write an UPDATE statement that modifies the Orders table. 
-- Change all ship amount for order dates after 2015-03-30 15:22:31 to 15.  
-- If you get an error due to safe-update mode, 
-- you can add a LIMIT clause to update the first 100 rows of the table. 
-- (This should update all rows in the table.)
-- ***********************************************************
SET SQL_SAFE_UPDATES = 0;
UPDATE orders SET ship_amount = 15
WHERE order_date = '2015-03-30 15:22:31';
/*

Write at least a few sentences on what you feel are the main learning points in this assignment?
	It is pretty clear that the main points on this assignment is to get comfortable with the UPDATE, INSERT, and DELETE statements.
Additionally, learning the intricacies of each statement and how they could be applied to an existing or new database.

Write at least a  few sentences on, what this assignment covered/what you feel you learned, 
that could be relevant for doing the Midterm Group Project. 
(Note: Your team could find itself even using update and delete statements as side sql work done on the Midterm Group Project even though it's not explicitly required to do so.)
I think even though UPDATE and DELETE are useful, and additionally you say using them as side SQL work done, the INSERT statement is the most useful for the midterm.
As it makes more sense to insert new data into new tables than to update them. I might try to utilize the LAST_INSERT_ID() though. 
I want to make my project flexible to updating one thing will auto update the rest of the dependencies, but currently I have them
manually imputted. With all that being said however, it might be useful to use the UPDATE statement to do so.


 */
