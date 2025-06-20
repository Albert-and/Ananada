

Select itemcode, QryGroup1
FROM OITM
WHERE QryGroup1 = 'Y'




Select TOP(10)* 
FROM OITM



select cardcode, cardname, v.SlpName, OwnerCode
from OCRD c
INNER JOIN OSLP v ON v.SlpCode = c.SlpCode 




Use Pruebas_V10

SELECT * from @OCAL



 SELECT DISTIN e.Code,e.U_Estatus,e.CreateDate,e.U_UN,d.U_Cantidad,
  d.U_Articulo,d.U_Desc_Incidencia
  FROM [Pruebas_V10].[dbo].[@OCAL] e
FULL JOIN [Pruebas_V10].[dbo].[@ACAL1] d ON e.Code = d.Code
 RIGHT JOIN [Pruebas_V10].[dbo].[@ACAL2] f ON e.Code = f.Code
  WHERE e.U_Estatus = 'Abierto'



 SELECT Code,U_Estatus,CreateDate,U_UN
  FROM [Pruebas_V10].[dbo].[@OCAL] 

----------------------------------------
  
SELECT  e.Code            AS 'Registro'
       ,U_UN              AS 'Unidad de Negocio'
       ,U_Fecha           AS 'Fecha'
       ,U_DocSap          AS 'Documento Relacionado'
       ,U_Ref_SN          AS 'Socio de Negocio'
       ,U_Clave_Reporte   AS 'Clave de Reporte'
       ,U_Tipo_Incidencia AS 'Incidencia'
       ,U_Estatus         AS 'Estatus'
       ,d.U_Articulo      AS 'SKU'
       ,d.U_Cantidad      AS 'Cantidad'
FROM [Pruebas_V10].[dbo].[@OCAL] e
INNER JOIN [Pruebas_V10].[dbo].[@ACAL1] d
ON e.Code = d.Code


--------------------------

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