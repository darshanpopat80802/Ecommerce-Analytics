-- EASY (1–20)
-- SELECT, WHERE, ORDER BY, LIMIT

-- 1. Retrieve all customers.
SELECT * FROM customers;

-- 2. Display first_name and email of all customers.
SELECT customers.first_name, customers.email from customers;

-- 3. Find customers registered after 2024-01-01.
SELECT COUNT(*) FROM customers WHERE registration_date BETWEEN '2024-01-01' AND CURRENT_DATE;

-- 4. Show products with selling_price greater than 10000.
SELECT * FROM products WHERE selling_price > 10000;

-- 5. Retrieve all active products.
SELECT * FROM products WHERE active_status = TRUE;

-- 6. List all brands sorted alphabetically.
SELECT * FROM brands ORDER BY brand_name;

-- 7. Find customers with loyalty_points greater than 1000.
SELECT * FROM customers WHERE loyalty_points > 1000;

-- 8. Show top 10 most expensive products.
SELECT * FROM products ORDER BY selling_price DESC LIMIT 10;

-- 9. Retrieve orders placed in the current year.
SELECT * FROM orders WHERE EXTRACT(YEAR FROM order_date) = EXTRACT(YEAR FROM CURRENT_TIMESTAMP);

-- 10. Display all warehouses located in Gujarat.
SELECT * FROM warehouses WHERE state = 'Gujarat';

-- DISTINCT
-- 11. List unique cities from customer_addresses.
SELECT DISTINCT(customer_addresses.city) FROM customer_addresses;

-- 12. Find distinct payment methods used.
SELECT DISTINCT (payments.payment_method) FROM payments;

-- AGGREGATE FUNCTIONS
-- 13. Count total customers.
SELECT COUNT(*) FROM customers;

-- 14. Count total orders.
SELECT COUNT(*) FROM orders;

-- 15. Find average product selling price.
SELECT AVG(products.selling_price) FROM products;

-- 16. Find highest product price.
SELECT MAX(products.selling_price) FROM products;

-- 17. Find lowest product price.
SELECT MIN(products.selling_price) FROM products;

-- 18. Calculate total inventory quantity.
SELECT SUM(quantity_available) FROM inventory;

-- 19. Count total suppliers.
SELECT COUNT(*) FROM suppliers;

-- 20. Count total employees.
SELECT COUNT(*) FROM employees;