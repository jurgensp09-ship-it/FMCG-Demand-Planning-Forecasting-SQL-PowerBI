SELECT
    country,
    sku_id,
    category,
    COUNT(*) AS TotalDays,
    ROUND(AVG(CAST(units_sold AS DECIMAL(10,2))), 2) AS Avg_DailyDemand,
    ROUND(STDEV(units_sold), 2) AS StdDev_DailyDemand,
    ROUND(AVG(CAST(lead_time_days AS DECIMAL(10,2))), 2) AS Avg_LeadTimeDays,
    ROUND(1.65 * STDEV(units_sold) * SQRT(AVG(CAST(lead_time_days AS DECIMAL(10,2)))), 2) AS Safety_Stock
FROM FMCG_Table
WHERE country IN ('Italy', 'Spain', 'Germany', 'Poland')
GROUP BY country, sku_id, category
ORDER BY Safety_Stock DESC;

