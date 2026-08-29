SELECT
    country,
    city,
    COUNT(*) AS TotalDays,
    SUM(units_sold) AS Total_UnitsSold,
    ROUND(SUM(CAST(net_sales AS DECIMAL(14,2))), 2) AS Total_NetSales,
    CAST(ROUND(SUM(units_sold) * 100.0 / SUM(SUM(units_sold)) OVER (), 2) AS DECIMAL (5, 2)) AS Pct_of_Total_Volume
FROM FMCG_Table
WHERE country IN ('Italy', 'Spain', 'Germany', 'Poland')
GROUP BY country, city
ORDER BY Total_UnitsSold DESC;