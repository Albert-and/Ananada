



  Select
  E.DocNum,
  e.DocDate,
  e.OwnerCode,
  c.ItemCode,
  c.Quantity,
  c.LineTotal,
  e.CardCode,
  c.OwnerCode
  FROM OPDN e
  INNER JOIN PDN1 c ON c.DocEntry = e.DocEntry
  WHERE E.DocDate >= '20210101'



Select SlpCode,SlpName
FROM OSLP


   Select
  c.ItemCode,e.DocDate, c.LineTotal,c.Quantity,e.CardCode
  FROM OPDN e
  INNER JOIN PDN1 c ON c.DocEntry = e.DocEntry



select *
from OPLN



SELECT * from wtm2 T

WHERE T.WTMCode not IN (SELECT WTMCode FROM OWTM)




SELECT *
FROM OITG
WHERE ItmsGrpNam LIKE 'B%'