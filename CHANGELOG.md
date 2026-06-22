# Changelog — Bike Buyers SQL Analysis

All notable changes and improvements to this project are documented here.

---

## [v1.3] — June 22, 2026
### Added
- Query 8: `RANK() OVER (PARTITION BY)` — income ranking within occupation groups
- Query 9: `SUM() OVER (PARTITION BY ORDER BY)` — running buyer total by region
- Query 10: `AVG() OVER (PARTITION BY)` — peer income comparison per customer
- Query 11: CTE-based high-converting segment filter (conversion > 55%)
- Query 12: CTE with occupation targeting priority classification
- Query 13: Subquery in WHERE — above-average earner conversion rate
- Query 14: Subquery in HAVING — regions outperforming average buyer rate
### Changed
- Replaced filler queries (SELECT *, COUNT only) with analytical queries
- Updated README to reflect 14 queries and full concept index
- Added SQL concept code block to README for recruiter visibility

---

## [v1.2] — June 21, 2026
### Added
- `data_dictionary.md` — full column definitions and data types
- Screenshots folder for query output previews
### Changed
- Improved business question framing above each query
- Added dataset summary header to SQL file

---

## [v1.1] — June 20, 2026
### Added
- Queries 7–10: commute distance, married homeowner profile, income group summary
- Business impact section to README
- LinkedIn and Gmail badges in README
### Changed
- Refactored GROUP BY queries to include conversion rate percentage calculation
- Standardized column quoting style (double-quotes for SQLite compatibility)

---

## [v1.0] — June 19, 2026
### Initial Release
- Created relational schema for bike_sales table (999 records, 14 columns)
- Queries 1–6: gender breakdown, regional buyers, occupation income, high-income filter, age group purchase rate
- Basic README with project overview and dataset summary
