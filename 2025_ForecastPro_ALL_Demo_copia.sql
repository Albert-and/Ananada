SELECT *
  FROM [ANANDA_MAYOREO].[dbo].[vw_FCP_ALL]





SELECT
    SUM(Quantity) AS TotalQuantity
FROM INV1
WHERE DocDate BETWEEN '2025-05-01' AND '2025-05-30'
  AND ItemCode = '9078';
 



 DROP VIEW vw_FCP_ALL






CREATE VIEW vw_FCP_ALL AS
SELECT 
    'Ananda' AS 'ItemID0', -- Columna fija con el valor "Ananda"
    ----OITB.ItmsGrpNam AS 'ItemID1', -- Grupo de artículo
    ----OITM.U_codigo AS 'ItemID2', -- Código adicional del artículo
    INV1.ItemCode AS 'ItemID1', -- Código del artículo (SKU)
    OINV.CardCode AS 'ItemID2', -- Código del cliente
    OITM.ItemName AS 'Description', -- Nombre del artículo
    DATEPART(YEAR, OINV.DocDate) AS 'hist_year', -- Año de la venta
    DATEPART(WEEK, OINV.DocDate) AS 'hist_period', -- Número de semana
    53 AS 'ppy', -- Total de semanas por año (valor fijo)
    53 AS 'ppc', -- Total de semanas por año (valor fijo)
    SUM(INV1.Quantity) AS 'hist_value' -- Cantidad total vendida
FROM 
    [ANANDA_BD].[dbo].[INV1] AS INV1 -- Detalle de las facturas
INNER JOIN 
    [ANANDA_BD].[dbo].[OINV] AS OINV ON INV1.DocEntry = OINV.DocEntry -- Relación con la cabecera de la factura
INNER JOIN 
    [ANANDA_BD].[dbo].[OITM] AS OITM ON INV1.ItemCode = OITM.ItemCode -- Relación con los artículos
INNER JOIN 
    [ANANDA_BD].[dbo].[OITB] AS OITB ON OITM.ItmsGrpCod = OITB.ItmsGrpCod -- Relación con los grupos de artículos
WHERE 
    OINV.CANCELED = 'N' -- Excluir facturas canceladas
    AND INV1.ItemCode IN (
    '64934','33897','34559','5905'
    ) -- Filtrar por artículos específicos
GROUP BY 
    OITB.ItmsGrpNam, 
    OITM.U_codigo, 
    INV1.ItemCode, 
    OINV.CardCode, 
    OITM.ItemName, 
    DATEPART(YEAR, OINV.DocDate), 
    DATEPART(WEEK, OINV.DocDate)

UNION ALL

SELECT 
    'Ananda' AS 'ItemID0', -- Columna fija con el valor "Ananda"
    -----OITB.ItmsGrpNam AS 'ItemID1', -- Grupo de artículo
    ----OITM.U_codigo AS 'ItemID2', -- Código adicional del artículo
    INV1.ItemCode AS 'ItemID1', -- Código del artículo (SKU)
    OINV.CardCode AS 'ItemID2', -- Código del cliente
    OITM.ItemName AS 'Description', -- Nombre del artículo
    DATEPART(YEAR, OINV.DocDate) AS 'hist_year', -- Año de la venta
    DATEPART(WEEK, OINV.DocDate) AS 'hist_period', -- Número de semana
    53 AS 'ppy', -- Total de semanas por año (valor fijo)
    53 AS 'ppc', -- Total de semanas por año (valor fijo)
    SUM(INV1.Quantity) AS 'hist_value' -- Cantidad total vendida
FROM 
    [ANANDA_MAYOREO].[dbo].[INV1] AS INV1 -- Detalle de las facturas
INNER JOIN 
    [ANANDA_MAYOREO].[dbo].[OINV] AS OINV ON INV1.DocEntry = OINV.DocEntry -- Relación con la cabecera de la factura
INNER JOIN 
    [ANANDA_MAYOREO].[dbo].[OITM] AS OITM ON INV1.ItemCode = OITM.ItemCode -- Relación con los artículos
INNER JOIN 
    [ANANDA_MAYOREO].[dbo].[OITB] AS OITB ON OITM.ItmsGrpCod = OITB.ItmsGrpCod -- Relación con los grupos de artículos
WHERE 
    OINV.CANCELED = 'N' -- Excluir facturas canceladas
    AND INV1.ItemCode IN (
        '64934','33897','34559','5905'
    ) -- Filtrar por artículos específicos
