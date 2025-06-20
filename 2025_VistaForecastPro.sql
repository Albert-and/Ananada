



CREATE VIEW vw_FCP_Test AS
SELECT 
    'Ananda' AS 'ItemId', -- Columna fija con el valor "Ananda"
    OITB.ItmsGrpNam AS 'ItemId1', -- Grupo de artículo
    OINV.CardCode AS 'ItemId2', -- Código del cliente
    INV1.ItemCode AS 'ItemId3', -- Código del artículo (SKU)
    OITM.ItemName AS 'Description', -- Nombre del artículo
    DATEPART(YEAR, OINV.DocDate) AS 'hist_year', -- Año de la venta
    DATEPART(WEEK, OINV.DocDate) AS 'hist_period', -- Número de semana
    52 AS 'ppy', -- Total de semanas por año (valor fijo)
    52 AS 'ppc', -- Total de semanas por año (valor fijo)
    SUM(INV1.Quantity) AS 'hist_value' -- Cantidad total vendida
FROM 
    INV1 -- Detalle de las facturas
INNER JOIN 
    OINV ON INV1.DocEntry = OINV.DocEntry -- Relación con la cabecera de la factura
INNER JOIN 
    OITM ON INV1.ItemCode = OITM.ItemCode -- Relación con los artículos
INNER JOIN 
    OITB ON OITM.ItmsGrpCod = OITB.ItmsGrpCod -- Relación con los grupos de artículos
WHERE 
    OINV.CANCELED = 'N' -- Excluir facturas canceladas
    AND INV1.ItemCode IN ('10804',
                          '14740',
                          '22192',
                          '22200',
                          '22418',
                          '22419',
                          '33897',
                          '33898',
                          '33900') -- Filtrar por artículos específicos
GROUP BY 
    OITB.ItmsGrpNam, 
    OINV.CardCode, 
    INV1.ItemCode, 
    OITM.ItemName, 
    OINV.DocDate



SELECT * FROM vw_FCP_Test; -- Consulta para verificar el contenido de la vista