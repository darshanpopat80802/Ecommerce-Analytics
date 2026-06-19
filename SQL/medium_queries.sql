-- GROUP BY
-- 1. Count customers by gender.
SELECT gender, COUNT(*) FROM customers GROUP BY gender;

-- 2. Count products by category.
SELECT t2.category_name, COUNT(t1.category_id) as product_count FROM products t1
INNER JOIN categories t2 ON t1.category_id = t2.category_id
GROUP BY t2.category_name ORDER BY COUNT(t1.category_id);

-- 3. Count products by brand.
SELECT b1.brand_name, COUNT(t1.brand_id) as brand_count FROM products t1
INNER JOIN brands b1 ON t1.brand_id = b1.brand_id
GROUP BY b1.brand_name
ORDER BY COUNT(t1.brand_id);

-- 4. Total orders by status.
SELECT order_status, COUNT(*) FROM orders GROUP BY order_status;

-- 5. Average order value by status.
SELECT order_status, AVG(total_amount) FROM orders GROUP BY order_status;

-- 6. Total sales by customer.
SELECT CONCAT(c1.first_name, ' ' ,c1.last_name) as customer_name, SUM(o1.total_amount) as total_sales
FROM orders o1 INNER JOIN customers c1 ON o1.customer_id = c1.customer_id
GROUP BY CONCAT(c1.first_name, ' ' ,c1.last_name)
ORDER BY SUM(o1.total_amount) DESC;

-- 7. Total sales by product.
SELECT t2.product_name, SUM(t1.subtotal) as total_sales FROM order_items t1
INNER JOIN products t2 ON t1.product_id = t2.product_id
GROUP BY t2.product_name;

-- 8. Total sales by category.
SELECT t3.category_name, SUM(t1.subtotal) AS total_sales FROM order_items t1
INNER JOIN products t2 on t2.product_id = t1.product_id
INNER JOIN categories t3 on t2.category_id = t3.category_id
GROUP BY t3.category_name
ORDER BY total_sales DESC;

-- 9. Total sales by brand.
SELECT t3.brand_name, SUM(t1.subtotal) FROM order_items t1
JOIN products ON t1.product_id = products.product_id
JOIN brands t3 ON products.brand_id = t3.brand_id
GROUP BY t3.brand_name
ORDER BY  t3.brand_name;

-- 10. Total inventory by warehouse.
SELECT t2.warehouse_name, SUM(quantity_available) as total_inventory FROM inventory t1
JOIN warehouses t2 ON t1.warehouse_id = t2.warehouse_id
GROUP BY t2.warehouse_name;

-- HAVING
-- 11. Find customers with more than 5 orders.
SELECT t1.customer_id, CONCAT(t2.first_name, ' ' ,t2.last_name), COUNT(order_id) AS total_orders FROM orders t1
JOIN customers t2 ON t1.customer_id = t2.customer_id
GROUP BY t1.customer_id, CONCAT(t2.first_name, ' ' ,t2.last_name)
HAVING COUNT(order_id) > 5
ORDER BY total_orders DESC;

-- 12. Find products sold more than 100 times.
SELECT t2.product_id, t2.product_name, COUNT(order_id) AS total_orders, SUM(quantity) AS total_quantity  FROM order_items t1
JOIN products t2 ON t1.product_id = t2.product_id
GROUP BY t2.product_id, t2.product_name
HAVING SUM(quantity) > 100
ORDER BY total_quantity DESC;

-- 13. Find categories with more than 50 products.
SELECT t2.category_name, COUNT(t1.category_id) FROM products t1
JOIN categories t2 ON t1.category_id = t2.category_id
GROUP BY t2.category_name
HAVING COUNT(t1.category_id) > 50;

-- 14. Find brands having more than 20 products.
SELECT t2.brand_name, COUNT(t1.brand_id) FROM products t1
JOIN brands t2 ON t1.brand_id = t2.brand_id
GROUP BY t2.brand_name
HAVING COUNT(t1.brand_id) > 20
ORDER BY COUNT(t1.brand_id) DESC;

-- 15. Find employees with sales targets (annually) above 3000000.
SELECT t2.employee_id, CONCAT(t2.first_name, ' ' ,t2.last_name), SUM(target_amount) AS total_target
FROM sales_targets t1
JOIN employees t2 ON t1.employee_id = t2.employee_id
GROUP BY t2.employee_id, CONCAT(t2.first_name, ' ' ,t2.last_name)
HAVING SUM(target_amount) > 3000000
ORDER BY SUM(target_amount) DESC;

