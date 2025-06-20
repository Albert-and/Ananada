



SELECT T2.[ItemCode], T2.[ItemName], T1.[WhsCode], T1.WhsName,

ISNULL((SELECT (SUM(Y.InQty)-SUM(Y.OutQty))
FROM OINM Y WHERE Y.ItemCode = T2.ItemCode AND Y.Warehouse = T1.WhsCode
 AND Y.DocDate<='20250408'),0) 'Stock',

ISNULL((SELECT (SUM(Y.TransValue))  
FROM OINM Y WHERE Y.ItemCode = T2.ItemCode AND Y.Warehouse = T1.WhsCode
 AND Y.DocDate <='20250408'),0)'Costo Total'

FROM OITM T2

INNER JOIN OITW T0 ON T0.ItemCode=T2.ItemCode

INNER JOIN OWHS T1 ON T1.WhsCode=T0.WhsCode

WHERE (SELECT (SUM(Y.InQty)-SUM(Y.OutQty)) FROM OINM Y WHERE Y.ItemCode = T2.ItemCode
 AND Y.Warehouse = T1.WhsCode AND Y.DocDate<='20250408') != '0'

ORDER BY T2.[ItemCode], T1.[WhsCode]


---Optimizada------

WITH StockData AS (
    SELECT 
        Y.ItemCode,
        Y.Warehouse,
        SUM(Y.InQty) - SUM(Y.OutQty) AS Stock,
        SUM(Y.TransValue) AS CostoTotal
    FROM OINM Y
    WHERE Y.DocDate <= '20250430'
    GROUP BY Y.ItemCode, Y.Warehouse
)
SELECT 
    T2.[ItemCode], 
    T2.[ItemName], 
    T1.[WhsCode], 
    T1.[WhsName], 
    ISNULL(SD.Stock, 0) AS 'Stock',
    ISNULL(SD.CostoTotal, 0) AS 'Costo Total'
FROM OITM T2
INNER JOIN OITW T0 ON T0.ItemCode = T2.ItemCode
INNER JOIN OWHS T1 ON T1.WhsCode = T0.WhsCode
LEFT JOIN StockData SD ON SD.ItemCode = T2.ItemCode AND SD.Warehouse = T1.WhsCode
WHERE ISNULL(SD.Stock, 0) != 0
ORDER BY T2.[ItemCode], T1.[WhsCode];

