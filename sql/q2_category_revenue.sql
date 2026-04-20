-- Question 2: Which product categories drive the most revenue?
-- Joins 4 tables. LEFT JOIN on category_translation retains products without a mapped English name.

SELECT
    ct.product_category_name_english AS product_category,
    ROUND(SUM(oi.price), 2)          AS revenue
FROM orders o
JOIN order_items oi        ON o.order_id = oi.order_id
JOIN products p            ON oi.product_id = p.product_id
JOIN category_translation ct
    ON p.product_category_name = ct.product_category_name
WHERE o.order_status = 'delivered'
GROUP BY ct.product_category_name_english
ORDER BY revenue DESC
LIMIT 10;
