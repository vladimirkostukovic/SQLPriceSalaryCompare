SELECT 
    p.rok,
    ROUND(p.price_growth_pct::numeric, 2) AS price_growth_pct,
    ROUND(m.salary_growth_pct::numeric, 2) AS salary_growth_pct,
    ROUND((p.price_growth_pct - m.salary_growth_pct)::numeric, 2) AS difference_pct,
 	CASE 
    	WHEN (salary_growth_pct - price_growth_pct) < -10 THEN 'ANO'
    	ELSE 'NE'
END AS vyrazne_vyssi_rust_cen
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
ORDER BY p.rok;