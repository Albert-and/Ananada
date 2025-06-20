

SELECT T2.[ItemCode]'CODIGO',
 T2.[ItemName]'DESCRIPCION',
 --T2.[u_provppto] 'PROV.PPTO',
  ---T2.[U_fmpre]'FAMILIA PRESUPUESTO',
   T2.[avgprice]'COSTO ARTICULO',
    ----T2.[U_area]'AREA',
    T1.[WhsCode],
     T1.WhsName,
     T0.[Iscommited]'Reservado',
     T0.[OnOrder]'Solicitado',
     T2.[MinLevel]'Stock Minimo',
     T2.[MaxLevel]'Stock Maximo',

ISNULL((SELECT (SUM(Y.InQty)-SUM(Y.OutQty))FROM OINM Y 
WHERE Y.ItemCode = T2.ItemCode AND Y.Warehouse = T1.WhsCode 
AND Y.DocDate BETWEEN '01/01/2025' AND '31/01/2025'),0) 'Stock',

ISNULL((SELECT (SUM(Y.TransValue))  FROM OINM Y 
WHERE Y.ItemCode = T2.ItemCode 
AND Y.Warehouse = T1.WhsCode AND Y.DocDate <='31/01/205'),0)'Costo Total'

FROM OITM T2

INNER JOIN OITW T0 ON T0.ItemCode=T2.ItemCode

INNER JOIN OWHS T1 ON T1.WhsCode=T0.WhsCode

WHERE (SELECT (SUM(Y.InQty)-SUM(Y.OutQty)) FROM OINM Y WHERE Y.ItemCode = T2.ItemCode 
AND Y.Warehouse = T1.WhsCode AND Y.DocDate<=[%0] 
and (T0.whscode= [%3] OR T0.whscode= [%4] OR T0.whscode= [%5] 
OR T0.whscode= [%6] OR T0.whscode= [%7] OR T0.whscode= [%8] OR T0.whscode= [%9] 
OR T0.whscode= [%10] OR T0.whscode= [%11] OR T0.whscode= [%12] OR T0.whscode= [%13] 
OR T0.whscode= [%14] OR T0.whscode= [%15] OR T0.whscode= [%16] OR T0.whscode= [%17] 
OR T0.whscode= [%18] OR T0.whscode= [%19] OR T0.whscode= [%20] OR T0.whscode= [%21] 
OR T0.whscode= [%22] OR T0.whscode= [%23] OR T0.whscode= [%24] OR T0.whscode= [%25] 
OR T0.whscode= [%26])) != '0'

ORDER BY T2.[ItemCode], T1.[WhsCode]




SELECT 
    T2.[ItemCode] 'CODIGO', 
    T2.[ItemName] 'DESCRIPCION', 
    ---T2.[u_provppto] 'PROV.PPTO', 
    ---T2.[U_fmpre] 'FAMILIA PRESUPUESTO', 
    T2.[avgprice] 'COSTO ARTICULO', 
   --- T2.[U_area] 'AREA',
    T1.[WhsCode], 
    T1.WhsName,
    T0.[Iscommited] 'Reservado',
    T0.[OnOrder] 'Solicitado',
    T2.[MinLevel] 'Stock Minimo', 
    T2.[MaxLevel] 'Stock Maximo',
    ISNULL((SELECT (SUM(Y.InQty)-SUM(Y.OutQty)) FROM OINM Y 
           WHERE Y.ItemCode = T2.ItemCode AND Y.Warehouse = T1.WhsCode 
           AND Y.DocDate BETWEEN '01/01/2025' AND '31/01/2025'),0) 'Stock',
    ISNULL((SELECT (SUM(Y.TransValue)) FROM OINM Y 
           WHERE Y.ItemCode = T2.ItemCode AND Y.Warehouse = T1.WhsCode 
           AND Y.DocDate <= '31/01/2025'), 0) 'Costo Total'
FROM 
    OITM T2
    INNER JOIN OITW T0 ON T0.ItemCode = T2.ItemCode
    INNER JOIN OWHS T1 ON T1.WhsCode = T0.WhsCode
