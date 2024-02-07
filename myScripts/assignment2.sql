USE my_gutair_shop; 
-- ****************************************************Problem 1:************************************************************
-- *	Write a SELECT statement that inner joins the Categories table to the Products table and returns these columns: 
-- *    category_name, product_name, list_price. Use the Implicit Syntax for an Inner Join to join between the tables.
-- *    Sort the result set in ascending order by the fields category_name and product_name. 
-- *    Note that the default ordering is by ascending order, but we want to explicitly specify it using the keyword ASC.
-- *************************************************************************************************************************
SELECT category_name, product_name, list_price 
FROM categories, products
WHERE categories.category_id = products.category_id
ORDER BY category_name ASC, product_name ASC;


-- ****************************************************Problem 2:************************************************************
--  	Write a SELECT statement that inner joins the Products table to the Order_Items and returns these columns: 
-- 		product_name, list_price, item_price, discount_amount.
-- 		Return one row for each order_item for the product that starts with “Washburn“
-- 		Use the Explicit Syntax for an Inner Join to join between the tables, 
-- 		and look at the columns to identify either a primary key foreign key relationship or an ad-hoc relationship.
-- *************************************************************************************************************************
SELECT product_name, list_price, item_price, discount_amount 
FROM products p INNER JOIN order_items oi ON p.product_id = oi.product_id
WHERE product_name LIKE 'Washburn%';

-- ****************************************************Problem 3:************************************************************
-- 		Write a SELECT statement that inner joins the Products table to the Order_Items and returns these columns: 
-- 		product_name, list_price, item_price, discount_amount. 
-- 		To join the tables, use (pun intended) the Join Using Clause.
-- 		Return one row for each order_item (meaning a record holding product_name, list_price, item_price, discount_amount), 
-- 		but only for order_items that have a discount_amount that is greater than 0
-- *************************************************************************************************************************
SELECT product_name, list_price, item_price, discount_amount
FROM products JOIN order_items USING (product_id)
WHERE discount_amount > 0;

-- ****************************************************Problem 4:************************************************************
-- 		Write a SELECT statement that inner joins the Orders, Order_Items, Products and Categories tables. 
-- 		This statement should return these columns: 
-- 		order_date,  product_name, category_name, item_price, discount_amount, quantity.
-- 		You must use aliases for the tables
-- 		To join the tables, use (pun intended) the Join On Clause.
-- 		Sort the result set in descending order by the fields: order_date, product_name, category_name. 
-- 		We want to explicitly specify it by using the keyword DESC.
-- 		All of the table joins should have primary key foreign key or ad-hoc relationships. 
-- *************************************************************************************************************************
SELECT order_date, product_name, category_name, item_price, discount_amount, quantity
FROM orders o 
	JOIN order_items oi ON o.order_id = oi.order_id
	JOIN products p ON p.product_id = oi.product_id
	JOIN categories c ON p.category_id = c.category_id
ORDER BY order_date DESC, product_name DESC, category_name DESC;


-- ****************************************************Problem 5:************************************************************
-- 		Write a SELECT statement that returns the line1, line2, city and zip_code columns from the Addresses table.
-- 		Return one row for each address record that has the same zip_code with another address. 
-- 		Hint: check that the address_id columns aren’t equal but the zip_code columns are equal.
-- 		Specify the join using the JOIN ON Clause along with the use of  two AND Operators
-- 		You must use alias(s) for the Addresses table
-- 		Sort the result set by line1 specifying in Ascending order. 
-- 		Note that the default ordering is by ascending order but we want to explicitly specify it using the keyword ASC
-- 		Note: There is no reason to use the Distinct Operator
-- *************************************************************************************************************************
SELECT a1.line1, a1.line2, a1.city, a1.zip_code 
FROM addresses a1 JOIN addresses a2 ON a1.city = a2.city AND a1.zip_code = a2.zip_code AND a1.address_id <> a2.address_id
ORDER BY line1 ASC;

-- ****************************************************Problem 6:************************************************************
-- 		Write a SELECT statement that returns these three columns: 
-- 		product_name	The product_name column from the Products table
-- 		list_price		Product List price from Products table
-- 		Item_id	  		Item_Id from the Orider_Items table
-- 		Return one row for each product that has never been sold. 
-- 		Hint: Use an Left Outer Join and only return rows where the Item_Id column contains a null value. 
-- 			  But your Left Outer Join must use the Join Using Clause
-- 		Note: There is no need to use the Distinct Operator
-- *************************************************************************************************************************
SELECT product_name, list_price, item_id
FROM products LEFT JOIN order_items USING (product_id)
WHERE item_id IS NULL;

-- ****************************************************Problem 7:************************************************************
-- 		Use the UNION operator to generate a result set consisting of three columns from the Products table: 
-- 		Discount_status		A calculated column that contains a value of DISCOUNTED or FULL PRICE
-- 		Product_name		The product_name column
-- 		discount_percent	The discount_percent column
-- 		If the product has a discount_percent greater than 0, the Discount_status column should contain a value of DISCOUNTED. 
-- 			Otherwise, it should contain a value of FULL PRICE.
-- 		Sort the final result set by product_name.

-- *************************************************************************************************************************
SELECT 'DISCOUNTED' AS discount_status, product_name, discount_percent FROM products WHERE discount_percent > 0
UNION
SELECT 'FULL PRICE' AS discount_status, product_name, discount_percent FROM products WHERE discount_percent = 0
ORDER BY product_name;

