



SElect TOP(10)*
from POR1





Select ShipDate AS "Fecha",
ItemCode as "SKU",
Dscription AS "Descripcion",
Quantity AS "No.Piezas",
Price AS "Precio"
from POR1
Where OcrCode = 02 AND ShipDate >= '01/01/2021'
ORDER BY ShipDate desc





SELECT TOP (10)*
FROM WTR1

SELECT ShipDate AS "Fecha",
ItemCode as "SKU",
Dscription AS "Descripcion",
Quantity AS "No.Piezas",
Price AS "Precio",
WhsCode AS "Almacen Destino"
FROM WTR1
where WhsCode = 'ALPC' AND ShipDate >= '01/01/2021'
ORDER BY ShipDate desc



SELECT * FROM OPLN