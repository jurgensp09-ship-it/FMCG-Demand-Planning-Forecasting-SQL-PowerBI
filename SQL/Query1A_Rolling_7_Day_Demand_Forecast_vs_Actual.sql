WITH RollingForecast AS (
    SELECT
        [date],
        country,
        store_id,
        sku_id,
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
    [date],
    country,
    SUM(Actual_UnitsSold) AS Total_Actual_UnitsSold,
    CAST(ROUND(SUM(Forecast_UnitsSold), 0) AS INT) AS Total_Forecast_UnitsSold
FROM RollingForecast
WHERE Forecast_UnitsSold IS NOT NULL
GROUP BY [date], country
ORDER BY country, [date];