/*====================================================
  RETAILIQ - INSTACART SQL BUSINESS ANALYSIS
  SECTION 1 : BASIC BUSINESS METRICS
====================================================*/

-- 1. How many unique customers are there ?
SELECT COUNT(DISTINCT user_id) AS unique_customers
FROM instacart.orders;

--Business value : 
--Measures the size of the customer base .
--Helps in KPI and customer growth tracking .

-- 2. How many total orders have been placed?
SELECT COUNT(*) AS total_orders
FROM instacart.orders;

--Business value :
--Indicates total platform activity and engagement.

-- 3. How many unique products are available?
SELECT COUNT(DISTINCT product_id) AS unique_products
FROM instacart.order_products;

--Business value :
--Indicates the variety of products available.

-- 4. What is the average number of orders placed per customer?
SELECT AVG(order_count) AS avg_orders_per_customer
FROM (
    SELECT user_id, COUNT(*) AS order_count
    FROM instacart.orders
    GROUP BY user_id
) AS customer_orders;

--Business value :
--Helps identify wheather customers are highly active or occasional shoppers.

-- 5. What is the average basket size (products per order)?
SELECT AVG(product_count) AS avg_basket_size
FROM (
    SELECT order_id, COUNT(*) AS product_count
    FROM instacart.order_products
    GROUP BY order_id
) AS order_baskets;

--Business value :
--Measures customer purchasing behaviour and helps in inventory planning.
