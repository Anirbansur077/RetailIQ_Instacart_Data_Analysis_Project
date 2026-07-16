/*====================================================
  RETAILIQ - INSTACART SQL BUSINESS ANALYSIS
  SECTION 5 : TIME-BASED ANALYSIS
====================================================*/

--1. Orders by Day of Week

SELECT
    CASE order_dow
        WHEN 0 THEN 'Sunday'
        WHEN 1 THEN 'Monday'
        WHEN 2 THEN 'Tuesday'
        WHEN 3 THEN 'Wednesday'
        WHEN 4 THEN 'Thursday'
        WHEN 5 THEN 'Friday'
        WHEN 6 THEN 'Saturday'
    END AS day_of_week,

    COUNT(order_id) AS total_orders

FROM orders

GROUP BY order_dow

ORDER BY total_orders DESC;

--Business value :
--Helps identify peak shopping days, which can inform staffing and inventory decisions.

--2. Orders by Hour of Day

SELECT

    order_hour_of_day,

    COUNT(order_id) AS total_orders

FROM orders

GROUP BY order_hour_of_day

ORDER BY total_orders DESC;

--Business value :
--Helps identify peak shopping hours, which can inform staffing and inventory decisions.

--3. Average Basket Size by Hour

WITH basket_size AS
(
    SELECT
        o.order_id,
        o.order_hour_of_day,
        COUNT(op.product_id) AS basket_size

    FROM orders o

    JOIN order_products__prior op
        ON o.order_id = op.order_id

    GROUP BY
        o.order_id,
        o.order_hour_of_day
)

SELECT

    order_hour_of_day,

    ROUND(
        AVG(basket_size),
        2
    ) AS avg_basket_size

FROM basket_size

GROUP BY order_hour_of_day

ORDER BY order_hour_of_day;

--Business value :
--Helps identify how basket size varies throughout the day, which can inform marketing and promotional strategies.

--4.  Weekday vs Weekend Ordering Behavior

SELECT

    CASE
        WHEN order_dow IN (0,6)
            THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,

    COUNT(order_id) AS total_orders,

    ROUND(
        COUNT(order_id) /
        CASE
            WHEN order_dow IN (0,6) THEN 2
            ELSE 5
        END,
        2
    ) AS avg_orders_per_day

FROM orders

GROUP BY day_type;

--Business value :
--Provides a fair comparison by accounting for the different number of weekdays (5) and weekend days (2).
--Helps plan staffing and promotions more effectively.

