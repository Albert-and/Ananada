


SELECT
Ref1 as 'Solicitud de Traslado',
DocNum as 'Id Traslado',
FORMAT(e.DocDate,'dd/MM/yyyy') as DocDate,
---CardCode as 'Codigo Cliente',
--CardName as 'Nombre Cliente',
e.Filler as 'Almacen Origen',
e.ToWhsCode as 'Almacen Destino',
d.ItemCode as 'SKU',
d.Dscription as 'Descripcion',
d.Quantity as 'Cantidad',
f.RefDocEntr,
f.RefDocNum
FROM OWTR e
INNER JOIN WTR1 d ON e.DocEntry = d.DocEntry
INNER JOIN WTR21 f ON e.DocEntry = f.DocEntry
wHERE DocNum = 100000003




SELECT
    e.Ref1 AS 'Solicitud de Traslado',
    e.DocNum AS 'Id Traslado',
    FORMAT(e.DocDate, 'dd/MM/yyyy') AS 'DocDate',
    e.Filler AS 'Almacen Origen',
    e.ToWhsCode AS 'Almacen Destino',
    d.ItemCode AS 'SKU',
    d.Dscription AS 'Descripcion',
    d.Quantity AS 'Cantidad',
    f.RefDocEntr,
    f.RefDocNum,
    f.RefObjType 
FROM OWTR e
LEFT JOIN WTR1 d ON e.DocEntry = d.DocEntry
LEFT JOIN WTR21 f ON e.DocEntry = f.DocEntry
wHERE e.DocNum = 100000003



SELECT
    e.Ref1 AS 'Solicitud de Traslado',
    e.DocNum AS 'Id Traslado',
    FORMAT(e.DocDate, 'dd/MM/yyyy') AS 'DocDate',
    e.Filler AS 'Almacen Origen',
    e.ToWhsCode AS 'Almacen Destino',
    d.ItemCode AS 'SKU',
    d.Dscription AS 'Descripcion',
    d.Quantity AS 'Cantidad',
    f.RefDocEntr,
    f.RefDocNum,
    f.RefObjType 
FROM OWTR e
LEFT JOIN WTR1 d ON e.DocEntry = d.DocEntry
LEFT JOIN WTR21 f ON e.DocEntry = f.DocEntry
wHERE f.RefObjType = 20 AND e.DocNum = 100000003


-----Query Validado de referencia de documento-----

SELECT
    e.Ref1 AS 'Solicitud de Traslado',
    e.DocNum AS 'Id Traslado',
    FORMAT(e.DocDate, 'dd/MM/yyyy') AS 'DocDate',
    e.Filler AS 'Almacen Origen',
    e.ToWhsCode AS 'Almacen Destino',
    d.ItemCode AS 'SKU',
    d.Dscription AS 'Descripcion',
    d.Quantity AS 'Cantidad',
    f.RefDocNum as 'Documento Relacionado'
FROM OWTR e
LEFT JOIN WTR1 d ON e.DocEntry = d.DocEntry
LEFT JOIN WTR21 f ON e.DocEntry = f.DocEntry AND f.RefObjType = 20
WHERE f.RefDocNum IS NOT NULL

-----------------




SELECT
e.DocNum,
e.DocEntry,
d.DocEntry
FROM OPOR e
INNER JOIN POR1 d ON e.DocEntry = d.DocEntry
WHERE e.DocNum = 100000001