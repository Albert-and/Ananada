.





SELECT DISTINCT T0.DocEntry [No. Interno], T0.DocNum [No. Factura],
T0.DocDate [Fecha], T0.CardCode [Cliente], T0.CardName [Nombre], T0.DocTotal [Total Facturado],
T0.DocStatus [Estatus de Documento], T2.SlpName [Vendedor]
FROM OINV T0 
LEFT JOIN OSLP T2 ON T0.SlpCode = T2.SlpCode
WHERE T0.SERIES <> '75' AND T0.CANCELED = 'N' AND t0.DocDate >= '01/01/2021' AND T2.SlpName = 'Maria Elena Juarez Cerna'
group by T0.DocEntry , T0.DocNum ,
T0.DocDate , T0.CardCode, T0.CardName , T0.DocTotal ,
T0.DocStatus , T2.SlpName







Select TOP(10)*
from ORDR




Select DocNum,DocDate,CardCode,CardName,DocTotal
from ORDR 
Where SlpCode = '38' AND DocDate >= '01/01/2021'
