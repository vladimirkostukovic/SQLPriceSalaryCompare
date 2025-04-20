3. SELECT 
category_name,
ROUND(AVG(CASE WHEN rok = 2006 THEN avg_price_per_year END), 2) AS "2006",
ROUND(AVG(CASE WHEN rok = 2007 THEN avg_price_per_year END), 2) AS "2007",
ROUND(100.0 * (
AVG(CASE WHEN rok = 2007 THEN avg_price_per_year END) - AVG(CASE WHEN rok = 2006 THEN avg_price_per_year END)
) / NULLIF(AVG(CASE WHEN rok = 2006 THEN avg_price_per_year END), 0), 2) AS perc_2007_vs_2006,

ROUND(AVG(CASE WHEN rok = 2008 THEN avg_price_per_year END), 2) AS "2008",
ROUND(100.0 * (
AVG(CASE WHEN rok = 2008 THEN avg_price_per_year END) - AVG(CASE WHEN rok = 2007 THEN avg_price_per_year END)
) / NULLIF(AVG(CASE WHEN rok = 2007 THEN avg_price_per_year END), 0), 2) AS perc_2008_vs_2007,

ROUND(AVG(CASE WHEN rok = 2009 THEN avg_price_per_year END), 2) AS "2009",
ROUND(100.0 * (
AVG(CASE WHEN rok = 2009 THEN avg_price_per_year END) - AVG(CASE WHEN rok = 2008 THEN avg_price_per_year END)
) / NULLIF(AVG(CASE WHEN rok = 2008 THEN avg_price_per_year END), 0), 2) AS perc_2009_vs_2008,

ROUND(AVG(CASE WHEN rok = 2010 THEN avg_price_per_year END), 2) AS "2010",
ROUND(100.0 * (
AVG(CASE WHEN rok = 2010 THEN avg_price_per_year END) - AVG(CASE WHEN rok = 2009 THEN avg_price_per_year END)
) / NULLIF(AVG(CASE WHEN rok = 2009 THEN avg_price_per_year END), 0), 2) AS perc_2010_vs_2009,

ROUND(AVG(CASE WHEN rok = 2011 THEN avg_price_per_year END), 2) AS "2011",
ROUND(100.0 * (
AVG(CASE WHEN rok = 2011 THEN avg_price_per_year END) - AVG(CASE WHEN rok = 2010 THEN avg_price_per_year END)
) / NULLIF(AVG(CASE WHEN rok = 2010 THEN avg_price_per_year END), 0), 2) AS perc_2011_vs_2010,

ROUND(AVG(CASE WHEN rok = 2012 THEN avg_price_per_year END), 2) AS "2012",
ROUND(100.0 * (
AVG(CASE WHEN rok = 2012 THEN avg_price_per_year END) - AVG(CASE WHEN rok = 2011 THEN avg_price_per_year END)
) / NULLIF(AVG(CASE WHEN rok = 2011 THEN avg_price_per_year END), 0), 2) AS perc_2012_vs_2011,

ROUND(AVG(CASE WHEN rok = 2013 THEN avg_price_per_year END), 2) AS "2013",
ROUND(100.0 * (
AVG(CASE WHEN rok = 2013 THEN avg_price_per_year END) - AVG(CASE WHEN rok = 2012 THEN avg_price_per_year END)
) / NULLIF(AVG(CASE WHEN rok = 2012 THEN avg_price_per_year END), 0), 2) AS perc_2013_vs_2012,

ROUND(AVG(CASE WHEN rok = 2014 THEN avg_price_per_year END), 2) AS "2014",
ROUND(100.0 * (
AVG(CASE WHEN rok = 2014 THEN avg_price_per_year END) - AVG(CASE WHEN rok = 2013 THEN avg_price_per_year END)
) / NULLIF(AVG(CASE WHEN rok = 2013 THEN avg_price_per_year END), 0), 2) AS perc_2014_vs_2013,

ROUND(AVG(CASE WHEN rok = 2015 THEN avg_price_per_year END), 2) AS "2015",
ROUND(100.0 * (
AVG(CASE WHEN rok = 2015 THEN avg_price_per_year END) - AVG(CASE WHEN rok = 2014 THEN avg_price_per_year END)
) / NULLIF(AVG(CASE WHEN rok = 2014 THEN avg_price_per_year END), 0), 2) AS perc_2015_vs_2014,

ROUND(AVG(CASE WHEN rok = 2016 THEN avg_price_per_year END), 2) AS "2016",
ROUND(100.0 * (
AVG(CASE WHEN rok = 2016 THEN avg_price_per_year END) - AVG(CASE WHEN rok = 2015 THEN avg_price_per_year END)
) / NULLIF(AVG(CASE WHEN rok = 2015 THEN avg_price_per_year END), 0), 2) AS perc_2016_vs_2015,

ROUND(AVG(CASE WHEN rok = 2017 THEN avg_price_per_year END), 2) AS "2017",
ROUND(100.0 * (
AVG(CASE WHEN rok = 2017 THEN avg_price_per_year END) - AVG(CASE WHEN rok = 2016 THEN avg_price_per_year END)
) / NULLIF(AVG(CASE WHEN rok = 2016 THEN avg_price_per_year END), 0), 2) AS perc_2017_vs_2016,

ROUND(AVG(CASE WHEN rok = 2018 THEN avg_price_per_year END), 2) AS "2018",
ROUND(100.0 * (
AVG(CASE WHEN rok = 2018 THEN avg_price_per_year END) - AVG(CASE WHEN rok = 2017 THEN avg_price_per_year END)
) / NULLIF(AVG(CASE WHEN rok = 2017 THEN avg_price_per_year END), 0), 2) AS perc_2018_vs_2017

FROM (
SELECT 
cpc.name AS category_name,
EXTRACT(YEAR FROM cp.date_from) AS rok,
AVG(cp.value)::numeric AS avg_price_per_year
FROM czechia_price cp 
JOIN czechia_price_category cpc ON cpc.code = cp.category_code
JOIN czechia_region cr ON cr.code = cp.region_code
WHERE EXTRACT(YEAR FROM cp.date_from) BETWEEN 2006 AND 2018
GROUP BY cpc.name, rok
) AS sub
GROUP BY category_name
ORDER BY category_name;
