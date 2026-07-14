# Data Dictionary

## Dataset
Instacart Market Basket Analysis

---

## Table: orders

| Column | Data Type | Description |
|---------|-----------|-------------|
| order_id | Integer | Unique identifier for each order |
| customer_id | Integer | Unique identifier for each customer |
| eval_set | String | Indicates whether the order belongs to the prior, train, or test dataset |
| order_number | Integer | Sequence number of the customer's order |
| order_dow | Integer | Day of the week when the order was placed (0–6) |
| order_hour_of_day | Integer | Hour of the day when the order was placed (0–23) |
| days_since_prior_order | Float | Days since the customer's previous order |

**Primary Key:** `order_id`

**Foreign Keys:** None

**Business Meaning:**
Each row represents one order placed by a customer.

---

## Table: products

| Column | Data Type | Description |
|---------|-----------|-------------|
| product_id | Integer | Unique product identifier |
| product_name | String | Name of the product |
| aisle_id | Integer | References the aisle the product belongs to |
| department_id | Integer | References the department the product belongs to |

**Primary Key:** `product_id`

**Foreign Keys:**
- aisle_id → aisles.aisle_id
- department_id → departments.department_id

**Business Meaning:**
Each row represents a product sold by Instacart.


---

## Table: aisles

| Column | Data Type | Description |
|---------|-----------|-------------|
| aisle_id | Integer  | Unique product identifier |
| aisle    | String   | Name of the aisle |

**Primary Key:** `aisle_id`

**Foreign Keys:** None

**Business Meaning:**
Each row represents a aisle id and aisle name.

---

## Table : deparments

| Column | Data Type | Description |
|---------|-----------|-------------|
| department_id | Integer  | Unique product identifier |
| department   | String   | Name of the aisle |

**Primary Key:** `department_id`

**Foreign Keys:** None

**Business Meaning:**
Each row represents a department id and department name.

---

## Table : order_products_prior

| Column | Data Type | Description |
|---------|-----------|-------------|
| order_id | Integer  | Unique Identifier for each order |
| product_id  | Integer | Unique Identifier for each product |
| add_to_cart | Integer | Item number which is being add to cart for that particular order_id |
| reorder | Integer | Tells is the item is being reordered or not |

**Primary Keys:**  `order_id` + `product_id`

**Foreign Keys:** 
- order_id → orders.order_id
- product_id → products.product_id

**Business Meaning :**
Each row represents for a order id which products are being add to cart and are reordered or not .

---


