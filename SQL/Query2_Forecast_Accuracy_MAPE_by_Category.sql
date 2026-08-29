WITH RollingForecast AS (
    SELECT
        [date],
        country,
        store_id,
        sku_id,
        category,
        units_sold AS Actual_UnitsSold,
        AVG(CAST(units_sold AS DECIMAL(10,2))) OVER (
            PARTITION BY store_id, sku_id
            ORDER BY [date]
            ROWS BETWEEN 7 PRECEDING AND 1 PRECEDING
        ) AS Forecast_UnitsSold
    FROM FMCG_Table
    WHERE country IN ('Italy', 'Spain', 'Germany', 'Poland')
)
SELECT
    category,
    COUNT(*) AS TotalForecasts,
    ROUND(AVG(ABS(Actual_UnitsSold - Forecast_UnitsSold) / NULLIF(Actual_UnitsSold, 0)) * 100, 2) AS MAPE_Percent
FROM RollingForecast
WHERE Forecast_UnitsSold IS NOT NULL
GROUP BY category
ORDER BY MAPE_Percent ASC;

