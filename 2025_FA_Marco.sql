



------FA----




SELECT 
    OITW.ItemCode AS 'SKU',
    OITM.ItemName AS 'Nombre',
    ISNULL(SUM(Ventas.VentasFacturadas), 0) AS 'Venta', -- Cantidad vendida acumulada
    ISNULL(SUM(ForecastData.Forecast), 0) AS 'Forecast', -- Forecast acumulado
    CASE 
        WHEN ISNULL(SUM(Ventas.VentasFacturadas), 0) = 0 THEN '0%'
        ELSE FORMAT((1 - ((ISNULL(SUM(Ventas.VentasFacturadas), 0) - ISNULL(SUM(ForecastData.Forecast), 0)) / ISNULL(SUM(Ventas.VentasFacturadas), 0))) * 100, 'N2') + '%'
    END AS '%FA'
FROM OITW
INNER JOIN OITM ON OITW.ItemCode = OITM.ItemCode
LEFT JOIN (
    -- Subquery para calcular las ventas facturadas por SKU en enero, febrero y marzo
    SELECT 
        INV1.ItemCode,
        SUM(INV1.Quantity) AS VentasFacturadas -- Sumar la cantidad vendida
    FROM OINV
    INNER JOIN INV1 ON OINV.DocEntry = INV1.DocEntry
    WHERE OINV.CANCELED = 'N' -- Excluir documentos cancelados
      AND YEAR(OINV.DocDate) = YEAR(GETDATE()) -- Solo ventas del año actual
      AND MONTH(OINV.DocDate) IN (1, 2, 3) -- Solo enero, febrero y marzo
    GROUP BY INV1.ItemCode
) AS Ventas ON OITW.ItemCode = Ventas.ItemCode
LEFT JOIN (
    -- Subquery para obtener el forecast de enero, febrero y marzo
    SELECT
        FCT1.ItemCode,
        SUM(FCT1.Quantity) AS Forecast -- Sumar el forecast
    FROM FCT1
    WHERE FCT1.AbsID = 3 -- Filtrar por AbsID específico
      AND MONTH(FCT1.Date) IN (1, 2, 3) -- Solo enero, febrero y marzo
      AND YEAR(FCT1.Date) = YEAR(GETDATE()) -- Solo del año actual
    GROUP BY FCT1.ItemCode
) AS ForecastData ON OITW.ItemCode = ForecastData.ItemCode
GROUP BY OITW.ItemCode, OITM.ItemName
ORDER BY '%FA' DESC;







------FA----




SELECT 
    OITW.ItemCode AS 'SKU',
    OITM.ItemName AS 'Nombre',
    ISNULL(SUM(Ventas.VentasFacturadas), 0) AS 'Venta', -- Cantidad vendida acumulada
    ISNULL(SUM(ForecastData.Forecast), 0) AS 'Forecast', -- Forecast acumulado
    CASE 
        WHEN ISNULL(SUM(Ventas.VentasFacturadas), 0) = 0 THEN '0%'
        ELSE FORMAT((1 - ((ISNULL(SUM(Ventas.VentasFacturadas), 0) - ISNULL(SUM(ForecastData.Forecast), 0)) / ISNULL(SUM(Ventas.VentasFacturadas), 0))) * 100, 'N2') + '%'
    END AS '%FA'
FROM OITW
INNER JOIN OITM ON OITW.ItemCode = OITM.ItemCode
LEFT JOIN (
    -- Subquery para calcular las ventas facturadas por SKU en enero, febrero y marzo
    SELECT 
        INV1.ItemCode,
        SUM(INV1.Quantity) AS VentasFacturadas -- Sumar la cantidad vendida
    FROM OINV
    INNER JOIN INV1 ON OINV.DocEntry = INV1.DocEntry
    WHERE OINV.CANCELED = 'N' -- Excluir documentos cancelados
      AND YEAR(OINV.DocDate) = YEAR(GETDATE()) -- Solo ventas del año actual
      AND MONTH(OINV.DocDate) IN (1) -- Solo enero, febrero y marzo
    GROUP BY INV1.ItemCode
) AS Ventas ON OITW.ItemCode = Ventas.ItemCode
LEFT JOIN (
    -- Subquery para obtener el forecast de enero, febrero y marzo
    SELECT
        FCT1.ItemCode,
        SUM(FCT1.Quantity) AS Forecast -- Sumar el forecast
    FROM FCT1
    WHERE FCT1.AbsID = 3 -- Filtrar por AbsID específico
      AND MONTH(FCT1.Date) IN (1) -- Solo enero, febrero y marzo
      AND YEAR(FCT1.Date) = YEAR(GETDATE()) -- Solo del año actual
    GROUP BY FCT1.ItemCode
) AS ForecastData ON OITW.ItemCode = ForecastData.ItemCode
GROUP BY OITW.ItemCode, OITM.ItemName
ORDER BY '%FA' DESC;



