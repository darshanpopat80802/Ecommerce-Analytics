CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(255) NOT NULL UNIQUE,
    gender VARCHAR(255) NOT NULL,
    birth_date DATE,
    registration_date DATE DEFAULT CURRENT_DATE,
    loyalty_points INTEGER DEFAULT 0
);

CREATE TABLE customer_addresses(
  address_id INTEGER PRIMARY KEY,
  customer_id INTEGER,
  address_type VARCHAR(255) NOT NULL,
  address_line_1 VARCHAR(255) NOT NULL,
  address_line_2 VARCHAR(255) NOT NULL,
  city VARCHAR(255) NOT NULL,
  state VARCHAR(255) NOT NULL,
  country VARCHAR(255) NOT NULL,
  postal_code VARCHAR(255) NOT NULL,

  CONSTRAINT customers_id_fk FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE categories(
    category_id INTEGER PRIMARY KEY,
    category_name VARCHAR(255) UNIQUE,
    parent_category_id INTEGER,

    CONSTRAINT category_fk FOREIGN KEY (parent_category_id) REFERENCES categories(category_id)
);

CREATE TABLE brands(
    brand_id INTEGER PRIMARY KEY,
    brand_name VARCHAR(255) UNIQUE,
    country VARCHAR(255)
);

CREATE TABLE suppliers(
    supplier_id INTEGER PRIMARY KEY,
    supplier_name VARCHAR(255) NOT NULL,
    contact_person VARCHAR(255),
    email VARCHAR(255),
    phone VARCHAR(255),
    city VARCHAR(255),
    state VARCHAR(255),
    country VARCHAR(255)
);

CREATE TABLE products(
    product_id INTEGER PRIMARY KEY,
    category_id INTEGER,
    brand_id INTEGER,
    supplier_id INTEGER,
    product_name VARCHAR(255) NOT NULL,
    description TEXT,
    cost_price DECIMAL(10, 2) NOT NULL,
    selling_price DECIMAL(10, 2) NOT NULL,
    launch_date DATE,
    active_status BOOLEAN,

    CONSTRAINT product_category_id_fk FOREIGN KEY (category_id) REFERENCES categories(category_id),
    CONSTRAINT product_brand_id_fk FOREIGN KEY (brand_id) REFERENCES brands(brand_id),
    CONSTRAINT product_supplier_id_fk FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

CREATE TABLE warehouses(
    warehouse_id INTEGER PRIMARY KEY,
    warehouse_name VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    state VARCHAR(255) NOT NULL,
    country VARCHAR(255) NOT NULL
);

CREATE TABLE inventory(
    inventory_id INTEGER PRIMARY KEY,
    product_id INTEGER,
    warehouse_id INTEGER,
    quantity_available INTEGER NOT NULL,
    reorder_level INTEGER NOT NULL,
    last_updated TIMESTAMP NOT NULL,

    CONSTRAINT inventory_product_id_fk FOREIGN KEY (product_id) REFERENCES products(product_id),
    CONSTRAINT inventory_warehouses_id_fk FOREIGN KEY (warehouse_id) REFERENCES warehouses(warehouse_id)
);

CREATE TABLE departments (
    department_id INTEGER PRIMARY KEY,
    department_name VARCHAR(255) UNIQUE
);

CREATE TABLE employees (
    employee_id INTEGER PRIMARY KEY,
    department_id INTEGER,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE,
    hire_date DATE NOT NULL,
    salary DECIMAL(12,2) NOT NULL,

    CONSTRAINT employees_department_id_fk FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

CREATE TABLE orders(
    order_id INTEGER PRIMARY KEY ,
    customer_id INTEGER,
    order_date TIMESTAMP NOT NULL ,
    order_status VARCHAR(255) NOT NULL ,
    total_amount DECIMAL(12,2) NOT NULL ,

    CONSTRAINT orders_customer_id_fk FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items(
    order_item_id INTEGER PRIMARY KEY ,
    order_id INTEGER,
    product_id INTEGER,
    quantity INTEGER NOT NULL ,
    unit_price DECIMAL(10,2) NOT NULL ,
    subtotal DECIMAL(12,2) NOT NULL ,

    CONSTRAINT order_items_order_id_fk FOREIGN KEY (order_id) REFERENCES orders(order_id),
    CONSTRAINT order_items_product_id_fk FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE payments(
    payment_id INTEGER PRIMARY KEY,
    order_id INTEGER,
    payment_date TIMESTAMP NOT NULL ,
    payment_method VARCHAR(255) NOT NULL ,
    payment_status VARCHAR(255) NOT NULL ,
    amount DECIMAL(12,2) NOT NULL ,

    CONSTRAINT payments_order_id_fk FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

CREATE TABLE shipments(
    shipment_id INTEGER PRIMARY KEY ,
    order_id INTEGER,
    warehouse_id INTEGER,
    shipped_date TIMESTAMP,
    delivery_date TIMESTAMP,
    shipping_cost DECIMAL(10,2) NOT NULL ,
    tracking_number VARCHAR(255) UNIQUE ,

    CONSTRAINT shipments_order_id_fk FOREIGN KEY (order_id) REFERENCES orders(order_id),
    CONSTRAINT shipments_warehouse_id_fk FOREIGN KEY (warehouse_id) REFERENCES warehouses(warehouse_id)
);

CREATE TABLE returns(
    return_id INTEGER PRIMARY KEY ,
    order_id INTEGER,
    product_id INTEGER,
    return_date DATE NOT NULL ,
    reason VARCHAR(255) NOT NULL ,
    refund_amount DECIMAL(12,2) NOT NULL ,

    CONSTRAINT returns_order_id_fk FOREIGN KEY (order_id) REFERENCES orders(order_id),
    CONSTRAINT returns_product_id_fk FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE reviews(
    review_id INTEGER PRIMARY KEY ,
    customer_id INTEGER,
    product_id INTEGER,
    rating INTEGER NOT NULL ,
    review_text TEXT,
    review_date TIMESTAMP NOT NULL ,

    CONSTRAINT reviews_customer_id_fk FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT reviews_product_id_fk FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE promotions(
    promotion_id INTEGER PRIMARY KEY ,
    promotion_name VARCHAR(255) NOT NULL ,
    start_date DATE NOT NULL ,
    end_date DATE NOT NULL ,
    discount_percent DECIMAL(5,2) NOT NULL
);

CREATE TABLE product_promotions(
    product_id INTEGER,
    promotion_id INTEGER,

    CONSTRAINT product_promotions_composite_key PRIMARY KEY (product_id, promotion_id),
    CONSTRAINT product_promotions_product_id_fk FOREIGN KEY (product_id) REFERENCES products(product_id),
    CONSTRAINT product_promotions_promotion_id_fk FOREIGN KEY (promotion_id) REFERENCES promotions(promotion_id)
);

CREATE TABLE order_management(
    management_id INTEGER PRIMARY KEY ,
    order_id INTEGER,
    employee_id INTEGER,
    action_date TIMESTAMP NOT NULL ,
    action_type VARCHAR(255) NOT NULL ,

    CONSTRAINT order_management_order_id_fk FOREIGN KEY (order_id) REFERENCES orders(order_id),
    CONSTRAINT order_management_employee_id_fk FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

CREATE TABLE sales_targets(
    target_id INTEGER PRIMARY KEY ,
    employee_id INTEGER,
    target_month INTEGER NOT NULL ,
    target_year INTEGER NOT NULL ,
    target_amount DECIMAL(12,2) NOT NULL ,

    CONSTRAINT sales_targets_employee_id_fk FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);