# Olist E-Commerce Analytics

**SQL-driven business analysis of 100,000+ real orders from Brazil's largest online marketplace**

> **Tools:** SQLite · SQL (JOINs, Window Functions, CASE, CTEs) · Python (Pandas, Matplotlib) · Tableau *(in progress)*

---

## Project Overview

The [Olist dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) contains real transactional data from a Brazilian e-commerce marketplace spanning 2016–2018. I modeled 9 relational tables to answer six core business questions that any e-commerce analytics team would prioritize — revenue performance, product mix, geographic concentration, payment behavior, customer satisfaction, and customer lifetime value.

Each question was formulated as a business problem first, then translated into SQL. Results were visualized in Python and compiled into a portfolio document.

---

## Database Schema

| Table | Contents | Key Columns |
|---|---|---|
| `orders` | One row per order — status, timestamps | `order_id`, `customer_id` |
| `order_items` | Items per order — price, product, seller | `order_id`, `product_id` |
| `order_payments` | Payment type, installments, value | `order_id` |
| `order_reviews` | Customer review score and comment | `order_id` |
| `customers` | Customer location (city, state) | `customer_id`, `customer_unique_id` |
| `products` | Product details and category | `product_id` |
| `sellers` | Seller location | `seller_id` |
| `category_translation` | Portuguese → English category names | `product_category_name` |
| `geolocation` | Zip code coordinates | `geolocation_zip_code_prefix` |

---

## Business Questions & Key Findings

### Q1 — Monthly Revenue Trend
**Finding:** Revenue grew consistently throughout 2017, with a sharp Black Friday spike in November 2017. The pattern confirms strong seasonality that should directly inform inventory planning and marketing spend allocation.

→ [SQL](sql/q1_monthly_revenue.sql)

---

### Q2 — Top Product Categories by Revenue
**Finding:** Health & Beauty leads at R$1.23M, followed by Watches/Gifts and Bed/Bath/Table. These three categories alone represent a disproportionate share of total revenue — a classic Pareto distribution that signals where to concentrate seller recruitment and promotional investment.

→ [SQL](sql/q2_category_revenue.sql)

---

### Q3 — Revenue and Orders by State
**Finding:** São Paulo dominates both order volume and total revenue. However, average order value is more evenly distributed — secondary states like MG, RJ, and RS show strong AOV despite lower volume, indicating under-penetrated markets with real purchase intent.

→ [SQL](sql/q3_state_revenue.sql)

---

### Q4 — Payment Method & Installment Behavior
**Finding:** Credit card accounts for 73.9% of all transactions. Among credit card users, a meaningful cluster splits purchases across 6–10 installments — spreading larger purchases across months. This has direct implications for cash flow management and seller payment timing.

→ [SQL](sql/q4_payment_behavior.sql)

---

### Q5 — Delivery Speed vs. Customer Review Score
**Finding:** Review scores drop from 4.42 → 3.12 as delivery time increases from under 7 days to over 21 days — a 1.3-point decline across 84,000+ reviewed orders. This directly quantifies the ROI of logistics investment in measurable customer satisfaction terms.

→ [SQL](sql/q5_delivery_vs_reviews.sql)

---

### Q6 — Customer Value Segmentation
**Finding:** 57% of customers fall in the Low spend tier (under R$100). The VIP segment — just 938 customers (1% of the base) — generates R$1.52M, averaging R$1,620 per customer. Classic long-tail distribution that supports targeted retention spend for high-value segments.

→ [SQL](sql/q6_customer_segments.sql)

---

## Repository Structure

```
olist-ecommerce-analysis/
├── sql/
│   ├── q1_monthly_revenue.sql
│   ├── q2_category_revenue.sql
│   ├── q3_state_revenue.sql
│   ├── q4_payment_behavior.sql
│   ├── q5_delivery_vs_reviews.sql
│   └── q6_customer_segments.sql
├── data/
│   └── (CSV exports from each query — for Tableau)
└── README.md
```

---

## SQL Techniques Used

- Multi-table JOINs (up to 4 tables in a single query)
- `CASE / WHEN` bucketing for custom segmentation
- Aggregate functions: `SUM`, `COUNT DISTINCT`, `AVG`, `ROUND`
- Window functions: `SUM() OVER()` for percentage calculations
- Date functions: `STRFTIME`, `JULIANDAY`
- Nested subqueries / derived tables
- NULL handling and status-based filtering

---

## Next Steps

- [ ] Export all query results as CSVs to `/data/`
- [ ] Build Tableau Public dashboard (Revenue · Categories · Geography · Satisfaction)
- [ ] Add Tableau link here once published

---

*Rodrigo Ramirez · UT Austin BBA, Management Information Systems & Analytics · [LinkedIn](https://linkedin.com/in/rodrigoramirezut) · [GitHub](https://github.com/rorc02)*
