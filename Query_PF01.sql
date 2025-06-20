


SELECT 
    FORMAT(f.DocDate, 'yyyy-MM') AS Mes,
    l.ItemCode AS SKU,
    SUM(l.Quantity) AS Cantidad_Total,
    AVG(l.LineTotal) AS Precio_Promedio
FROM 
    OINV f
JOIN 
    INV1 l ON f.DocEntry = l.DocEntry
JOIN 
    OITM p ON l.ItemCode = p.ItemCode
JOIN 
    OCRD c ON f.CardCode = c.CardCode
WHERE 
    f.DocDate BETWEEN '2021-01-01' AND '2023-12-31' AND p.ItmsGrpCod IN (101, 102)
GROUP BY 
    FORMAT(f.DocDate, 'yyyy-MM'), 
    l.ItemCode,
    p.ItmsGrpCod
ORDER BY 
    Mes, SKU;