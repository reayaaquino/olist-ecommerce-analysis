-- Question: What's the breakdown of order statuses, and what percentage does each represent?
-- Uses a window function (SUM(COUNT(*)) OVER()) to get each status's share of the total in one query.

SELECT
    order_status,
    COUNT(*) AS status_count,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM orders
GROUP BY order_status
ORDER BY status_count DESC;
