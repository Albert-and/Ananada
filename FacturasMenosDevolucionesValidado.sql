


-- CTE para las Ventas
WITH Ventas AS (
    SELECT
        CAST(OINV.DocDate AS DATE) AS Fecha,
        DATEPART(MONTH, OINV.DocDate) AS Mes,
        DATEPART(YEAR, OINV.DocDate) AS Año,
        OINV.CardCode,
        INV1.ItemCode,
        OINV.Series,
        NNM1.SeriesName AS NombreSerie,
        SUM(INV1.Quantity) AS CantidadVendida,
        SUM(INV1.LineTotal) / NULLIF(SUM(INV1.Quantity), 0) AS PrecioUnitario -- Calcula el precio unitario promedio
    FROM OINV
    INNER JOIN INV1 ON OINV.DocEntry = INV1.DocEntry
    INNER JOIN NNM1 ON OINV.Series = NNM1.Series
    WHERE
        INV1.ItemCode NOT LIKE 'F%'
        AND OINV.CANCELED = 'N'  -- Solo documentos no cancelados
    GROUP BY
        CAST(OINV.DocDate AS DATE),
        DATEPART(MONTH, OINV.DocDate),
        DATEPART(YEAR, OINV.DocDate),
        OINV.CardCode,
        INV1.ItemCode,
        OINV.Series,
        NNM1.SeriesName
),

-- CTE para las Devoluciones (Notas de Crédito)
Devoluciones AS (
    SELECT
        CAST(ORIN.DocDate AS DATE) AS Fecha,
        DATEPART(MONTH, ORIN.DocDate) AS Mes,
        DATEPART(YEAR, ORIN.DocDate) AS Año,
        ORIN.CardCode,
        RIN1.ItemCode,
        ORIN.Series,
        NNM1.SeriesName AS NombreSerie,
        SUM(RIN1.Quantity) AS CantidadDevuelta,
        SUM(RIN1.LineTotal) / NULLIF(SUM(RIN1.Quantity), 0) AS PrecioUnitarioDevuelto -- Calcula el precio unitario promedio
    FROM ORIN
    INNER JOIN RIN1 ON ORIN.DocEntry = RIN1.DocEntry
    INNER JOIN NNM1 ON ORIN.Series = NNM1.Series
    WHERE
        RIN1.ItemCode NOT LIKE 'F%'
        AND ORIN.CANCELED = 'N'  -- Solo documentos no cancelados
    GROUP BY
        CAST(ORIN.DocDate AS DATE),
        DATEPART(MONTH, ORIN.DocDate),
        DATEPART(YEAR, ORIN.DocDate),
        ORIN.CardCode,
        RIN1.ItemCode,
        ORIN.Series,
        NNM1.SeriesName
)

-- Consulta Final que Une Ventas y Devoluciones
SELECT
    COALESCE(V.Fecha, D.Fecha) AS Fecha,
    COALESCE(V.Mes, D.Mes) AS Mes,
    COALESCE(V.Año, D.Año) AS Año,
    COALESCE(V.CardCode, D.CardCode) AS CardCode,
    COALESCE(V.ItemCode, D.ItemCode) AS ItemCode,
    COALESCE(V.Series, D.Series) AS Series,
    COALESCE(V.NombreSerie, D.NombreSerie) AS NombreSerie,
    ISNULL(V.CantidadVendida, 0) - ISNULL(D.CantidadDevuelta, 0) AS CantidadNeta,
    (ISNULL(V.CantidadVendida, 0) * ISNULL(V.PrecioUnitario, 0) - ISNULL(D.CantidadDevuelta, 0) * ISNULL(D.PrecioUnitarioDevuelto, 0)) /
    NULLIF(ISNULL(V.CantidadVendida, 0) - ISNULL(D.CantidadDevuelta, 0), 0) AS PrecioUnitarioNeto
FROM Ventas V
FULL OUTER JOIN Devoluciones D
    ON V.Fecha = D.Fecha
    AND V.CardCode = D.CardCode
    AND V.ItemCode = D.ItemCode
    AND V.Series = D.Series
ORDER BY
    Fecha,
    CardCode,
    ItemCode;


***************************


