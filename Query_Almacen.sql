

select *
from OITM
where ItemCode = '37775'



SELECT OnHand as 'Stock', IsCommited as 'Comprometido', OnHand - IsCommited as 'Disponible'
FROM OITW
where ItemCode = '1001001' and WhsCode = 'alpc' AND WhsCode = 'alt'

-------Query Existencias-----------------
SELECT o.ItemCode,o.ItemName,s.OnHand as 'Stock', s.IsCommited as 'Comprometido', s.OnHand - s.IsCommited as 'Disponible',WhsCode
FROM OITW s
INNER JOIN OITM o ON s.ItemCode = o.ItemCode
WHERE  WhsCode = 'ALPC' OR WhsCode = 'ALPC' AND s.OnHand >= 1


SELECT o.ItemCode,o.ItemName,s.OnHand as 'Stock', s.IsCommited as 'Comprometido',
s.OnHand - s.IsCommited as 'Disponible'
 FROM OITW
INNER JOIN OITM o ON s.ItemCode = o.ItemCode
WHERE  WhsCode = 'alpc'



------------------------
SELECT o.ItemCode,o.ItemName,s.OnHand as 'Stock', s.IsCommited as 'Comprometido', s.OnHand - s.IsCommited as 'Disponible'
FROM OITW s
INNER JOIN OITM o ON s.ItemCode = o.ItemCode
WHERE  WhsCode = 'ALPM' AND WhsCode = 'alr'

--------------------------------


select *
from OITG



select ItemCode,ItemName,QryGroup1
where ItemCode = '1001001'



select *
from OITM
where ItemCode = '37777'


select ItemCode,ItemName,ItemClass,ItemType,ObjType
from OITM
where ItemCode = '37775'

select *
from opln


select *
from OITM
where ItemCode = '37777'


SELECT T0.[ItemCode]as codigo, T0.[ItemName] as Descripcion, T0.[OnHand]as existencia, t0.InvNtryuom as UM, T0.[AvgPrice] as costo, T1.[Price] AS 'Precio Base' , T2.PRICE as 'Precio minimo',T0.[LastPurPrc]as 'ultimo precio de compra', T0.[LastPurDat]'fecha ultima compra'
FROM OITM T0  
	INNER JOIN ITM1 T1 ON T0.ItemCode = T1.ItemCode AND T1.PRICELIST = 1  
	INNER JOIN ITM1 T2 ON T0.ITEMCODE = T2.ITEMCODE AND T2.PRICELIST = 2



	SELECT T0.[ItemCode], T0.[ItemName], T1.[Price] FROM OITM T0
	INNER JOIN ITM1 T1 ON T0.ItemCode = T1.ItemCode
	INNER JOIN OPLN T2 ON T1.PriceList = T2.ListNum WHERE  T2.[ListName] = 'LAutCHPar' 
	OR T2.[ListName] = 'Costo'

	---------------------------------------------
SELECT T0.[DocNum][Número de Orden],
 T1.[ItemCode][Código Artículo],
 T1.[Dscription][Descripcón], 
 T1.Quantity AS "CANTIDAD"
FROM OPOR T0  
INNER JOIN POR1 T1 ON T0.[DocEntry] = T1.[DocEntry]
INNER JOIN OITM T3 ON T1.ItemCode = T3.ItemCode
WHERE T0.DocDate = CONVERT(DATE, GETDATE()-5)


-------------------

SELECT OnHand as 'Stock',
IsCommited as 'Comprometido',
OnHand - IsCommited as 'Disponible'
FROM OITW

select ItemCode AS "Clave",
ItemName AS "Nombre",
OnHand AS "Disponible",
AvgPrice AS "Precio Promedio",
SalPackUn AS "Inner"
from OITM



SELECT *
FROM OITM
Where ItemCode = '1001015'


select TOP(100)*
FROM OWHS




select OnHand,IsCommited,OnOrder,AvgPrice
from OITW
WHERE WhsCode = 'ALPC'


select o.ItemCode AS "Clave",
o.ItemName AS "Nombre",
o.OnHand AS "Disponible",
o.AvgPrice AS "Precio Promedio",
o.SalPackUn AS "Inner",
t.OnHand AS "Disponible_ALPC",
t.IsCommited AS "Comprometido_ALPC",
t.OnOrder AS "Pedido_ALPC",
t.AvgPrice AS "PP_ALPC",
o.SWW AS "Ubicacion",
t.WhsCode AS "ALMACEN"
from OITM o 
INNER JOIN OITW t ON o.ItemCode = t.ItemCode
Where t.WhsCode = 'ALPC'
-----------------------------------------------------
select o.ItemCode AS "Clave",
o.ItemName AS "Nombre",
o.OnHand AS "Disponible",
o.AvgPrice AS "Precio Promedio",
o.SalPackUn AS "Inner",
t.OnHand AS "Disponible_ALPC",
t.IsCommited AS "Comprometido_ALPC",
t.OnOrder AS "Pedido_ALPC",
t.AvgPrice AS "PP_ALPC",
o.SWW AS "Ubicacion",
t.WhsCode AS "ALMACEN"
from OITM o 
INNER JOIN OITW t ON o.ItemCode = t.ItemCode
Where t.WhsCode = 'ALPM'



-----------


select o.ItemCode AS "Clave",
o.ItemName AS "Nombre",
o.OnHand AS "Disponible",
o.AvgPrice AS "Precio Promedio",
o.SalPackUn AS "Inner",
t.OnHand AS "Disponible_ALPC",
t.IsCommited AS "Comprometido_ALPC",
t.OnOrder AS "Pedido_ALPC",
t.AvgPrice AS "PP_ALPC",
o.SWW AS "Ubicacion",
t.WhsCode AS "ALMACEN"
from OITM o 
INNER JOIN OITW t ON o.ItemCode = t.ItemCode
Where o.ItemCode = '10635'

------------------------------


SELECT T0.[ItemCode],
Cast (T1.[ItemName] as Varchar(60)) 'Nombre del artículo' ,
T0.[BinAbs] ID_Interno,
T2.[BinCode],
T0.[WhsCode] Almacen,
T0.[OnHandQty] 'Stock en Ubicación'
FROM OIBQ T0
INNER JOIN OITM T1 ON T0.[ItemCode] = T1.[ItemCode]
INNER JOIN OBIN T2 ON T0.[BinAbs] = T2.[AbsEntry]
INNER JOIN OITW T3 ON T0.[ItemCode]=T3.[ItemCode] and T0.[WhsCode]=T3.[WhsCode]
WHERE T0.[WhsCode] ='ALPC' 

---------------Almacen Mayoreo con Existencias------------

SELECT o.ItemCode,
o.ItemName,
s.OnHand as 'Stock',
s.IsCommited as 'Comprometido',
s.OnHand - s.IsCommited as 'Disponible',
s.WhsCode
FROM OITW s
INNER JOIN OITM o ON s.ItemCode = o.ItemCode
WHERE  s.WhsCode = 'ALPM' AND s.OnHand - s.IsCommited > 0
order by o.ItemCode












select *
FROM OBIN
Where AbsEntry = '10635'


select *
FROM rbIN

50005