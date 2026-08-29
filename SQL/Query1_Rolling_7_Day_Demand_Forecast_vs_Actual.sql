WITH RollingForecast AS (
    SELECT
        [date],
        country,
        store_id,
        sku_id,
        units_sold AS Actual_UnitsSold,
        AVG(Cast(units_sold as decimal (5,2))) OVER (
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
    store_id,
    sku_id,
    Actual_UnitsSold,
    ROUND(Forecast_UnitsSold, 2) AS Forecast_UnitsSold
FROM RollingForecast
WHERE Forecast_UnitsSold IS NOT NULL
ORDER BY store_id, sku_id, [date];

