USE my_guitar_shop;
/***************************Problem 1***********************************
Create and call a stored procedure named insert_category_sp. In the stored
procedure, a new row is added to the Categories table. To do that, this procedure
should have one parameter for the category name.
Code two CALL statements that test this procedure. Note that this table doesn’t
allow duplicate category names.
The second call should try to add the same value for category name. Verify the 2nd
call results in an error.
************************************************************************/
DROP PROCEDURE IF EXISTS insert_category_sp;
DELIMITER $$
CREATE PROCEDURE insert_category_sp(IN proc_category_name VARCHAR(100))
BEGIN
    DECLARE checkDuplicates INT;
    SET checkDuplicates = (SELECT COUNT(*) FROM categories WHERE category_name = proc_category_name);
    IF checkDuplicates > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Duplicate category name is not allowed';
    ELSE
        INSERT INTO categories (category_name) VALUES (proc_category_name);
        SELECT 'Category added successfully!' AS message;
    END IF;
END $$
DELIMITER ;

-- Test the stored procedure
CALL insert_category_sp('category 1'); -- Should succeed
CALL insert_category_sp('category 2'); -- Should succeed
CALL insert_category_sp('category 1'); -- Should fail

/***************************Problem 2***********************************
Create and call a stored function named discount_price_sf that calculates the
discount price of an item in the Order_Items table (discount amount subtracted from
item price). To do that, this function should accept one parameter for the item ID,
and it should return the value of the discount price for that item
************************************************************************/
DROP FUNCTION IF EXISTS discount_price_sf;
DELIMITER $$
CREATE FUNCTION discount_price_sf(func_item_id INT)
RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
    RETURN (SELECT item_price - discount_amount FROM order_items WHERE item_id = func_item_id);
END$$
DELIMITER ;
SELECT item_id, item_price, discount_amount FROM order_items WHERE item_id = 1;
SELECT discount_price_sf(1); 
/***************************Problem 3***********************************
Create and call a stored function named item_total_sf that calculates the total
amount of an item in the Order_Items table (discount price multiplied by quantity). To
do that, this function should accept one parameter for the item ID, it should use the
discount_price_sf function that you created in Problem 2, and it should return the
value of the total for that item
************************************************************************/
DROP FUNCTION IF EXISTS item_total_sf;
DELIMITER $$
CREATE FUNCTION item_total_sf(func_item_id INT) 
RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
    RETURN (SELECT discount_price_sf(func_item_id)*quantity FROM order_items WHERE func_item_id = item_id);
END$$
DELIMITER ;
SELECT discount_price_sf(5) AS total_discount_price, discount_price_sf(5) * 2 AS T_discount_price_times_two,
		item_total_sf(5) AS item_total_sf_5_result; -- should return discount amount* 2 -- 


/***************************Problem 4***********************************
Create and call a stored procedure named update_product_discount_sp that
updates the discount_percent column in the Products table. This procedure should
have one parameter for the product ID and another for the discount percent.
If the value for the discount_percent column is a negative number, the stored
procedure should signal state indicating that the value for this column must be a
positive number. Otherwise, do the update on the discount_percent column in the
Products table.
************************************************************************/
DROP PROCEDURE IF EXISTS update_product_discount_sp;
DELIMITER $$
CREATE PROCEDURE update_product_discount_sp(IN proc_product_id INT, IN proc_discount_percent DECIMAL(5,2))
BEGIN
    IF proc_discount_percent < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Discount percent must be a positive number';
    ELSE
        UPDATE products
        SET discount_percent = proc_discount_percent WHERE product_id = proc_product_id;
    END IF;
END$$
DELIMITER ;
-- Update discount_percent for product_id 1 to 20% discount
SELECT * FROM products WHERE product_id = 1;
CALL update_product_discount_sp(1, 20); -- 
SELECT * FROM products WHERE product_id = 1;
CALL update_product_discount_sp(2, -10); -- should fail
/*

	Write at least a few sentences on what you feel are the main learning points in this assignment?
		The main learning points of this assignment is to further understand error handling and how to use "noSQL" in SQL. Aka, expanding
        on the knowlege of last week of how you can write "regular code" within a SQL script to handle databases, this time using both SFUNC, SPROC, and perameters.
        I also think you wanted to showcase the difference between SPROC's and SFUNC's and thier individal use cases.
	Write at least a  few sentences on, what this assignment covered/what you feel you learned, that could be relevant for doing the Final Group Project:
    I feel like I didn't learn anything too new, at least in terms of programming, other than the difference between functions and procedures and what the syntax for perameters are. 
    For my final project I might end up using functions more often than procedures, such as for calcualtions,
	because procedures tend to lean more twords "wrting" to a database and fucntions are more of a "read only", at least as showcased here.
    Since the final project is only reading the database, from what I can tell, I belive using functions for things you find doing a lot would
    be benificial.

*/