WHERE 
    (SELECT (SUM(Y.InQty)-SUM(Y.OutQty)) FROM OINM Y 
     WHERE Y.ItemCode = T2.ItemCode AND Y.Warehouse = T1.WhsCode 
     AND Y.DocDate <= '[%0]' AND T0.WhsCode IN ('ALPM', 'ALPO')) != 0
ORDER BY 
    T2.[ItemCode], T1.[WhsCode]








SELECT 
    T2.[ItemCode] 'CODIGO', 
    T2.[ItemName] 'DESCRIPCION', 
    ---T2.[U_fmpre] 'FAMILIA PRESUPUESTO', 
    T2.[avgprice] 'COSTO ARTICULO',
    T1.[WhsCode], 
    T1.WhsName,
    T0.[Iscommited] 'Reservado',
    T0.[OnOrder] 'Solicitado',
    T2.[MinLevel] 'Stock Minimo', 
    T2.[MaxLevel] 'Stock Maximo',
    ISNULL((SELECT (SUM(Y.InQty)-SUM(Y.OutQty)) FROM OINM Y 
           WHERE Y.ItemCode = T2.ItemCode AND Y.Warehouse = T1.WhsCode 
           AND Y.DocDate BETWEEN '20250101' AND '20250131'), 0) 'Stock',
    ISNULL((SELECT (SUM(Y.TransValue)) FROM OINM Y 
           WHERE Y.ItemCode = T2.ItemCode AND Y.Warehouse = T1.WhsCode 
           AND Y.DocDate <= '20250131'), 0) 'Costo Total'
FROM 
    OITM T2
    INNER JOIN OITW T0 ON T0.ItemCode = T2.ItemCode
    INNER JOIN OWHS T1 ON T1.WhsCode = T0.WhsCode
WHERE 
    (SELECT (SUM(Y.InQty)-SUM(Y.OutQty)) FROM OINM Y 
     WHERE Y.ItemCode = T2.ItemCode AND Y.Warehouse = T1.WhsCode 
     AND Y.DocDate <= '20250131' AND T0.WhsCode IN ('ALPM', 'ALPO')) != 0
ORDER BY 
    T2.[ItemCode], T1.[WhsCode]



-----


SELECT 
    T2.[ItemCode] 'CODIGO', 
    T2.[ItemName] 'DESCRIPCION', 
    ---T2.[U_fmpre] 'FAMILIA PRESUPUESTO', 
    T2.[avgprice] 'COSTO ARTICULO',
    T1.[WhsCode], 
    T1.WhsName,
    T0.[Iscommited] 'Reservado',
    T0.[OnOrder] 'Solicitado',
    T2.[MinLevel] 'Stock Minimo', 
    T2.[MaxLevel] 'Stock Maximo',
    ISNULL((SELECT (SUM(Y.InQty)-SUM(Y.OutQty)) FROM OINM Y 
           WHERE Y.ItemCode = T2.ItemCode AND Y.Warehouse = T1.WhsCode 
           AND Y.DocDate <= '20250131'), 0) 'Stock',
    ISNULL((SELECT (SUM(Y.TransValue)) FROM OINM Y 
           WHERE Y.ItemCode = T2.ItemCode AND Y.Warehouse = T1.WhsCode 
           AND Y.DocDate <= '20250131'), 0) 'Costo Total'
FROM 
    OITM T2
    INNER JOIN OITW T0 ON T0.ItemCode = T2.ItemCode
    INNER JOIN OWHS T1 ON T1.WhsCode = T0.WhsCode
WHERE 
    T0.WhsCode IN ('ALPM', 'ALPO')
    AND (
        SELECT (SUM(Y.InQty)-SUM(Y.OutQty)) 
        FROM OINM Y 
        WHERE Y.ItemCode = T2.ItemCode 
        AND Y.Warehouse = T1.WhsCode 
        AND Y.DocDate <= '20250131'
    ) > 0  -- Cambiado para mostrar solo existencias positivas
ORDER BY 
    T2.[ItemCode], T1.[WhsCode]