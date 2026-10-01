-- Question: What percentage of customers have an average order value above the overall average?
-- Three-CTE structure: per-customer averages, the single overall average (via CROSS JOIN),
-- then a CASE WHEN label, then a final grouped percentage.

WITH per_customer_cte AS (
    SELECT
        c.customer_unique_id,
        ROUND(AVG(price), 2) AS avg_order_value
    FROM orders o
    JOIN order_items i ON o.order_id = i.order_id
    JOIN customers c ON o.customer_id = c.customer_id
    GROUP BY c.customer_unique_id
),
total_cte AS (
    SELECT ROUND(AVG(price), 2) AS total_avg_order_value
    FROM order_items
),
average_type_cte AS (
    SELECT
        *,
        CASE
            WHEN avg_order_value > total_avg_order_value THEN 'above average'
            ELSE 'below average'
        END AS customer_type
    FROM per_customer_cte
    CROSS JOIN total_cte
)
SELECT
    customer_type,
    COUNT(*) AS type_count,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS type_percent
FROM average_type_cte
GROUP BY customer_type
ORDER BY customer_type ASC;
