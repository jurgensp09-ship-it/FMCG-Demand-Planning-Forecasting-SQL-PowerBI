SELECT
    category,
    CASE WHEN promo_flag = 1 THEN 'Promo' ELSE 'No Promo' END AS Promo_Status,
    COUNT(*) AS TotalDays,
    ROUND(AVG(CAST(units_sold AS DECIMAL(10,2))), 2) AS Avg_UnitsSold,
    ROUND(AVG(CAST(net_sales AS DECIMAL(12,2))), 2) AS Avg_NetSales,
    ROUND(AVG(CAST(discount_pct AS DECIMAL(5,2))), 2) AS Avg_DiscountPct
FROM FMCG_Table
WHERE country IN ('Italy', 'Spain', 'Germany', 'Poland')
GROUP BY category, CASE WHEN promo_flag = 1 THEN 'Promo' ELSE 'No Promo' END
ORDER BY category, Promo_Status;

SELECT
    category,
    CASE 
        WHEN promo_flag = 0 THEN '1) No Promo'
        WHEN discount_pct = 0.10 THEN '2) 10% Discount'
        WHEN discount_pct = 0.15 THEN '3) 15% Discount'
        WHEN discount_pct = 0.20 THEN '4) 20% Discount'
        WHEN discount_pct = 0.30 THEN '5) 30% Discount'
    END AS Discount_Tier,
    COUNT(*) AS TotalDays,
    ROUND(AVG(CAST(units_sold AS DECIMAL(10,2))), 2) AS Avg_UnitsSold,
    ROUND(AVG(CAST(net_sales AS DECIMAL(12,2))), 2) AS Avg_NetSales
FROM FMCG_Table
WHERE country IN ('Italy', 'Spain', 'Germany', 'Poland')
GROUP BY 
    category,
    CASE 
        WHEN promo_flag = 0 THEN '1) No Promo'
        WHEN discount_pct = 0.10 THEN '2) 10% Discount'
        WHEN discount_pct = 0.15 THEN '3) 15% Discount'
        WHEN discount_pct = 0.20 THEN '4) 20% Discount'
        WHEN discount_pct = 0.30 THEN '5) 30% Discount'
    END
ORDER BY category, Discount_Tier;