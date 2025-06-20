
SELECT
    OINV.DocNum AS 'No. Factura',
    OINV.DocDate AS 'Fecha',
    NNM1.SeriesName AS 'Serie',
    OINV.CardCode AS 'CardCode',
    INV1.ItemCode AS 'SKU',
    INV1.Quantity AS 'Cantidad Vendida'
FROM OINV
INNER JOIN INV1 ON OINV.DocEntry = INV1.DocEntry
INNER JOIN NNM1 ON OINV.Series = NNM1.Series
WHERE
    INV1.ItemCode NOT LIKE 'F%'
ORDER BY
    OINV.DocNum, INV1.LineNum

-------
SELECT
    ORIN.DocNum AS 'No. Nota de Crédito',
    ORIN.DocDate AS 'Fecha',
    NNM1.SeriesName AS 'Nombre de la Serie',
    ORIN.CardCode AS 'CardCode',
    RIN1.ItemCode AS 'ItemCode',
    RIN1.Quantity AS 'Cantidad'
FROM ORIN
INNER JOIN RIN1 ON ORIN.DocEntry = RIN1.DocEntry
INNER JOIN NNM1 ON ORIN.Series = NNM1.Series
WHERE
    RIN1.ItemCode NOT LIKE 'F%'
ORDER BY
    ORIN.DocNum, RIN1.LineNum

------- Consulta Final (Agrupada)----

-- CTE para las Ventas
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
    COALESCE(V.Fecha, D.Fecha) AS Fecha,
    COALESCE(V.Mes, D.Mes) AS Mes,
    COALESCE(V.Año, D.Año) AS Año,
    COALESCE(V.CardCode, D.CardCode) AS CardCode,
    COALESCE(V.ItemCode, D.ItemCode) AS ItemCode,
    COALESCE(V.Series, D.Series) AS Series,
    ISNULL(V.CantidadVendida, 0) - ISNULL(D.CantidadDevuelta, 0) AS CantidadNeta
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

-------

/*

A continuación, te proporcionaré una consulta SQL que no solo calcula la cantidad vendida neta (cantidad vendida menos cantidad devuelta) agrupada por Fecha, Mes, Año, CardCode y ItemCode, sino que también incluye los números de documentos tanto de Facturas como de Devoluciones en columnas separadas.

Objetivo de la Consulta:
Calcular la Cantidad Neta: Ventas menos Devoluciones.
Agregar Columnas de Mes y Año: Extraídas de la columna de Fecha.
Incluir Números de Documento:
Facturas: Números de documentos de ventas.
Devoluciones: Números de documentos de devoluciones.
Excluir ItemCode que Comienzan con 'F': Según tus indicaciones anteriores.
Consideraciones Previas:
Versiones de SQL Server:
STRING_AGG: La función STRING_AGG está disponible a partir de SQL Server 2017. Si estás utilizando una versión anterior, deberás utilizar métodos alternativos como FOR XML PATH para concatenar cadenas.
Tablas Utilizadas:
Ventas:
Encabezado: OINV (Facturas de Clientes).
Detalle: INV1.
Devoluciones:
Encabezado: ORIN (Notas de Crédito).
Detalle: RIN1.
Permisos y Existencia de Tablas:
Asegúrate de tener los permisos necesarios para acceder a todas las tablas mencionadas (OINV, INV1, ORIN, RIN1, OCRD, OITM, NNM1).
Consulta SQL Completa:
La siguiente consulta utiliza Common Table Expressions (CTEs) para separar las ventas y las devoluciones, agregando los números de documentos y luego combinándolos para obtener la cantidad neta.

*/



-- CTE para las Ventas
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
    COALESCE(V.Fecha, D.Fecha) AS Fecha,
    COALESCE(V.Mes, D.Mes) AS Mes,
    COALESCE(V.Año, D.Año) AS Año,
    COALESCE(V.CardCode, D.CardCode) AS CardCode,
    COALESCE(V.ItemCode, D.ItemCode) AS ItemCode,
    COALESCE(V.Series, D.Series) AS Series,
    ISNULL(V.CantidadVendida, 0) - ISNULL(D.CantidadDevuelta, 0) AS CantidadNeta
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