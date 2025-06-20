

SELECT
	T0.BaseEntry AS 'OV',
	T0.BaseLine AS 'LN OV',
	T0.DocEntry AS 'ENTREGA',
	T0.LineNum AS 'LN ENTREGA',
	T1.CardName AS 'CLIENTE',
	T0.ItemCode AS 'ITEM', 
	T0.Dscription AS 'DESRIPCION DEL ITEM', 
	T0.Quantity AS 'QTY ENTREGADA',
	T0.DocDate 
FROM DLN1 T0 
	INNER JOIN ODLN T1 ON T1.DocEntry=T0.DocEntry
WHERE T1.CANCELED='N' --AND T0.BaseEntry =[%0]  AQUI PUEDES FILTRAR POR OV SI LO CONSIDERAS NECESARIO
ORDER BY T0.BaseEntry


---Para filtrar específicamente por las entregas realizadas desde hace dos días hasta la fecha
--actual, deberías aplicar el filtro en la columna T0.DocDate, que corresponde a la fecha de
--las entregas. Aquí te dejo el query ajustado:


SELECT 
    t2.BaseEntry as 'ov',           -- Número de la Orden de Venta (OV)
    t2.BaseLine as 'ln ov',         -- Línea de la Orden de Venta
    T0.DocEntry AS 'ENTREGA',       -- Número de la Entrega
    T0.BaseEntry AS 'factura',      -- Número de la Factura
    T0.LineNum AS 'LN ENTREGA',     -- Número de línea de la entrega
    T1.CardName AS 'CLIENTE',       -- Nombre del cliente
    T0.ItemCode AS 'ITEM',          -- Código del ítem
    T0.Dscription AS 'DESCRIPCION DEL ITEM', -- Descripción del ítem
    T0.Quantity AS 'QTY ENTREGADA', -- Cantidad entregada
    T0.DocDate                      -- Fecha del documento de entrega
FROM DLN1 T0 
INNER JOIN ODLN T1 ON T1.DocEntry = T0.DocEntry -- Unión con la tabla de entregas
INNER JOIN INV1 T2 ON T2.DocEntry = T0.BaseEntry AND T2.LineNum = T0.BaseLine -- Unión con la tabla de facturas
WHERE T1.CANCELED = 'N'             -- Filtra entregas que no han sido canceladas
AND T0.DocDate BETWEEN DATEADD(DAY, -2, GETDATE()) AND GETDATE() -- Filtra entregas desde hace 2 días hasta hoy
-- AND T0.BaseEntry = [%0]           -- Descomenta esto si necesitas filtrar por una OV específica
ORDER BY T0.BaseEntry;              -- Ordena por el número de la Orden de Venta (OV)

-----Time Stamp Entrega----


--Para convertir el campo DocTime a un formato de hora legible en SAP Business One,
--puedes realizar una conversión adecuada. El campo DocTime en SAP suele estar almacenado
--en formato HHMMSS como un entero (por ejemplo, 123045 representaría 12:30:45).
--A continuación, te dejo una consulta que convierte DocTime a un formato de hora legible:

SELECT 
    DocNum,                            -- Número de documento
    DocDate,                           -- Fecha del documento
    CONVERT(VARCHAR(5), 
        STUFF(RIGHT('0000' + CAST(DocTime AS VARCHAR(4)), 4), 3, 0, ':')
    , 108) AS 'Hora de Documento'      -- Conversión de DocTime a formato HH:MM sin segundos
FROM ODLN;

----

SELECT 
    DocNum,                            -- Número de documento
    DocDate,                           -- Fecha del documento
    CONVERT(VARCHAR(10), DocDate, 120) + ' ' + 
    CONVERT(VARCHAR(5), 
        STUFF(RIGHT('0000' + CAST(DocTime AS VARCHAR(4)), 4), 3, 0, ':')
    , 108) AS 'Fecha y Hora de Documento' -- Concatenación de DocDate y DocTime en formato YYYY-MM-DD HH:MM
FROM ODLN;

-------

SELECT DISTINCT
    t0.DocNum AS 'Orden de Venta',
    -- Concatenating DocDate and DocTime without repeating CONVERT functions
    CONVERT(VARCHAR(16), DATEADD(MINUTE, t0.DocTime % 100 + (t0.DocTime / 100) * 60, t0.DocDate), 120) AS 'Time Orden de Venta',
    t2.DocNum AS 'Entrega',
    CONVERT(VARCHAR(16), DATEADD(MINUTE, t2.DocTime % 100 + (t2.DocTime / 100) * 60, t2.DocDate), 120) AS 'Time Entrega',
    t4.DocNum AS 'Factura',
    CONVERT(VARCHAR(16), DATEADD(MINUTE, t4.DocTime % 100 + (t4.DocTime / 100) * 60, t4.DocDate), 120) AS 'Time Factura'
FROM ORDR t0
INNER JOIN RDR1 t1 ON t1.DocEntry = t0.DocEntry
LEFT JOIN ODLN t2 ON t2.DocEntry = t1.TrgetEntry
INNER JOIN DLN1 t3 ON t3.DocEntry = t2.DocEntry
LEFT JOIN OINV t4 ON t4.DocEntry = t3.TrgetEntry
INNER JOIN INV1 t5 ON t5.DocEntry = t4.DocEntry
LEFT JOIN ORDN t6 ON t3.TrgetEntry = t6.DocEntry
----WHERE t0.DocDate BETWEEN DATEADD(DAY, -10, GETDATE()) AND GETDATE()
ORDER BY t0.DocNum;

