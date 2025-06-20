

USE ANANDA_BD
----------------------- orden de venta---------------------------------
SELECT T1.DocEntry, T1.DocNum, T1.DocStatus, T1.DocDate, 
T1.CardCode, T1.CardName, T1.DocTotal,
(select top 1 Descr from UFD1 where FieldID = 29 and fldvalue = T1.U_EstatusOV 
and TableID = 'ORDR'
group by FieldID, indexid, fldvalue, Descr)
 AS 'Estatus ANANDA',T2.SlpName,
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
 WHERE T1.series <> '76' AND T1.DocDate >=  CONVERT(DATE, GETDATE()-60) 
------------------------------------------------------------------------

--------------Entrada-----------------------
SELECT DISTINCT T1.BaseRef [No. OV], T0.DocEntry, T0.DocNum,
T0.DocStatus,  T0.DocDate, T0.DocTotal, T0.CardCode, T0.CardName, t2.SlpName,T0.U_Cajas,T0.U_PesoCaja
FROM ODLN T0
inner JOIN DLN1 T1 ON T0.DocEntry = T1.DocEntry
left JOIN OSLP T2 ON T0.SlpCode = T2.SlpCode
WHERE t0.CANCELED = 'N' AND (t1.BaseRef <> 'null' AND t1.BaseRef <>' ') 
AND T1.BaseRef>='600000' AND T0.DocDate >=  CONVERT(DATE, GETDATE()-60) 


-----------------------------------------------

---------Venta---------------------

SELECT isnull(T6.baseref,'') as 'No. OV',T0.cardcode,
T0.cardname,T2.Slpname as 'Asesor',
T0.Doctotal,
T0.Docnum,
T1.seriesname,
T3.[ItemCode],
T3.[Dscription],
T3.[Quantity],
T3.[LineTotal],
T0.DocDate,
T5.ItmsGrpNam as 'Categoría',
T4.U_Codigo as 'Segmento',
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
WHEN 'IVAC16' 
THEN (T3.LineTotal-T3.Quantity*T3.GrossBuyPr)*1.16
WHEN 'IVAC0' THEN T3.LineTotal-T3.Quantity*T3.GrossBuyPr
END AS 'Total Ganancia'
FROM OINV T0  
INNER JOIN NNM1 T1 ON T0.[Series] = T1.[Series] 
INNER JOIN OSLP T2 ON T0.[SlpCode] = T2.[SlpCode] 
INNER JOIN INV1 T3 ON T0.[DocEntry] = T3.[DocEntry]
inner join OITM T4 ON T4.itemcode=T3.Itemcode
inner join OITB T5 ON T5.ItmsGrpCod=T4.ItmsGrpCod
left join DLN1 T6 ON t6.ObjType=t3.basetype and t6.DocEntry=t3.baseentry and t6.LineNum=t3.BaseLine
WHERE T0.CANCELED = 'N' AND T1.SeriesName <> 'SI' AND T0.DocDate >=  CONVERT(DATE, GETDATE()-60) AND T1.SeriesName='FAC'

--and T3.ItemCode not like 'F%'#(lf)UNION ALL#(lf)#(lf)SELECT isnull(T6.baseref,'')as 'No. OV',T0.cardcode,T0.cardname,T2.Slpname as 'Asesor',T0.Doctotal,T0.Docnum,T1.seriesname,T3.[ItemCode], T3.[Dscription], T3.[Quantity]*-1, T3.[LineTotal], T0.DocDate,T5.ItmsGrpNam as 'Categoría',T4.U_Codigo as 'Segmento',#(lf)#(lf)CASE#(lf)WHEN T4.QryGroup1='Y' THEN 'LINEA'#(lf)WHEN T4.QryGroup2='Y' THEN 'MIXTO'#(lf)WHEN T4.QryGroup3='Y' THEN 'CASA'#(lf)END AS 'Cuadrante',#(lf)#(lf)CASE#(lf)T1.SeriesName#(lf)WHEN 'NC' THEN 'Carrito'#(lf)WHEN 'NM' THEN 'Mayoreo'#(lf)END AS 'Tipo de Venta',#(lf)#(lf)CASE#(lf)T3.[TaxCode]#(lf)WHEN 'IVAC16' THEN (T3.[LineTotal]*1.16)*-1#(lf)WHEN 'IVAC0' THEN T3.[LineTotal]#(lf)END AS 'Total Facturado',#(lf)#(lf)CASE#(lf)T3.[TaxCode]#(lf)WHEN 'IVAC16' THEN (T3.LineTotal-T3.Quantity*T3.GrossBuyPr)*1.16*-1#(lf)WHEN 'IVAC0' THEN (T3.LineTotal-T3.Quantity*T3.GrossBuyPr)*-1#(lf)END AS 'Total Ganancia'#(lf)#(lf)FROM ORIN T0#(lf)INNER JOIN NNM1 T1 ON T0.[Series] = T1.[Series] #(lf)INNER JOIN OSLP T2 ON T0.[SlpCode] = T2.[SlpCode] #(lf)INNER JOIN RIN1 T3 ON T0.[DocEntry] = T3.[DocEntry]#(lf)inner join OITM T4 ON T4.itemcode=T3.Itemcode#(lf)inner join OITB T5 ON T5.ItmsGrpCod=T4.ItmsGrpCod#(lf)left join DLN1 T6 ON t6.ObjType=t3.basetype and t6.DocEntry=t3.baseentry and t6.LineNum=t3.BaseLine#(lf)WHERE T0.CANCELED = 'N' AND T1.SeriesName <> 'SI' AND T0.DocDate>='20210101' AND T1.SeriesName='NC'--and T3.ItemCode not like 'F%'"

