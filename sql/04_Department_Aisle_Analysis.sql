/*====================================================
  RETAILIQ - INSTACART SQL BUSINESS ANALYSIS
  SECTION 4 : DEPARTMENT AND AISLE ANALYSIS
====================================================*/

-- 1. Departments with the Highest Product Purchases

SELECT

    d.department_id,
    d.department,

    COUNT(op.product_id) AS total_products_purchased

FROM order_products_prior op

JOIN products p
    ON op.product_id = p.product_id

JOIN departments d
    ON p.department_id = d.department_id

GROUP BY
    d.department_id,
    d.department

ORDER BY total_products_purchased DESC;

--Business value :
--Helps identify the most popular departments, which can inform inventory management and marketing strategies.

--2. Most Popular Aisles

SELECT

    a.aisle_id,
    a.aisle,

    COUNT(op.product_id) AS total_products_purchased

FROM order_products__prior op

JOIN products p
    ON op.product_id = p.product_id

JOIN aisles a
    ON p.aisle_id = a.aisle_id

GROUP BY
    a.aisle_id,
    a.aisle

ORDER BY total_products_purchased DESC
LIMIT 20;

--Business value :
Identifies the busiest shopping aisles.

--3.Departments with the Highest Reorder Rates

SELECT

    d.department_id,
    d.department,

    COUNT(*) AS total_purchases,

    SUM(op.reordered) AS reordered_products,

    ROUND(
        SUM(op.reordered) * 100.0 /
        COUNT(*),
        2
    ) AS reorder_rate

FROM order_products__prior op

JOIN products p
    ON op.product_id = p.product_id

JOIN departments d
    ON p.department_id = d.department_id

GROUP BY
    d.department_id,
    d.department

ORDER BY reorder_rate DESC;

--Business value :
--Helps identify departments that customers are likely to reorder from, which can inform inventory planning and promotional strategies.

--4. Aisles with the Highest Reorder Rates

SELECT

    a.aisle_id,
    a.aisle,

    COUNT(*) AS total_purchases,

    SUM(op.reordered) AS reordered_products,

    ROUND(
        SUM(op.reordered) * 100.0 /
        COUNT(*),
        2
    ) AS reorder_rate

FROM order_products__prior op

JOIN products p
    ON op.product_id = p.product_id

JOIN aisles a
    ON p.aisle_id = a.aisle_id

GROUP BY
    a.aisle_id,
    a.aisle

ORDER BY reorder_rate DESC
LIMIT 20;

--Business value :
--Identifies the most loyal product categories.

