-- ============================================================
-- Bike Sales SQL Analysis
-- Author: Jai Kiran R | github.com/Jaikiran-Visual
-- Dataset: 999 customer records | Table: bike_sales
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
-- QUERY 1: Select all customers (sample)
-- ============================================================
SELECT *
FROM bike_sales
LIMIT 10;

-- ============================================================
-- QUERY 2: Count total customers
-- ============================================================
SELECT COUNT(*) AS total_customers
FROM bike_sales;

-- ============================================================
-- QUERY 3: Bike purchase breakdown by gender
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
-- QUERY 4: Buyers by region
-- Business Q: Which region drives the most purchases?
-- ============================================================
SELECT "Region",
       COUNT(*) AS total,
       SUM(CASE WHEN "Purchased Bike" = 'Yes' THEN 1 ELSE 0 END) AS buyers
FROM bike_sales
GROUP BY "Region"
ORDER BY buyers DESC;

-- ============================================================
-- QUERY 5: Average income by occupation
-- Business Q: Which occupation group earns the most?
-- ============================================================
SELECT "Occupation",
       COUNT(*) AS count,
       ROUND(AVG("Income"), 0) AS avg_income
FROM bike_sales
GROUP BY "Occupation"
ORDER BY avg_income DESC;

-- ============================================================
-- QUERY 6: High-income bike buyers (> $100,000)
-- Business Q: Who are the premium buyer profiles?
-- ============================================================
SELECT "Gender", "Age Group", "Occupation", "Income"
FROM bike_sales
WHERE "Purchased Bike" = 'Yes'
  AND "Income" > 100000
ORDER BY "Income" DESC
LIMIT 10;

-- ============================================================
-- QUERY 7: Purchase rate by age group
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
-- QUERY 8: Commute distance vs purchase
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
-- QUERY 9: Married homeowners profile
-- Business Q: What does the married homeowner buyer look like?
-- ============================================================
SELECT "Gender", "Age", "Income", "Occupation", "Purchased Bike"
FROM bike_sales
WHERE "Marital Status" = 'married'
  AND "Home Owner" = 'Yes'
ORDER BY "Income" DESC
LIMIT 15;

-- ============================================================
-- QUERY 10: Income group purchase summary
-- Business Q: Does income group affect purchase likelihood?
-- ============================================================
SELECT "Income Group",
       COUNT(*) AS total,
       SUM(CASE WHEN "Purchased Bike" = 'Yes' THEN 1 ELSE 0 END) AS buyers,
       ROUND(AVG("Income"), 0) AS avg_income
FROM bike_sales
GROUP BY "Income Group"
ORDER BY avg_income DESC;

-- ============================================================
-- KEY SQL CONCEPTS USED:
-- SELECT, FROM, WHERE, GROUP BY, ORDER BY, LIMIT
-- COUNT, SUM, AVG, ROUND (aggregate functions)
-- CASE WHEN ... THEN ... END (conditional logic)
-- Note: Column names with spaces use double-quotes
-- Note: String values use single quotes e.g. 'Yes', 'Europe'
-- ============================================================
