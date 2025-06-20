SELECT
    e.Code AS 'Código Producto',
    e.Name AS 'Nombre Producto',
    d.Code AS 'Código Componente',
    d.ItemName AS 'Nombre Componente',
    d.Quantity AS 'Cantidad Componente'
FROM 
    OITT e
INNER JOIN 
    ITT1 d ON e.Code = d.Father
WHERE 
    e.CreateDate = CONVERT(DATE, '2025-03-31', 120);