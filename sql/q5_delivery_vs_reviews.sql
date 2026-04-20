-- Question 5: Does faster delivery lead to better customer reviews?
-- Uses JULIANDAY() to calculate delivery duration and CASE to bucket into ranges.
-- NOTE: review_score lives in order_reviews (r), not in orders (o).

SELECT
    CASE
        WHEN JULIANDAY(o.order_delivered_customer_date)
           - JULIANDAY(o.order_purchase_timestamp) <= 7
            THEN 'Under 7 days'
        WHEN JULIANDAY(o.order_delivered_customer_date)
           - JULIANDAY(o.order_purchase_timestamp) BETWEEN 8 AND 14
            THEN '8-14 days'
        WHEN JULIANDAY(o.order_delivered_customer_date)
           - JULIANDAY(o.order_purchase_timestamp) BETWEEN 15 AND 21
            THEN '15-21 days'
        WHEN JULIANDAY(o.order_delivered_customer_date)
           - JULIANDAY(o.order_purchase_timestamp) > 21
            THEN 'Over 21 days'
        ELSE 'Unknown'
    END AS delivery_bucket,
    ROUND(AVG(r.review_score), 2) AS average_review,
    COUNT(DISTINCT o.order_id)    AS total_orders
FROM orders o
JOIN order_reviews r ON o.order_id = r.order_id
WHERE o.order_delivered_customer_date IS NOT NULL
GROUP BY delivery_bucket
ORDER BY
    CASE
        WHEN JULIANDAY(o.order_delivered_customer_date)
           - JULIANDAY(o.order_purchase_timestamp) <= 7    THEN 1
        WHEN JULIANDAY(o.order_delivered_customer_date)
           - JULIANDAY(o.order_purchase_timestamp) BETWEEN 8 AND 14  THEN 2
        WHEN JULIANDAY(o.order_delivered_customer_date)
           - JULIANDAY(o.order_purchase_timestamp) BETWEEN 15 AND 21 THEN 3
        WHEN JULIANDAY(o.order_delivered_customer_date)
           - JULIANDAY(o.order_purchase_timestamp) > 21   THEN 4
        ELSE 5
    END;
