USE my_guitar_shop; 
/***************************Problem 1***********************************
Create and call a stored procedure named testProblemOne_sp. This stored
procedure should declare a variable and set it to the most expensive price from all
products in the Products table using list_price column.
- If the price is more than 1000 output, "Wow the most expensive guitar has the
price <put price of the most expensive guitar here>'
- If the price is less than 1000 output, "I am going to buy the guitar that costs
<put price of the most expensive guitar here>'
************************************************************************/
DELIMITER $$
CREATE PROCEDURE testProblemOne_sp()
BEGIN
    DECLARE max_price DECIMAL(10, 2);

    SELECT MAX(list_price) INTO max_price
    FROM Products;

    IF max_price > 1000 THEN
        SELECT CONCAT('Wow the most expensive guitar has the price $', max_price);
    ELSE
        SELECT CONCAT('I am going to buy the guitar that costs $', max_price);
    END IF;
END $$
DELIMITER ;

CALL testProblemOne_sp();

/***************************Problem 2***********************************
Create and call a stored procedure named testProblemTwo_sp. This stored
procedure should use two variables to store: (1) the count of the orders that use
credit card Visa in the Orders table and (2) the lowest shipping price for those orders
(that used Visa credit card). If the lowest shipping price is greater than or equal to 5,
the stored procedure should display a result set that displays the values of both
variables. Otherwise, the procedure should display a result set that displays a
message that says, “The lowest price of shipping for Visa orders is less than 5”.
************************************************************************/
DELIMITER $$
CREATE PROCEDURE testProblemTwo_sp()
BEGIN
    DECLARE count_visa_orders INT;
    DECLARE lowest_shipping_price DECIMAL(10, 2);

    SELECT COUNT(*) INTO count_visa_orders FROM Orders WHERE card_type = 'Visa';
    SELECT MIN(ship_amount) INTO lowest_shipping_price FROM Orders WHERE card_type = 'Visa';

    IF lowest_shipping_price >= 5 THEN
        SELECT count_visa_orders, lowest_shipping_price;
    ELSE
        SELECT 'The lowest price of shipping for Visa orders is less than 5';
    END IF;
END$$
DELIMITER ;

CALL testProblemTwo_sp();

/***************************Problem 3***********************************
Create and call a stored procedure named testProblemThree_sp. This stored
procedure should create a cursor for a result set that consists of the product_name
(from product table), item_price (from order_items table) and quantity columns (from
order_items table) for each product from order #7.
The rows in this result set should be sorted in ascending sequence by
product_name. Then, the procedure should display a string variable that includes the
product_name, item_price and quantity for each product so it looks something like
this: image
Here, each value is enclosed in double quotes ("), each column is separated by a
comma (,) and each row is separated by a pipe character (|).
Make sure to close the cursor after it is done being used
************************************************************************/
DELIMITER $$
CREATE PROCEDURE testProblemThree_sp()
BEGIN
   DECLARE product_name VARCHAR(255);
    DECLARE item_price DECIMAL(10, 2);
    DECLARE quantity INT;

    DECLARE done INT DEFAULT FALSE;
    DECLARE cur CURSOR FOR
        SELECT p.product_name, oi.item_price, oi.quantity
        FROM products p
        JOIN order_items oi ON p.product_id = oi.product_id
        WHERE oi.order_id = 7
        ORDER BY p.product_name ASC;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;
    SET @result = '';

    read_loop: LOOP
        FETCH cur INTO product_name, item_price, quantity;
        IF done THEN
            LEAVE read_loop;
        END IF;
        SET @result = CONCAT(@result, '"', product_name, '",', '"', item_price, '",', '"', quantity, '"|');
    END LOOP;

    CLOSE cur;
    SELECT @result AS result;
END$$
DELIMITER ;
CALL testProblemThree_sp();
/***************************Problem 4***********************************
Create and call a stored procedure named testProblemFour_sp. This
procedure should attempt to delete a product named “'Fender
Stratocaster'” from the Products table. If the delete is successful, the
procedure should display this message:
1 row was deleted.
If it is unsuccessful, the procedure should display this message:
Row was not deleted because of the child records present.
************************************************************************/ 
DELIMITER $$
CREATE PROCEDURE testProblemFour_sp()
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Row was not deleted because of the child records present.';
    END;

    DELETE FROM Products WHERE ProductName = 'Fender Stratocaster';

    IF ROW_COUNT() > 0 THEN
        SELECT '1 row was deleted.';
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Row was not deleted because of the child records present.';
    END IF;
    
END$$
DELIMITER ;
CALL testProblemFour_sp();
/***************************Problem 5***********************************
Create and call a stored procedure named testProblemsFive_sp. This
procedure should include a set of two SQL statements coded as a
transaction to reflect the following change: Category “Violin” has been
added and “Drums” was removed.
If these statements execute successfully, commit the changes. Otherwise, roll back
the changes. Create custom output message for the commit and rollback case.
Also, before the transaction, set autocommit to off
After the transaction, set autocommit to back on
************************************************************************/
DELIMITER $$
CREATE PROCEDURE testProblemFive_sp()
BEGIN
	DECLARE exit handler for sqlexception, sqlwarning
    BEGIN
        ROLLBACK;
        SET AUTOCOMMIT = 1;
        SELECT 'Rollback executed: ' AS 'Message', NOW() AS 'Timestamp';
    END;

    SET AUTOCOMMIT = 0;

    START TRANSACTION;

    -- Remove 'Drums' category
    DELETE FROM categories WHERE name = 'Drums';

    -- Add 'Violin' category
    INSERT INTO categories (name) VALUES ('Violin');

    COMMIT;
    SET AUTOCOMMIT = 1;
    SELECT 'Commit executed: ' AS 'Message', NOW() AS 'Timestamp';
END$$
DELIMITER ;
CALL testProblemFivesp();
/***************************Problem 6***********************************
Create and call a stored procedure named testProblemSix_sp. This
procedure should include a set of two SQL statements coded as a
transaction to reflect the following change: delete Order 7.
To do this code 2 delete statements:
- first delete all order_items with that order id 7,
- then delete the order 7.
If these statements execute successfully, commit the changes. Otherwise, roll back
the changes.
Create custom output message for the commit and rollback case.
Before the transaction starts set autocommit to off
After the code runs to either commit or rollback the transaction, set autocommit to on
(Hint: see Chapter 14 Exercises)

************************************************************************/
DELIMITER $$
CREATE PROCEDURE testProblemSix_sp()
BEGIN
	DECLARE exit handler for sqlexception, sqlwarning
    BEGIN
        ROLLBACK;
        SET AUTOCOMMIT = 1;
        SELECT 'Rollback executed: ' AS 'Message', NOW() AS 'Timestamp';
    END;

    SET AUTOCOMMIT = 0;

    START TRANSACTION;

    DELETE FROM order_items WHERE order_id = 7;

    DELETE FROM orders WHERE id = 7;

    COMMIT;
    SET AUTOCOMMIT = 1;
    SELECT 'Commit executed: ' AS 'Message', NOW() AS 'Timestamp';
END$$
DELIMITER ;
CALL testProblemSix_sp();


/*

	Write at least a few sentences on what you feel are the main learning points in this assignment?

	Write at least a  few sentences on, what this assignment covered/what you feel you learned, that could be relevant for doing the Final Group Project:
    

*/