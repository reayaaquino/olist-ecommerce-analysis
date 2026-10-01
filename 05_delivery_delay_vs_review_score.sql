-- Question: Is there a relationship between delivery delay and review score?
-- First version: average delay across ALL orders per review score.
-- Second version: filtered to only orders that were genuinely late, to isolate the effect.

-- All orders
WITH delivery AS (
    SELECT
        r.review_score,
        ROUND(AVG(o.order_delivered_customer_date::date - o.order_estimated_delivery_date::date), 2) AS avg_delivery_delay,
        ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS percent_of_orders
    FROM order_reviews r
    JOIN orders o ON r.order_id = o.order_id
    GROUP BY r.review_score
)
SELECT
    review_score,
    CASE
        WHEN avg_delivery_delay < 0 THEN ABS(avg_delivery_delay) || ' days early'
        ELSE avg_delivery_delay || ' days late'
    END AS avg_delivery_duration,
    percent_of_orders
FROM delivery
ORDER BY review_score DESC;

-- Only genuinely late orders
WITH delivery AS (
    SELECT
        r.review_score,
        ROUND(AVG(o.order_delivered_customer_date::date - o.order_estimated_delivery_date::date), 2) AS avg_delivery_delay,
        ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS percent_of_orders
    FROM order_reviews r
    JOIN orders o ON r.order_id = o.order_id
    WHERE o.order_delivered_customer_date::date - o.order_estimated_delivery_date::date > 0
    GROUP BY r.review_score
)
SELECT
    review_score,
    avg_delivery_delay || ' days late' AS avg_delivery_duration,
    percent_of_orders
FROM delivery
ORDER BY review_score DESC;