----

SELECT DISTINCT
    t0.DocNum AS 'Orden de Venta',
    -- Concatenación de DocDate y DocTime en formato YYYY-MM-DD HH:MM
    CONVERT(VARCHAR(16), DATEADD(MINUTE, t0.DocTime % 100 + (t0.DocTime / 100) * 60, t0.DocDate), 120) AS 'Time Orden de Venta',
    t2.DocNum AS 'Entrega',
    CONVERT(VARCHAR(16), DATEADD(MINUTE, t2.DocTime % 100 + (t2.DocTime / 100) * 60, t2.DocDate), 120) AS 'Time Entrega',
    t4.DocNum AS 'Factura',
    CONVERT(VARCHAR(16), DATEADD(MINUTE, t4.DocTime % 100 + (t4.DocTime / 100) * 60, t4.DocDate), 120) AS 'Time Factura'
FROM ORDR t0
INNER JOIN RDR1 t1 ON t1.DocEntry = t0.DocEntry
LEFT JOIN ODLN t2 ON t2.DocEntry = t1.TrgetEntry
LEFT JOIN DLN1 t3 ON t3.DocEntry = t2.DocEntry
LEFT JOIN OINV t4 ON t4.DocEntry = t3.TrgetEntry
LEFT JOIN INV1 t5 ON t5.DocEntry = t4.DocEntry
LEFT JOIN ORDN t6 ON t3.TrgetEntry = t6.DocEntry
WHERE (t2.DocNum IS NULL AND t4.DocNum IS NULL)  -- Órdenes sin entrega ni factura
   OR t0.DocDate BETWEEN DATEADD(DAY, -10, GETDATE()) AND GETDATE()
ORDER BY t0.DocNum;


------------------


SELECT DISTINCT
    t0.DocNum AS 'Orden de Venta',
    -- Concatenación de DocDate y DocTime en formato YYYY-MM-DD HH:MM
    CONVERT(VARCHAR(16), DATEADD(MINUTE, t0.DocTime % 100 + (t0.DocTime / 100) * 60, t0.DocDate), 120) AS 'Time Orden de Venta',
    t2.DocNum AS 'Entrega',
    CONVERT(VARCHAR(16), DATEADD(MINUTE, t2.DocTime % 100 + (t2.DocTime / 100) * 60, t2.DocDate), 120) AS 'Time Entrega',
    t4.DocNum AS 'Factura',
    CONVERT(VARCHAR(16), DATEADD(MINUTE, t4.DocTime % 100 + (t4.DocTime / 100) * 60, t4.DocDate), 120) AS 'Time Factura',
    CASE 
        WHEN t0.DocStatus = 'C' THEN 'Cerrada'
        ELSE 'Abierta'
    END AS 'Estado Orden de Venta'
FROM ORDR t0
INNER JOIN RDR1 t1 ON t1.DocEntry = t0.DocEntry
LEFT JOIN ODLN t2 ON t2.DocEntry = t1.TrgetEntry
LEFT JOIN DLN1 t3 ON t3.DocEntry = t2.DocEntry
LEFT JOIN OINV t4 ON t4.DocEntry = t3.TrgetEntry
LEFT JOIN INV1 t5 ON t5.DocEntry = t4.DocEntry
LEFT JOIN ORDN t6 ON t3.TrgetEntry = t6.DocEntry
WHERE (t2.DocNum IS NULL AND t4.DocNum IS NULL)  -- Órdenes sin entrega ni factura
   OR t0.DocDate BETWEEN DATEADD(DAY, -10, GETDATE()) AND GETDATE()
ORDER BY t0.DocNum;


---------
SELECT DISTINCT
    T0.DOCNUM AS 'Factura',           -- Número de la factura
    OD.DocNum AS 'Entrega',           -- Número de la entrega
    OV.DocNum AS 'Orden de Venta',
    -- Concatenación de DocDate y DocTime en formato YYYY-MM-DD HH:MM
    CONVERT(VARCHAR(16), DATEADD(MINUTE, OV.DocTime % 100 + (OV.DocTime / 100) * 60, OV.DocDate), 120) AS 'Time Orden de Venta' -- Número de la Orden de Venta
    -----R1.BaseDocNum AS 'Folio OV'       -- Número de documento base (referencia)
FROM INV1 AS I1
INNER JOIN OINV AS T0 ON I1.DocEntry = T0.DocEntry   -- Relación entre la cabecera y las líneas de la factura
LEFT JOIN ODLN AS OD ON I1.BaseEntry = OD.DocEntry   -- Relación entre la factura y la entrega
LEFT JOIN DLN1 AS D1 ON OD.DocEntry = D1.DocEntry    -- Relación entre la cabecera y las líneas de la entrega
LEFT JOIN ORDR AS OV ON D1.BaseEntry = OV.DocEntry   -- Relación entre la entrega y la orden de venta
LEFT JOIN RDR1 AS R1 ON OV.DocEntry = R1.DocEntry    -- Relación entre la cabecera y las líneas de la orden de venta
WHERE T0.DocStatus = 'O'                             -- Filtrar solo facturas abiertas
ORDER BY T0.DocNum;
