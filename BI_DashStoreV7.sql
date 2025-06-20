
SELECT T1.DocEntry, T1.DocNum, T1.DocStatus, T1.DocDate, 
T1.CardCode, T1.CardName, T1.DocTotal,
(select top 1 Descr from UFD1 where FieldID = 29 and fldvalue = T1.U_EstatusOV 
and TableID = 'ORDR'
group by FieldID, indexid, fldvalue, Descr) AS 'Estatus ANANDA',T2.SlpName,
CASE
T3.SeriesName
WHEN 'PC' THEN 'Carrito'
WHEN 'PM' THEN 'Mayoreo'
WHEN 'NC' THEN 'Carrito'
WHEN 'NM' THEN 'Mayoreo'
END AS 'Tipo de Venta'
FROM ORDR T1 
LEFT JOIN OSLP T2 ON T1.SlpCode = T2.SlpCode
INNER JOIN NNM1 T3 ON T3.[Series] = T1.[Series]
WHERE T1.series <> '76' AND T1.DocDate BETWEEN CONVERT(date,GETDATE()-45) AND CONVERT(date,GETDATE()-1)

-------------------------------------------

SELECT DISTINCT T1.BaseRef [No. OV], T0.DocEntry, T0.DocNum,
T0.DocStatus,  T0.DocDate, T0.DocTotal, T0.CardCode, T0.CardName, t2.SlpName,T0.U_Cajas,T0.U_PesoCaja
FROM ODLN T0
inner JOIN DLN1 T1 ON T0.DocEntry = T1.DocEntry
left JOIN OSLP T2 ON T0.SlpCode = T2.SlpCode
WHERE t0.CANCELED = 'N' and (t1.BaseRef <> 'null' and t1.BaseRef <>' ') 
and T1.BaseRef>='600000' AND T0.DocDate BETWEEN CONVERT(date,GETDATE()-45) AND CONVERT(date,GETDATE()-1)

----------------------------------------------------------------------------------------

SELECT DISTINCT T0.DocEntry [No. Interno], T0.DocNum [No. Factura],
T3.DocNum [No. Entrega], T6.DocNum [No. OV],
T0.DocDate [Fecha], T0.CardCode [Cliente], T0.CardName [Nombre], T0.DocTotal [Total Facturado],
T0.DocStatus [Estatus de Documento], T2.SlpName [Vendedor],
CASE
T7.SeriesName
WHEN 'FAC' THEN 'Carrito'
WHEN 'FAM' THEN 'Mayoreo'
WHEN 'NC' THEN 'Carrito'
WHEN 'NM' THEN 'Mayoreo'
END AS 'Tipo de Venta',(T0.GrosProfit*1.16) as 'Ganancía',round((T0.GrosProfit*1.16)/nullif((T0.DocTotal),0),5) as 'Rentabilidad'
FROM ORDR T6
inner JOIN RDR1 T5 ON T5.DocEntry = T6.DocEntry 
LEFT JOIN DLN1 T4 ON t5.ObjType=t4.basetype and t5.DocEntry=t4.baseentry and t5.LineNum=t4.BaseLine
inner JOIN ODLN T3 ON T3.DocEntry = T4.DocEntry 
LEFT JOIN INV1 T1 ON t4.ObjType=t1.basetype and t4.DocEntry=t1.baseentry and t4.LineNum=t1.BaseLine
inner JOIN OINV T0 ON T0.DocEntry = T1.DocEntry 
LEFT JOIN OSLP T2 ON T0.SlpCode = T2.SlpCode
INNER JOIN NNM1 T7 ON T7.[Series] = T0.[Series] 
WHERE T0.SERIES <> '75' AND T0.CANCELED = 'N' AND T0.DocDate BETWEEN CONVERT(date,GETDATE()-45) AND CONVERT(date,GETDATE()-1)
group by T0.DocEntry , T0.DocNum ,
T1.BaseRef , T6.DOCNUM ,
T0.DocDate , T0.CardCode, T0.CardName , T0.DocTotal, 
T0.DocStatus , T2.SlpName,T7.SeriesName,T0.GrosProfit,t3.DocNum
union all  
SELECT DISTINCT T0.DocEntry [No. Interno], T0.DocNum [No. Factura],
T1.BaseRef [No. Entrega], T4.BaseRef [No. OV],
T0.DocDate [Fecha], T0.CardCode [Cliente], T0.CardName [Nombre], 
(T0.DocTotal * -1) [Total Facturado],
T0.DocStatus [Estatus de Documento], T2.SlpName [Vendedor],
CASE
T7.SeriesName
WHEN 'FAC' THEN 'Carrito'
WHEN 'FAM' THEN 'Mayoreo'
WHEN 'NC' THEN 'Carrito'
WHEN 'NM' THEN 'Mayoreo'
END AS 'Tipo de Venta', (T0.GrosProfit*1.16) as 'Ganancía',round((T0.GrosProfit*1.16)/nullif((T0.DocTotal),0),5) as 'Rentabilidad'
FROM ORIN T0 
LEFT JOIN RIN1 T1 ON T0.DocEntry = T1.DocEntry
LEFT JOIN OSLP T2 ON T0.SlpCode = T2.SlpCode
LEFT JOIN OINV T3 ON T3.DocNum = T1.BaseRef
LEFT JOIN INV1 T4 ON T4.DocEntry = T3.DocEntry
INNER JOIN NNM1 T7 ON T7.[Series] = T0.[Series]
WHERE T0.CANCELED = 'N' AND T0.DocDate BETWEEN CONVERT(date,GETDATE()-45) AND CONVERT(date,GETDATE()-1)
group by T0.DocEntry , T0.DocNum ,
T1.BaseRef , T4.BaseRef ,
T0.DocDate , T0.CardCode, T0.CardName , T0.DocTotal ,
T0.DocStatus , T2.SlpName,T7.SeriesName,T0.GrosProfit

