






---ov----
SELECT
T1.DocEntry,
T1.DocNum AS 'OV',
T1.NumAtCard,
T1.DocDate,
T1.CardCode,
T1.Series,
U_DateLiberacion,
(select top 1 Descr from UFD1 where FieldID = 29 and fldvalue = T1.U_EstatusOV
and TableID = 'ORDR'
group by FieldID, indexid, fldvalue, Descr) AS 'Estatus ANANDA',
 T2.SlpName
FROM ORDR T1
LEFT JOIN OSLP T2 ON T1.SlpCode = T2.SlpCode
WHERE T1.Canceled = 'N'
order by T1.DocNum

----ENTREGA----------

SELECT DISTINCT
T1.BaseRef [No. OV],
T0.DocEntry,
T0.DocNum AS 'ENTREGA',
T0.DocDate,
T0.CardCode
FROM ODLN T0
inner JOIN DLN1 T1 ON T0.DocEntry = T1.DocEntry
left JOIN OSLP T2 ON T0.SlpCode = T2.SlpCode
WHERE t0.CANCELED = 'N' and (t1.BaseRef <> 'null' and t1.BaseRef <>' ')
ORDER BY T1.BaseRef


----------FACTURACION----

SELECT DISTINCT
    T2.[DocNum] AS 'Numero Entrega',
    T2.[DocDate] AS 'Fecha de Entrega',
    T4.[DocNum] AS 'No. Factura',
    T4.[DocDate] AS 'Fecha Factura',
    T4.[DocTime] AS 'Hora Factura'
FROM 
    ODLN T2
LEFT JOIN 
    DLN1 T1 ON T1.[DocEntry] = T2.[DocEntry]
LEFT JOIN 
    INV1 T3 ON T3.[BaseEntry] = T2.[DocEntry] AND T3.[BaseType] = T2.[ObjType]
LEFT JOIN 
    OINV T4 ON T3.[DocEntry] = T4.[DocEntry]
WHERE
    T2.[CANCELED] = 'N' AND
    T4.[CANCELED] = 'N';
