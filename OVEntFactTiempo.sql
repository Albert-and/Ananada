


SELECT DISTINCT
    T0.[DocNum] AS 'No. OV',
    T0.[DocDate] AS 'Fecha OV',
    T2.[DocNum] AS 'Numero Entrega',
    T2.[DocDate] AS 'Fecha de Entrega',
    T4.[DocNum] AS 'No. Factura',
    T4.[DocDate] AS 'Fecha Factura',
    T4.[DocTime] AS 'Hora Factura',
    T0.[U_EstatusOV] AS 'Estatus Ananda',
    CAST(T0.U_DateLiberacion AS NVARCHAR(MAX)) AS 'TimeLiberacion'
FROM 
    ORDR T0
LEFT JOIN 
    DLN1 T1 ON T1.[BaseEntry] = T0.[DocEntry] AND T1.[BaseType] = T0.[ObjType]
LEFT JOIN 
    ODLN T2 ON T1.[DocEntry] = T2.[DocEntry]
LEFT JOIN 
    INV1 T3 ON (T3.[BaseEntry] = T2.[DocEntry] AND T3.[BaseType] = T2.[ObjType]) OR (T3.[BaseEntry] = T0.[DocEntry] AND T3.[BaseType] = T0.[ObjType])
LEFT JOIN 
    OINV T4 ON T3.[DocEntry] = T4.[DocEntry]
Where T0.DocDate >= '20240501'
ORDER BY 
    T0.[DocNum], T2.[DocNum], T4.[DocNum]