-----------------------

SELECT isnull(T6.baseref,'') as 'No. OV',T0.cardcode,T0.cardname,T2.Slpname as 'Asesor',
T0.Doctotal,T0.Docnum,T1.seriesname,T3.[ItemCode], T3.[Dscription], T3.[Quantity],T3.[LineTotal],
T0.DocDate, T5.ItmsGrpNam as 'Categoría',T4.U_Codigo as 'Segmento',
CASE
WHEN T4.QryGroup1='Y' THEN 'LINEA'
WHEN T4.QryGroup2='Y' THEN 'MIXTO'
WHEN T4.QryGroup3='Y' THEN 'CASA'
END AS 'Cuadrante',
CASE
T1.SeriesName
WHEN 'FAC' THEN 'Carrito'
WHEN 'FAM' THEN 'Mayoreo'
END AS 'Tipo de Venta',
CASE
T3.[TaxCode]
WHEN 'IVAC16' THEN T3.[LineTotal]*1.16
WHEN 'IVAC0' THEN T3.[LineTotal]
END AS 'Total Facturado',
CASE
T3.[TaxCode]
WHEN 'IVAC16' THEN (T3.LineTotal-T3.Quantity*T3.GrossBuyPr)*1.16
WHEN 'IVAC0' THEN T3.LineTotal-T3.Quantity*T3.GrossBuyPr
END AS 'Total Ganancia'
FROM OINV T0  
INNER JOIN NNM1 T1 ON T0.[Series] = T1.[Series] 
INNER JOIN OSLP T2 ON T0.[SlpCode] = T2.[SlpCode] 
INNER JOIN INV1 T3 ON T0.[DocEntry] = T3.[DocEntry]
inner join OITM T4 ON T4.itemcode=T3.Itemcode
inner join OITB T5 ON T5.ItmsGrpCod=T4.ItmsGrpCod
left join DLN1 T6 ON t6.ObjType=t3.basetype and t6.DocEntry=t3.baseentry and t6.LineNum=t3.BaseLine
WHERE T0.CANCELED = 'N' AND T1.SeriesName <> 'SI' AND T0.DocDate BETWEEN CONVERT(date,GETDATE()-45) AND CONVERT(date,GETDATE()-1)
AND T1.SeriesName='FAC'

--------------------------------

SELECT  T4.ItmsGrpNam                                                                                                               AS 'Categoría'
       ,T1.[U_CLASIF_STORE]                                                                                                         AS 'Clasificación'
       ,T0.[OnHand]                                                                                                                 AS 'Total Pzs'
       ,CASE T1.[TaxCodeAp] WHEN 'IVAP16' THEN ROUND(T3.[Price] * 1,2) * T0.[OnHand] WHEN 'IVAP0' THEN T3.[Price] * T0.[OnHand] END AS 'Valor Inventario'
FROM OITW T0
INNER JOIN OITM T1
ON T0.[ItemCode] = T1.[ItemCode]
INNER JOIN OWHS T2
ON T0.[WhsCode]=T2.[WhsCode]
INNER JOIN ITM1 T3
ON T1.[ItemCode] = T3.[ItemCode]
INNER JOIN OITB T4
ON T1.ItmsGrpCod=T4.ItmsGrpCod
WHERE (T1.[U_CLASIF_STORE]='A' OR T1.[U_CLASIF_STORE]='B' OR T1.[U_CLASIF_STORE]='C'OR T1.[U_CLASIF_STORE]='N' OR T1.[U_CLASIF_STORE]='O')
AND T0.[WhsCode]='ALPC'
AND T3.PriceList='10' 
------------------------
CXC

SELECT  P0.DocNum
       ,P0.DocDate
       ,P0.DocDueDate
       ,P0.CardCode
       ,P0.CardName
       ,P0.DocTotal
       ,P0.PaidToDate
       ,T1.SlpName
       ,(
SELECT  (doctotal - paidtodate))                                                                                                       AS 'Saldo'
       ,(CASE WHEN (DATEDIFF(Day,DocDueDate,getdate())) <-7 THEN 'POR VENCER' WHEN (DATEDIFF(Day,DocDueDate,getdate()))>=-7 AND (DATEDIFF(Day,DocDueDate,getdate())) <=0 THEN 'SEMANA CORRIENTE' WHEN (DATEDIFF(Day,DocDueDate,getdate())) > 0 THEN 'VENCIDO' END) AS 'CONCEPTO'
       ,(CASE T2.SeriesName WHEN 'FAC' THEN 'Carrito' WHEN 'FAM' THEN 'Mayoreo' WHEN 'FC' THEN 'Carrito' WHEN 'FM' THEN 'Mayoreo' END) AS 'Tipo de Venta'
