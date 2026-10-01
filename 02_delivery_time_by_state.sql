-- Question: How does actual delivery time vary by customer state?
-- Joins customers to orders, calculates days from purchase to delivery, averages by state.

SELECT
    c.customer_state,
    ROUND(AVG(o.order_delivered_customer_date::date - o.order_purchase_timestamp::date), 2) AS average_delivery_days
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_state
ORDER BY average_delivery_days ASC;
