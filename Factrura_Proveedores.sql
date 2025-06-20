SELECT 
fc.DocNum AS "No. Factura",
fd.BaseEntry AS "No. Entrada",
fc.CardCode AS "Proveedor",
fc.Project AS "Proyecto",
fc.DocDate AS "Fecha Factura",
fc.DocDueDate AS "Fecha Vencimiento",
fd.ItemCode AS "SKU",
fd.Quantity AS "Cantidad",
fd.Price AS "Precio",
fd.OcrCode AS "Canal de Venta",
fd.OcrCode2 AS "Centro de Costos",
fd.U_Ultimopreciocompra AS "Precio LC",
fc.OwnerCode AS "Comprador"
FROM OPCH fc
INNER JOIN PCH1 fd ON fc.DocEntry = fd.DocEntry