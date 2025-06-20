SELECT T0.[DocNum]
FROM OPDN T0
INNER JOIN PDN1 T1 ON T0.[DocEntry] = T1.[DocEntry]
WHERE T0.CreateDate  = CONVERT (date,GETDATE())
and T1.[WhsCode] = 'ALT'

SELECT T0.[DocNum]
FROM OPDN T0
INNER JOIN PDN1 T1 ON T0.[DocEntry] = T1.[DocEntry]
WHERE CONVERT (date,T0.CreateDate) = CONVERT (date,GETDATE())
and T1.[WhsCode] = 'ALT'


----ALMACEN DE TRANSITO


SELECT DISTINCT DocNum, Comments, JrnlMemo, UpdateDate,Filler
FROM OWTR
WHERE DocDate = CONVERT(DATE, GETDATE()) AND Filler = 'ALR'



select *
from OWTR
where DocDate = '05/06/2021'
