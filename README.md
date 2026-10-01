# Olist E-Commerce SQL Analysis

I built this project to practice SQL beyond tutorials, using a real, messy e-commerce
dataset instead of pre-cleaned exercise data. I'm transitioning from a Power BI/reporting
background into SQL-first analysis, and wanted a project that actually forced me to debug,
question assumptions about the data, and build up from simple aggregates to multi-step CTEs.

I set up PostgreSQL locally, designed the schema myself (tables, keys, relationships), and
loaded the Olist Brazilian e-commerce dataset (around 100K orders) from Kaggle to work
through a series of real business questions.

## What I found

Order fulfillment was strong overall. 97% of orders were delivered successfully, with
cancellations under 1%. But delivery time varied a lot by region: São Paulo customers
averaged 8.7 days, while customers in Roraima waited closer to 29 days, which points to a
real logistics gap rather than random noise.

Seller revenue turned out to be very fragmented. Even the top seller only accounts for
1.7% of total platform revenue, so no single seller is carrying the marketplace.

Repeat purchases were rare: just 3% of customers bought more than once. That's a retention
problem worth digging into further if this were a live business.

The most interesting finding was around delivery delay and reviews. Looking at all orders,
even 1-star reviews were technically delivered a few days early on average, which seemed
to contradict the obvious assumption. So I isolated just the orders that were genuinely
late, and the pattern became clear: among late orders, 1-star reviews made up over half,
compared to about 16% for 5-star. Lateness clearly hurts reviews, but it's not the only
thing driving low scores.

Lastly, only 30% of customers have an average order value above the overall average. A
reminder that a single average can be pulled upward by a smaller group of high spenders.

## Files

- `01_order_status_breakdown.sql`: order status mix and percentage breakdown
- `02_delivery_time_by_state.sql`: average delivery time by customer state
- `03_seller_revenue_share.sql`: top sellers by revenue and market share
- `04_repeat_vs_onetime_buyers.sql`: repeat vs. one-time buyer split
- `05_delivery_delay_vs_review_score.sql`: delivery delay vs. review score, including the late-orders-only comparison
- `06_above_average_order_value.sql`: customers above vs. below the overall average order value

## Tools and techniques

PostgreSQL, built and queried locally. Multi-table joins, CTEs (including chained CTEs),
window functions (including nested/double-aggregate patterns like SUM(SUM(x)) OVER()),
CASE WHEN labeling, and CROSS JOIN.

## Dataset

[Olist Brazilian E-Commerce Public Dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce), via Kaggle.
