SELECT 
    category_name,
    ROUND(AVG(diff)::numeric, 2) AS avg_yearly_growth_pct
FROM (
    SELECT 
        cpc.name AS category_name,
        EXTRACT(YEAR FROM cp.date_from) AS rok,
        AVG(cp.value) AS avg_price,
        LAG(AVG(cp.value)) OVER (PARTITION BY cpc.name ORDER BY EXTRACT(YEAR FROM cp.date_from)) AS prev_price
    FROM czechia_price cp
    JOIN czechia_price_category cpc ON cpc.code = cp.category_code
    JOIN czechia_region cr ON cr.code = cp.region_code
    WHERE EXTRACT(YEAR FROM cp.date_from) BETWEEN 2006 AND 2018
    GROUP BY cpc.name, EXTRACT(YEAR FROM cp.date_from)
) AS diff_calc

CROSS JOIN LATERAL (
    SELECT 
        CASE 
            WHEN prev_price IS NOT NULL AND prev_price > 0 
            THEN 100.0 * (avg_price - prev_price) / prev_price
            ELSE NULL 
        END AS diff
) AS d

GROUP BY category_name
HAVING COUNT(diff) > 5 
ORDER BY avg_yearly_growth_pct ASC
LIMIT 5;