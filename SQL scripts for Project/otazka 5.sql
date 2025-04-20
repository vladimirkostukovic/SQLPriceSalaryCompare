INSERT INTO data_academy_content.t_vladimir_kostukovic_project_sql_secondary_final (
    year,
    price_growth_pct,
    salary_growth_pct,
    gdp_growth_pct,
    gdp_per_capita_growth_pct
)
SELECT 
    p.rok,
    ROUND(p.price_growth_pct::numeric, 2),
    ROUND(m.salary_growth_pct::numeric, 2),
    ROUND(e.gdp_growth_pct::numeric, 2),
    ROUND(e.gdp_per_capita_growth_pct::numeric, 2)
FROM (
    SELECT 
        EXTRACT(YEAR FROM cp.date_from) AS rok,
        100.0 * (AVG(cp.value) - LAG(AVG(cp.value)) OVER (ORDER BY EXTRACT(YEAR FROM cp.date_from))) / 
        LAG(AVG(cp.value)) OVER (ORDER BY EXTRACT(YEAR FROM cp.date_from)) AS price_growth_pct
    FROM czechia_price cp
    WHERE cp.value IS NOT NULL
    GROUP BY EXTRACT(YEAR FROM cp.date_from)
) p
JOIN (
    SELECT 
        cp.payroll_year AS rok,
        100.0 * (AVG(cp.value) - LAG(AVG(cp.value)) OVER (ORDER BY cp.payroll_year)) / 
        LAG(AVG(cp.value)) OVER (ORDER BY cp.payroll_year) AS salary_growth_pct
    FROM czechia_payroll cp
    WHERE cp.calculation_code = 100 AND cp.value IS NOT NULL AND cp.value > 999
    GROUP BY cp.payroll_year
) m ON p.rok = m.rok
LEFT JOIN (
    SELECT 
        e.year,
        100.0 * (e.gdp - LAG(e.gdp) OVER (ORDER BY e.year)) / 
        NULLIF(LAG(e.gdp) OVER (ORDER BY e.year), 0) AS gdp_growth_pct,
        100.0 * (
            (e.gdp / NULLIF(e.population, 0)) -
            (LAG(e.gdp) OVER (ORDER BY e.year) / NULLIF(LAG(e.population) OVER (ORDER BY e.year), 0))
        ) /
        NULLIF((LAG(e.gdp) OVER (ORDER BY e.year) / NULLIF(LAG(e.population) OVER (ORDER BY e.year), 0)), 0) AS gdp_per_capita_growth_pct
    FROM economies e
    WHERE LOWER(e.country) = 'czech republic'
) e ON e.year = p.rok
WHERE p.rok BETWEEN 2006 AND 2018
ORDER BY p.rok;