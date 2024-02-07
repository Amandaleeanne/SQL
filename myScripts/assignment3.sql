USE my_gutair_shop; 
-- **********************Problem 1********************************
-- * Write a SQL statement that selects these columns:
-- *The count of the number of products in the Products table
-- *The average of the list_price columns in the Products table
-- ***************************************************************
SELECT COUNT(*), avg(list_price) AS 'average list price'
FROM products;
-- ************************Problem 2********************************
-- * Write a SQL statement that returns one row for every category that has products with these columns:
-- * The category_name column from the Categories table
-- * The count of the products in the Products table per Category
-- * The list price of the cheapest product in the Products table per Category
-- * Sort the result set so the category with the most products appears first.
-- ******************************************************************
SELECT category_name, COUNT(p.product_id) AS product_count, MIN(p.list_price) AS min_list_price
FROM categories c
JOIN products p ON c.category_id = p.category_id
GROUP BY c.category_name
ORDER BY product_count DESC;
-- **************************Problem 3***********************************
-- * Write a SQL statement that returns one row for each category and calculate total sum and total discount of the products sold in that category:
-- * The category_name column from the Category table
-- * Distinct product count that was sold in each category
-- * The Sum of the (Item Price multiplied by the quantity) in the Order_Items table per Category – this value we refer to as the “item price total”
-- * The Sum of the (Discount amount multiplied by the quantity) in the Order_Items table per Category
-- * Sort the result set in descending sequence by the “item price total” for each category.
-- * Hint: you will need to join tables: categories, products and order_items tables
-- ***********************************************************************
SELECT category_name, COUNT(DISTINCT p.product_id) AS distinct_product_count,
    SUM(oi.item_price * oi.quantity) AS item_price_total,
    SUM(oi.discount_amount * oi.quantity) AS discount_total
FROM categories c
JOIN products p ON c.category_id = p.category_id
JOIN order_Items oi ON p.product_id = oi.product_id
GROUP BY c.category_name
ORDER BY item_price_total DESC;
-- *******************************Problem 4****************************
-- * Write a SQL statement that returns one row for every customer that has orders with these columns:
-- * The first_name from the Customers table
-- * A count of the number of orders
-- * Show the most expensive item_price that was purchased per customer – we refer to this as the “highest priced-item” column
-- * Return only those rows where the customer has more than 1 order.
-- * Sort the result set in descending sequence by the highest priced item column
-- * HINT: You will need to join 3 tables: orders, order_items and customers
-- **********************************************************************
SELECT first_name, COUNT(c.customer_id) AS number_of_orders, MAX(oi.item_price) AS 'highest priced-item'
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON oi.order_id = o.order_id
GROUP BY first_name
HAVING COUNT(c.customer_id) > 1
ORDER BY 'highest priced-item' DESC;
-- ***************************Problem 5******************************
-- * Modify the solution to exercise 4 so it only counts and finds max priced line items 
-- * that have an item_price value that’s greater than 300.
-- ****************************************************************
SELECT first_name, COUNT(c.customer_id) AS number_of_orders, MAX(CASE WHEN oi.item_price > 300 THEN oi.item_price ELSE NULL END) AS 'highest priced-item'
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON oi.order_id = o.order_id
GROUP BY first_name
HAVING COUNT(c.customer_id) > 1
ORDER BY 'highest priced-item' DESC;
-- ********************Problem 6*****************************
-- * Write a SQL statement that answers this question: 
-- * What is the total amount ordered by each customer? 
-- * Return these columns:
-- * Customer email address from the Customer table
-- * Count of customer orders from the Orders table
-- * The total ship amount for each customer in the Orders table
-- * Group by the customer's email adreess with rollup
-- * In the Having Clause, specify that the total ship amount 
-- * is greater than 5.
-- ***********************************************************
SELECT c.email_address, COUNT(o.order_id), SUM(o.ship_amount) AS ship_amount
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.email_address WITH ROLLUP
HAVING  COALESCE(SUM(o.ship_amount), 0) > 5;
-- ********************Problem 7*****************************
-- * Write a SQL statement that answers this question: 
-- * Which product was purchased by more than one customer
-- * Product_name
-- * Number_of_orders_items  - number of order line items that purchased per product
-- * Number_of_distinct_customers – number of distinct customers purchased the product
-- * HINTS
-- * You will need to join 4 tables
-- * To count order items, count the number of item_id in the order_items table
-- * Don’t forget to do a group by, figuring out correct group by column is important
-- * Specify a having clause where the number_of_distinct_customers is greater than 1
-- ***********************************************************
SELECT product_name, COUNT(oi.item_id) AS number_of_order_items, COUNT(DISTINCT c.customer_id) AS number_of_distinct_customers
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o ON  oi.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id  
GROUP BY product_name
HAVING number_of_distinct_customers > 1;

