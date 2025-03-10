SQL Analysis of Wages and Food Prices in Czechia 🇨🇿📊

Overview

This project analyzes wage growth across industries and food price changes in Czechia over multiple years. It answers key economic questions using SQL queries on a database that contains wage and price data.

⸻

Questions Answered

The SQL script provides insights into the following questions:

1️⃣ Do wages increase over the years in all industries, or do some decline?
2️⃣ How many liters of milk and kilograms of bread could be bought for an average salary in the first and last comparable period?
3️⃣ Which food category has the slowest price growth (lowest annual percentage increase)?
4️⃣ Is there a year when food price inflation was significantly higher than wage growth (greater than 10%)?

⸻

SQL Queries Explained

1️⃣ Wage Data Calculation
	•	Calculates average salaries per year and industry.
	•	Computes year-over-year wage changes.
	•	Identifies the industry with the slowest wage growth.

2️⃣ Food Price Analysis
	•	Extracts historical food prices for each year.
	•	Calculates year-over-year percentage price changes.
	•	Determines which food category has the slowest price increase.

3️⃣ Comparison of Wage and Price Growth
	•	Compares average wage growth vs. food price inflation.
	•	Identifies years when price inflation exceeded wage growth by more than 10%.

4️⃣ Purchasing Power Calculation
	•	Computes how much milk and bread can be bought per average salary in the first and last available period.

⸻

Database Structure

The script uses the following database tables:
🔹 czechia_payroll → Wage data by year and industry.
🔹 czechia_price → Food price data by year and category.
🔹 czechia_price_category → Classification of food products.
🔹 czechia_region → Regional information (not used in final query).

⸻
How to Run the Query

1️⃣ Load the SQL Script

Run the SQL file in PostgreSQL or another supported database engine:

\i path/to/script.sql

