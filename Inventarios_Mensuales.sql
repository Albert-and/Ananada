



WITH StockCTE AS (
    SELECT 
        Y.ItemCode,
        Y.Warehouse,
        SUM(Y.InQty) - SUM(Y.OutQty) AS Stock
    FROM OINM Y
    WHERE Y.DocDate BETWEEN '2023-01-01' AND '2024-01-31' AND Y.Warehouse = 'ALPM'
    GROUP BY Y.ItemCode, Y.Warehouse
)
SELECT 
    T1.WhsCode, 
    T1.WhsName, 
    T0.ItemCode, 
    T2.ItemName, 
    COALESCE(S.Stock, 0) AS Stock

FROM 
    OITW T0
    INNER JOIN OWHS T1 ON T0.WhsCode = T1.WhsCode 
    INNER JOIN OITM T2 ON T0.ItemCode = T2.ItemCode
    LEFT JOIN StockCTE S ON T0.ItemCode = S.ItemCode AND T0.WhsCode = S.Warehouse
WHERE T1.WhsCode = 'ALPM'
ORDER BY Stock DESC