

SELECT *
FROM RDR1
WHERE DocDate = CONVERT(DATE, GETDATE())



SELECT TOP(10)*
FROM ORDR
WHERE DocDate = CONVERT(DATE, GETDATE())


SELECT r.DocNum as "Pedido",r.DocDate AS "Fecha",r.CardCode AS "Cliente",r.CardName AS "Nombre Cliente",r.Address AS "Direccion",r.DocTotal AS "Total",
o.DocTotal as "Total Entrega",r.U_EstatusOV AS "Estatus",o.U_IV_MAG_IdOferta
FROM ORDR r
right Join ODLN o ON r.CardCode = o.CardCode
WHERE r.DocDate = CONVERT(DATE, GETDATE()-5) OR r.DocDate = CONVERT(DATE, GETDATE())
ORDER BY r.DocDate Desc


SELECT TOP(10)o.DocNum,o.CardCode, r.U_IV_MAG_EstatusOferta, o.U_IV_MAG_EstatusOferta
from ODLN o
INNER JOIN ORDR r ON o.JrnlMemo = r.JrnlMemo
where o.DocNum = 616453


Select *
FROM ODLN
Where U_IV_MAG_IdOferta = 83775

SELECT *
from ORDR
Where U_IV_MAG_IdOferta = 83775
------------------------------------------------


SELECT r.DocNum as "Pedido",r.DocDate AS "Fecha",r.CardCode AS "Cliente",r.CardName AS "Nombre Cliente",r.Address AS "Direccion",r.DocTotal AS "Total",
o.DocTotal as "Total Entrega",r.U_EstatusOV AS "Estatus",o.U_IV_MAG_IdOferta
FROM ODLN r
INNER JOIN ORDR o ON r.U_IV_MAG_IdOferta = o.U_IV_MAG_IdOferta
WHERE o.DocDate = CONVERT(DATE, GETDATE())
ORDER BY o.DocDate desc
-----------------------------------

SELECT r.DocNum as "Pedido",r.DocDate AS "Fecha",r.CardCode AS "Cliente",r.CardName AS "Nombre Cliente",r.Address AS "Direccion",r.DocTotal AS "Total",
o.DocTotal as "Total Entrega",r.U_EstatusOV AS "Estatus",o.U_IV_MAG_IdOferta
FROM ODLN o
INNER JOIN ORDR r ON o.U_IV_MAG_IdOferta = r.U_IV_MAG_IdOferta
WHERE o.DocDate = CONVERT(DATE, GETDATE())
ORDER BY o.DocDate desc

--------------------------

SELECT U_IV_MAG_IdOferta AS "ID_Magento",
DocNum as "Pedido",
DocDate AS "Fecha",
CardCode AS "Cliente",
CardName AS "Nombre Cliente",
Address AS "Direccion",
DocTotal AS "Total",
U_EstatusOV AS "Estatus"
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
Where DocDate BETWEEN CONVERT(DATE, GETDATE()-3) AND CONVERT(DATE, GETDATE())

---------------------------------

SELECT o.DocNum as "Pedido",
o.DocDate AS "Fecha",
o.CardCode AS "Cliente",
o.CardName AS "Nombre Cliente",
o.Address AS "Direccion",
o.DocTotal AS "Total",
f.DocTotal AS "Total Entrega",
o.U_EstatusOV AS "Estatus",
o.U_IV_MAG_IdOferta AS "ID_Magento"
FROM ORDR o
INNER JOIN ODLN f ON f.U_IV_MAG_IdOferta = o.U_IV_MAG_IdOferta
Where f.DocDate BETWEEN CONVERT(DATE, GETDATE()-3) AND CONVERT(DATE, GETDATE())
ORDER BY f.DocDate desc







--------------------

SELECT DocNum as "Pedido",DocDate AS "Fecha",
CardCode AS "Cliente",
CardName AS "Nombre Cliente",
Address AS "Direccion",
DocTotal AS "Total",
U_EstatusOV AS "Estatus",
U_IV_MAG_IdOferta AS "ID_Magento"
FROM ORDR
Where DocDate BETWEEN CONVERT(DATE, GETDATE()-3) AND CONVERT(DATE, GETDATE())
ORDER BY DocDate desc
