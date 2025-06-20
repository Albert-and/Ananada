


-----ORDENES DE VENTA & ENTREGAS----------------------

SELECT DISTINCT
    T0.[DocNum] AS 'No. OV',
    T0.[DocDate] AS 'Fecha OV',
    T0.CANCELED AS 'ESTATUS OV',
    T2.[DocNum] AS 'Numero Entrega',
    T2.[DocDate] AS 'Fecha de Entrega',
    T2.CANCELED AS 'ESTATUS ENTREGA',
    T0.[U_EstatusOV] AS 'Estatus Ananda',
    CAST(T0.U_DateLiberacion AS NVARCHAR(MAX)) AS 'TimeLiberacion'
FROM 
    ORDR T0
INNER JOIN 
    DLN1 T1 ON T1.[BaseEntry] = T0.[DocEntry] AND T1.[BaseType] = T0.[ObjType]
INNER JOIN 
    ODLN T2 ON T1.[DocEntry] = T2.[DocEntry]

------- **********************VALIDADO *****************

SELECT DISTINCT
    T0.[DocNum] AS 'No. OV',
    T0.[DocDate] AS 'Fecha OV',
    T0.CANCELED AS 'ESTATUS OV',
    T2.[DocNum] AS 'Numero Entrega',
    T2.[DocDate] AS 'Fecha de Entrega',
    T2.CANCELED AS 'ESTATUS ENTREGA',
    T0.[U_EstatusOV] AS 'Estatus Ananda',
    ----CAST(DATEADD(hour, 1, CAST(CAST(T0.U_DateLiberacion AS NVARCHAR(MAX)) AS DATETIME)) AS NVARCHAR(MAX)) AS 'TimeLiberacion'
FROM 
    ORDR T0
INNER JOIN 
    DLN1 T1 ON T1.[BaseEntry] = T0.[DocEntry] AND T1.[BaseType] = T0.[ObjType]
INNER JOIN 
    ODLN T2 ON T1.[DocEntry] = T2.[DocEntry]



------ENTREGAS & FACTURAS --------------------*******VALIDADO*************

SELECT DISTINCT
    T2.[DocNum] AS 'Numero Entrega',
    T2.[DocDate] AS 'Fecha de Entrega',
    T2.CANCELED as 'Estatus Entrega',
    T4.[DocNum] AS 'No. Factura',
    T4.[DocDate] AS 'Fecha Factura',
    T4.[DocTime] AS 'Hora Factura',
    T4.CANCELED as 'Estatus Factura'
FROM 
    ODLN T2
LEFT JOIN 
    INV1 T3 ON (T3.[BaseEntry] = T2.[DocEntry] AND T3.[BaseType] = T2.[ObjType])
LEFT JOIN 
    OINV T4 ON T3.[DocEntry] = T4.[DocEntry] 
ORDER BY
T2.[DocNum]
