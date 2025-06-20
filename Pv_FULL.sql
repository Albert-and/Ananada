
SELECT
    T1.DocNum AS OrdenVenta,
    T1.CardCode AS CodigoCliente,
    UPPER(T1.CardName) AS NombreCliente,
    CASE 
        WHEN T1.Series = 9 THEN 'Mayoreo'
        WHEN T1.Series = 76 THEN 'Online'
        WHEN T1.Series = 77 THEN 'Pedidos Especiales'
        ELSE 'Otro'
    END AS Tipo_Serie,
    
    -- Conversión del tipo ntext a datetime sin manejo de valores nulos
    CONVERT(DATETIME, CONVERT(NVARCHAR(MAX), T1.U_DateLiberacion), 120) AS T_Liberacion,

    -- Horas que han transcurrido desde la fecha de liberación hasta ahora (solo si U_DateLiberacion no es nulo)
    CASE 
        WHEN T1.U_DateLiberacion IS NOT NULL THEN DATEDIFF(HOUR, CONVERT(DATETIME, CONVERT(NVARCHAR(MAX), T1.U_DateLiberacion), 120), GETDATE())
        ELSE NULL
    END AS HorasConsumidas,

    -- Cuenta regresiva: tiempo restante para cumplir las 24 horas desde la liberación (solo si U_DateLiberacion no es nulo)
    CASE 
        WHEN T1.U_DateLiberacion IS NOT NULL THEN 24 - DATEDIFF(HOUR, CONVERT(DATETIME, CONVERT(NVARCHAR(MAX), T1.U_DateLiberacion), 120), GETDATE())
        ELSE NULL
    END AS CuentaRegresiva,

    -- Estatus ANANDA
    (SELECT TOP 1 Descr 
     FROM UFD1 
     WHERE FieldID = 29 
       AND fldvalue = T1.U_EstatusOV
       AND TableID = 'ORDR'
     ORDER BY FieldID, indexid, fldvalue) AS 'Estatus ANANDA'

FROM
    ORDR T1
LEFT JOIN (
    SELECT DISTINCT BaseEntry
    FROM INV1
    WHERE BaseType = 17
) AS Facturas
ON T1.DocEntry = Facturas.BaseEntry
WHERE
    T1.DocStatus = 'O' 
    AND Facturas.BaseEntry IS NULL  -- Excluye las órdenes que ya tienen una factura
    AND 'Estatus Ananda' <> 'Retenido'
ORDER BY
    T1.DocNum;




--------

SELECT *
FROM (
    SELECT
        T1.DocNum AS OrdenVenta,
        T1.CardCode AS CodigoCliente,
        UPPER(T1.CardName) AS NombreCliente,
        CASE 
            WHEN T1.Series = 9 THEN 'Mayoreo'
            WHEN T1.Series = 76 THEN 'Online'
            WHEN T1.Series = 77 THEN 'Pedidos Especiales'
            ELSE 'Otro'
        END AS Tipo_Serie,
        
        -- Conversión del tipo ntext a datetime sin manejo de valores nulos
        CONVERT(DATETIME, CONVERT(NVARCHAR(MAX), T1.U_DateLiberacion), 120) AS T_Liberacion,

        -- Horas que han transcurrido desde la fecha de liberación hasta ahora (solo si U_DateLiberacion no es nulo)
        CASE 
            WHEN T1.U_DateLiberacion IS NOT NULL THEN DATEDIFF(HOUR, CONVERT(DATETIME, CONVERT(NVARCHAR(MAX), T1.U_DateLiberacion), 120), GETDATE())
            ELSE NULL
        END AS HorasConsumidas,

        -- Cuenta regresiva: tiempo restante para cumplir las 24 horas desde la liberación (solo si U_DateLiberacion no es nulo)
        CASE 
            WHEN T1.U_DateLiberacion IS NOT NULL THEN 24 - DATEDIFF(HOUR, CONVERT(DATETIME, CONVERT(NVARCHAR(MAX), T1.U_DateLiberacion), 120), GETDATE())
            ELSE NULL
        END AS CuentaRegresiva,

        -- Estatus ANANDA
        (SELECT TOP 1 Descr 
         FROM UFD1 
         WHERE FieldID = 29 
           AND fldvalue = T1.U_EstatusOV
           AND TableID = 'ORDR'
         ORDER BY FieldID, indexid, fldvalue) AS 'Estatus ANANDA'

    FROM
        ORDR T1
    LEFT JOIN (
        SELECT DISTINCT BaseEntry
        FROM INV1
        WHERE BaseType = 17
    ) AS Facturas
    ON T1.DocEntry = Facturas.BaseEntry
    WHERE
        T1.DocStatus = 'O' 
        AND Facturas.BaseEntry IS NULL  -- Excluye las órdenes que ya tienen una factura
) AS Subquery
WHERE
    [Estatus ANANDA] <> 'Retenido'
ORDER BY
    OrdenVenta;



-------------



