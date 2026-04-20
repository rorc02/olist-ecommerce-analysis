-- Question 6: What does the customer value distribution look like?
-- Uses customer_unique_id (not customer_id) to correctly identify repeat customers.
-- One real person can have multiple customer_id values across different orders.

-- Part A: Top individual customers by spend
SELECT
    c.customer_unique_id,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2)    AS total_spend
FROM customers c
JOIN orders o      ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_unique_id
ORDER BY total_spend DESC
LIMIT 20;

-- Part B: Customer value segmentation
SELECT
    CASE
        WHEN total_spend < 100             THEN '1. Low (under $100)'
        WHEN total_spend BETWEEN 100 AND 300 THEN '2. Mid ($100-$300)'
        WHEN total_spend BETWEEN 300 AND 1000 THEN '3. High ($300-$1K)'
        ELSE '4. VIP (over $1K)'
    END AS segment,
    COUNT(*) AS customers,
    ROUND(AVG(total_spend), 2) AS avg_spend,
    ROUND(SUM(total_spend), 2) AS total_revenue
FROM (
    SELECT
        c.customer_unique_id,
        ROUND(SUM(oi.price), 2) AS total_spend
    FROM customers c
    JOIN orders o      ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
) sub
GROUP BY segment
ORDER BY segment;
