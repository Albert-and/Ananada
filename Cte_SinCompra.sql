-- CTE para obtener los clientes que compraron en el mes anterior
WITH ClientesMesAnterior AS (
    SELECT DISTINCT
        OINV.CardCode
    FROM OINV
    WHERE 
        OINV.DocDate >= DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()) - 1, 0) -- Primer día del mes anterior
        AND OINV.DocDate < DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0) -- Primer día del mes actual
        AND OINV.CANCELED = 'N'
),

-- CTE para obtener los clientes que compraron en el mes actual
ClientesMesActual AS (
    SELECT DISTINCT
        OINV.CardCode
    FROM OINV
    WHERE 
        OINV.DocDate >= DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0) -- Primer día del mes actual
        AND OINV.DocDate < DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()) + 1, 0) -- Primer día del próximo mes
        AND OINV.CANCELED = 'N'
)

-- Selección final de clientes que compraron el mes anterior pero no este mes
SELECT 
    C.CardCode AS 'Código de Cliente'
FROM 
    ClientesMesAnterior C
LEFT JOIN 
    ClientesMesActual A ON C.CardCode = A.CardCode
WHERE 
    A.CardCode IS NULL


---------------


SELECT 
    C.CardCode AS 'Código de Cliente',
    C.CardName AS 'Nombre de Cliente',
    MAX(I.DocDate) AS 'Última Fecha de Compra',
    SUM(L.LineTotal) AS 'Último Monto Comprado'
FROM 
    OINV I
INNER JOIN 
    INV1 L ON I.DocEntry = L.DocEntry
INNER JOIN 
    OCRD C ON I.CardCode = C.CardCode
WHERE 
    I.CANCELED = 'N'  -- Solo documentos no cancelados
GROUP BY 
    C.CardCode, C.CardName
ORDER BY 
    'Última Fecha de Compra' DESC