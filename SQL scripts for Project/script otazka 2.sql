
SELECT 
    industry_name,
    produkt,
    mzda_2006,
    mzda_2018,
    nakup_2006,
    nakup_2018,
    mzda_diff_pct,
    nakup_diff_pct,
    CASE
        WHEN mzda_diff_pct > 0 AND nakup_diff_pct > 0 THEN 'Zlepšení'
        WHEN mzda_diff_pct > 0 AND nakup_diff_pct < 0 THEN 'Zhoršení'
        WHEN mzda_diff_pct > 0 AND nakup_diff_pct BETWEEN -2 AND 2 THEN 'Stagnace'
        ELSE 'Jiné'
    END AS zaver
FROM (
    SELECT 
        m.industry_name,
        p.produkt,
        ROUND(AVG(CASE WHEN p.rok = 2006 THEN m.avg_year_salary END)::numeric, 2) AS mzda_2006,
        ROUND(AVG(CASE WHEN p.rok = 2018 THEN m.avg_year_salary END)::numeric, 2) AS mzda_2018,
        ROUND(AVG(CASE WHEN p.rok = 2006 THEN m.avg_year_salary / p.prumerna_cena END)::numeric, 2) AS nakup_2006,
        ROUND(AVG(CASE WHEN p.rok = 2018 THEN m.avg_year_salary / p.prumerna_cena END)::numeric, 2) AS nakup_2018,
        ROUND((
            (AVG(CASE WHEN p.rok = 2018 THEN m.avg_year_salary END) - 
             AVG(CASE WHEN p.rok = 2006 THEN m.avg_year_salary END)) / 
             AVG(CASE WHEN p.rok = 2006 THEN m.avg_year_salary END) * 100
        )::numeric, 2) AS mzda_diff_pct,
        ROUND((
            (AVG(CASE WHEN p.rok = 2018 THEN m.avg_year_salary / p.prumerna_cena END) - 
             AVG(CASE WHEN p.rok = 2006 THEN m.avg_year_salary / p.prumerna_cena END)) / 
             AVG(CASE WHEN p.rok = 2006 THEN m.avg_year_salary / p.prumerna_cena END) * 100
        )::numeric, 2) AS nakup_diff_pct
    FROM (
        SELECT 
            CASE 
                WHEN cpc.name = 'Chléb konzumní kmínový' THEN 'Chléb'
                WHEN cpc.name = 'Pečivo pšeničné bílé' THEN 'Pečivo'
                WHEN cpc.name = 'Mléko polotučné pasterované' THEN 'Mléko'
                ELSE 'Jiné'
            END AS produkt,
            EXTRACT(YEAR FROM cp.date_from) AS rok,
            AVG(cp.value) AS prumerna_cena
        FROM czechia_price cp 
        JOIN czechia_price_category cpc ON cpc.code = cp.category_code
        JOIN czechia_region cr ON cr.code = cp.region_code
        WHERE 
            cpc.name IN (
                'Chléb konzumní kmínový', 
                'Pečivo pšeničné bílé', 
                'Mléko polotučné pasterované'
            )
            AND EXTRACT(YEAR FROM cp.date_from) IN (2006, 2018)
        GROUP BY produkt, rok
    ) p
    JOIN (
        SELECT 
            cp.payroll_year AS rok,
            cpib.name AS industry_name,
            AVG(cp.value) AS avg_year_salary
        FROM czechia_payroll cp
        JOIN czechia_payroll_industry_branch cpib ON cpib.code = cp.industry_branch_code
        WHERE 
            cp.calculation_code = 100 
            AND cp.value IS NOT NULL 
            AND cp.value > 999
            AND cp.payroll_year IN (2006, 2018)
        GROUP BY cp.payroll_year, cpib.name
    ) m ON p.rok = m.rok
    GROUP BY m.industry_name, p.produkt
) AS analyza;