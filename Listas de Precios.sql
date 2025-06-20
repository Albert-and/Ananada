

SELECT T0.[ItemCode]as codigo,
------T0.[ItemName] as Descripcion,
T0.[OnHand]as existencia,
T0.InvNtryuom as UM,
T1.[Price] AS 'Lista01' ,
T2.PRICE as 'Lista02',
T3.PRICE as 'Lista03'
FROM OITM T0  
	INNER JOIN ITM1 T1 ON T0.ItemCode = T1.ItemCode AND T1.PRICELIST = 1  
	INNER JOIN ITM1 T2 ON T0.ITEMCODE = T2.ITEMCODE AND T2.PRICELIST = 2
	INNER JOIN ITM1 T3 ON T0.ITEMCODE = T3.ITEMCODE AND T2.PRICELIST = 3





	SELECT T0.[ItemCode], T0.[ItemName], T1.[Price] FROM OITM T0
	INNER JOIN ITM1 T1 ON T0.ItemCode = T1.ItemCode
	INNER JOIN OPLN T2 ON T1.PriceList = T2.ListNum WHERE  T2.[ListName] = 'LAutCHPar' 
	OR T2.[ListName] = 'Costo'




SELECT T0.[ItemCode],
T0.[ItemName],
T0.[AvgPrice],
T1.[Price]
FROM OITM T0
INNER JOIN ITM1 T1 ON T0.ItemCode = T1.ItemCode
INNER JOIN OPLN T2 ON T1.PriceList = T2.ListNum
INNER JOIN OPLN T3 ON T1.PriceList = T3.ListNum


SELECT 
T0.ITEMCODE AS 'Codigo',
T0.ITEMNAME AS 'Descripcion',
T0.OnHand AS 'Existencia',
T1.PriceList AS 'Listas',
T1.[Price] as 'Precio'
FROM OITM T0
INNER JOIN ITM1 T1 ON T0.ItemCode = T1.ItemCode
Where T1.PriceList <= 10 AND T0.OnHand >= 1 


AND ItemCode


SELECT top(100)*
FROM ITM1

