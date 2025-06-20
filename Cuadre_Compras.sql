

-------------------------------------------OC--------------------------
SELECT o.DocNum,o.CardCode,o.CardName,p.ItemCode,p.Dscription, p.Quantity,p.Price,p.LineTotal,o.DocDate,CONCAT(o.DocNum,'-',p.ItemCode) AS "ID"
FROM OPOR o
INNER JOIN POR1 p ON o.DocEntry = p.DocEntry
WHERE o.DocDate >= '03/21/2021'



-------------------Entrada--------------------------
SELECT p.BaseRef,
o.DocDate,
p.ItemCode,
p.Quantity,
P.LineTotal,
CONCAT(p.BaseRef,'-',p.ItemCode) AS "ID2"
FROM OPDN o
INNER JOIN PDN1 p ON o.DocEntry = p.DocEntry
WHERE o.DocDate >= '03/21/2021'


--------------------------------

SELECT o.DocNum, o.DocEntry, o.CardCode,o.CardName,p.ItemCode,p.Dscription, p.Quantity,p.Price,p.LineTotal,p.Price,p.LineTotal
FROM OPOR o
INNER JOIN POR1 p ON o.DocEntry = p.DocEntry
INNER JOIN PDN1 x ON o.DocNum = x.BaseRef
Where o.DocNum = 102507
Order BY ItemCode desc


SELECT o.DocNum, o.DocEntry, o.CardCode,o.CardName,p.ItemCode,p.Dscription, p.Quantity,p.Price,p.LineTotal,p.Price,p.LineTotal
FROM OPOR o
INNER JOIN 



SELECT *
from POR1
where DocEntry = 5006


select * from PDN1 WHERE DocDate = '07/21/2021'