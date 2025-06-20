




--Ventas Acumuladas por UN: Mayoreo + Online -------

SELECT 
    INV1.ItemCode AS 'ID',
    OITM.ItemName AS 'DESCRIPCIÓN',
    SUM(CASE WHEN NNM1.Series = 116 THEN INV1.Quantity ELSE 0 END) AS 'Cantidad Mayoreo',
    SUM(CASE WHEN NNM1.Series = 117 THEN INV1.Quantity ELSE 0 END) AS 'Cantidad Online',
    SUM(CASE WHEN NNM1.Series IN (116, 117) THEN INV1.Quantity ELSE 0 END) AS 'Cantidad Total'
FROM INV1
INNER JOIN OINV ON INV1.DocEntry = OINV.DocEntry
INNER JOIN OITM ON INV1.ItemCode = OITM.ItemCode
INNER JOIN NNM1 ON OINV.Series = NNM1.Series
WHERE 
    OINV.CANCELED = 'N' -- Excluir documentos cancelados
    AND NNM1.Series IN (116, 117) -- Solo series de Mayoreo y Online
    AND OINV.DocDate >= DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0) -- Primer día del mes actual
    AND OINV.DocDate < DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()) + 1, 0) -- Primer día del próximo mes
GROUP BY 
    INV1.ItemCode, 
    OITM.ItemName
ORDER BY 
    'Cantidad Total' DESC; -- Ordenar por cantidad total en orden descendente



--Inventario UN: Mayoreo + Online (Disponible) -------
SELECT 
    OITW.ItemCode AS 'ID',
    OITB.ItmsGrpNam AS 'Categoría',
    SUM(CASE WHEN OITW.WhsCode = 'ALPM' THEN (OITW.OnHand - OITW.IsCommited) ELSE 0 END) AS 'Inv Mayoreo',
    SUM(CASE WHEN OITW.WhsCode = 'ALPO' THEN (OITW.OnHand - OITW.IsCommited) ELSE 0 END) AS 'Inv Online',
    SUM(CASE WHEN OITW.WhsCode IN ('ALPM', 'ALPO') THEN (OITW.OnHand - OITW.IsCommited) ELSE 0 END) AS 'Inv Total'
FROM OITW
INNER JOIN OITM ON OITW.ItemCode = OITM.ItemCode
INNER JOIN OITB ON OITM.ItmsGrpCod = OITB.ItmsGrpCod
WHERE 
    OITW.WhsCode IN ('ALPM', 'ALPO') -- Solo almacenes específicos
    AND OITW.ItemCode NOT LIKE '[A-Z]%' -- Excluir ItemCode que comienzan con letras
    AND OITB.ItmsGrpNam NOT LIKE 'Mix%' -- Excluir categorías que contienen "Mix"
GROUP BY 
    OITW.ItemCode, 
    OITM.ItemName, 
    OITB.ItmsGrpNam
ORDER BY 
    OITW.ItemCode;


-------------------------

SELECT 
    OITW.ItemCode AS 'ID',
    OITB.ItmsGrpNam AS 'Categoría',
    SUM(CASE WHEN OITW.WhsCode = 'ALPM' THEN (OITW.OnHand - OITW.IsCommited) ELSE 0 END) AS 'Inv Mayoreo',
    SUM(CASE WHEN OITW.WhsCode = 'ALPO' THEN (OITW.OnHand - OITW.IsCommited) ELSE 0 END) AS 'Inv Online',
    SUM(CASE WHEN OITW.WhsCode IN ('ALPM', 'ALPO') THEN (OITW.OnHand - OITW.IsCommited) ELSE 0 END) AS 'Inv Total'
FROM OITW
INNER JOIN OITM ON OITW.ItemCode = OITM.ItemCode
INNER JOIN OITB ON OITM.ItmsGrpCod = OITB.ItmsGrpCod
WHERE 
    OITW.WhsCode IN ('ALPM', 'ALPO') -- Solo almacenes específicos
    AND OITW.ItemCode NOT LIKE '[A-Z]%' -- Excluir ItemCode que comienzan con letras
    AND OITB.ItmsGrpNam NOT LIKE 'Mix%' -- Excluir categorías que contienen "Mix"
GROUP BY 
    OITW.ItemCode, 
    OITM.ItemName, 
    OITB.ItmsGrpNam
ORDER BY 
    OITW.ItemCode;

-------