---- Query Ventas ---

SELECT 
    INV1.ItemCode AS 'SKU',
    SUM(INV1.Quantity) AS 'Cantidad Total Facturada'
FROM OINV
INNER JOIN INV1 ON OINV.DocEntry = INV1.DocEntry
WHERE OINV.CANCELED = 'N' -- Excluir documentos cancelados
  AND YEAR(OINV.DocDate) = YEAR(GETDATE()) -- Solo ventas del año actual
  AND MONTH(OINV.DocDate) IN (1, 2, 3) -- Solo enero, febrero y marzo
GROUP BY INV1.ItemCode
ORDER BY INV1.ItemCode;


--Query Forecast.---


SELECT
    FCT1.ItemCode AS 'SKU',
    MONTH(FCT1.Date) AS 'Mes',
    SUM(FCT1.Quantity) AS 'Cantidad Forecast'
FROM FCT1
WHERE FCT1.AbsID = 3 -- Filtrar por AbsID específico
  AND YEAR(FCT1.Date) = YEAR(GETDATE()) -- Solo forecast del año actual
  AND MONTH(FCT1.Date) IN (1, 2, 3) -- Solo enero, febrero y marzo
GROUP BY FCT1.ItemCode, MONTH(FCT1.Date)
ORDER BY FCT1.ItemCode, MONTH(FCT1.Date);



----Revision FA %----


SELECT 
    OITW.ItemCode AS 'SKU',
    OITM.ItemName AS 'Nombre',
    ISNULL(SUM(Ventas.CantidadFacturada), 0) AS 'Venta', -- Cantidad total facturada
    ISNULL(SUM(ForecastData.CantidadForecast), 0) AS 'Forecast', -- Cantidad total forecast
    CASE 
        WHEN ISNULL(SUM(Ventas.CantidadFacturada), 0) = 0 THEN '0%'
        ELSE FORMAT((1 - ((ISNULL(SUM(Ventas.CantidadFacturada), 0) - ISNULL(SUM(ForecastData.CantidadForecast), 0)) / ISNULL(SUM(Ventas.CantidadFacturada), 0))) * 100, 'N2') + '%'
    END AS '%FA'
FROM OITW
INNER JOIN OITM ON OITW.ItemCode = OITM.ItemCode
LEFT JOIN (
    -- Subquery para calcular las ventas facturadas por SKU en enero, febrero y marzo
    SELECT 
        INV1.ItemCode,
        SUM(INV1.Quantity) AS CantidadFacturada -- Sumar la cantidad facturada
    FROM OINV
    INNER JOIN INV1 ON OINV.DocEntry = INV1.DocEntry
    WHERE OINV.CANCELED = 'N' -- Excluir documentos cancelados
      AND YEAR(OINV.DocDate) = YEAR(GETDATE()) -- Solo ventas del año actual
      AND MONTH(OINV.DocDate) IN (1, 2, 3) -- Solo enero, febrero y marzo
    GROUP BY INV1.ItemCode
) AS Ventas ON OITW.ItemCode = Ventas.ItemCode
LEFT JOIN (
    -- Subquery para obtener el forecast de enero, febrero y marzo
    SELECT
        FCT1.ItemCode,
        SUM(FCT1.Quantity) AS CantidadForecast -- Sumar la cantidad forecast
    FROM FCT1
    WHERE FCT1.AbsID = 3 -- Filtrar por AbsID específico
      AND YEAR(FCT1.Date) = YEAR(GETDATE()) -- Solo forecast del año actual
      AND MONTH(FCT1.Date) IN (1, 2, 3) -- Solo enero, febrero y marzo
    GROUP BY FCT1.ItemCode
) AS ForecastData ON OITW.ItemCode = ForecastData.ItemCode
WHERE ForecastData.CantidadForecast IS NOT NULL -- Filtrar solo productos en el forecast
GROUP BY OITW.ItemCode, OITM.ItemName
ORDER BY '%FA' DESC;




SELECT 
    INV1.ItemCode AS 'SKU',
    SUM(INV1.Quantity) AS 'Cantidad Total Facturada'
FROM OINV
INNER JOIN INV1 ON OINV.DocEntry = INV1.DocEntry
WHERE OINV.CANCELED = 'N' -- Excluir documentos cancelados
  AND YEAR(OINV.DocDate) = YEAR(GETDATE()) -- Solo ventas del año actual
  AND MONTH(OINV.DocDate) IN (1, 2, 3) -- Solo enero, febrero y marzo
  AND INV1.ItemCode = '9078'
GROUP BY INV1.ItemCode
ORDER BY INV1.ItemCode;






