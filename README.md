## Autor

Vladimír Kosťukovič  
Email: kostyukovych@gmail.com 
https://www.linkedin.com/in/vladimirkostukovic/
## Licence

Tento projekt je dostupný pod licencí MIT.

# SQLPriceSalaryCompare

## O projektu

Tento projekt analyzuje vývoj mezd a cen základních potravin v České republice v období 2000–2021. Zaměřuje se na vztah mezi růstem mezd, cen, HDP a kupní silou. Pomocí SQL dotazů a datových vizualizací odpovídá na klíčové analytické otázky v oblasti ekonomiky a životní úrovně obyvatel.

## Výzkumné otázky

1. Rostou mzdy ve všech odvětvích, nebo v některých letech i klesají?
2. Kolik si může člověk koupit litrů mléka a kilogramů chleba za průměrnou mzdu v letech 2006 a 2018?
3. Která kategorie potravin zdražuje nejpomaleji?
4. Existuje rok, kdy ceny potravin rostly výrazně rychleji než mzdy?
5. Má růst HDP vliv na vývoj mezd a cen potravin?

## Použité datové zdroje

- `czechia_payroll`
- `czechia_price`
- `czechia_payroll_industry_branch`
- `czechia_price_category`
- `czechia_region`
- Odvozené a očištěné tabulky (např. t_vladimir_kostukovic_project_sql_primary_final, `t_vladimir_kostukovic_project_sql_secondary_final`)

## Struktura projektu
SQLPriceSalaryCompare/
├── README.md

├── sql/                     # SQL skripty k jednotlivým otázkám

├── data/                    # vystupni soubory CSV, Pivots

├── visualizations/          # http://176.102.66.84:3000/public/dashboard/b31103ad-0a60-434a-9e15-23e0405a2f72

├── docs/                    # Finální PDF dokumentace
