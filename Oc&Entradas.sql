SELECT
ee.CardCode AS 'Proveedor',
oc.DocNum AS 'OC',
ee.DocNum as 'Entrada',
oc.DocDate AS 'Fecha Oc',
ee.DocDate AS 'Fecha Entrada',
oc.DocDueDate AS 'Fecha Entrega Solicitada',
ee.DocDueDate AS 'Fecha Real Entrada',
do.ItemCode As 'SKU OC',
ed.ItemCode AS 'SKU Entrada',
do.Quantity as 'Cantidad OC',
ed.Quantity AS 'Cantidad Entrada',
do.Price AS 'Precio OC', 
ed.Price AS 'Precio Entrada'
FROM OPOR oc
INNER JOIN POR1 do ON oc.DocEntry = do.DocEntry
INNER JOIN PDN1 ed ON do.DocEntry = ed.BaseEntry
AND do.LineNum= ed.BaseLine
INNER JOIN OPDN ee ON ed.DocEntry = ee.DocEntry
where oc.DocDate >= '20220101' AND oc.CANCELED = 'N'