SELECT
    category,
    CASE 
        WHEN temperature < 10 THEN '1. Cold (<10°C)'
        WHEN temperature BETWEEN 10 AND 18 THEN '2. Mild (10-18°C)'
        WHEN temperature > 18 THEN '3. Warm (>18°C)'
    END AS Temperature_Band,
    COUNT(*) AS TotalDays,
    ROUND(AVG(CAST(units_sold AS DECIMAL(10,2))), 2) AS Avg_UnitsSold,
    ROUND(AVG(CAST(rain_mm AS DECIMAL(10,2))), 2) AS Avg_RainMM
FROM FMCG_Table
WHERE country IN ('Italy', 'Spain', 'Germany', 'Poland')
GROUP BY 
    category,
    CASE 
        WHEN temperature < 10 THEN '1. Cold (<10°C)'
        WHEN temperature BETWEEN 10 AND 18 THEN '2. Mild (10-18°C)'
        WHEN temperature > 18 THEN '3. Warm (>18°C)'
    END
ORDER BY category, Temperature_Band;