--------------------------------------

----------

SELECT isnull(T6.baseref,'') as 'No. OV',
T0.cardcode,
T0.cardname,
T2.Slpname as 'Asesor',
T0.Doctotal,
T0.Docnum,
T1.seriesname,
T3.[ItemCode],
T3.[Dscription],
T3.[Quantity],
T3.[LineTotal],
T0.DocDate,
T5.ItmsGrpNam as 'Categoría',
T4.U_Codigo as 'Segmento',
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
WHERE T0.CANCELED = 'N' AND T1.SeriesName <> 'SI' AND T0.DocDate >=  CONVERT(DATE, GETDATE()-60) AND T1.SeriesName='FAC'

--and T3.ItemCode not like 'F%'#(lf)#(lf)UNION ALL#(lf)#(lf)SELECT isnull(T6.baseref,'')as 'No. OV',T0.cardcode,T0.cardname,T2.Slpname as 'Asesor',T0.Doctotal,T0.Docnum,T1.seriesname,T3.[ItemCode], T3.[Dscription], T3.[Quantity]*-1, T3.[LineTotal], T0.DocDate,T5.ItmsGrpNam as 'Categoría',T4.U_Codigo as 'Segmento',#(lf)#(lf)CASE#(lf)WHEN T4.QryGroup1='Y' THEN 'LINEA'#(lf)WHEN T4.QryGroup2='Y' THEN 'MIXTO'#(lf)WHEN T4.QryGroup3='Y' THEN 'CASA'#(lf)END AS 'Cuadrante',#(lf)#(lf)CASE#(lf)T1.SeriesName#(lf)WHEN 'NC' THEN 'Carrito'#(lf)WHEN 'NM' THEN 'Mayoreo'#(lf)END AS 'Tipo de Venta',#(lf)#(lf)CASE#(lf)T3.[TaxCode]#(lf)WHEN 'IVAC16' THEN (T3.[LineTotal]*1.16)*-1#(lf)WHEN 'IVAC0' THEN T3.[LineTotal]#(lf)END AS 'Total Facturado',#(lf)#(lf)CASE#(lf)T3.[TaxCode]#(lf)WHEN 'IVAC16' THEN (T3.LineTotal-T3.Quantity*T3.GrossBuyPr)*1.16*-1#(lf)WHEN 'IVAC0' THEN (T3.LineTotal-T3.Quantity*T3.GrossBuyPr)*-1#(lf)END AS 'Total Ganancia'#(lf)#(lf)FROM ORIN T0#(lf)INNER JOIN NNM1 T1 ON T0.[Series] = T1.[Series] #(lf)INNER JOIN OSLP T2 ON T0.[SlpCode] = T2.[SlpCode] #(lf)INNER JOIN RIN1 T3 ON T0.[DocEntry] = T3.[DocEntry]#(lf)inner join OITM T4 ON T4.itemcode=T3.Itemcode#(lf)inner join OITB T5 ON T5.ItmsGrpCod=T4.ItmsGrpCod#(lf)left join DLN1 T6 ON t6.ObjType=t3.basetype and t6.DocEntry=t3.baseentry and t6.LineNum=t3.BaseLine#(lf)WHERE T0.CANCELED = 'N' AND T1.SeriesName <> 'SI' AND T0.DocDate>='20210101' AND T1.SeriesName='NC'--and T3.ItemCode not like 'F%'

---------------------------------

------Cliente Vendedor----------------------------------------

select 
T0.Cardcode,T0.Cardname as Cliente,
T0.GroupCode,T2.SlpName as Vendedor
from ocrd T0
INNER JOIN OSLP T2 ON T0.[SlpCode] = T2.[SlpCode]

-----------------------------------


------Cambio estatus OV------

select T0.DocNum as 'Documento',
 T0.DocDate as 'Fecha de creación',
  T0.UpdateDate as 'Fecha de liberación',
  T0.U_EstatusOV,
  (select top 1 Descr
   from UFD1
    where FieldID = 29 and fldvalue = T0.U_EstatusOV) as 'Estatus ANANDA'
    from ORDR T0
    where T0.U_EstatusOV is not null AND T0.DocDate >=  CONVERT(DATE, GETDATE()-60) 
    order by T0.docnum, T0.UpdateDate

-----------------------------







Select e.DocNum,e.DocDate, e.CardCode,c.ItemCode,c.Dscription,c.LineTotal
FROM OINV e
INNER JOIN INV1 c ON c.DocEntry = e.DocEntry
WHERE e.CardCode = 124666 AND e



































 SELECT DATEPART(day,currentDate) as day, 
     CASE DATEPART(month, currentDate)
          WHEN 1 THEN N'JAN'
          WHEN 2 THEN N'FEB'
          WHEN 3 THEN N'MAR'
          WHEN 4 THEN N'APR'
          WHEN 5 THEN N'MAI'
          WHEN 6 THEN N'JUN'
          WHEN 7 THEN N'JUL'
          WHEN 8 THEN N'AUG'
          WHEN 9 THEN N'SEP'
          WHEN 10 THEN N'OCT'
          WHEN 11 THEN N'NOV'
          WHEN 12 THEN N'DEC'
      END as month