GROUP BY 
    OITB.ItmsGrpNam, 
    OITM.U_codigo, 
    INV1.ItemCode, 
    OINV.CardCode, 
    OITM.ItemName, 
    DATEPART(YEAR, OINV.DocDate), 
    DATEPART(WEEK, OINV.DocDate);





-----------Mes---------------------
SELECT * FROM [ANANDA_MAYOREO].[dbo].[vw_Test2024FCPro]

DROP VIEW IF EXISTS vw_Test2024FCPro;

CREATE VIEW vw_Test2024FCPro AS
SELECT 
    'Ananda' AS 'ItemID0', -- Columna fija con el valor "Ananda"
    INV1.ItemCode AS 'ItemID1', -- Código del artículo (SKU)
    OINV.CardCode AS 'ItemID2', -- Código del cliente
    OITM.ItemName AS 'Description', -- Nombre del artículo
    DATEPART(YEAR, OINV.DocDate) AS 'hist_year', -- Año de la venta
    DATEPART(MONTH, OINV.DocDate) AS 'hist_period', -- Número de mes
    12 AS 'ppy', -- Total de meses por año (valor fijo)
    12 AS 'ppc', -- Total de meses por año (valor fijo)
    SUM(INV1.Quantity) AS 'hist_value' -- Cantidad total vendida
FROM 
    [ANANDA_BD].[dbo].[INV1] AS INV1 -- Detalle de las facturas
INNER JOIN 
    [ANANDA_BD].[dbo].[OINV] AS OINV ON INV1.DocEntry = OINV.DocEntry -- Relación con la cabecera de la factura
INNER JOIN 
    [ANANDA_BD].[dbo].[OITM] AS OITM ON INV1.ItemCode = OITM.ItemCode -- Relación con los artículos
INNER JOIN 
    [ANANDA_BD].[dbo].[OITB] AS OITB ON OITM.ItmsGrpCod = OITB.ItmsGrpCod -- Relación con los grupos de artículos
WHERE 
    OINV.CANCELED = 'N' -- Excluir facturas canceladas
    AND INV1.ItemCode IN (
        '33897','33900','64394','22419'
    ) -- Filtrar por artículos específicos
GROUP BY 
    OITB.ItmsGrpNam, 
    OITM.U_codigo, 
    INV1.ItemCode, 
    OINV.CardCode, 
    OITM.ItemName, 
    DATEPART(YEAR, OINV.DocDate), 
    DATEPART(MONTH, OINV.DocDate)

UNION ALL

SELECT 
    'Ananda' AS 'ItemID0', -- Columna fija con el valor "Ananda"
    INV1.ItemCode AS 'ItemID1', -- Código del artículo (SKU)
    OINV.CardCode AS 'ItemID2', -- Código del cliente
    OITM.ItemName AS 'Description', -- Nombre del artículo
    DATEPART(YEAR, OINV.DocDate) AS 'hist_year', -- Año de la venta
    DATEPART(MONTH, OINV.DocDate) AS 'hist_period', -- Número de mes
    12 AS 'ppy', -- Total de meses por año (valor fijo)
    12 AS 'ppc', -- Total de meses por año (valor fijo)
    SUM(INV1.Quantity) AS 'hist_value' -- Cantidad total vendida
FROM 
    [ANANDA_MAYOREO].[dbo].[INV1] AS INV1 -- Detalle de las facturas
INNER JOIN 
    [ANANDA_MAYOREO].[dbo].[OINV] AS OINV ON INV1.DocEntry = OINV.DocEntry -- Relación con la cabecera de la factura
INNER JOIN 
    [ANANDA_MAYOREO].[dbo].[OITM] AS OITM ON INV1.ItemCode = OITM.ItemCode -- Relación con los artículos
INNER JOIN 
    [ANANDA_MAYOREO].[dbo].[OITB] AS OITB ON OITM.ItmsGrpCod = OITB.ItmsGrpCod -- Relación con los grupos de artículos
WHERE 
    OINV.CANCELED = 'N' -- Excluir facturas canceladas
    AND INV1.ItemCode IN (
        '33897','33900','64394','22419'
    ) -- Filtrar por artículos específicos
GROUP BY 
    OITB.ItmsGrpNam, 
    OITM.U_codigo, 
    INV1.ItemCode, 
    OINV.CardCode, 
    OITM.ItemName, 
    DATEPART(YEAR, OINV.DocDate), 
    DATEPART(MONTH, OINV.DocDate);