SELECT *
FROM (
    SELECT
        T1.DocNum AS OrdenVenta,
        --T1.CardCode AS CodigoCliente,
        UPPER(T1.CardName) AS NombreCliente,
        CASE 
            WHEN T1.Series = 9 THEN 'Mayoreo'
            WHEN T1.Series = 76 THEN 'Online'
            WHEN T1.Series = 77 THEN 'Pedidos Especiales'
            ELSE 'Otro'
        END AS Tipo_Serie,
        
        -- Conversión del tipo ntext a datetime sin manejo de valores nulos
        CONVERT(DATETIME, CONVERT(NVARCHAR(MAX), T1.U_DateLiberacion), 120) AS T_Liberacion,

        -- Horas que han transcurrido desde la fecha de liberación hasta ahora (solo si U_DateLiberacion no es nulo)
        CASE 
            WHEN T1.U_DateLiberacion IS NOT NULL THEN DATEDIFF(HOUR, CONVERT(DATETIME, CONVERT(NVARCHAR(MAX), T1.U_DateLiberacion), 120), GETDATE())
            ELSE NULL
        END AS HorasConsumidas,

        -- Cuenta regresiva: tiempo restante para cumplir las 24 horas desde la liberación (solo si U_DateLiberacion no es nulo)
        CASE 
            WHEN T1.U_DateLiberacion IS NOT NULL THEN 24 - DATEDIFF(HOUR, CONVERT(DATETIME, CONVERT(NVARCHAR(MAX), T1.U_DateLiberacion), 120), GETDATE())
            ELSE NULL
        END AS CuentaRegresiva,

        -- Estatus ANANDA
        (SELECT TOP 1 Descr 
         FROM UFD1 
         WHERE FieldID = 29 
           AND fldvalue = T1.U_EstatusOV
           AND TableID = 'ORDR'
         ORDER BY FieldID, indexid, fldvalue) AS 'Estatus ANANDA'

    FROM
        ORDR T1
    LEFT JOIN (
        SELECT DISTINCT BaseEntry
        FROM INV1
        WHERE BaseType = 17
    ) AS Facturas
    ON T1.DocEntry = Facturas.BaseEntry
    WHERE
        T1.DocStatus = 'O' 
        AND Facturas.BaseEntry IS NULL  -- Excluye las órdenes que ya tienen una factura
) AS Subquery
WHERE
    [Estatus ANANDA] <> 'Retenido'
ORDER BY
    OrdenVenta;



----------------

SELECT *
FROM (
    SELECT
        T1.DocNum AS OrdenVenta,
        --T1.CardCode AS CodigoCliente,
        UPPER(T1.CardName) AS NombreCliente,
        CASE 
            WHEN T1.Series = 9 THEN 'Mayoreo'
            WHEN T1.Series = 76 THEN 'Online'
            WHEN T1.Series = 77 THEN 'Pedidos Especiales'
            ELSE 'Otro'
        END AS Tipo_Serie,
        
        -- Conversión del tipo ntext a datetime sin manejo de valores nulos
        CONVERT(DATETIME, CONVERT(NVARCHAR(MAX), T1.U_DateLiberacion), 120) AS T_Liberacion,

        -- Horas que han transcurrido desde la fecha de liberación hasta ahora (solo si U_DateLiberacion no es nulo)
        CASE 
            WHEN T1.U_DateLiberacion IS NOT NULL THEN DATEDIFF(HOUR, CONVERT(DATETIME, CONVERT(NVARCHAR(MAX), T1.U_DateLiberacion), 120), GETDATE())
            ELSE NULL
        END AS HorasConsumidas,

        -- Cuenta regresiva: tiempo restante para cumplir las 24 horas desde la liberación (solo si U_DateLiberacion no es nulo)
        CASE 
            WHEN T1.U_DateLiberacion IS NOT NULL THEN 24 - DATEDIFF(HOUR, CONVERT(DATETIME, CONVERT(NVARCHAR(MAX), T1.U_DateLiberacion), 120), GETDATE())
            ELSE NULL
        END AS CuentaRegresiva,

        -- Estatus ANANDA
        (SELECT TOP 1 Descr 
         FROM UFD1 
         WHERE FieldID = 29 
           AND fldvalue = T1.U_EstatusOV
           AND TableID = 'ORDR'
         ORDER BY FieldID, indexid, fldvalue) AS 'Estatus ANANDA'

    FROM
        ORDR T1
    LEFT JOIN (
        SELECT DISTINCT BaseEntry
        FROM INV1
        WHERE BaseType = 17
    ) AS Facturas
    ON T1.DocEntry = Facturas.BaseEntry
    WHERE
        T1.DocStatus = 'O' 
        AND Facturas.BaseEntry IS NULL  -- Excluye las órdenes que ya tienen una factura
) AS Subquery
WHERE
    [Estatus ANANDA] <> 'Facturado'
ORDER BY
    OrdenVenta;





------------

SELECT DocNum,DocStatus, U_DateLiberacion,
       (SELECT TOP 1 Descr 
        FROM UFD1 
        WHERE FieldID = 29 
          AND fldvalue = U_EstatusOV
          AND TableID = 'ORDR'
        ORDER BY FieldID, indexid, fldvalue) AS 'Estatus'
FROM ORDR
WHERE (SELECT TOP 1 Descr 
       FROM UFD1 
       WHERE FieldID = 29 
         AND fldvalue = U_EstatusOV
         AND TableID = 'ORDR'
       ORDER BY FieldID, indexid, fldvalue) = 'Por surtir'





if $[ORDR.U_EstatusOV] = 1
BEGIN
DECLARE @D DATETIME 
SET @D = GETDATE()
SELECT CONVERT(varchar(20), @D , 120)
END

SELECT 
    CASE 
        WHEN EXISTS (SELECT 1 
                     FROM OINV T0 
                     INNER JOIN INV1 T1 ON T0.DocEntry = T1.DocEntry 
                     WHERE T1.BaseEntry = $[ORDR.DocEntry] 
                     AND T1.BaseType = '17') 
        THEN '10'
        ELSE NULL 
    END
