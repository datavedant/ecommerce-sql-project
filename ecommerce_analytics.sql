 E-Commerce Sales Analytics SQL Project
 Author: Your Name
 Tool: MySQL 8.0
 
 CREATE DATABASE IF NOT EXISTS ecommerce_analytics;
USE ecommerce_analytics

-- 1. CUSTOMERS
CREATE TABLE customers (
    customer_id   INT AUTO_INCREMENT PRIMARY KEY,
    full_name     VARCHAR(100) NOT NULL,
    email         VARCHAR(100) UNIQUE NOT NULL,
    phone         VARCHAR(15),
    address       TEXT,
    city          VARCHAR(50),
    state         VARCHAR(50),
    created_at    DATE NOT NULL DEFAULT (CURRENT_DATE)
);

-- 2. CATEGORIES
CREATE TABLE categories (
    category_id   INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL,
    description   TEXT
);

-- 3. PRODUCTS
CREATE TABLE products (
    product_id     INT AUTO_INCREMENT PRIMARY KEY,
    category_id    INT NOT NULL,
    product_name   VARCHAR(150) NOT NULL,
    description    TEXT,
    price          DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
    stock_quantity INT NOT NULL DEFAULT 0 CHECK (stock_quantity >= 0),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- 4. ORDERS
CREATE TABLE orders (
    order_id     INT AUTO_INCREMENT PRIMARY KEY,
    customer_id  INT NOT NULL,
    order_date   DATE NOT NULL DEFAULT (CURRENT_DATE),
    status       VARCHAR(20) NOT NULL DEFAULT 'Pending'
                 CHECK (status IN ('Pending','Processing','Shipped','Delivered','Cancelled')),
    total_amount DECIMAL(10, 2) NOT NULL CHECK (total_amount >= 0),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- 5. ORDER_ITEMS
CREATE TABLE order_items (
    item_id     INT AUTO_INCREMENT PRIMARY KEY,
    order_id    INT NOT NULL,
    product_id  INT NOT NULL,
    quantity    INT NOT NULL CHECK (quantity > 0),
    unit_price  DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id)   REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 6. PAYMENTS
CREATE TABLE payments (
    payment_id     INT AUTO_INCREMENT PRIMARY KEY,
    order_id       INT NOT NULL UNIQUE,
    payment_method VARCHAR(30) NOT NULL
                   CHECK (payment_method IN ('Credit Card','Debit Card','UPI','Net Banking','COD')),
    amount         DECIMAL(10, 2) NOT NULL,
    payment_status VARCHAR(20) NOT NULL DEFAULT 'Pending'
                   CHECK (payment_status IN ('Pending','Completed','Failed','Refunded')),
    payment_date   DATE,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- 7. SHIPPING
CREATE TABLE shipping (
    shipping_id     INT AUTO_INCREMENT PRIMARY KEY,
    order_id        INT NOT NULL UNIQUE,
    carrier         VARCHAR(50),
    tracking_number VARCHAR(50),
    shipped_date    DATE,
    delivered_date  DATE,
    shipping_status VARCHAR(20) DEFAULT 'Pending'
                    CHECK (shipping_status IN ('Pending','In Transit','Delivered','Returned')),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);
-- 8. reviews
CREATE TABLE reviews (
    review_id   INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id  INT NOT NULL,
    rating      INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment     TEXT,
    review_date DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id)  REFERENCES products(product_id)
);

SHOW TABLES;

INSERT INTO categories (category_name, description) VALUES
('Electronics',     'Mobile phones, laptops, accessories and gadgets'),
('Fashion',         'Clothing, footwear and accessories for men and women'),
('Home & Kitchen',  'Furniture, appliances and kitchen essentials'),
('Books',           'Academic, fiction, non-fiction and competitive exam books'),
('Sports & Fitness','Gym equipment, sportswear and outdoor gear'),
('Beauty',          'Skincare, haircare and personal care products'),
('Toys & Games',    'Kids toys, board games and educational items'),
('Groceries',       'Daily essentials, snacks and beverages');


INSERT INTO products (category_id, product_name, price, stock_quantity) VALUES
(1, 'Samsung Galaxy M34 5G',        18999.00, 120),
(1, 'boAt Rockerz 450 Headphones',   1299.00, 300),
(1, 'Lenovo IdeaPad Slim 3 Laptop',  45999.00,  50),
(1, 'Redmi Note 13 Pro',            24999.00,  85),
(2, 'Levi\'s 511 Slim Fit Jeans',    2499.00, 200),
(2, 'Nike Air Max 270',              8995.00,  75),
(2, 'Allen Solly Formal Shirt',      1499.00, 150),
(2, 'Biba Women Kurta Set',          1799.00, 110),
(3, 'Prestige Electric Kettle',       899.00, 180),
(3, 'Milton Thermosteel Bottle',      549.00, 250),
(3, 'Philips Air Fryer',             4999.00,  60),
(3, 'Cello Folding Study Table',     2199.00,  90),
(4, 'Wings of Fire – APJ Abdul Kalam', 199.00, 500),
(4, 'Let Us C – Yashavant Kanetkar', 499.00, 320),
(4, 'Atomic Habits – James Clear',   399.00, 280),
(5, 'Boldfit Gym Gloves',            399.00, 400),
(5, 'Nivia Football Size 5',         799.00, 130),
(6, 'Himalaya Neem Face Wash',       175.00, 600),
(6, 'Mamaearth Vitamin C Serum',     599.00, 220),
(7, 'Lego Classic Creative Bricks',  2499.00,  95);


INSERT INTO customers (full_name, email, phone, address, city, state, created_at) VALUES
('Aarav Sharma',     'aarav.sharma@gmail.com',     '9876543210', '12 MG Road',          'Mumbai',    'Maharashtra', '2023-01-15'),
('Priya Patel',      'priya.patel@gmail.com',      '9823456789', '34 Nehru Nagar',       'Ahmedabad', 'Gujarat',     '2023-02-20'),
('Rohit Verma',      'rohit.verma@yahoo.com',      '9712345678', '56 Lajpat Nagar',      'Delhi',     'Delhi',       '2023-03-10'),
('Sneha Iyer',       'sneha.iyer@gmail.com',       '9654321098', '78 Anna Salai',        'Chennai',   'Tamil Nadu',  '2023-04-05'),
('Karan Mehta',      'karan.mehta@hotmail.com',    '9543210987', '90 Koregaon Park',     'Pune',      'Maharashtra', '2023-04-18'),
('Divya Nair',       'divya.nair@gmail.com',       '9432109876', '11 Brigade Road',      'Bangalore', 'Karnataka',   '2023-05-22'),
('Amit Joshi',       'amit.joshi@gmail.com',       '9321098765', '23 Park Street',       'Kolkata',   'West Bengal', '2023-06-01'),
('Pooja Gupta',      'pooja.gupta@rediffmail.com', '9210987654', '45 Hazratganj',        'Lucknow',   'Uttar Pradesh','2023-06-14'),
('Vikram Singh',     'vikram.singh@gmail.com',     '9109876543', '67 Banjara Hills',     'Hyderabad', 'Telangana',   '2023-07-08'),
('Ananya Das',       'ananya.das@gmail.com',       '9098765432', '89 Salt Lake',         'Kolkata',   'West Bengal', '2023-07-25'),
('Rahul Tiwari',     'rahul.tiwari@gmail.com',     '8987654321', '101 Civil Lines',      'Allahabad', 'Uttar Pradesh','2023-08-03'),
('Meera Pillai',     'meera.pillai@gmail.com',     '8876543210', '22 Edappally',         'Kochi',     'Kerala',      '2023-08-17'),
('Suresh Yadav',     'suresh.yadav@gmail.com',     '8765432109', '44 Ashoka Road',       'Patna',     'Bihar',       '2023-09-05'),
('Kavya Reddy',      'kavya.reddy@gmail.com',      '8654321098', '66 Jubilee Hills',     'Hyderabad', 'Telangana',   '2023-09-20'),
('Nikhil Kulkarni',  'nikhil.kulkarni@gmail.com',  '8543210987', '88 FC Road',           'Pune',      'Maharashtra', '2023-10-11'),
('Ritu Agarwal',     'ritu.agarwal@gmail.com',     '8432109876', '110 Rajpur Road',      'Dehradun',  'Uttarakhand', '2023-10-28'),
('Arjun Bose',       'arjun.bose@gmail.com',       '8321098765', '33 Lake Town',         'Kolkata',   'West Bengal', '2023-11-09'),
('Simran Kaur',      'simran.kaur@gmail.com',      '8210987654', '55 Model Town',        'Ludhiana',  'Punjab',      '2023-11-22'),
('Manish Dubey',     'manish.dubey@gmail.com',     '8109876543', '77 Tilak Nagar',       'Bhopal',    'Madhya Pradesh','2023-12-04'),
('Lakshmi Menon',    'lakshmi.menon@gmail.com',    '8098765432', '99 Residency Road',    'Bangalore', 'Karnataka',   '2023-12-19');


INSERT INTO orders (customer_id, order_date, status, total_amount) VALUES
( 1, '2024-01-05', 'Delivered',   18999.00),
( 2, '2024-01-12', 'Delivered',    2998.00),
( 3, '2024-01-20', 'Delivered',   45999.00),
( 4, '2024-02-02', 'Delivered',    1299.00),
( 5, '2024-02-14', 'Delivered',    8995.00),
( 6, '2024-02-28', 'Delivered',    4999.00),
( 7, '2024-03-10', 'Delivered',     598.00),
( 8, '2024-03-22', 'Delivered',   24999.00),
( 9, '2024-04-01', 'Delivered',    2199.00),
(10, '2024-04-15', 'Delivered',     774.00),
(11, '2024-05-03', 'Shipped',      1798.00),
(12, '2024-05-17', 'Shipped',      4999.00),
(13, '2024-06-02', 'Processing',   1299.00),
(14, '2024-06-18', 'Delivered',   18999.00),
(15, '2024-07-04', 'Delivered',    2499.00),
( 1, '2024-07-20', 'Delivered',    1199.00),
( 3, '2024-08-01', 'Cancelled',   24999.00),
( 6, '2024-08-15', 'Delivered',     350.00),
( 9, '2024-09-03', 'Shipped',      8995.00),
(12, '2024-09-19', 'Delivered',     599.00),
( 2, '2024-10-05', 'Delivered',    2499.00),
(16, '2024-10-22', 'Processing',   1499.00),
(17, '2024-11-08', 'Delivered',    1799.00),
(18, '2024-11-25', 'Delivered',     799.00),
(20, '2024-12-10', 'Pending',      45999.00);


INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
( 1,  1, 1, 18999.00),
( 2,  5, 1,  2499.00),
( 2, 18, 1,   175.00),  -- two items in one order
( 2, 10, 1,   549.00),
( 3,  3, 1, 45999.00),
( 4,  2, 1,  1299.00),
( 5,  6, 1,  8995.00),
( 6, 11, 1,  4999.00),
( 7, 13, 2,   199.00),
( 7, 14, 1,   499.00),  -- books order
( 8,  4, 1, 24999.00),
( 9, 12, 1,  2199.00),
(10, 16, 2,   399.00),
(11,  7, 1,  1499.00),
(11,  9, 1,   899.00),
(12, 11, 1,  4999.00),
(13, 14, 1,   499.00),
(13, 15, 2,   399.00),
(14,  1, 1, 18999.00),
(15,  5, 1,  2499.00),
(16,  2, 1,  1299.00),
(17,  4, 1, 24999.00),
(18, 18, 2,   175.00),
(19,  6, 1,  8995.00),
(20, 19, 1,   599.00),
(21, 20, 1,  2499.00),
(22,  7, 1,  1499.00),
(23,  8, 1,  1799.00),
(24, 17, 1,   799.00),
(25,  3, 1, 45999.00);

INSERT INTO payments (order_id, payment_method, amount, payment_status, payment_date) VALUES
( 1, 'Credit Card',  18999.00, 'Completed', '2024-01-05'),
( 2, 'UPI',           2998.00, 'Completed', '2024-01-12'),
( 3, 'Net Banking',  45999.00, 'Completed', '2024-01-20'),
( 4, 'UPI',           1299.00, 'Completed', '2024-02-02'),
( 5, 'Credit Card',   8995.00, 'Completed', '2024-02-14'),
( 6, 'Debit Card',    4999.00, 'Completed', '2024-02-28'),
( 7, 'COD',            598.00, 'Completed', '2024-03-12'),
( 8, 'Credit Card',  24999.00, 'Completed', '2024-03-22'),
( 9, 'UPI',           2199.00, 'Completed', '2024-04-01'),
(10, 'COD',            774.00, 'Completed', '2024-04-17'),
(11, 'UPI',           1798.00, 'Completed', '2024-05-03'),
(12, 'Debit Card',    4999.00, 'Completed', '2024-05-17'),
(13, 'UPI',           1299.00, 'Pending',   NULL),
(14, 'Credit Card',  18999.00, 'Completed', '2024-06-18'),
(15, 'COD',           2499.00, 'Completed', '2024-07-07'),
(16, 'UPI',           1199.00, 'Completed', '2024-07-20'),
(17, 'Credit Card',  24999.00, 'Refunded',  '2024-08-01'),
(18, 'UPI',            350.00, 'Completed', '2024-08-15'),
(19, 'Debit Card',    8995.00, 'Completed', '2024-09-03'),
(20, 'UPI',            599.00, 'Completed', '2024-09-19'),
(21, 'COD',           2499.00, 'Completed', '2024-10-07'),
(24, 'UPI',            799.00, 'Completed', '2024-11-25');


INSERT INTO shipping (order_id, carrier, tracking_number, shipped_date, delivered_date, shipping_status) VALUES
( 1, 'Delhivery', 'DL10012024', '2024-01-06', '2024-01-09', 'Delivered'),
( 2, 'BlueDart',  'BD20012024', '2024-01-13', '2024-01-16', 'Delivered'),
( 3, 'DTDC',      'DT20012024', '2024-01-21', '2024-01-25', 'Delivered'),
( 4, 'Delhivery', 'DL02022024', '2024-02-03', '2024-02-06', 'Delivered'),
( 5, 'BlueDart',  'BD14022024', '2024-02-15', '2024-02-18', 'Delivered'),
( 6, 'Ekart',     'EK28022024', '2024-02-29', '2024-03-04', 'Delivered'),
( 7, 'India Post','IP10032024', '2024-03-11', '2024-03-15', 'Delivered'),
( 8, 'Delhivery', 'DL22032024', '2024-03-23', '2024-03-26', 'Delivered'),
( 9, 'BlueDart',  'BD01042024', '2024-04-02', '2024-04-05', 'Delivered'),
(10, 'DTDC',      'DT15042024', '2024-04-16', '2024-04-20', 'Delivered'),
(11, 'Ekart',     'EK03052024', '2024-05-04', NULL,          'In Transit'),
(12, 'Delhivery', 'DL17052024', '2024-05-18', NULL,          'In Transit'),
(14, 'BlueDart',  'BD18062024', '2024-06-19', '2024-06-22', 'Delivered'),
(15, 'India Post','IP04072024', '2024-07-05', '2024-07-10', 'Delivered'),
(16, 'Delhivery', 'DL20072024', '2024-07-21', '2024-07-24', 'Delivered'),
(18, 'Ekart',     'EK15082024', '2024-08-16', '2024-08-19', 'Delivered'),
(19, 'BlueDart',  'BD03092024', '2024-09-04', NULL,          'In Transit'),
(20, 'DTDC',      'DT19092024', '2024-09-20', '2024-09-23', 'Delivered'),
(21, 'India Post','IP05102024', '2024-10-06', '2024-10-12', 'Delivered'),
(24, 'Delhivery', 'DL25112024', '2024-11-26', '2024-11-29', 'Delivered');


INSERT INTO reviews (customer_id, product_id, rating, comment, review_date) VALUES
( 1,  1, 5, 'Excellent phone, great battery life and camera!',        '2024-01-12'),
( 2,  5, 4, 'Good fit and quality, true to size.',                   '2024-01-19'),
( 3,  3, 5, 'Laptop is super fast, worth every rupee.',              '2024-01-28'),
( 4,  2, 3, 'Decent headphones but bass could be stronger.',         '2024-02-08'),
( 5,  6, 5, 'Very comfortable, great for long walks.',               '2024-02-22'),
( 6, 11, 4, 'Air fryer works well, easy to clean.',                  '2024-03-05'),
( 7, 13, 5, 'Inspirational book, must read for every Indian.',       '2024-03-18'),
( 8,  4, 4, 'Good performance phone at this price range.',           '2024-04-01'),
( 9, 12, 3, 'Table is okay, assembly instructions could be clearer.','2024-04-10'),
(10, 16, 5, 'Best gym gloves under 500 rupees!',                     '2024-04-22'),
(12, 11, 5, 'Love the air fryer, made cooking so much easier.',      '2024-05-25'),
(14,  1, 4, 'Good phone overall, heating issue sometimes.',          '2024-06-25'),
(15,  5, 5, 'Perfect jeans, great material and stitching.',          '2024-07-12'),
(18, 17, 4, 'Good quality football, holds air well.',                '2024-12-02'),
(20, 19, 5, 'Serum shows visible results in 2 weeks, highly recommend.','2024-09-28');


SELECT 'customers'   AS tbl, COUNT(*) AS rows FROM customers   UNION ALL
SELECT 'products',            COUNT(*)         FROM products    UNION ALL
SELECT 'categories',          COUNT(*)         FROM categories  UNION ALL
SELECT 'orders',              COUNT(*)         FROM orders      UNION ALL
SELECT 'order_items',         COUNT(*)         FROM order_items UNION ALL
SELECT 'payments',            COUNT(*)         FROM payments    UNION ALL
SELECT 'shipping',            COUNT(*)         FROM shipping    UNION ALL
SELECT 'reviews',             COUNT(*)         FROM reviews;


#Query 1 — View all customers from Maharashtra

SELECT customer_id, full_name, city, state
FROM customers
WHERE state = 'Maharashtra'
ORDER BY city;

#Query 2 — All products under ₹1000, sorted by price

SELECT product_name, price, stock_quantity
FROM products
WHERE price < 1000
ORDER BY price ASC;

#Query 3 — Count of orders by status

SELECT status, COUNT(*) AS total_orders
FROM orders
GROUP BY status
ORDER BY total_orders DESC;

#Query 4 — Total revenue generated (all time)
SELECT 
    CONCAT('₹', FORMAT(SUM(total_amount), 2)) AS total_revenue
FROM orders
WHERE status != 'Cancelled';

#Query 5 — Most expensive products in each category

SELECT 
    c.category_name,
    p.product_name,
    p.price
FROM products p
JOIN categories c ON p.category_id = c.category_id
ORDER BY c.category_name, p.price DESC;

#Query 6 — Customers who registered in 2023 Q4 (Oct–Dec)

SELECT full_name, city, state, created_at
FROM customers
WHERE created_at BETWEEN '2023-10-01' AND '2023-12-31'
ORDER BY created_at;

#Query 7 — Products with low stock (below 100 units)

SELECT 
    product_name,
    stock_quantity,
    price,
    CASE 
        WHEN stock_quantity < 60  THEN 'Critical'
        WHEN stock_quantity < 100 THEN 'Low'
        ELSE 'OK'
    END AS stock_alert
FROM products
WHERE stock_quantity < 100
ORDER BY stock_quantity ASC;

#Query 8 — Orders placed in each month of 2024

SELECT 
    MONTHNAME(order_date) AS month_name,
    MONTH(order_date)     AS month_num,
    COUNT(*)              AS total_orders,
    SUM(total_amount)     AS monthly_revenue
FROM orders
WHERE YEAR(order_date) = 2024
GROUP BY MONTH(order_date), MONTHNAME(order_date)
ORDER BY month_num;

#Query 9 — Find all orders that used UPI payment

SELECT 
    o.order_id,
    c.full_name,
    o.total_amount,
    o.order_date,
    p.payment_status
FROM orders o
JOIN customers c  ON o.customer_id = c.customer_id
JOIN payments p   ON o.order_id    = p.order_id
WHERE p.payment_method = 'UPI'
ORDER BY o.order_date;

#Query 10 — Products that have never been reviewed

SELECT 
    p.product_id,
    p.product_name,
    p.price
FROM products p
LEFT JOIN reviews r ON p.product_id = r.product_id
WHERE r.review_id IS NULL
ORDER BY p.product_id;

#Query 11 — Average rating per product (only reviewed products)

SELECT 
    p.product_name,
    COUNT(r.review_id)      AS review_count,
    ROUND(AVG(r.rating), 1) AS avg_rating
FROM products p
JOIN reviews r ON p.product_id = r.product_id
GROUP BY p.product_id, p.product_name
ORDER BY avg_rating DESC, review_count DESC;

#Query 12 — Orders that are shipped but not yet delivered

SELECT 
    o.order_id,
    c.full_name,
    s.carrier,
    s.tracking_number,
    s.shipped_date,
    DATEDIFF(CURDATE(), s.shipped_date) AS days_in_transit
FROM orders o
JOIN customers c ON o.customer_id  = c.customer_id
JOIN shipping  s ON o.order_id     = s.order_id
WHERE s.delivered_date IS NULL
  AND s.shipping_status = 'In Transit'
ORDER BY s.shipped_date;

-- Should return 25 rows with customer names attached

SELECT o.order_id, c.full_name, o.order_date, o.status, o.total_amount
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
ORDER BY o.order_date;


