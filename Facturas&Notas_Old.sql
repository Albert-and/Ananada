


WITH Ventas AS (
    SELECT
        CAST(OINV.DocDate AS DATE) AS Fecha,
        DATEPART(MONTH, OINV.DocDate) AS Mes,
        DATEPART(YEAR, OINV.DocDate) AS Año,
        OINV.CardCode,
        INV1.ItemCode,
        OINV.Series,
        SUM(INV1.Quantity) AS CantidadVendida
    FROM OINV
    INNER JOIN INV1 ON OINV.DocEntry = INV1.DocEntry
    WHERE
        INV1.ItemCode NOT LIKE 'F%'
        AND OINV.CANCELED = 'N'  -- Solo documentos no cancelados
        AND OINV.Series = 108
        AND OINV.DocDate >= '2022-01-01'
    GROUP BY
        CAST(OINV.DocDate AS DATE),
        DATEPART(MONTH, OINV.DocDate),
        DATEPART(YEAR, OINV.DocDate),
        OINV.CardCode,
        INV1.ItemCode,
        OINV.Series
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
        SUM(RIN1.Quantity) AS CantidadDevuelta
    FROM ORIN
    INNER JOIN RIN1 ON ORIN.DocEntry = RIN1.DocEntry
    WHERE
        RIN1.ItemCode NOT LIKE 'F%'
        AND ORIN.CANCELED = 'N'  -- Solo documentos no cancelados
        AND ORIN.Series = 85
        AND ORIN.DocDate >= '2022-01-01'  -- Aseguramos que las devoluciones sean desde la misma fecha
    GROUP BY
        CAST(ORIN.DocDate AS DATE),
        DATEPART(MONTH, ORIN.DocDate),
        DATEPART(YEAR, ORIN.DocDate),
        ORIN.CardCode,
        RIN1.ItemCode,
        ORIN.Series
)
 
-- Consulta Final que Une Ventas y Devoluciones
SELECT
    V.Fecha AS Fecha,
    V.Mes AS Mes,
    V.Año AS Año,
    V.CardCode AS CardCode,
    V.ItemCode AS ItemCode,
    V.Series AS Series,
    ISNULL(V.CantidadVendida, 0) - ISNULL(D.CantidadDevuelta, 0) AS CantidadNeta
FROM Ventas V
LEFT JOIN Devoluciones D
    ON V.CardCode = D.CardCode
    AND V.ItemCode = D.ItemCode
    AND V.Series = D.Series
    AND D.Fecha >= V.Fecha  -- Aseguramos que las devoluciones sean desde la fecha de las facturas
ORDER BY
    V.Fecha,
    V.CardCode,
    V.ItemCode;



