SELECT TOP (1000) [FaltanteID]
      ,[ParentID]
      ,[CodigoCliente]
      ,[IdVendedor]
      ,[CodigoArticulo]
      ,[Cantidad]
      ,[PrecioUnitario]
      ,[FechaRegistro]
      ,[FechaUpdate]
      ,[DocEntryRelacion]
  FROM [IV_Desarrollos].[dbo].[ProductoFaltante]


SELECT 
CodigoCliente,
CodigoArticulo,
Cantidad,
FechaRegistro
FROM ProductoFaltante
Where CodigoArticulo IN ('22419','33897','33900','64394')





SELECT 
    CodigoCliente,
    CodigoArticulo,
    SUM(Cantidad) AS CantidadTotal, -- Suma las cantidades si hay duplicados
    MIN(FechaRegistro) AS FechaRegistro -- Toma la primera fecha de registro
FROM ProductoFaltante
WHERE CodigoArticulo IN ('22419', '33897', '33900', '64394')
GROUP BY 
    CodigoCliente,
    CodigoArticulo,
    YEAR(FechaRegistro), -- Agrupa por año
    MONTH(FechaRegistro) -- Agrupa por mes
ORDER BY 
    CodigoCliente,
    CodigoArticulo,
    MIN(FechaRegistro);



SELECT 
    CodigoArticulo AS SKU,
    SUM(Cantidad) AS CantidadTotal, -- Suma las cantidades de ventas perdidas por semana
    MIN(FechaRegistro) AS FechaRegistro, -- Toma la primera fecha de registro de la semana
    DATEPART(YEAR, FechaRegistro) AS Año, -- Obtiene el año de la fecha
    DATEPART(WEEK, FechaRegistro) AS Semana -- Obtiene el número de semana del año
FROM ProductoFaltante
WHERE CodigoArticulo IN ('22419', '33897', '33900', '64394')
GROUP BY 
    CodigoArticulo,
    DATEPART(YEAR, FechaRegistro), -- Agrupa por año
    DATEPART(WEEK, FechaRegistro) -- Agrupa por semana
ORDER BY 
    Año,
    Semana,
    CodigoArticulo;