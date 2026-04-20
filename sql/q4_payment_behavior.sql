-- Question 4: How do customers pay, and what does installment behavior reveal?

-- Part A: Payment method breakdown
-- Uses a window function (SUM OVER) to calculate share of transactions without a subquery.
SELECT
    payment_type,
    COUNT(*) AS transactions,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 1) AS pct_of_transactions,
    ROUND(SUM(payment_value), 2)                       AS total_value,
    ROUND(AVG(payment_value), 2)                       AS avg_payment_value,
    ROUND(AVG(payment_installments), 1)                AS avg_installments
FROM order_payments
WHERE payment_type != 'not_defined'
GROUP BY payment_type
ORDER BY transactions DESC;

-- Part B: Credit card installment distribution
SELECT
    payment_installments AS installments,
    COUNT(*) AS count,
    ROUND(AVG(payment_value), 2) AS avg_value
FROM order_payments
WHERE payment_type = 'credit_card'
  AND payment_installments BETWEEN 1 AND 12
GROUP BY installments
ORDER BY installments;