FROM OINV P0
INNER JOIN OSLP T1
ON P0.SlpCode = T1.SlpCode
INNER JOIN NNM1 T2
ON P0.[Series] = T2.[Series] AND (P0.doctotal > P0.paidtodate) AND T2.SeriesName <> 'SI'and P0.Docnum>'2'
WHERE DocDate BETWEEN CONVERT(date, GETDATE()-45) AND CONVERT(date, GETDATE()-1)

--------------------

SELECT  T0.[DocDate]
       ,T0.[DocStatus]
       ,T0.[DocNum]                 AS 'No OV'
       ,T1.[ItemCode]
       ,T2.[ItemName]               AS 'Producto'
       ,T1.[Quantity]               AS 'Cantidad solicitada'
       ,T1.[DelivrdQty]             AS 'Cantidad suministrada'
       ,(T1.Quantity-T1.DelivrdQty) AS 'Cantidad negada'
       ,T1.[price]*1.16             AS 'Price'
FROM ORDR T0
INNER JOIN RDR1 T1
ON T0.[DocEntry] = T1.[DocEntry]
INNER JOIN OITM T2
ON T1.[ItemCode] = T2.[ItemCode]
WHERE T0.[DocStatus]='C'
AND T1.[LineStatus] ='C'And T0.[Docdate] BETWEEN CONVERT(date, GETDATE()-45) AND CONVERT(date, GETDATE()-1)
AND (T1.Quantity-T1.DelivrdQty) >0

---------------------------------

SELECT  distinct T0.docdate
       ,T0.docnum AS 'OV'
       ,T0.Cardcode
       ,T0.CardName
       ,T1.itemcode
       ,T1.dscription
       ,T1.Quantity
FROM ORDR T0
INNER JOIN RDR1 T1
ON T0.DocEntry = T1.DocEntry
WHERE T0.docdate BETWEEN CONVERT(date, GETDATE()-45) AND CONVERT(date, GETDATE()-1)
ORDER BY T0.DocNum ASC



SELECT U_EstatusOV,U_HoraCreacion
FROM ORDR
Where DocNum = '563402'



----------------------
Select 
i.ItemCode,
ItemName,
g.ItmsGrpNam,
OnHand,
OnOrder,
IsCommited,
p.PriceList
FROM OITM i
INNER JOIN AITB g ON i.ItmsGrpCod = g.ItmsGrpCod
INNER JOIN ITM1 p ON p.ItemCode = i.ItemCode
Where p.PriceList = 10
----------------------

Compras
--------------------

Select ItemCode,Quantity,Price, DocDate,DocEntry
from PCH1
wHERE ItemCode = '50005'

----
Select  DocDate,DocEntry
from OPCH
wHERE DocEntry = 7201



SELECT ItemCode,WhsCode,OnHand
FROM OITW
WHERE WhsCode = 'ALPM'




Select TOP(10)*
FROM PDN1

---------------------------


Select
c.ItemCode,e.DocDate, c.LineTotal,c.Quantity,e.CardCode
FROM OPDN e
INNER JOIN PDN1 c ON c.DocEntry = e.DocEntry
WHERE e.DocDate >= '20220101'





SELECT T0.[ItemCode], T0.[ItemName], T1.[Price],t1.On FROM OITM T0
	INNER JOIN ITM1 T1 ON T0.ItemCode = T1.ItemCode
	INNER JOIN OPLN T2 ON T1.PriceList = T2.ListNum WHERE  T2.[ListName] = 'Coto AND'







SELECT *
       FROM OITR
       WHERE ReconNum = '98779'






SELECT *
FROM OITW
WHERE ItemCode = '50005'

SELECT ItemName
FROM OITM





SELECT a.ItemCode,n.ItemName,a.WhsCode,a.OnHand,a.StockValue
FROM OITW a
INNER JOIN OITM n ON a.ItemCode = n.ItemCode
WHERE a.OnHand > 0



SELECT ItemCode,WhsCode,OnHand,StockValue
FROM OITW


Select 
Cardcode AS "Numero",
CardName AS "Nombre",
LicTradNum AS "RFC",
p.lastName AS "Nombre Vendedor",
o.E_Mail AS "Correo",
o.Address,
o.ZipCode,
o.MailAddres,
o.MailZipCod
from OCRD o
INNER JOIN OHEM p ON p.empID = o.OwnerCode
WHERE CardCode NOT LIKE 'P%'
ORDER BY p.lastName DESC 


SELECT CardCode,CardName,CreateDate,E_Mail,ZipCode,Balance,CreditLine,LicTradNum,ListNum,o.SlpName,c.SlpCode
FROM OCRD c
INNER JOIN OSLP o ON o.SlpCode = c.SlpCode 
order by CreateDate DESC


SELECT TOP(10)*
FROM OCRD 