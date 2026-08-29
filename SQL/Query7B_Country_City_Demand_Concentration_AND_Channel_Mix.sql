SELECT
    country,
    channel,
    COUNT(*) AS TotalDays,
    SUM(units_sold) AS Total_UnitsSold,
    CAST(ROUND(SUM(units_sold) * 100.0 / SUM(SUM(units_sold)) OVER (PARTITION BY country), 2) AS DECIMAL (5, 2)) AS Pct_of_Country_Volume
FROM FMCG_Table
WHERE country IN ('Italy', 'Spain', 'Germany', 'Poland')
GROUP BY country, channel
ORDER BY country, Pct_of_Country_Volume DESC;