SELECT *
FROM (
    SELECT 
        cp.payroll_year,
        cp.industry_branch_code,
        cpib.name AS industry_name,
        AVG(cp.value) AS avg_year_salary,
        AVG(cp.value) - LAG(AVG(cp.value)) OVER (
            PARTITION BY cp.industry_branch_code 
            ORDER BY cp.payroll_year
        ) AS salary_diff,
        100.0 * (AVG(cp.value) - LAG(AVG(cp.value)) OVER (
            PARTITION BY cp.industry_branch_code 
            ORDER BY cp.payroll_year
        )) / LAG(AVG(cp.value)) OVER (
            PARTITION BY cp.industry_branch_code 
            ORDER BY cp.payroll_year
        ) AS percent_diff
    FROM czechia_payroll cp 
    JOIN czechia_payroll_industry_branch cpib 
        ON cpib.code = cp.industry_branch_code
    WHERE 
        cp.calculation_code = 100 
        AND cp.value IS NOT NULL 
        AND cp.value > 999
    GROUP BY 
        cp.payroll_year, 
        cp.industry_branch_code, 
        cpib.name
) AS sub
WHERE salary_diff < 0
ORDER BY industry_name, payroll_year;