-- CTE para las Ventas
WITH Ventas AS (
    SELECT
        EOMONTH(OINV.DocDate) AS FechaFinMes,  -- Último día del mes
        DATEPART(YEAR, OINV.DocDate) AS Año,
        DATEPART(MONTH, OINV.DocDate) AS Mes,
        OINV.CardCode,
        OINV.Series,
        NNM1.SeriesName AS NombreSerie,
        SUM(INV1.Quantity) AS CantidadVendida,
        SUM(INV1.LineTotal) AS TotalFacturado  -- Total facturado (cantidad * precio unitario)
    FROM OINV
    INNER JOIN INV1 ON OINV.DocEntry = INV1.DocEntry
    INNER JOIN NNM1 ON OINV.Series = NNM1.Series
    WHERE
        INV1.ItemCode NOT LIKE 'F%'
        AND OINV.CANCELED = 'N'  -- Solo documentos no cancelados
    GROUP BY
        EOMONTH(OINV.DocDate),
        DATEPART(YEAR, OINV.DocDate),
        DATEPART(MONTH, OINV.DocDate),
        OINV.CardCode,
        OINV.Series,
        NNM1.SeriesName
),

-- CTE para las Devoluciones (Notas de Crédito)
Devoluciones AS (
    SELECT
        EOMONTH(ORIN.DocDate) AS FechaFinMes,  -- Último día del mes
        DATEPART(YEAR, ORIN.DocDate) AS Año,
        DATEPART(MONTH, ORIN.DocDate) AS Mes,
        ORIN.CardCode,
        ORIN.Series,
        NNM1.SeriesName AS NombreSerie,
        SUM(RIN1.Quantity) AS CantidadDevuelta,
        SUM(RIN1.LineTotal) AS TotalDevoluciones  -- Total de devoluciones
    FROM ORIN
    INNER JOIN RIN1 ON ORIN.DocEntry = RIN1.DocEntry
    INNER JOIN NNM1 ON ORIN.Series = NNM1.Series
    WHERE
        RIN1.ItemCode NOT LIKE 'F%'
        AND ORIN.CANCELED = 'N'  -- Solo documentos no cancelados
    GROUP BY
        EOMONTH(ORIN.DocDate),
        DATEPART(YEAR, ORIN.DocDate),
        DATEPART(MONTH, ORIN.DocDate),
        ORIN.CardCode,
        ORIN.Series,
        NNM1.SeriesName
)

-- Consulta Final que Une Ventas y Devoluciones
SELECT
    COALESCE(V.FechaFinMes, D.FechaFinMes) AS FechaFinMes,
    COALESCE(V.Año, D.Año) AS Año,
    COALESCE(V.Mes, D.Mes) AS Mes,
    COALESCE(V.CardCode, D.CardCode) AS CardCode,
    COALESCE(V.Series, D.Series) AS Series,
    COALESCE(V.NombreSerie, D.NombreSerie) AS NombreSerie,
    ISNULL(V.CantidadVendida, 0) - ISNULL(D.CantidadDevuelta, 0) AS CantidadNeta,
    ISNULL(V.TotalFacturado, 0) - ISNULL(D.TotalDevoluciones, 0) AS ValorNeto  -- Valor neto (ventas - devoluciones)
FROM Ventas V
FULL OUTER JOIN Devoluciones D
    ON V.FechaFinMes = D.FechaFinMes
    AND V.CardCode = D.CardCode
    AND V.Series = D.Series
ORDER BY
    FechaFinMes,
    CardCode,
    Series;

**************

-- CTE para las Ventas
WITH Ventas AS (
    SELECT
        EOMONTH(OINV.DocDate) AS FechaFinMes,  -- Último día del mes
        NNM1.SeriesName AS NombreSerie,
        SUM(INV1.Quantity) AS CantidadVendida,
        SUM(INV1.LineTotal) AS TotalFacturado  -- Total facturado (cantidad * precio unitario)
    FROM OINV
    INNER JOIN INV1 ON OINV.DocEntry = INV1.DocEntry
    INNER JOIN NNM1 ON OINV.Series = NNM1.Series
    WHERE
        INV1.ItemCode NOT LIKE 'F%'
        AND OINV.CANCELED = 'N'  -- Solo documentos no cancelados
    GROUP BY
        EOMONTH(OINV.DocDate),
        NNM1.SeriesName
),

-- CTE para las Devoluciones (Notas de Crédito)
Devoluciones AS (
    SELECT
        EOMONTH(ORIN.DocDate) AS FechaFinMes,  -- Último día del mes
        NNM1.SeriesName AS NombreSerie,
        SUM(RIN1.Quantity) AS CantidadDevuelta,
        SUM(RIN1.LineTotal) AS TotalDevoluciones  -- Total de devoluciones
    FROM ORIN
    INNER JOIN RIN1 ON ORIN.DocEntry = RIN1.DocEntry
    INNER JOIN NNM1 ON ORIN.Series = NNM1.Series
    WHERE
        RIN1.ItemCode NOT LIKE 'F%'
        AND ORIN.CANCELED = 'N'  -- Solo documentos no cancelados
    GROUP BY
        EOMONTH(ORIN.DocDate),
        NNM1.SeriesName
)

