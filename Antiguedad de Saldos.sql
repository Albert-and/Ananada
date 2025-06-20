


-- Declaración de variable para la fecha actual
DECLARE @FECHAFIN DATETIME = CAST(GETDATE() AS DATE); -- Solo la fecha sin hora

-- CTE para calcular los saldos por cliente
WITH SaldoClientes AS (
    SELECT 
        T1.CardCode AS Cliente,
        SUM(T0.BalDueDeb) - SUM(T0.BalDueCred) AS Saldo
    FROM dbo.JDT1 T0 WITH (NOLOCK)
    INNER JOIN dbo.OCRD T1 WITH (NOLOCK)
        ON T0.ShortName = T1.CardCode
        AND T1.CardType = 'C'
    WHERE 
        T0.IntrnMatch = '0'
        AND T0.BalDueDeb != T0.BalDueCred
    GROUP BY T1.CardCode
),

-- CTE principal filtrando los clientes según las condiciones
ClientesFiltrados AS (
    SELECT 
        T1.CardCode,
        T0.Ref1,
        T0.BalDueDeb,
        T0.BalDueCred,
        T0.BalFcCred,
        T0.BalFcDeb,
        T0.TransType,
        T0.DueDate
    FROM dbo.JDT1 T0 WITH (NOLOCK)
    INNER JOIN dbo.OCRD T1 WITH (NOLOCK)
        ON T0.ShortName = T1.CardCode
        AND T1.CardType = 'C'
    WHERE 
        T0.IntrnMatch = '0'
        AND T0.BalDueDeb != T0.BalDueCred
        AND T1.CardCode NOT IN (
            SELECT Cliente
            FROM SaldoClientes
            WHERE Saldo = 0
        )
)

-- Consulta combinada final asegurando unicidad con OUTER APPLY
SELECT 
    Y3.SlpName,
    CF.CardCode,
    CF.Ref1,
    CF.BalDueDeb,
    CF.BalDueCred,
    CF.BalFcCred,
    CF.BalFcDeb,
    CF.TransType,
    CF.DueDate,
    OINV.DocNum,
    OINV.DocDate,
    OINV.DocTotal
FROM ClientesFiltrados CF
OUTER APPLY (
    SELECT TOP 1 
        OINV.DocNum,
        OINV.DocDate,
        OINV.DocTotal,
        OINV.SlpCode
    FROM dbo.OINV OINV 
    WHERE 
        CF.CardCode = OINV.CardCode
        AND OINV.DocDate <= @FECHAFIN -- Opcional: Filtrar facturas hasta la fecha actual
    ORDER BY OINV.DocDate DESC -- Selecciona la factura más reciente
) OINV
LEFT JOIN dbo.OSLP Y3 
    ON Y3.SlpCode = OINV.SlpCode -- Asegúrate de que esta condición sea correcta según tu estructura
ORDER BY 
    CF.CardCode,
    CF.Ref1,
    OINV.DocNum;




    ================

    DECLARE @FECHAFIN DATETIME = CAST(GETDATE() AS DATE); -- Fecha actual

-- CTE para calcular los saldos por cliente
WITH SaldoClientes AS (
    SELECT 
        T1.CardCode AS Cliente,
        SUM(T0.BalDueDeb) - SUM(T0.BalDueCred) AS Saldo
    FROM dbo.JDT1 T0 WITH (NOLOCK)
    INNER JOIN dbo.OCRD T1 WITH (NOLOCK)
        ON T0.ShortName = T1.CardCode
        AND T1.CardType = 'C'
    WHERE 
        T0.IntrnMatch = '0'
        AND T0.BalDueDeb != T0.BalDueCred
    GROUP BY T1.CardCode
),

-- CTE principal filtrando los clientes según las condiciones
ClientesFiltrados AS (
    SELECT 
        T1.CardCode,
        T0.Ref1,
        T0.BalDueDeb,
        T0.BalDueCred,
        T0.BalFcCred,
        T0.BalFcDeb,
        T0.TransType,
        T0.DueDate
    FROM dbo.JDT1 T0 WITH (NOLOCK)
    INNER JOIN dbo.OCRD T1 WITH (NOLOCK)
        ON T0.ShortName = T1.CardCode
        AND T1.CardType = 'C'
    WHERE 
        T0.IntrnMatch = '0'
        AND T0.BalDueDeb != T0.BalDueCred
        AND T1.CardCode NOT IN (
            SELECT Cliente
            FROM SaldoClientes
            WHERE Saldo = 0
        )
)

-- Consulta combinada final con agregación de facturas
SELECT 
    Y3.SlpName,
    CF.CardCode,
    CF.Ref1,
    CF.BalDueDeb,
    CF.BalDueCred,
    CF.BalFcCred,
    CF.BalFcDeb,
    CF.TransType,
    CF.DueDate,
    COUNT(OINV.DocNum) AS NumFacturas,
    SUM(OINV.DocTotal) AS TotalFacturado
FROM ClientesFiltrados CF
LEFT JOIN dbo.OINV OINV 
    ON CF.CardCode = OINV.CardCode
    AND OINV.DocDate <= @FECHAFIN -- Opcional: Filtrar facturas hasta la fecha actual
LEFT JOIN dbo.OSLP Y3 
    ON Y3.SlpCode = OINV.SlpCode 
GROUP BY
    Y3.SlpName,
    CF.CardCode,
    CF.Ref1,
    CF.BalDueDeb,
    CF.BalDueCred,
    CF.BalFcCred,
    CF.BalFcDeb,
    CF.TransType,
    CF.DueDate
ORDER BY 
    CF.CardCode,
    CF.Ref1;