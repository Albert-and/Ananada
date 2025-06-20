

---Ordenes de venta ------

SELECT T1.DocEntry, T1.DocNum, T1.DocStatus, T1.DocDate,
T1.CardCode, T1.CardName, T1.DocTotal,
(select top 1 Descr from UFD1 where FieldID = 29 and fldvalue = T1.U_EstatusOV
and TableID = 'ORDR'
group by FieldID, indexid, fldvalue, Descr) AS 'Estatus ANANDA',
 T2.SlpName
FROM ORDR T1
LEFT JOIN OSLP T2 ON T1.SlpCode = T2.SlpCode
WHERE series <> '76' AND T1.DocDate BETWEEN '10/01/2021' AND '12/31/2021' 


----Entregas ---------

SELECT DISTINCT T1.BaseRef [No. OV], T0.DocEntry, T0.DocNum,
T0.DocStatus, T0.DocDate, T0.DocTotal, T0.CardCode, T0.CardName, t2.SlpName
FROM ODLN T0
inner JOIN DLN1 T1 ON T0.DocEntry = T1.DocEntry
left JOIN OSLP T2 ON T0.SlpCode = T2.SlpCode
WHERE t0.CANCELED = 'N' and (t1.BaseRef <> 'null' and t1.BaseRef <>' ') AND T0.DocDate BETWEEN '10/01/2021' AND '12/31/2021'


---Facturacion AND NC ---

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





SELECT e.DocNum,e.DocDate,e.CardCode,e.CardName,c.ItemCode, c.LineTotal
FROM ORIN e
INNER JOIN RIN1 c ON  c.DocEntry = e.DocEntry
Where e. DocDate BETWEEN '10/01/2021' AND '10/31/2021'

