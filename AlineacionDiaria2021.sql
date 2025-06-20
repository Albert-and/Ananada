
---------Facturacion------------
SELECT 
e.DocNum,
c.BaseDocNum,
c.DocEntry,
c.ItemCode,
c.Quantity,
c.Price,
c.LineTotal,
c.DocDate,
e.CardName,
e.SlpCode
from INV1 c 
INNER JOIN OINV e on c.DocEntry = e.DocEntry
WHERE c.DocDate BETWEEN CONVERT(date,GETDATE()-15) AND CONVERT(date,GETDATE()-1) AND c.ItemCode NOT LIKE 'F%'

---Ordenes de venta ------

SELECT T1.DocEntry, T1.DocNum, T1.DocStatus, T1.DocDate,
T1.CardCode, T1.CardName, T1.DocTotal,
(select top 1 Descr from UFD1 where FieldID = 29 and fldvalue = T1.U_EstatusOV
and TableID = 'ORDR'
group by FieldID, indexid, fldvalue, Descr) AS 'Estatus ANANDA',
 T2.SlpName
FROM ORDR T1
LEFT JOIN OSLP T2 ON T1.SlpCode = T2.SlpCode
WHERE series <> '76' AND T1.DocDate BETWEEN CONVERT(date,GETDATE()-15) AND CONVERT(date,GETDATE()-1)

--------Entrega-----

SELECT DISTINCT T1.BaseRef [No. OV], T0.DocEntry, T0.DocNum,
T0.DocStatus, T0.DocDate, T0.DocTotal, T0.CardCode, T0.CardName, t2.SlpName
FROM ODLN T0
inner JOIN DLN1 T1 ON T0.DocEntry = T1.DocEntry
left JOIN OSLP T2 ON T0.SlpCode = T2.SlpCode
WHERE t0.CANCELED = 'N' and (t1.BaseRef <> 'null' and t1.BaseRef <>' ') AND T0.DocDate BETWEEN CONVERT(date,GETDATE()-15) AND CONVERT(date,GETDATE()-1)


-----------

SELECT 
e.DocNum,
c.BaseDocNum,
c.DocEntry,
c.ItemCode,
c.Quantity,
c.Price,
c.LineTotal,
c.DocDate,
e.CardName,
e.SlpCode,
o.SlpName
from INV1 c 
INNER JOIN OINV e on c.DocEntry = e.DocEntry
INNER JOIN OSLP o ON o.SlpCode = e.SlpCode 
WHERE c.DocDate BETWEEN '10/01/2021' AND '10/31/2021' 








SELECT DISTINCT T0.DocEntry [No. Interno], T0.DocNum [No. Factura],
T0.DocDate [Fecha], T0.CardCode [Cliente], T0.CardName [Nombre], T0.DocTotal [Total Facturado],
T0.DocStatus [Estatus de Documento], T2.SlpName [Vendedor]
FROM OINV T0 
LEFT JOIN OSLP T2 ON T0.SlpCode = T2.SlpCode
WHERE T0.SERIES <> '75' AND T0.CANCELED = 'N'
group by T0.DocEntry , T0.DocNum ,
T0.DocDate , T0.CardCode, T0.CardName , T0.DocTotal ,
T0.DocStatus , T2.SlpName