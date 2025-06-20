

------------Nombre de La Lista-----------
SELECT *
FROM OPLN

------------------------------------------

---Precios x SKU de la lista 10-------------
Select TOP(10)*
From ITM1
WHERE PriceList = 10
-----------------------------------------


-------- Query 01--------------------

SELECT 
o.ItemCode AS "SKU",
o.ItemName AS "Descripcion",
o.ItmsGrpCod AS "Grupo de Articulo",
o.CardCode AS "Proveedor",
pl.Price AS "Costo AND"
FROM OITM o
INNER JOIN  ITM1 pl ON pl.ItemCode = o.ItemCode
WHERE o.OnHand =1  AND pl.PriceList = 10
-------------------------------------------------------------

---PROVEEDORES---
Select CardCode,CardName
FROM OCRD
-----------------------

--Categoria--------
Select ItmsGrpCod,ItmsGrpNam
From OITB
--------------

-----------Facturas-----------------------

SELECT 
c.DocDate as "Fecha",
e.DocNum as "Documento",
c.ItemCode as "SKU",
c.Dscription as "Descripcion",
c.Quantity as "Cantidad",
c.LineTotal as "Valor Linea",
e.CardName as "Cliente",
nv.SlpName as "Nombre Vendedor"
from INV1 c 
INNER JOIN OINV e on c.DocEntry = e.DocEntry
INNER JOIN OSLP nv ON nv.SlpCode = e.SlpCode
WHERE e.DocDate BETWEEN CONVERT(date,GETDATE()-60)  AND CONVERT(date,GETDATE()-1) AND c.ItemCode NOT LIKE 'F%' AND e.Series = 108
ORDER BY c.DocDate DESC

------------------------------


-----Entradas------------------

SELECT
T0.DocDate AS 'Fecha',
T0.DocNum AS 'Num de documento',
T1.Dscription AS 'Descripcion',
T1.ItemCode AS 'SKU',
T1.Quantity As 'Cantidad',
T1.Price AS 'Precio', T0.CardName
FROM OPDN T0
INNER JOIN PDN1 T1 ON T1.DocEntry = T0.DocEntry
WHERE t0.DocDate >= CONVERT(date,GETDATE()-180)



-----OV-----
SELECT
c.DocDate,c.DocEntry,c.ItemCode,c.Dscription,c.Quantity,e.CardName
from RDR1 c
INNER JOIN ORDR e ON e.DocEntry = c.DocEntry
WHERE c.DocDate >= CONVERT(date,GETDATE()-1) 


------------




AND ItemCode BETWEEN 9073 AND 9074



-------

SELECT 
c.DocDate as "Fecha",
e.DocNum as "Documento",
c.ItemCode as "SKU",
c.Dscription as "Descripcion",
c.Quantity as "Cantidad",
c.LineTotal as "Valor Linea",
e.CardName as "Cliente",
nv.SlpName as "Nombre Vendedor",
e.Series
from INV1 c 
INNER JOIN OINV e on c.DocEntry = e.DocEntry
INNER JOIN OSLP nv ON nv.SlpCode = e.SlpCode
WHERE e.DocDate BETWEEN CONVERT(date,GETDATE()-15)  AND CONVERT(date,GETDATE()-1) AND c.ItemCode NOT LIKE 'F%' 
ORDER BY c.DocDate DESC


SELECT 
c.DocDate as "Fecha",
e.DocNum as "Documento",
c.ItemCode as "SKU",
c.Dscription as "Descripcion",
c.Quantity as "Cantidad",
c.LineTotal as "Valor Linea",
e.CardName as "Cliente",
e.Series,
e.FolSeries
from INV1 c 
INNER JOIN OINV e on c.DocEntry = e.DocEntry
WHERE e.DocDate BETWEEN '01/01/2021' AND '09/30/2021' AND c.ItemCode = '35719'





SELECT
T0.ITEMCODE AS 'Codigo',
T0.ITEMNAME AS 'Descripcion',
T0.OnHand AS 'Existencia',
T1.PriceList AS 'Listas',
T1.Price as 'Precio'
FROM OITM T0
INNER JOIN ITM1 T1 ON T0.ItemCode = T1.ItemCode
Where T1.PriceList <= 10 AND T0.OnHand >= 1





Select * 
from OPLN


Select o.ListName, i.ItemCode,i.Price
from ITM1 i
INNER JOIN OPLN o ON i.PriceList = o.ListNum
WHERE i.ItemCode = '35720' 


Select o.ListName, i.ItemCode,i.Price
from ITM1 i
INNER JOIN OPLN o ON i.PriceList = o.ListNum
WHERE i.ItemCode = '35719' 






SELECT 
T0.ITEMCODE AS 'Codigo',
T0.ITEMNAME AS 'Descripcion',
T0.OnHand AS 'Existencia',
T1.PriceList AS 'Listas',
T1.[Price] as 'Precio'
FROM OITM T0
INNER JOIN ITM1 T1 ON T0.ItemCode = T1.ItemCode
Where T0.ItemCode = '35719'