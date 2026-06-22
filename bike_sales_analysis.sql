-- ============================================================
-- Bike Sales SQL Analysis
-- Author: Jai Kiran R | github.com/Jaikiran-Visual
-- Dataset: 999 customer records | Table: bike_sales
-- Updated: June 2026 — Added Window Functions, CTEs, Subqueries
-- ============================================================

-- TABLE SCHEMA
-- bike_sales (
--   Customer ID TEXT,  Marital Status TEXT,  Gender TEXT,
--   Income NUMBER,     Children NUMBER,      Education TEXT,
--   Occupation TEXT,   Home Owner TEXT,      Cars NUMBER,
--   Commute Distance TEXT,  Region TEXT,     Age NUMBER,
--   Purchased Bike TEXT,    Age Group TEXT,  Income Group TEXT
-- )

-- DATASET SUMMARY
-- Total records: 999 | Bike buyers: 481 (~48.1%)
-- Avg income: $57,000 | Regions: Europe, Pacific, North America
-- Age groups: Young, Middle Aged, Senior

-- ============================================================
-- QUERY 1: Bike purchase breakdown by gender
-- Business Q: Do male or female customers buy more bikes?
-- ============================================================
SELECT "Gender",
       COUNT(*) AS total_customers,
       SUM(CASE WHEN "Purchased Bike" = 'Yes' THEN 1 ELSE 0 END) AS bike_buyers,
       ROUND(AVG("Income"), 0) AS avg_income
FROM bike_sales
GROUP BY "Gender"
ORDER BY total_customers DESC;

-- ============================================================
-- QUERY 2: Buyers by region
-- Business Q: Which region drives the most purchases?
-- ============================================================
SELECT "Region",
       COUNT(*) AS total,
       SUM(CASE WHEN "Purchased Bike" = 'Yes' THEN 1 ELSE 0 END) AS buyers
FROM bike_sales
GROUP BY "Region"
ORDER BY buyers DESC;

-- ============================================================
-- QUERY 3: Average income by occupation
-- Business Q: Which occupation group earns the most?
-- ============================================================
SELECT "Occupation",
       COUNT(*) AS count,
       ROUND(AVG("Income"), 0) AS avg_income
FROM bike_sales
GROUP BY "Occupation"
ORDER BY avg_income DESC;

-- ============================================================
-- QUERY 4: High-income bike buyers (> $100,000)
-- Business Q: Who are the premium buyer profiles?
-- ============================================================
SELECT "Gender", "Age Group", "Occupation", "Income"
FROM bike_sales
WHERE "Purchased Bike" = 'Yes'
  AND "Income" > 100000
ORDER BY "Income" DESC
LIMIT 10;

