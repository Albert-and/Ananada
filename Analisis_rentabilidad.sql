



select * from OITM where ItemCode = '51038'


SELECT 
T0.ITEMCODE AS 'Codigo',
T0.ITEMNAME AS 'Descripcion',
T0.OnHand AS 'Existencia',
T1.PriceList AS 'Listas',
T1.[Price] as 'Precio'
FROM OITM T0
INNER JOIN ITM1 T1 ON T0.ItemCode = T1.ItemCode
Where T1.PriceList <= 10 AND t0.ItemCode = '51038'


select ItemCode,WhsCode,AvgPrice
from OITW
Where ItemCode = '51038'


select *
from WTR1
where ItemCode = '51038'

select DocEntry,ItemCode,Dscription,Quantity, Price,WhsCode
from RDR1
where ItemCode = '51038'
================================================================================

-----------Compra--------------
select DocEntry,ItemCode,Dscription,Quantity, Price,WhsCode, DocDate
from POR1
where ItemCode = '27180'
ORDER BY DocDate desc

---------------Recibo-----------
select DocEntry,ItemCode,Dscription,Quantity, Price,WhsCode
from PDN1
where ItemCode = '51038'

---------Movimientos de Almacen-------------
select DocEntry,ItemCode,Dscription,Quantity, Price,WhsCode
from RDR1
where ItemCode = '27180'

--------------------Venta (Entrega)-----------

select o.DocNum,r.DocEntry,r.ItemCode,r.Dscription,r.Quantity, r.Price,r.WhsCode,r.DocDate
from DLN1 r 
INNER JOIN ODLN o ON r.DocEntry = o.DocEntry
where r.ItemCode = '27180'
ORDER BY r.DocDate desc


                          

-------Precio del MA----------------
select ItemCode,WhsCode,AvgPrice
from OITW
Where ItemCode = '51038'

-----------------Listas de precios-----------------
SELECT 
T0.ITEMCODE AS 'Codigo',
T0.ITEMNAME AS 'Descripcion',
T0.OnHand AS 'Existencia',
T1.PriceList AS 'Listas',
T1.[Price] as 'Precio'
FROM OITM T0
INNER JOIN ITM1 T1 ON T0.ItemCode = T1.ItemCode
Where T1.PriceList <= 10 AND t0.ItemCode = '27180'


-------------Devolucion

select DocEntry,ItemCode,Dscription,Quantity, Price, DocDate
from RIN1
Where ItemCode = '51038'
--------------------





ELSE () = Create TBD
DocEntry,ItemCode,Dscription,Quantity, Price, DocDate

select * from OITM where ItemCode = '51038'