# ecommerce-sql-project
E-Commerce Sales Analytics project using MySQL

## Overview
A complete relational database project simulating an Indian 
e-commerce platform, built using MySQL.

## Database Schema
8 tables fully normalized with proper relationships:
- customers — 20 customers across 12 Indian states
- products — 20 products across 8 categories  
- categories — 8 product categories
- orders — 25 orders with status tracking
- order_items — 30 line items linking orders to products
- payments — 22 records (UPI, Credit Card, COD, Net Banking)
- shipping — 20 records with carrier and tracking info
- reviews — 15 product reviews with star ratings

## SQL Concepts Used
- CREATE TABLE with PRIMARY KEY, FOREIGN KEY, CHECK constraints
- INSERT with realistic Indian e-commerce data (140+ rows)
- SELECT with WHERE, ORDER BY, LIMIT
- GROUP BY with COUNT, SUM, AVG
- INNER JOIN across 3 tables
- LEFT JOIN to find unmatched records
- CASE WHEN for conditional logic
- Date functions: DATEDIFF, MONTHNAME, YEAR
- IS NULL / IS NOT NULL

## Sample Queries
### Total orders by status
SELECT status, COUNT(*) AS total_orders
FROM orders
GROUP BY status
ORDER BY total_orders DESC;

### Monthly revenue for 2024
SELECT MONTHNAME(order_date) AS month,
       COUNT(*) AS orders,
       SUM(total_amount) AS revenue
FROM orders
WHERE YEAR(order_date) = 2024
GROUP BY MONTH(order_date), MONTHNAME(order_date)
ORDER BY MONTH(order_date);

## Tools Used
- MySQL 8.0
- MySQL Workbench

## How to Run
1. Open MySQL Workbench
2. Open the ecommerce_analytics.sql file
3. Run the full script — it creates the database,
   tables and inserts all data automatically
