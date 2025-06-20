SELECT 
    OITM.ItemCode AS 'Código de Producto',
    ItemName AS 'Nombre de Producto',
    PriceList AS 'Lista de Precios',
    Price AS 'Precio'
FROM 
    ITM1
JOIN 
    OITM ON ITM1.ItemCode = OITM.ItemCode
WHERE 
    OITM.ItemCode = '40040'