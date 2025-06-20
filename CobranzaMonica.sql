
----Facturas & NC-----
SELECT
    'Factura' AS "Origen",
    T0.[CANCELED],
    CASE T4.[SeriesName]
        WHEN 'FAC' THEN 'Carrito'
        WHEN 'FAM' THEN 'Mayoreo'
    END AS "Tipo de Venta",
    T0.[DocNum], 
    T0.[NumAtCard], 
    T0.[CardCode], 
    T1.[CardName], 
    T0.[DocDate], 
    T0.[DocTotal] - T0.[VatSum] AS "Importe antes de IVA", 
    T0.[VatSum], 
    T0.[DocTotal], 
    T2.[ListName], 
    T0.[DocTotal] - T0.[PaidToDate] AS "Saldo factura"
FROM OINV T0
INNER JOIN OCRD T1 ON T0.[CardCode] = T1.[CardCode]
INNER JOIN OPLN T2 ON T1.[ListNum] = T2.[ListNum]
INNER JOIN OSLP T3 ON T1.[SlpCode] = T3.[SlpCode]
INNER JOIN NNM1 T4 ON T0.[Series] = T4.[Series]
LEFT JOIN OHEM T5 ON T0.[OwnerCode] = T5.[empID]

UNION ALL

SELECT
    'Nota_de_credito' AS "Origen",
    T0.[CANCELED],
    CASE T4.[SeriesName]
        WHEN 'NC' THEN 'Carrito'
        WHEN 'NM' THEN 'Mayoreo'
    END AS "Tipo de Venta",
    T0.[DocNum], 
    T0.[NumAtCard], 
    T0.[CardCode], 
    T1.[CardName], 
    T0.[DocDate], 
    (T0.[DocTotal] - T0.[VatSum]) * (-1) AS "Importe antes de IVA", 
    T0.[VatSum] * (-1), 
    T0.[DocTotal] * (-1), 
    T2.[ListName], 
    (T0.[DocTotal] - T0.[PaidToDate]) * (-1) AS "Saldo factura"
FROM ORIN T0
INNER JOIN OCRD T1 ON T0.[CardCode] = T1.[CardCode]
INNER JOIN OPLN T2 ON T1.[ListNum] = T2.[ListNum]
INNER JOIN OSLP T3 ON T1.[SlpCode] = T3.[SlpCode]
INNER JOIN NNM1 T4 ON T0.[Series] = T4.[Series]
LEFT JOIN OHEM T5 ON T0.[OwnerCode] = T5.[empID]

--------------ID Vendedor------


SELECT
DocNum,
v.SlpName AS "Vendedor",
o.lastName AS "Propietario",
fs.SeriesName AS "UN"
FROM OINV f
INNER JOIN OSLP v ON f.SlpCode = v.SlpCode
INNER JOIN NNM1 fs ON f.Series = fs.Series
LEFT JOIN OHEM o ON f.OwnerCode = o.empID

-----
SELECT
e.DocNum,
LineTotal
FROM INV1 c
INNER JOIN OINV e ON e.DocEntry = c.DocEntry
Where ItemCode LIKE 'F%'



