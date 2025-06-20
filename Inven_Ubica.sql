

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

SELECT T0.[ItemCode],
Cast (T1.[ItemName] as Varchar(60)) 'Nombre del artículo' ,
T0.[BinAbs] ID_Interno,
T2.[BinCode] AS "Ubicacion",
T0.[WhsCode] Almacen,
T0.[OnHandQty] 'Stock en Ubicación'
FROM OIBQ T0
INNER JOIN OITM T1 ON T0.[ItemCode] = T1.[ItemCode]
INNER JOIN OBIN T2 ON T0.[BinAbs] = T2.[AbsEntry]
INNER JOIN OITW T3 ON T0.[ItemCode]=T3.[ItemCode] and T0.[WhsCode]=T3.[WhsCode]
WHERE T0.[WhsCode] ='ALPM' 


SELECT T0.[ItemCode],
Cast (T1.[ItemName] as Varchar(60)) 'Nombre del artículo' ,
----T0.[BinAbs] ID_Interno,
T2.[BinCode] AS "Ubicacion",
T0.[WhsCode] Almacen
----T0.[OnHandQty] 'Stock en Ubicación'
FROM OIBQ T0
INNER JOIN OITM T1 ON T0.[ItemCode] = T1.[ItemCode]
INNER JOIN OBIN T2 ON T0.[BinAbs] = T2.[AbsEntry]
INNER JOIN OITW T3 ON T0.[ItemCode]=T3.[ItemCode] and T0.[WhsCode]=T3.[WhsCode]
WHERE T0.[WhsCode] ='ALPC' 

--------------------
SELECT T0.[ItemCode],
Cast (T1.[ItemName] as Varchar(60)) 'Nombre del artículo' ,
T2.[BinCode] AS "Ubicacion",
T0.[WhsCode] Almacen,
T0.OnHandQty
FROM OIBQ T0
INNER JOIN OITM T1 ON T0.[ItemCode] = T1.[ItemCode]
INNER JOIN OBIN T2 ON T0.[BinAbs] = T2.[AbsEntry]
INNER JOIN OITW T3 ON T0.[ItemCode]=T3.[ItemCode] and T0.[WhsCode]=T3.[WhsCode]
WHERE T0.[WhsCode] ='ALPM' 
----------------------------

select o.ItemCode AS "Clave",
o.ItemName AS "Nombre",
o.OnHand AS "Disponible",
o.AvgPrice AS "Precio Promedio",
o.SalPackUn AS "Inner",
t.OnHand AS "Disponible_ALPM",
t.IsCommited AS "Comprometido_ALPM",
t.OnOrder AS "Pedido_ALPM",
t.AvgPrice AS "PP_ALPM",
o.SWW AS "Ubicacion",
t.WhsCode AS "ALMACEN"
from OITM o 
INNER JOIN OITW t ON o.ItemCode = t.ItemCode
Where t.WhsCode = 'ALPM'
-----------------------------------------


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
------------------

SELECT T0.[ItemCode],
Cast (T1.[ItemName] as Varchar(60)) 'Nombre del artículo' ,
T2.[BinCode] AS "Ubicacion",
T0.[WhsCode] Almacen
FROM OIBQ T0
INNER JOIN OITM T1 ON T0.[ItemCode] = T1.[ItemCode]
INNER JOIN OBIN T2 ON T0.[BinAbs] = T2.[AbsEntry]
INNER JOIN OITW T3 ON T0.[ItemCode]=T3.[ItemCode] and T0.[WhsCode]=T3.[WhsCode]
WHERE T0.[WhsCode] ='ALPC' 
------------------------------------




select TOP(10)*
FROM OITW 







and T3.[DftBinEnfd] ='Y'
ORDER BY T0.[ItemCode]