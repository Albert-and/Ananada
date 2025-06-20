SELECT *
  FROM [IV_Desarrollos].[dbo].[OrdenesVenta_Cab]


USE IV_Desarrollos

SELECT f.CodigoCliente,f.CodigoArticulo,f.Cantidad,f.PrecioUnitario,f.FechaRegistro,
        o.CodigoCliente,o.Comentarios,o.DocEntry,f.ParentID,o.Estatus,o.Factura
  FROM ProductoFaltante f
  INNER JOIN OrdenesVenta_Cab o ON f.ParentID = o.AI
WHERE f.ParentID = '81915'




USE ANANDA_BD

Select o.CardCode,o.DocDate,o.DocNum,o.U_IV_EC_IdDocumento,
f.CodigoArticulo,f.Cantidad,f.PrecioUnitario
FROM ANANDA_BD.dbo.ORDR o
INNER JOIN [IV_Desarrollos].dbo.ProductoFaltante f ON f.ParentID = o.U_IV_EC_IdDocumento
WHERE f.Cantidad > 0



AND o.DocDate > '01012022'



WHERE CardCode = '124520'