-- INNER JOIN
-- 16. Show order details with customer names.
SELECT CONCAT(t1.first_name, ' ' ,t1.last_name) AS customer_name,
       t2.order_id, t2.order_date, t2.total_amount,
       t4.product_name, t3.quantity, t3.unit_price, t3.subtotal
FROM customers t1
JOIN orders t2 ON t1.customer_id = t2.customer_id
JOIN order_items t3 ON t2.order_id = t3.order_id
JOIN products t4 ON t3.product_id = t4.product_id;

-- 17. Show products with category names.
SELECT t1.product_name, t2.category_name FROM products t1
JOIN categories t2 ON t1.category_id = t2.category_id
ORDER BY t2.category_name;

-- 18. Show products with supplier names.
SELECT t1.product_name, t2.supplier_name FROM products t1
JOIN suppliers t2 ON t1.supplier_id = t2.supplier_id
ORDER BY t2.supplier_name;

-- 19. Show employees with department names.
SELECT CONCAT(t1.first_name, ' ', t1.last_name), t2.department_name FROM employees t1
JOIN departments t2 ON t1.department_id = t2.department_id
ORDER BY t2.department_name;

-- 20. Show inventory with warehouse names.
SELECT t2.warehouse_name, t3.product_name, SUM(t1.quantity_available) AS total_quantity
FROM inventory t1
JOIN warehouses t2 ON t1.warehouse_id = t2.warehouse_id
JOIN products t3 ON t1.product_id = t3.product_id
GROUP BY t2.warehouse_name, t3.product_name
ORDER BY total_quantity DESC;

-- LEFT JOIN
-- 21. Find customers who never placed orders.
SELECT CONCAT(t1.first_name, ' ', t1.last_name), t1.customer_id, t2.order_id FROM customers t1
LEFT JOIN orders t2 ON t1.customer_id = t2.customer_id
WHERE t2.order_id IS NULL;

-- 22. Find products never ordered.
SELECT t1.product_id, t2.order_id FROM products t1
LEFT JOIN order_items t2 ON t1.product_id = t2.product_id
WHERE t2.order_id IS NULL;

-- 23. Find suppliers without products.
SELECT t1.supplier_id, t1.supplier_name FROM suppliers t1
LEFT JOIN products t2 ON t1.supplier_id = t2.supplier_id
WHERE t2.supplier_id IS NULL;

-- 24. Find promotions without products.
SELECT t1.promotion_id, t1.promotion_name FROM promotions t1
LEFT JOIN product_promotions t2 ON t1.promotion_id = t2.promotion_id
WHERE t2.promotion_id IS NULL;

-- 25. Find employees without sales targets.
SELECT t1.employee_id, CONCAT(t1.first_name, ' ', t1.last_name) AS employee_name FROM employees t1
LEFT JOIN sales_targets t2 ON t1.employee_id = t2.employee_id
WHERE t2.employee_id IS NULL;

-- Multi-Table Joins
-- 26. Show order, customer, and payment information.
SELECT t2.customer_id, CONCAT(t2.first_name, ' ', t2.last_name) AS employee_name,
       t1.order_date, t1.order_status, t1.total_amount,
       t3.payment_date, t3.payment_status, t3.payment_method, t3.amount
FROM orders t1
JOIN customers t2 ON t1.customer_id = t2.customer_id
JOIN payments t3 ON t1.order_id = t3.order_id;

-- 27. Show order, shipment, and warehouse details.
SELECT t1.order_id, t1.customer_id,
       t2.shipped_date, t2.delivery_date, t2.shipping_cost,
       t3.warehouse_name
FROM orders t1
JOIN shipments t2 ON t1.order_id = t2.order_id
JOIN warehouses t3 ON t2.warehouse_id = t3.warehouse_id;

-- 28. Show customer reviews with product names.
SELECT CONCAT(t3.first_name, ' ', t3.last_name),
       t2.product_name,
       t1.review_text, t1.review_date, t1.rating
FROM reviews t1
JOIN products t2 ON t1.product_id = t2.product_id
JOIN customers t3 ON t1.customer_id = t3.customer_id;

-- 29. Show product promotions with promotion names.
SELECT t1.product_name, t3.promotion_name
FROM products t1
JOIN product_promotions t2 ON t1.product_id = t2.product_id
JOIN promotions t3 ON t2.promotion_id = t3.promotion_id
ORDER BY t1.product_name;

-- 30. Show employee actions performed on orders.
SELECT CONCAT(t1.first_name, ' ', t1.last_name),
       t2.order_id, t2.action_date, t2.action_type
FROM employees t1
JOIN order_management t2 ON t1.employee_id = t2.employee_id;