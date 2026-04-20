-- Question 1: How has monthly revenue trended over time?
-- Filters to delivered orders only. Excludes 2016 due to incomplete data.

SELECT
    STRFTIME('%Y-%m', order_purchase_timestamp) AS month,
    ROUND(SUM(oi.price), 2)                     AS total_revenue,
    COUNT(DISTINCT o.order_id)                  AS total_orders
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
  AND o.order_purchase_timestamp >= '2017-01-01'
  AND o.order_purchase_timestamp <= '2018-09-01'
GROUP BY STRFTIME('%Y-%m', o.order_purchase_timestamp)
ORDER BY month;
