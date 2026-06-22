# Analysis Notes & Iteration Log

Personal notes on decisions made during the project — what worked, what didn't, and what I'd improve next time.

---

## Why I Chose SQLite
The dataset (999 rows, 14 columns) was manageable in SQLite without needing a full PostgreSQL setup. For a production dataset of 1M+ rows, I would migrate to PostgreSQL or BigQuery and restructure into normalized tables (customers, transactions, geography).

---

## Single-Table Limitation
This project uses one flat table. Real business databases would split this into:
- `customers` (demographics: age, gender, income, occupation)
- `transactions` (purchase date, product, amount)
- `geography` (region, commute zone)

A JOIN-based version of this analysis is planned as the next iteration.

---

## What the Window Functions Revealed
The `RANK() OVER (PARTITION BY "Occupation")` query showed something the plain GROUP BY average missed — customers ranked in the **top 25% within their occupation income tier** converted at nearly 2x the rate of bottom-quartile earners in the same job category. This peer-relative signal is more actionable than absolute income thresholds.

---

## CTE vs Subquery — When I Used Each
- Used **CTEs** (Query 11, 12) when the intermediate result needed to be reused or filtered — cleaner and more readable
- Used **Subqueries** (Query 13, 14) for single-use scalar comparisons (e.g., WHERE income > avg income) — more concise for one-off filters

---

## Next Steps for This Project
- [ ] Add a Python EDA layer (pandas + seaborn) for visual distribution analysis
- [ ] Normalize into 2–3 tables and rewrite queries with JOINs
- [ ] Add a `views.sql` file with reusable SQL views for the most-used segments
- [ ] Test queries on a larger synthetic dataset (10,000+ rows)
