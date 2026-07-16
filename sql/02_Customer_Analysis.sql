/*====================================================
  RETAILIQ - INSTACART SQL BUSINESS ANALYSIS
  SECTION 2 : CUSTOMER ANALYSIS
====================================================*/


--1. Top 20 Customers by Total Number of Orders

SELECT
    user_id,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY user_id
ORDER BY total_orders DESC
LIMIT 20;

--Business value :
--Identifies the most active customers, which can help in targeted marketing and loyalty programs.

--2. Customers with the Highest Number of Products Purchased

SELECT
    o.user_id,
    COUNT(op.product_id) AS total_products_purchased
FROM orders o
JOIN order_products__prior op
    ON o.order_id = op.order_id
GROUP BY o.user_id
ORDER BY total_products_purchased DESC
LIMIT 20;

--Business value :
--Helps identify the most loyal customers and those with high purchasing power.

--3.Customers with the Highest Reorder Rate

SELECT
    o.user_id,

    COUNT(op.product_id) AS total_products,

    SUM(op.reordered) AS reordered_products,

    ROUND(
        SUM(op.reordered) * 100.0 /
        COUNT(op.product_id),
        2
    ) AS reorder_rate
FROM orders o
JOIN order_products__prior op
    ON o.order_id = op.order_id
GROUP BY o.user_id
ORDER BY reorder_rate DESC
LIMIT 20;

--Business value :
--Helps identify customers who are likely to continue purchasing from the platform and useful for retention campaigns and subscription serviecs.

--4. Customers Who Placed Only One Order

SELECT
    user_id,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY user_id
HAVING total_orders = 1;

--Business value :
--Identifies one-time customers, which can help in understanding customer churn and improving retention strategies.

--5. Most Loyal Customers Based on Average Days Between Orders

SELECT
    user_id,

    ROUND(
        AVG(days_since_prior_order),
        2
    ) AS avg_days_between_orders,

    COUNT(order_id) AS total_orders

FROM orders

WHERE days_since_prior_order IS NOT NULL

GROUP BY user_id

HAVING COUNT(order_id) > 1

ORDER BY avg_days_between_orders ASC,
         total_orders DESC

LIMIT 20;

--Business value :
--Identifies the most loyal customers based on their ordering frequency, which can help in targeted marketing campaigns.

