-- Question 3: Which Brazilian states generate the most orders and revenue?
-- Note: customer state lives in the customers table, not the orders table.

SELECT
    c.customer_state                                         AS state,
    ROUND(SUM(oi.price), 2)                                  AS revenue,
    COUNT(DISTINCT o.order_id)                               AS total_orders,
    ROUND(SUM(oi.price) / COUNT(DISTINCT o.order_id), 2)    AS avg_order_value
FROM customers c
JOIN orders o      ON c.customer_id = o.customer_id
JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_state
ORDER BY revenue DESC;
