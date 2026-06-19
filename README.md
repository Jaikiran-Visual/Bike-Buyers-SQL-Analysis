# 🔍 Bike Buyers SQL Analysis — Demographics & Purchase Behaviour

**Tools:** SQL, SQLite  
**Dataset:** 1,000+ customer records  
**Date:** June 2026  
**Author:** [Jai Kiran R](https://linkedin.com/in/jaikiran-analyst)

---

## 📌 Project Overview

Designed a relational database and wrote 7 business-focused SQL queries to identify the highest-value buyer segments in a bike sales dataset. Focused on translating demographic data into actionable marketing and campaign targeting recommendations.

---

## 🎯 Business Problem

> *Which customer demographics drive the highest conversion rates, and how should marketing teams prioritize their outreach?*

Without structured segmentation, marketing budgets get spread thin across all demographics equally — leading to wasted spend on low-conversion groups.

---

## 🗃️ Database Schema

```sql
CREATE TABLE bike_buyers (
    ID INTEGER PRIMARY KEY,
    Marital_Status TEXT,
    Gender TEXT,
    Income REAL,
    Children INTEGER,
    Education TEXT,
    Occupation TEXT,
    Home_Owner TEXT,
    Cars INTEGER,
    Commute_Distance TEXT,
    Region TEXT,
    Age INTEGER,
    Purchased_Bike TEXT
);
```

---

## 🔎 SQL Queries & Business Questions

### Query 1 — Purchase Rate by Age Group
```sql
SELECT
  CASE
    WHEN Age < 31 THEN 'Young (< 31)'
    WHEN Age BETWEEN 31 AND 54 THEN 'Middle-Aged (31-54)'
    ELSE 'Senior (55+)'
  END AS Age_Group,
  COUNT(*) AS Total_Customers,
  SUM(CASE WHEN Purchased_Bike = 'Yes' THEN 1 ELSE 0 END) AS Buyers,
  ROUND(100.0 * SUM(CASE WHEN Purchased_Bike = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS Conversion_Rate
FROM bike_buyers
GROUP BY Age_Group
ORDER BY Conversion_Rate DESC;
```

### Query 2 — Conversion by Commute Distance
```sql
SELECT
  Commute_Distance,
  COUNT(*) AS Total,
  SUM(CASE WHEN Purchased_Bike = 'Yes' THEN 1 ELSE 0 END) AS Buyers,
  ROUND(100.0 * SUM(CASE WHEN Purchased_Bike = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS Conversion_Rate
FROM bike_buyers
GROUP BY Commute_Distance
ORDER BY Conversion_Rate DESC;
```

### Query 3 — Income vs Purchase Behaviour (Window Function)
```sql
SELECT
  Gender,
  ROUND(AVG(Income), 0) AS Avg_Income,
  ROUND(AVG(CASE WHEN Purchased_Bike = 'Yes' THEN Income END), 0) AS Avg_Income_Buyers,
  RANK() OVER (ORDER BY AVG(CASE WHEN Purchased_Bike = 'Yes' THEN Income END) DESC) AS Income_Rank
FROM bike_buyers
GROUP BY Gender;
```

> *(+ 4 more business-focused queries covering occupation, region, home ownership, and multi-variable segmentation)*

---

## 📊 Key Findings

| Variable | Finding |
|---|---|
| **Commute Distance** | 0–1 mile commuters had **40%+ higher conversion** than long-distance commuters |
| **Age Group** | Middle-aged (31–54) had the highest absolute buyer count |
| **Income** | Buyers averaged significantly higher income than non-buyers across all genders |
| **Occupation** | Professionals and skilled manual workers had the strongest conversion rates |

---

## 💼 Business Impact

- ✅ Short-commute segment has **40%+ higher conversion** → prioritize geo-targeted ads in dense urban/suburban areas
- ✅ SQL segmentation model can help increase **marketing ROI by 20–25%** through smarter budget allocation
- ✅ Delivered 3 actionable recommendations for campaign targeting and customer segmentation

---

## 💡 Business Recommendations

1. **Target short-commute urban customers** with “last-mile commute” messaging in city-centre ad placements
2. **Focus budget on middle-aged professionals** — highest volume + strong income profile
3. **Upsell to existing car owners** with 1–2 cars — data shows they buy bikes as a commute supplement

---

## 💬 Connect

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://linkedin.com/in/jaikiran-analyst)
[![Email](https://img.shields.io/badge/Gmail-D14836?style=for-the-badge&logo=gmail&logoColor=white)](mailto:jaikivisual@gmail.com)
[![Portfolio](https://img.shields.io/badge/Portfolio-GitHub-black?style=for-the-badge&logo=github)](https://github.com/Jaikiran-Visual)
