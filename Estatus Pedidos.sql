




SELECT U_IV_MAG_IdOferta AS "ID_Magento",
DocNum as "Pedido",
DocDate AS "Fecha",
CardCode AS "Cliente",
CardName AS "Nombre Cliente",
Address AS "Direccion",
DocTotal AS "Total",
U_EstatusOV AS "Estatus",
SlpCode
from ORDR
Where DocDate BETWEEN CONVERT(DATE, GETDATE()-3) AND CONVERT(DATE, GETDATE())
ORDER BY DocDate desc



SELECT U_IV_MAG_IdOferta AS "ID_Magento",
DocNum as "Pedido",
DocDate AS "Fecha",
CardCode AS "Cliente",
CardName AS "Nombre Cliente",
Address AS "Direccion",
DocTotal AS "Total",
U_EstatusOV AS "Estatus"
FROM ODLN
Where DocDate >= '08/01/2021'


select SlpCode,SlpName
from OSLP


Select DocNum,Series
from ORDR
Where DocNum = 620154

Series = 73


----------------------------------------------------------------------------------
Select DocNum, CardCode, CardName, NumAtCard, DocDate, U_EstatusOV,SlpCode
From ORDR
Where DocDate BETWEEN CONVERT(DATE, GETDATE()-3) AND CONVERT(DATE, GETDATE()) AND Series = 73  
-----------------------------------------------------------------------------------
select SlpCode,SlpName
from OSLP
--------------------------------

Select o.DocNum, o.CardCode, o.CardName, o.NumAtCard, o.DocDate, o.U_EstatusOV,p.SlpName
From ORDR o
INNER JOIN OSLP p ON o.SlpCode = p.SlpCode
Where o.DocDate BETWEEN CONVERT(DATE, GETDATE()-3) AND CONVERT(DATE, GETDATE()) AND o.Series = 73  



---------------

select o.DocNum, o.CardCode, o.CardName, o.NumAtCard, o.DocDate, o.U_EstatusOV,p.SlpName
from OINV o
INNER JOIN OSLP p ON o.SlpCode = p.SlpCode
Where o.DocDate BETWEEN CONVERT(DATE, GETDATE()-3) AND CONVERT(DATE, GETDATE()) AND o.Series = 73  

-----------------


Select o.DocNum AS "Factura", o.CardCode AS "No. Cliente", o.CardName AS "Nombre Cliente", o.DocDate as "Fecha",p.SlpName
from OINV o
INNER JOIN OSLP p ON o.SlpCode = p.SlpCode
where o.DocDate BETWEEN CONVERT(DATE, GETDATE()-3) AND CONVERT(DATE, GETDATE()) 