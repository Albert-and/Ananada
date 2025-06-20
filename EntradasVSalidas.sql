


----Entradas -----
SELECT o.DocNum,
o.DocDate,
p.ItemCode,
p.Dscription,
p.Quantity
FROM OPDN o
INNER JOIN PDN1 p ON o.DocEntry = p.DocEntry
WHERE o.DocDate >= '01/01/2021'

---Entrega---

Select o.DocNum,
o.DocDate,
d.ItemCode,
d.Dscription,
d.Quantity
from DLN1 d
INNER JOIN ODLN o ON d.DocEntry = o.DocEntry
WHERE o.DocDate >= '01/01/2021'






Select d.DocEntry,d.ShipDate,d.ItemCode,d.Dscription,d.Quantity
from DLN1 d
WHERE d.ShipDate >= '08/01/2021'


Select o.DocEntry,o.DocNum,o.DocDate,
from ODLN o