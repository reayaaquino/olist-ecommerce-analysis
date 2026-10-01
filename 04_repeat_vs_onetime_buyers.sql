-- Question: What percentage of customers are repeat buyers vs. one-time buyers?
-- customer_unique_id is used instead of customer_id, since customer_id resets per order
-- in this dataset and doesn't reliably identify a person across multiple purchases.

WITH customer_orders AS (
    SELECT
        customer_unique_id,
        COUNT(*) AS order_count,
        CASE
            WHEN COUNT(*) > 1 THEN 'repeat'
            ELSE 'one-time'
        END AS customer_type
    FROM customers
    GROUP BY customer_unique_id
)
SELECT
    customer_type,
    COUNT(*) AS type_count,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS type_percent
FROM customer_orders
GROUP BY customer_type
ORDER BY type_count DESC;
