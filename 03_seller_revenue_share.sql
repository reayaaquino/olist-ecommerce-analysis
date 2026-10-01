-- Question: Which sellers bring in the most revenue, and what share of total revenue does each hold?
-- Uses a double aggregate window function (SUM(SUM(price)) OVER()) since the raw column
-- isn't visible anymore once GROUP BY has already collapsed rows.

SELECT
    seller_id,
    SUM(price) AS revenue,
    ROUND(100.0 * SUM(price) / SUM(SUM(price)) OVER (), 2) AS revenue_percentage
FROM order_items
GROUP BY seller_id
ORDER BY revenue DESC
LIMIT 10;
