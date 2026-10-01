# Olist E-Commerce SQL Analysis

A SQL analysis of the Brazilian Olist e-commerce dataset (~100K orders), exploring delivery
performance, customer behavior, and seller revenue using PostgreSQL. Built as part of upskilling
toward Analytics Engineering, moving from a Power BI/reporting background into SQL-first analysis.

## Tools
PostgreSQL, built and queried locally. Dataset sourced from Kaggle (Olist Brazilian E-Commerce
Public Dataset), loaded into a relational schema with foreign key relationships across customers,
orders, order items, and reviews.

## Key Findings

1. **Order status breakdown** — 97.0% of orders were successfully delivered, with cancellations
   accounting for only 0.6%.
2. **Delivery time varies significantly by region** — São Paulo customers saw the fastest average
   delivery (8.7 days), while Roraima saw the slowest (29.3 days) — a 3x+ difference likely tied
   to logistics infrastructure.
3. **Seller revenue is highly fragmented** — the top seller accounts for only 1.69% of total
   platform revenue, indicating no single seller dominates the marketplace.
4. **Low repeat-purchase rate** — only 3.1% of customers are repeat buyers; 96.9% purchase once.
5. **Delivery delay is a strong driver of poor reviews** — among orders that were genuinely
   late, 1-star reviews jumped to 53.7% of all late orders (vs. 16.5% for 5-star), with average
   lateness also increasing as review score dropped.
6. **A small customer segment pulls the average up** — only 30.2% of customers have an average
   order value above the overall average, showing the metric is skewed by a smaller group of
   higher-spending customers.

## Files

| File | Question |
|---|---|
| `01_order_status_breakdown.sql` | What's the breakdown of order statuses? |
| `02_delivery_time_by_state.sql` | How does delivery time vary by state? |
| `03_seller_revenue_share.sql` | Which sellers drive the most revenue? |
| `04_repeat_vs_onetime_buyers.sql` | What share of customers are repeat buyers? |
| `05_delivery_delay_vs_review_score.sql` | Does delivery delay affect review scores? |
| `06_above_average_order_value.sql` | What % of customers spend above the average? |

## Techniques Used
Multi-table joins, CTEs (including chained/nested CTEs), window functions
(`SUM() OVER()`, including double-aggregate patterns), `CASE WHEN` labeling, `CROSS JOIN`,
and percentage/share calculations.

## Dataset Source
[Olist Brazilian E-Commerce Public Dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) via Kaggle.
