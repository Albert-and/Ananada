


SELECT TOP(10)*
FROM ORDR


SELECT DocNum,DocDate,CardCode,CardName,DocTotal
FROM ORDR
WHERE DocDate >= CONVERT(date,GETDATE()-90)





SELECT DocNum,DocDate,CardCode,CardName,DocTotal
FROM ORDR
WHERE DocDate >= CONVERT(date,GETDATE()-90) AND DocNum > 60000




-------Carrito-----------
SELECT 
o.DocNum,
o.DocDate,
o.CardCode,
o.CardName,
o.DocTotal,
o.Series,
v.SlpName
FROM ORDR o
INNER JOIN OSLP v ON v.SlpCode = o.SlpCode
WHERE o.DocDate >= CONVERT(date,GETDATE()-90) AND o.Series = 73
--------------------------------------------------------------
--------------------------------------------------------------
SELECT 
o.DocNum as 'No.Documento',
o.DocDate as 'Fecha',
o.CardCode as 'No. Cliente',
o.CardName as 'Nombre Cliente',
o.DocTotal as 'Total',
o.Series as 'Serie',
v.SlpName as 'Vendedor'
FROM ORDR o
INNER JOIN OSLP v ON v.SlpCode = o.SlpCode
WHERE o.DocDate >= CONVERT(date,GETDATE()-60)
-------------------------------------------------------------
--------------------------------------------------------------

select *
from POR1
WHERE DocDate = '10/7/2021'
-----------------------------------
SELECT * 
from opor
WHERE DocDate = '10/7/2021'

-----------------------------------
-----------------------------------
SELECT
e.DocNum,
e.DocDate,
e.CardCode,
e.CardName,
c.ItemCode,
c.Dscription,
c.Quantity,
c.Price,
c.LineTotal,
e.Series
FROM OPOR e
INNER JOIN POR1 c ON c.DocEntry = e.DocEntry
WHERE e.DocDate >= CONVERT(date,GETDATE()-60) AND e.Series = 71
--------------------------
-------------------------


SELECT e.DocNum,e.DocDate,e.CardCode,e.CardName,
c.ItemCode,c.Dscription,c.Quantity,c.Price,c.LineTotal,e.Series
FROM OPOR e
INNER JOIN POR1 c ON c.DocEntry = e.DocEntry
WHERE e.DocNum = 103835

---------------------------------




SELECT b.CardCode AS "NUM DE PROVEEDOR",
b.DocDate AS "FECHA",
b.CardName AS "PROVEEDOR",
d.ItemCode AS "ITEM",
d.Dscription AS "DESCRIPCION",
d.Quantity AS "PIEZAS",
d.Price AS "PRECIO X UNIDAD",
d.LineTotal AS "TOTAL X INNER",
b.DocTotal AS "TOTAL DE LA COMPRA",
c.SlpName AS "COMPRADOR",
b.Series AS "SERIE"
FROM OPOR b, POR1 d
INNER JOIN OSLP c ON c.SlpCode = d.SlpCode
WHERE b.DocDate = CONVERT(date,GETDATE()-1)
ORDER BY c.SlpName




SELECT b.CardCode AS "NUM DE PROVEEDOR",
b.DocDate AS "FECHA",
b.CardName AS "PROVEEDOR",
d.ItemCode AS "ITEM",
d.Dscription AS "DESCRIPCION",
d.Quantity AS "PIEZAS",
d.Price AS "PRECIO X UNIDAD",
d.LineTotal AS "TOTAL X INNER",
b.DocTotal AS "TOTAL DE LA COMPRA",
c.SlpName AS "COMPRADOR",
b.Series AS "SERIE"
FROM OPOR b
INNER JOIN OSLP c ON c.SlpCode = d.SlpCode
WHERE b.DocDate = CONVERT(date,GETDATE()-1)
ORDER BY c.SlpName


SELECT 
c.CntctCode AS 'CodigoContacto',
c.CardCode AS 'CodigoCliente', 
t.CardName AS 'Nombre',
c.Active AS 'Activo'
FROM OCPR c
INNER JOIN OCRD t ON t.CardCode = c.CardCode
WHERE c.CardCode NOT LIKE 'P%' 


AND C.Active = 'N'

SELECT CntctCode,CardCode,Name,Active
from OCPR




SELECT CntctCode,CardCode,U_AVS_SendDocs
FROM OCPR



SHOW KEYS 
FROM OCPR 
WHERE KEYNAME = 'PRIMARY'


select * FROM OCPR
   INFORMATION_SCHEMA.C
    where table_name = 'OCPR';

Where CardCode ='14'




-----SN----
SELECT CardCode,CardName
from OCRD
WHERE CardCode Like 'P%' 



----Familias-----
SELECT ItmsGrpCod,ItmsGrpNam
FROM OITB



SELECT *
from OUSR






SELECT TOP(10)*
FROM ODLN




SELECT DocDate,DocNum, DocTotal
FROM ODLN
Where DocDate BETWEEN CONVERT(DATE, GETDATE()-30) AND CONVERT(DATE, GETDATE()) AND Series >= 74