-- Consulta Final que Une Ventas y Devoluciones
SELECT
    COALESCE(V.FechaFinMes, D.FechaFinMes) AS FechaFinMes,
    COALESCE(V.NombreSerie, D.NombreSerie) AS NombreSerie,
    ISNULL(V.CantidadVendida, 0) - ISNULL(D.CantidadDevuelta, 0) AS CantidadNeta,
    ISNULL(V.TotalFacturado, 0) - ISNULL(D.TotalDevoluciones, 0) AS ValorNeto  -- Valor neto (ventas - devoluciones)
FROM Ventas V
FULL OUTER JOIN Devoluciones D
    ON V.FechaFinMes = D.FechaFinMes
    AND V.NombreSerie = D.NombreSerie
ORDER BY
    FechaFinMes,
    NombreSerie;

************** SIMPLIFICADO *****

-- CTE para las Ventas
WITH Ventas AS (
    SELECT
        EOMONTH(OINV.DocDate) AS FechaFinMes,  -- Último día del mes
        CASE 
            WHEN NNM1.SeriesName = 'A' THEN 'Mayoreo'
            WHEN NNM1.SeriesName = 'B' THEN 'Online'
            WHEN NNM1.SeriesName = 'C' THEN 'PedEsp'
            ELSE NNM1.SeriesName
        END AS NombreSerie,
        SUM(INV1.Quantity) AS CantidadVendida,
        SUM(INV1.LineTotal) AS TotalFacturado  -- Total facturado (cantidad * precio unitario)
    FROM OINV
    INNER JOIN INV1 ON OINV.DocEntry = INV1.DocEntry
    INNER JOIN NNM1 ON OINV.Series = NNM1.Series
    WHERE
        INV1.ItemCode NOT LIKE 'F%'
        AND OINV.CANCELED = 'N'  -- Solo documentos no cancelados
    GROUP BY
        EOMONTH(OINV.DocDate),
        CASE 
            WHEN NNM1.SeriesName = 'A' THEN 'Mayoreo'
            WHEN NNM1.SeriesName = 'B' THEN 'Online'
            WHEN NNM1.SeriesName = 'C' THEN 'PedEsp'
            ELSE NNM1.SeriesName
        END
),

-- CTE para las Devoluciones (Notas de Crédito)
Devoluciones AS (
    SELECT
        EOMONTH(ORIN.DocDate) AS FechaFinMes,  -- Último día del mes
        CASE 
            WHEN NNM1.SeriesName = 'A' THEN 'Mayoreo'
            WHEN NNM1.SeriesName = 'B' THEN 'Online'
            WHEN NNM1.SeriesName = 'C' THEN 'PedEsp'
            ELSE NNM1.SeriesName
        END AS NombreSerie,
        SUM(RIN1.Quantity) AS CantidadDevuelta,
        SUM(RIN1.LineTotal) AS TotalDevoluciones  -- Total de devoluciones
    FROM ORIN
    INNER JOIN RIN1 ON ORIN.DocEntry = RIN1.DocEntry
    INNER JOIN NNM1 ON ORIN.Series = NNM1.Series
    WHERE
        RIN1.ItemCode NOT LIKE 'F%'
        AND ORIN.CANCELED = 'N'  -- Solo documentos no cancelados
    GROUP BY
        EOMONTH(ORIN.DocDate),
        CASE 
            WHEN NNM1.SeriesName = 'A' THEN 'Mayoreo'
            WHEN NNM1.SeriesName = 'B' THEN 'Online'
            WHEN NNM1.SeriesName = 'C' THEN 'PedEsp'
            ELSE NNM1.SeriesName
        END
)

-- Consulta Final que Une Ventas y Devoluciones
SELECT
    COALESCE(V.FechaFinMes, D.FechaFinMes) AS FechaFinMes,
    COALESCE(V.NombreSerie, D.NombreSerie) AS NombreSerie,
    ISNULL(V.CantidadVendida, 0) - ISNULL(D.CantidadDevuelta, 0) AS CantidadNeta,
    ISNULL(V.TotalFacturado, 0) - ISNULL(D.TotalDevoluciones, 0) AS ValorNeto  -- Valor neto (ventas - devoluciones)
FROM Ventas V
FULL OUTER JOIN Devoluciones D
    ON V.FechaFinMes = D.FechaFinMes
    AND V.NombreSerie = D.NombreSerie
ORDER BY
    FechaFinMes,
    NombreSerie;