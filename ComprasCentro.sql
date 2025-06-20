


SELECT TOP(10)* 
from OITG

-----------Inventario--------------

SELECT o.ItemCode,
o.ItemName,
s.OnHand as 'Stock',
s.IsCommited as 'Comprometido',
s.OnHand - s.IsCommited as 'Disponible',
s.WhsCode, o.ItmsGrpCod
FROM OITW s
INNER JOIN OITM o ON s.ItemCode = o.ItemCode
WHERE  WhsCode = 'ALPC' AND ItmsGrpCod = 107

---------------------------------------------
-------------Compras-------------------------

SELECT p.ItemCode,
p.Dscription,
p.Quantity,
p.ShipDate,
p.Price,
p.LineTotal
FROM POR1 p
INNER JOIN OITM o ON o.ItemCode = p.ItemCode
WHERE p.ShipDate >= CONVERT(date,GETDATE()-120) AND o.ItmsGrpCod = 107


-----------------------------------------------
----------------Ventas----------------------------

SELECT i.ItemCode,
i.Dscription,
i.Quantity,
i.LineTotal,
i.DocDate
from INV1 i
INNER JOIN OITM o ON o.ItemCode = i.ItemCode
WHERE DocDate >= CONVERT(date,GETDATE()-120) AND o.ItmsGrpCod = 107

---------------------------------------------

========= Facturas===========


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



e.DocDate BETWEEN '10/01/2021' AND '10/31/2021' AND
===============================================
---------------------------------------------------



--------------ENTREGA----------
Select *
FROM ODLN
WHERE DocNum = 322053
--------------ENTREGA----------


--------- ORDEN------
SElect * 
FROM ORDR
WHERE DocNum =  620851
--------- ORDEN------





SELECT 
e.DocNum,
c.BaseDocNum,
c.DocEntry,
c.ItemCode,
c.Dscription,
c.Quantity,
c.LineTotal,
c.DocDate,
e.CardName,
e.Comments
from INV1 c 
INNER JOIN OINV e on c.DocEntry = e.DocEntry
WHERE c.DocDate BETWEEN '10/01/2021' AND '10/31/2021'
ORDER BY e.DocNum



---------------


SELECT
T0.[DocNum],
T0.[DocDate],
T0.[CardCode],
T0.[CardName],
T0.[UserSign],
T1.[LineNum],
T1.[ItemCode],
T1.[Dscription],
T1.[Quantity],
T1.[BaseRef] as "PEDIDO" 
FROM OPDN T0  
INNER JOIN PDN1 T1 ON T0.[DocEntry] = T1.[DocEntry] 
INNER JOIN OITM T2 ON T1.[ItemCode] = T2.[ItemCode]






SELECT *
FROM POR1
INNER JOIN OPOR on 
WHERE DocNum = 6771



SELECT * FROM OPDN 
SELECT * FROM PDN1



SELECT * FROM OPOR WHERE DocNum = 104258 ---PEDIDO
SELECT * FROM PDN1 WHERE DocEntry = 6764 ---eNTRADA