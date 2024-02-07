USE my_guitar_shop;
-- **************************************Problem 1*************************************************
-- 								Select all customers from the data table
SELECT * FROM customers;
-- **************************************Problem 2*************************************************
-- 								Select first name and email adress
SELECT first_name, email_address FROM customers
-- **************************************Problem 3*************************************************
-- 								Order by first name in ascending order
ORDER BY first_name
-- **************************************Problem 4*************************************************
-- 								Show only the first five rows
LIMIT 5;
-- **************************************Problem 5*************************************************
-- Write query that will produce the following result for the people who have name Allan, Allan email-adress is allan.sherwood@yahoo.com 
SELECT concat(first_name, '\'s email is ', email_address) as result FROM customers
WHERE LOWER(first_name) = 'allan';
-- **************************************Problem 6*************************************************
-- 		Select all data from Order_Items table such that item_price - discount_amount > 1000
SELECT * FROM Order_Items
WHERE item_price - discount_amount > 1000;
-- **************************************Problem 7*************************************************
-- 		Find products that have product name starting with "Gibson" and product code is "sg" 
SELECT * FROM products
WHERE product_code = 'sg' and product_name LIKE '%Gibson%';
-- **************************************Problem 8*************************************************
-- 				Find products with the following product codes : strat, sg, washburn 
SELECT * FROM products
WHERE product_code IN('strat','sg','washburn');
-- **************************************Problem 9*************************************************
-- 				Find products that dont have the following product codes : strat, sg, washburn 
SELECT * FROM products
WHERE product_code NOT IN('strat','sg','washburn');
-- **************************************Problem 10*************************************************
-- 							Find all orders that have no ship date set
SELECT * FROM orders
WHERE ship_date IS NULL;
-- **************************************Problem 11*************************************************
-- 			Write a SQL statement that selects from Products table the following information:
-- 			product_name, The product_name column, list_price, The list_price column
-- 			The two columns should be joined into 1 column
-- 			Find all the products that contain word “Gibson”.

SELECT CONCAT(product_name,': ' ,list_price) as product_and_price FROM products
WHERE product_name LIKE '%Gibson%';
-- **************************************Problem 12*************************************************
-- 				Write a SQL statement that selects these columns from the Orders table:
-- 								order_id	The order_id column
-- 								ship_amount	The ship_amount column
-- 								tax_amount	The tax_amount column
-- 				Round the ship_amount and tax_amount columns rounded to 0 decimal places.
-- 		Return only the rows with a ship_amount that is greater than 5 and tax_amount is less than 80.

SELECT order_id, ROUND(ship_amount, 0) AS ship_amount , ROUND(tax_amount, 0) AS tax_amount FROM orders
WHERE ship_amount > 5 and tax_amount < 80;
-- **************************************Problem 13*************************************************
-- 				Write a SQL statement that selects these columns from the Products table:
-- 						product_name	The product_name column
-- 						list_price	The list_price column
-- 						discount_percent	The discount_percent column
-- 						discount_amount	A column that’s calculated from the previous two columns
-- 						discount_price	A column that’s calculated from the previous three columns
-- 				Only return products with list_price greater than 200 and less than 800
-- 				Sort it by product_name in descending sequence.

SELECT product_name, list_price, discount_percent, 
	   list_price * (discount_percent / 100) AS discount_amount, 
       list_price - (list_price * (discount_percent / 100)) AS discount_price 
FROM products
WHERE list_price > 200 and list_price < 800
ORDER BY product_name Desc;
-- **************************************Problem 14*************************************************
-- 				Write a SQL statement that selects these columns from the Order_Items table:
-- 						item_id 	The item_id column
-- 						item_price	The item_price column
-- 						discount_amount	The discount_amount column
-- 						quantity	The quantity column
-- 						price_total	A column that’s calculated by multiplying the item price by the quantity
-- 						discount_total	A column that’s calculated by multiplying the discount amount by the quantity
-- 						item_total	A column that’s calculated by subtracting the discount amount from the item price and then multiplying by the quantity
-- 				Only return rows where the item_total is greater than 455.
-- 				Sort the result set by item total in descending sequence.

SELECT item_id, item_price, discount_amount, quantity,
	   item_price*quantity AS price_total,
       (item_price - discount_amount) * quantity AS item_total
FROM order_items
WHERE (item_price - discount_amount) * quantity > 455
ORDER BY item_total Desc;
-- **************************************Problem 15*************************************************
-- 			  Write a SQL statement that selects these columns from the Orders table:
-- 						order_id	  The order_id column
-- 						order_date	The order_date column
-- 						ship_amount	The ship_amount column
-- 						ship_date	The ship_date column
-- 							Round the ship_amount to 1 decimal place.
-- 					Only return data where ship_date doesn’t contain null.
-- 								Limit results to 5 rows.

SELECT order_id, order_date, ROUND(ship_amount, 1), ship_date FROM orders
WHERE ship_date IS NOT NULL
LIMIT 5;
-- **************************************Problem 16*************************************************
-- Write a SQL statement without a FROM clause that uses the NOW function to create a row with these columns:
-- today_unformatted	The NOW function unformatted
-- today_formatted	The NOW function in this format: 'MM/DD/YYYY’

SELECT NOW() AS today_unformatted, DATE_FORMAT(NOW(), '%m/%d/%y') AS today_formatted;
-- **************************************Problem 17*************************************************
-- Write a SQL SELECT statement without a FROM clause that creates a row with these columns:
-- Item_price	10 (10 dollars)
-- Discount_percent	.25 (25 percent)
-- Discount_amount	Item_price multiplied by Discount_percent
-- Final_price  	Item_price  minus (Item_price multiplied by Discount_percent) 

-- To calculate the third column, add the expressions you used for the first and third 
-- Note: reuse the expression copy paste, aliasing will not work

SELECT 10 AS Item_price, 0.25 AS Discount_percent,
    10 * 0.25 AS Discount_amount,
    10 - (10 * 0.25) AS Final_price;

-- **********************************************END************************************************






