



SELECT 
    o.CardCode,
    o.DocDate,
    o.DocNum,
    o.U_IV_EC_IdDocumento,
    f.CodigoArticulo,
    f.Cantidad,
    f.PrecioUnitario
FROM 
    ANANDA_MAYOREO.dbo.ORDR o
INNER JOIN 
    [IV_Desarrollos].dbo.ProductoFaltante f 
    ON f.ParentID = o.U_IV_EC_IdDocumento
WHERE 
    f.Cantidad > 0
    AND f.CodigoArticulo NOT IN
     (
    '22199',
    '22200',
    '22192',
    '20079',
    '35501',
    '35502',
    '34441',
    '40146',
    '40150',
    '34108',
    '5911',
    '5910',
    '10804',
    '10877',
    '10805',
    '21803',
    '22191',
    '40147',
    '35504',
    '22203',
    '35506',
    '22201',
    '10803',
    '19552',
    '17975',
    '9511'
    )  -- Add the product codes you want to exclude
