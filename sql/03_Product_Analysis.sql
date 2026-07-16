/*====================================================
  RETAILIQ - INSTACART SQL BUSINESS ANALYSIS
  SECTION 3 : PRODUCT ANALYSIS
====================================================*/

--1. Top 20 Most Ordered Products

SELECT
    p.product_id,
    p.product_name,
    COUNT(op.product_id) AS total_orders
FROM order_products_prior op
JOIN products p
    ON op.product_id = p.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY total_orders DESC
LIMIT 20;

--Business value :
--Identifies the most popular products, which can help in inventory management and marketing strategies.

--2. Products with Highest Reorder Rates

SELECT
    p.product_id,
    p.product_name,

    COUNT(*) AS total_purchases,

    SUM(op.reordered) AS reordered_count,

    ROUND(
        SUM(op.reordered) * 100.0 /
        COUNT(*),
        2
    ) AS reorder_rate
FROM order_products_prior op
JOIN products p
    ON op.product_id = p.product_id
GROUP BY
    p.product_id,
    p.product_name
HAVING COUNT(*) >= 100
ORDER BY reorder_rate DESC
LIMIT 20;

--Having COUNT(*) >= 100 ensures that we only consider products with a significant number of purchases to avoid skewed results from products with very few orders.

--Business value :
--Helps identify products that customers are likely to reorder, which can inform inventory planning and promotional strategies.

--3. Rarely Purchased Products

SELECT
    p.product_id,
    p.product_name,
    COUNT(op.product_id) AS total_purchases
FROM products p
LEFT JOIN order_products_prior op
    ON p.product_id = op.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY total_purchases ASC
LIMIT 20;

--Business value :
--Identifies products that are not frequently purchased, which can help in inventory management and promotional strategies.

--4. Products Appearing in the Highest Number of Unique Orders

SELECT
    p.product_id,
    p.product_name,

    COUNT(DISTINCT op.order_id) AS unique_orders

FROM order_products_prior op

JOIN products p
    ON op.product_id = p.product_id

GROUP BY
    p.product_id,
    p.product_name

ORDER BY unique_orders DESC

LIMIT 20;

--Business value :
--Useful for identifying universally popular products .

--5. Products Contributing Most to Customer Baskets

SELECT
    p.product_id,
    p.product_name,

    COUNT(op.order_id) AS basket_frequency

FROM order_products_prior op

JOIN products p
    ON op.product_id = p.product_id

GROUP BY
    p.product_id,
    p.product_name

ORDER BY basket_frequency DESC

LIMIT 20;

--Business value :
--Identifies products that are core components of shopping baskets.
