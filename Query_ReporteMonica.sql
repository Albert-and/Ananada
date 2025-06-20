==========Facturas & NC =======

SELECT DISTINCT T0.DocEntry [No. Interno], T0.DocNum [No. Factura],
T3.DocNum [No. Entrega], T6.DocNum [No. OV],
T0.DocDate [Fecha], T0.CardCode [Cliente], T0.CardName [Nombre], T0.DocTotal [Total Facturado],
T0.DocStatus [Estatus de Documento], T2.SlpName [Vendedor] 
FROM ORDR T6

inner JOIN RDR1 T5 ON T5.DocEntry = T6.DocEntry 

LEFT JOIN DLN1 T4 ON t5.ObjType=t4.basetype and t5.DocEntry=t4.baseentry and t5.LineNum=t4.BaseLine
inner JOIN ODLN T3 ON T3.DocEntry = T4.DocEntry 

LEFT JOIN INV1 T1 ON t4.ObjType=t1.basetype and t4.DocEntry=t1.baseentry and t4.LineNum=t1.BaseLine
inner JOIN OINV T0 ON T0.DocEntry = T1.DocEntry 

LEFT JOIN OSLP T2 ON T0.SlpCode = T2.SlpCode

WHERE T0.SERIES <> '75' AND T0.CANCELED = 'N'
group by T0.DocEntry , T0.DocNum ,
T1.BaseRef , T6.DOCNUM ,
T0.DocDate , T0.CardCode, T0.CardName , T0.DocTotal, 
T0.DocStatus , T2.SlpName, t3.DocNum
union all  
SELECT DISTINCT T0.DocEntry [No. Interno], T0.DocNum [No. Factura],
T1.BaseRef [No. Entrega], T4.BaseRef [No. OV],
T0.DocDate [Fecha], T0.CardCode [Cliente], T0.CardName [Nombre], 
(T0.DocTotal * -1) [Total Facturado],
T0.DocStatus [Estatus de Documento], T2.SlpName [Vendedor]
 FROM ORIN T0 

LEFT JOIN RIN1 T1 ON T0.DocEntry = T1.DocEntry

LEFT JOIN OSLP T2 ON T0.SlpCode = T2.SlpCode

LEFT JOIN OINV T3 ON T3.DocNum = T1.BaseRef

LEFT JOIN INV1 T4 ON T4.DocEntry = T3.DocEntry

WHERE T0.CANCELED = 'N'

group by T0.DocEntry , T0.DocNum ,
T1.BaseRef , T4.BaseRef ,
T0.DocDate , T0.CardCode, T0.CardName , T0.DocTotal ,
T0.DocStatus , T2.SlpName

==================================== ANTIGUEDAD DE SALDOS ===



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



SELECT
CardCode,
CardName
FROM OCRD







SELECT
    T0.Docnum AS [No.Factura],
    CASE
        WHEN T1.SeriesName IN ('Online', 'B') THEN 'Online'
        WHEN T1.SeriesName IN ('Mayoreo', 'A') THEN 'Mayoreo'
        WHEN T1.SeriesName IN ('PedEsp', 'C') THEN 'PedidosEspeciales'
        ELSE 'Otro' -- Manejo de casos no contemplados
    END AS [Tipo de Venta]
FROM dbo.OINV T0  
INNER JOIN dbo.NNM1 T1 
    ON T0.[Series] = T1.[Series] 
WHERE 
    T0.CANCELED = 'N' 
    AND T0.DocDate >= '2024-01-01' -- Formato de fecha estandarizado
ORDER BY 
    T0.Docnum; -- Ordenación opcional para mejorar la legibilidad