-- ============================================================
-- QUERY 5: Purchase rate by age group
-- Business Q: Which age group converts best?
-- ============================================================
SELECT "Age Group",
       COUNT(*) AS total,
       SUM(CASE WHEN "Purchased Bike" = 'Yes' THEN 1 ELSE 0 END) AS buyers,
       ROUND(100.0 * SUM(CASE WHEN "Purchased Bike" = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS conversion_rate_pct
FROM bike_sales
GROUP BY "Age Group"
ORDER BY conversion_rate_pct DESC;

-- ============================================================
-- QUERY 6: Commute distance vs purchase
-- Business Q: Does commute distance affect bike purchases?
-- ============================================================
SELECT "Commute Distance",
       COUNT(*) AS total,
       SUM(CASE WHEN "Purchased Bike" = 'Yes' THEN 1 ELSE 0 END) AS buyers,
       ROUND(100.0 * SUM(CASE WHEN "Purchased Bike" = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS conversion_rate_pct
FROM bike_sales
GROUP BY "Commute Distance"
ORDER BY buyers DESC;

-- ============================================================
-- QUERY 7: Income group purchase summary
-- Business Q: Does income level affect purchase likelihood?
-- ============================================================
SELECT "Income Group",
       COUNT(*) AS total,
       SUM(CASE WHEN "Purchased Bike" = 'Yes' THEN 1 ELSE 0 END) AS buyers,
       ROUND(AVG("Income"), 0) AS avg_income
FROM bike_sales
GROUP BY "Income Group"
ORDER BY avg_income DESC;

-- ============================================================
-- QUERY 8: WINDOW FUNCTION — Income rank within each occupation
-- Business Q: Who are the top earners in each occupation group?
-- Concepts: RANK() OVER (PARTITION BY ... ORDER BY ...)
-- ============================================================
SELECT "Customer ID",
       "Occupation",
       "Gender",
       "Income",
       RANK() OVER (PARTITION BY "Occupation" ORDER BY "Income" DESC) AS income_rank_in_occupation
FROM bike_sales
ORDER BY "Occupation", income_rank_in_occupation
LIMIT 20;

-- ============================================================
-- QUERY 9: WINDOW FUNCTION — Running total of buyers by region
-- Business Q: What is the cumulative buyer count as income increases per region?
-- Concepts: SUM() OVER (PARTITION BY ... ORDER BY ...)
-- ============================================================
SELECT "Region",
       "Income",
       "Purchased Bike",
       SUM(CASE WHEN "Purchased Bike" = 'Yes' THEN 1 ELSE 0 END)
           OVER (PARTITION BY "Region" ORDER BY "Income") AS running_buyer_total
FROM bike_sales
ORDER BY "Region", "Income";

-- ============================================================
-- QUERY 10: WINDOW FUNCTION — Compare each customer's income
--           to their occupation group average
-- Business Q: Is each buyer above or below their peer income group?
-- Concepts: AVG() OVER (PARTITION BY ...), CASE WHEN
-- ============================================================
SELECT "Customer ID",
       "Occupation",
       "Income",
       ROUND(AVG("Income") OVER (PARTITION BY "Occupation"), 0) AS avg_income_in_occupation,
       CASE
           WHEN "Income" > AVG("Income") OVER (PARTITION BY "Occupation") THEN 'Above Average'
           WHEN "Income" < AVG("Income") OVER (PARTITION BY "Occupation") THEN 'Below Average'
           ELSE 'At Average'
       END AS income_vs_peers,
       "Purchased Bike"
FROM bike_sales
ORDER BY "Occupation", "Income" DESC
LIMIT 25;

-- ============================================================
-- QUERY 11: CTE — High-value buyer segment deep dive
-- Business Q: Among the highest-converting segments, what is
--             the demographic breakdown?
-- Concepts: WITH cte AS (...), CTE reference in main query
-- ============================================================
WITH high_converting_segments AS (
    SELECT "Commute Distance",
           "Age Group",
           COUNT(*) AS total,
           SUM(CASE WHEN "Purchased Bike" = 'Yes' THEN 1 ELSE 0 END) AS buyers,
           ROUND(100.0 * SUM(CASE WHEN "Purchased Bike" = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS conversion_rate_pct
    FROM bike_sales
    GROUP BY "Commute Distance", "Age Group"
)
SELECT *
FROM high_converting_segments
WHERE conversion_rate_pct > 55
ORDER BY conversion_rate_pct DESC;

-- ============================================================
-- QUERY 12: CTE — Occupation-level summary with buyer rate
-- Business Q: Which occupations have both high income AND high conversion?
-- Concepts: WITH cte, calculated fields, filtering on aggregates
-- ============================================================
WITH occupation_summary AS (
    SELECT "Occupation",
           COUNT(*) AS total_customers,
           SUM(CASE WHEN "Purchased Bike" = 'Yes' THEN 1 ELSE 0 END) AS total_buyers,
           ROUND(AVG("Income"), 0) AS avg_income,
           ROUND(100.0 * SUM(CASE WHEN "Purchased Bike" = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS conversion_rate_pct
    FROM bike_sales
    GROUP BY "Occupation"
)
SELECT *,
       CASE
           WHEN avg_income > 60000 AND conversion_rate_pct > 50 THEN 'Priority Target Segment'
           WHEN avg_income > 60000 OR  conversion_rate_pct > 50 THEN 'Secondary Target Segment'
           ELSE 'Low Priority'
       END AS targeting_priority
FROM occupation_summary
ORDER BY conversion_rate_pct DESC;

-- ============================================================
-- QUERY 13: SUBQUERY — Customers earning above the overall average
-- Business Q: How many customers are above-average earners, and
--             what share of them purchased a bike?
-- Concepts: Subquery in WHERE clause
-- ============================================================
SELECT COUNT(*) AS above_avg_earners,
       SUM(CASE WHEN "Purchased Bike" = 'Yes' THEN 1 ELSE 0 END) AS buyers_above_avg,
       ROUND(100.0 * SUM(CASE WHEN "Purchased Bike" = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS conversion_rate_pct
FROM bike_sales
WHERE "Income" > (SELECT AVG("Income") FROM bike_sales);

-- ============================================================
-- QUERY 14: SUBQUERY — Region-wise buyers vs overall average buyers
-- Business Q: Which regions outperform the average buyer rate?
-- Concepts: Subquery in HAVING clause
-- ============================================================
SELECT "Region",
       COUNT(*) AS total,
       SUM(CASE WHEN "Purchased Bike" = 'Yes' THEN 1 ELSE 0 END) AS buyers,
       ROUND(100.0 * SUM(CASE WHEN "Purchased Bike" = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS conversion_rate_pct
FROM bike_sales
GROUP BY "Region"
HAVING conversion_rate_pct > (
    SELECT ROUND(100.0 * SUM(CASE WHEN "Purchased Bike" = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1)
    FROM bike_sales
)
ORDER BY conversion_rate_pct DESC;

-- ============================================================
-- KEY SQL CONCEPTS USED:
-- ✅ SELECT, FROM, WHERE, GROUP BY, ORDER BY, LIMIT
-- ✅ COUNT, SUM, AVG, ROUND (aggregate functions)
-- ✅ CASE WHEN ... THEN ... END (conditional logic)
-- ✅ RANK() OVER (PARTITION BY ... ORDER BY ...) — Window Function
-- ✅ SUM() OVER (PARTITION BY ... ORDER BY ...) — Running Total
-- ✅ AVG() OVER (PARTITION BY ...) — Peer Group Comparison
-- ✅ WITH cte AS (...) — Common Table Expressions (CTEs)
-- ✅ Subqueries in WHERE and HAVING clauses
-- Note: Column names with spaces use double-quotes in SQLite
-- ============================================================
