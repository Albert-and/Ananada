


select 
w.ItemCode as "SKU",
w.Dscription as "Descripción",
w.Quantity as "Cantidad",
w.DocDate AS "Fecha",
o.ToWhsCode AS "Almacen destino"
from WTR1 w
INNER JOIN OWTR o ON o.DocEntry = w.DocEntry
Where o.ToWhsCode ='ALPC' AND w.DocDate >= '01/01/2021'
ORDER BY w.DocDate desc



