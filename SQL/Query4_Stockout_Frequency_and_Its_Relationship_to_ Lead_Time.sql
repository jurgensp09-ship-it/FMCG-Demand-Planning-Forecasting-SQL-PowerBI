WITH SkuStats AS (
    SELECT
        country,
        sku_id,
        category,
        COUNT(*) AS TotalDays,
        SUM(CASE WHEN stock_out_flag = 1 THEN 1 ELSE 0 END) AS StockoutDays,
        CAST(ROUND(SUM(CASE WHEN stock_out_flag = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS DECIMAL(5,2)) AS Stockout_Rate_Percent,
        ROUND(STDEV(units_sold), 2) AS StdDev_DailyDemand,
        ROUND(AVG(CAST(lead_time_days AS DECIMAL(10,2))), 2) AS Avg_LeadTimeDays
    FROM FMCG_Table
    WHERE country IN ('Italy', 'Spain', 'Germany', 'Poland')
    GROUP BY country, sku_id, category
)
SELECT
    country,
    sku_id,
    category,
    TotalDays,
    StockoutDays,
    Stockout_Rate_Percent,
    StdDev_DailyDemand,
    Avg_LeadTimeDays
FROM SkuStats
ORDER BY Stockout_Rate_Percent DESC;