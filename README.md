# 🔍 Bike Buyers SQL Analysis — Demographics & Purchase Behaviour

**Tools:** SQL, SQLite  
**Dataset:** 999 customer records  
**Date:** June 2026  
**Author:** [Jai Kiran R](https://linkedin.com/in/jaikiran-analyst)

📂 **Files in this repo:**
- [`bike_sales_analysis.sql`](./bike_sales_analysis.sql) — 14 SQL queries (Basic → Advanced)
- [`data_dictionary.md`](./data_dictionary.md) — Full column definitions

---

## 📌 Project Overview

Designed a relational database and wrote **14 business-focused SQL queries** progressing from basic aggregations to advanced Window Functions, CTEs, and Subqueries. Focused on translating demographic data into actionable marketing and campaign targeting recommendations.

---

## 🎯 Business Problem

> *Which customer demographics drive the highest conversion rates, and how should marketing teams prioritize their outreach?*

Without structured segmentation, marketing budgets get spread thin across all demographics equally — leading to wasted spend on low-conversion groups.

---

## 🗃️ Dataset Summary

| Metric | Value |
|---|---|
| Total Records | 999 |
| Bike Buyers | 481 (~48.1%) |
| Average Income | $57,000 |
| Regions | Europe, Pacific, North America |
| Age Groups | Young, Middle Aged, Senior |

---

## 🔎 SQL Queries Included

| # | Query | Concept |
|---|---|---|
| 1 | Purchase breakdown by gender | GROUP BY, CASE WHEN, AVG |
| 2 | Buyers by region | GROUP BY, SUM, ORDER BY |
| 3 | Avg income by occupation | GROUP BY, AVG |
| 4 | High-income buyers (>$100K) | WHERE filter, ORDER BY |
| 5 | Purchase rate by age group | Conversion rate calculation |
| 6 | Commute distance vs purchase | GROUP BY, conversion rate |
| 7 | Income group purchase summary | GROUP BY, multi-metric |
| 8 | **Income rank within occupation** | **RANK() OVER (PARTITION BY)** |
| 9 | **Running buyer total by region** | **SUM() OVER (PARTITION BY ORDER BY)** |
| 10 | **Customer vs peer income comparison** | **AVG() OVER (PARTITION BY), CASE WHEN** |
| 11 | **High-converting segment deep dive** | **CTE — WITH ... AS (...)** |
| 12 | **Occupation priority targeting** | **CTE with derived classification** |
| 13 | **Above-average earner conversion** | **Subquery in WHERE clause** |
| 14 | **Regions beating average buyer rate** | **Subquery in HAVING clause** |

---

## ⚙️ SQL Concepts Demonstrated

```sql
-- Window Functions
RANK() OVER (PARTITION BY "Occupation" ORDER BY "Income" DESC)
SUM(...) OVER (PARTITION BY "Region" ORDER BY "Income")
AVG("Income") OVER (PARTITION BY "Occupation")

-- CTE (Common Table Expression)
WITH high_converting_segments AS (
    SELECT ...
    FROM bike_sales
    GROUP BY "Commute Distance", "Age Group"
)
SELECT * FROM high_converting_segments WHERE conversion_rate_pct > 55;

-- Subquery in WHERE
WHERE "Income" > (SELECT AVG("Income") FROM bike_sales)

-- Subquery in HAVING
HAVING conversion_rate_pct > (SELECT ROUND(100.0 * SUM(...) / COUNT(*), 1) FROM bike_sales)
```

---

## 📊 Key Findings

| Variable | Finding |
|---|---|
| **Commute Distance** | 0–1 mile commuters had **40%+ higher conversion** than long-distance commuters |
| **Age Group** | Middle-aged (31–54) had the highest absolute buyer count |
| **Income** | Buyers averaged significantly higher income than non-buyers across all genders |
| **Occupation** | Professionals and skilled manual workers had the strongest conversion rates |
| **Peer Comparison** | Above-average earners within their occupation group converted at higher rates |

---

## 💼 Business Impact

- ✅ Short-commute segment has **40%+ higher conversion** → prioritize geo-targeted ads in urban areas
- ✅ Window function analysis reveals **income rank within occupation** matters more than absolute income
- ✅ CTE-based segmentation identifies specific commute + age combinations converting above 55%
- ✅ Subquery confirms above-average earners convert at higher rates — validates premium targeting strategy

---

## 💡 Business Recommendations

1. **Target short-commute urban customers** with “last-mile commute” messaging in city-centre ad placements
2. **Focus budget on middle-aged professionals** — highest volume + strong income profile
3. **Use peer-relative income targeting** — customers earning above their occupation average show stronger purchase intent

---

## 💬 Connect

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://linkedin.com/in/jaikiran-analyst)
[![Email](https://img.shields.io/badge/Gmail-D14836?style=for-the-badge&logo=gmail&logoColor=white)](mailto:jaikivisual@gmail.com)
[![Portfolio](https://img.shields.io/badge/Portfolio-GitHub-black?style=for-the-badge&logo=github)](https://github.com/Jaikiran-Visual)
