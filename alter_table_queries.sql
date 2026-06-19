ALTER TABLE categories
ALTER COLUMN category_name SET NOT NULL;

ALTER TABLE brands
ALTER COLUMN brand_name SET NOT NULL;

ALTER TABLE products
ALTER COLUMN active_status SET DEFAULT TRUE;

ALTER TABLE inventory
ALTER COLUMN last_updated SET DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE departments
ALTER COLUMN department_name SET NOT NULL;

ALTER TABLE orders
ALTER COLUMN customer_id SET NOT NULL;

ALTER TABLE orders
ADD CONSTRAINT check_orders CHECK ( order_status in (
    'Pending',
    'Confirmed',
    'Packed',
    'Shipped',
    'Delivered',
    'Cancelled',
    'Returned'
) );

ALTER TABLE reviews
ADD CONSTRAINT check_ratings CHECK ( rating BETWEEN 1 AND 5);

ALTER TABLE promotions
ADD CONSTRAINT check_discount_percentage CHECK ( discount_percent BETWEEN 0 AND 100);

ALTER TABLE sales_targets
ADD CONSTRAINT check_target_month CHECK ( target_month BETWEEN 1 AND 12);

ALTER TABLE products
ALTER COLUMN category_id SET NOT NULL;

ALTER TABLE products
ALTER COLUMN brand_id SET NOT NULL;

ALTER TABLE products
ALTER COLUMN supplier_id SET NOT NULL;

ALTER TABLE orders
ALTER COLUMN customer_id SET NOT NULL;

ALTER TABLE order_items
ALTER COLUMN order_id SET NOT NULL;

ALTER TABLE order_items
ALTER COLUMN product_id SET NOT NULL;

ALTER TABLE payments
ALTER COLUMN order_id SET NOT NULL;

ALTER TABLE shipments
ALTER COLUMN order_id SET NOT NULL;

ALTER TABLE reviews
ALTER COLUMN customer_id SET NOT NULL;

ALTER TABLE reviews
ALTER COLUMN product_id SET NOT NULL;