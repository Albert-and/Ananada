




SELECT 
    T0.DocNum AS 'Número de Documento',
    T1.ItemCode AS 'Código de Artículo',
    T1.Dscription AS 'Descripción del Artículo',
    T1.Quantity AS 'Cantidad Solicitada',
    T2.NumInSale AS 'Cantidad por Empaque de Ventas'
FROM 
    ORDR T0 -- Cabecera de la Orden de Venta
    INNER JOIN RDR1 T1 ON T0.DocEntry = T1.DocEntry -- Detalle de la Orden de Venta
    INNER JOIN OITM T2 ON T1.ItemCode = T2.ItemCode -- Datos Maestros de Artículos
WHERE 
T0.DocDate = '20241217' AND
    T1.Quantity % T2.NumInSale <> 0 -- Verifica si la cantidad no es múltiplo del empaque de ventas
    AND T2.NumInSale > 0 -- Asegúrate de que el empaque de ventas esté configurado




SELECT 
    T0.DocNum AS 'Número de Documento',
    T1.ItemCode AS 'Código de Artículo',
    T1.Dscription AS 'Descripción del Artículo',
    T1.Quantity AS 'Cantidad Solicitada',
    T2.SalPackUn AS 'Cantidad por Empaque de Ventas'
FROM 
    ORDR T0 -- Cabecera de la Orden de Venta
    INNER JOIN RDR1 T1 ON T0.DocEntry = T1.DocEntry -- Detalle de la Orden de Venta
    INNER JOIN OITM T2 ON T1.ItemCode = T2.ItemCode -- Datos Maestros de Artículos
WHERE 
T0.DocDate = '20241217' AND
    T1.Quantity % T2.SalPackUn <> 0 -- Verifica si la cantidad no es múltiplo del empaque de ventas
    AND T2.SalPackUn > 0 -- Asegúrate de que el empaque de ventas esté configurado



SELECT  ItemCode, ItemName
FROM OITM
Where SalPackUn < 0