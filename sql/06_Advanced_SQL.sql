/*====================================================
  RETAILIQ - INSTACART SQL BUSINESS ANALYSIS
  SECTION 5 :  ADVANCED SQL
====================================================*/

--1. Rank the Top 10 Products Within Each Department

WITH product_sales AS
(
    SELECT

        d.department_id,
        d.department,

        p.product_id,
        p.product_name,

        COUNT(op.product_id) AS total_purchases

    FROM order_products__prior op

    JOIN products p
        ON op.product_id = p.product_id

    JOIN departments d
        ON p.department_id = d.department_id

    GROUP BY
        d.department_id,
        d.department,
        p.product_id,
        p.product_name
),

ranked_products AS
(
    SELECT

        *,

        ROW_NUMBER() OVER
        (
            PARTITION BY department_id
            ORDER BY total_purchases DESC
        ) AS product_rank

    FROM product_sales
)

SELECT

    department,
    product_name,
    total_purchases,
    product_rank

FROM ranked_products

WHERE product_rank <= 10

ORDER BY
    department,
    product_rank;

-- Business value: 
--Prioritize inventory for the top-ranked products.
--Use the rankings to inform shelf placement and merchandising decisions.

--2. Top 5 Customers in Each Department

WITH customer_department_purchase AS
(
    SELECT
        d.department_id,
        d.department,
        o.user_id,
        COUNT(op.product_id) AS total_products
    FROM orders o
    JOIN order_products__prior op
        ON o.order_id = op.order_id
    JOIN products p
        ON op.product_id = p.product_id
    JOIN departments d
        ON p.department_id = d.department_id
    GROUP BY
        d.department_id,
        d.department,
        o.user_id
),

ranked_customers AS
(
    SELECT
        *,
        DENSE_RANK() OVER(
            PARTITION BY department_id
            ORDER BY total_products DESC
        ) AS customer_rank
    FROM customer_department_purchase
)

SELECT
    department,
    user_id,
    total_products,
    customer_rank
FROM ranked_customers
WHERE customer_rank <= 5
ORDER BY department, customer_rank;

--Business Value :
--Supports personalized marketing by targeting customers with department-specific offers.

--3. Cumulative Orders by Order Number

SELECT

    order_number,

    COUNT(*) AS orders,

    SUM(COUNT(*)) OVER(
        ORDER BY order_number
    ) AS cumulative_orders

FROM orders

GROUP BY order_number

ORDER BY order_number;

--Business value :
--Useful for evaluating the impact of marketing campaigns and seasonal demand.

--4. Latest Basket vs Previous Basket

WITH basket_size AS
(
    SELECT
        o.user_id,
        o.order_id,
        o.order_number,
        COUNT(op.product_id) AS basket_size
    FROM orders o
    JOIN order_products__prior op
        ON o.order_id = op.order_id
    GROUP BY
        o.user_id,
        o.order_id,
        o.order_number
),

basket_compare AS
(
    SELECT
        *,
        LAG(basket_size) OVER(
            PARTITION BY user_id
            ORDER BY order_number
        ) AS previous_basket
    FROM basket_size
)

SELECT
    user_id,
    order_number,
    basket_size,
    previous_basket
FROM basket_compare
WHERE previous_basket IS NOT NULL
  AND basket_size > previous_basket
ORDER BY user_id;

--Business value :
--Detects customers whose purchasing behavior is increasing.

--5. Rank Departments by Average Basket Size

WITH basket_department AS
(
    SELECT
        o.order_id,
        d.department_id,
        d.department,
        COUNT(op.product_id) AS basket_size

    FROM orders o

    JOIN order_products__prior op
        ON o.order_id = op.order_id

    JOIN products p
        ON op.product_id = p.product_id

    JOIN departments d
        ON p.department_id = d.department_id

    GROUP BY
        o.order_id,
        d.department_id,
        d.department
),

department_average AS
(
    SELECT
        department,
        ROUND(AVG(basket_size),2) AS avg_basket_size
    FROM basket_department
    GROUP BY department
)

SELECT
    department,
    avg_basket_size,

    DENSE_RANK() OVER(
        ORDER BY avg_basket_size DESC
    ) AS department_rank

FROM department_average

ORDER BY department_rank;

--Business Value :
--Supports cross-selling and bundle promotion strategies.