SELECT
    FCT1.ItemCode AS 'SKU',
    SUM(FCT1.Quantity) AS 'Cantidad Total Forecast'
FROM FCT1
WHERE FCT1.AbsID = 3 -- Filtrar por AbsID específico
  AND YEAR(FCT1.Date) = YEAR(GETDATE()) -- Solo forecast del año actual
  AND MONTH(FCT1.Date) IN (1, 2, 3) -- Solo enero, febrero y marzo
  AND FCT1.ItemCode = '9078'
GROUP BY FCT1.ItemCode
ORDER BY FCT1.ItemCode;




---------



WITH Ventas AS (
    -- Subquery para calcular las ventas facturadas acumuladas
    SELECT 
        INV1.ItemCode AS 'SKU',
        SUM(INV1.Quantity) AS 'CantidadFacturada' -- Alias corregido
    FROM OINV
    INNER JOIN INV1 ON OINV.DocEntry = INV1.DocEntry
    WHERE OINV.CANCELED = 'N' -- Excluir documentos cancelados
      AND YEAR(OINV.DocDate) = YEAR(GETDATE()) -- Solo ventas del año actual
      AND MONTH(OINV.DocDate) IN (1, 2, 3) -- Solo enero, febrero y marzo
    GROUP BY INV1.ItemCode
),
Forecast AS (
    -- Subquery para calcular el forecast acumulado
    SELECT
        FCT1.ItemCode AS 'SKU',
        SUM(FCT1.Quantity) AS 'CantidadForecast' -- Alias corregido
    FROM FCT1
    WHERE FCT1.AbsID = 3 -- Filtrar por AbsID específico
      AND YEAR(FCT1.Date) = YEAR(GETDATE()) -- Solo forecast del año actual
      AND MONTH(FCT1.Date) IN (1, 2, 3) -- Solo enero, febrero y marzo
    GROUP BY FCT1.ItemCode
)
-- Query principal para calcular el FA%
SELECT 
    V.SKU,
    ISNULL(V.CantidadFacturada, 0) AS 'Venta', -- Alias corregido
    ISNULL(F.CantidadForecast, 0) AS 'Forecast', -- Alias corregido
    CASE 
        WHEN ISNULL(V.CantidadFacturada, 0) = 0 THEN '0%'
        ELSE FORMAT((1 - ((ISNULL(V.CantidadFacturada, 0) - ISNULL(F.CantidadForecast, 0)) / ISNULL(V.CantidadFacturada, 0))) * 100, 'N2') + '%'
    END AS '%FA'
FROM Ventas V
LEFT JOIN Forecast F ON V.SKU = F.SKU
ORDER BY '%FA' DESC;


---Forecast Accuracy ---


WITH Ventas AS (
    -- Subquery para calcular las ventas facturadas acumuladas
    SELECT 
        INV1.ItemCode AS 'SKU',
        SUM(INV1.Quantity) AS 'CantidadFacturada' -- Alias corregido
    FROM OINV
    INNER JOIN INV1 ON OINV.DocEntry = INV1.DocEntry
    WHERE OINV.CANCELED = 'N' -- Excluir documentos cancelados
      AND YEAR(OINV.DocDate) = YEAR(GETDATE()) -- Solo ventas del año actual
      AND MONTH(OINV.DocDate) IN (1, 2, 3) -- Solo enero, febrero y marzo
    GROUP BY INV1.ItemCode
),
Forecast AS (
    -- Subquery para calcular el forecast acumulado
    SELECT
        FCT1.ItemCode AS 'SKU',
        SUM(FCT1.Quantity) AS 'CantidadForecast' -- Alias corregido
    FROM FCT1
    WHERE FCT1.AbsID = 3 -- Filtrar por AbsID específico
      AND YEAR(FCT1.Date) = YEAR(GETDATE()) -- Solo forecast del año actual
      AND MONTH(FCT1.Date) IN (1, 2, 3) -- Solo enero, febrero y marzo
    GROUP BY FCT1.ItemCode
)
-- Query principal para calcular el FA%
SELECT 
    V.SKU,
    FORMAT(ISNULL(V.CantidadFacturada, 0), 'N0') AS 'Venta', -- Formato con separador de miles
    FORMAT(ISNULL(F.CantidadForecast, 0), 'N0') AS 'Forecast', -- Formato con separador de miles
    CASE 
        WHEN ISNULL(V.CantidadFacturada, 0) = 0 THEN '0%'
        ELSE FORMAT((1 - ((ISNULL(V.CantidadFacturada, 0) - ISNULL(F.CantidadForecast, 0)) / ISNULL(V.CantidadFacturada, 0))) * 100, 'N2') + '%'
    END AS '%FA'
FROM Ventas V
LEFT JOIN Forecast F ON V.SKU = F.SKU
ORDER BY '%FA' DESC;