SELECT
    category,
    CASE 
        WHEN promo_flag = 0 THEN 'No Promo'
        WHEN discount_pct = 0.10 THEN '10% Discount'
        WHEN discount_pct = 0.15 THEN '15% Discount'
        WHEN discount_pct = 0.20 THEN '20% Discount'
        WHEN discount_pct = 0.30 THEN '30% Discount'
    END AS Discount_Tier,
    COUNT(*) AS TotalDays,
    CAST(ROUND(AVG(CAST(margin_pct AS DECIMAL(10,2))), 2) AS DECIMAL(5,2)) AS Avg_MarginPct,
    ROUND(AVG(CAST(net_sales AS DECIMAL(12,2))), 2) AS Avg_NetSales
FROM FMCG_Table
WHERE country IN ('Italy', 'Spain', 'Germany', 'Poland')
GROUP BY 
    category,
    CASE 
        WHEN promo_flag = 0 THEN 'No Promo'
        WHEN discount_pct = 0.10 THEN '10% Discount'
        WHEN discount_pct = 0.15 THEN '15% Discount'
        WHEN discount_pct = 0.20 THEN '20% Discount'
        WHEN discount_pct = 0.30 THEN '30% Discount'
    END
ORDER BY category, Discount_Tier;