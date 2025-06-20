<<<<<<< HEAD





SELECT 
    ItemCode AS 'Código de Producto',
    ItemName AS 'Nombre de Producto',
    [1] AS 'Precio Lista 1',
    [2] AS 'Precio Lista 2',
    [3] AS 'Precio Lista 3',
    [4] AS 'Precio Lista 4',
    [5] AS 'Precio Lista 5',
    [6] AS 'Precio Lista 6',
    [7] AS 'Precio Lista 7',
    [8] AS 'Precio Lista 8',
    [9] AS 'Precio Lista 9',
    [10] AS 'Precio Lista 10',
    [11] AS 'Precio Lista 11',
    [12] AS 'Precio Lista 12',
    [13] AS 'Precio Lista 13',
    [14] AS 'Precio Lista 14',
    [15] AS 'Precio Lista 15',
    [16] AS 'Precio Lista 16'
FROM 
    (SELECT 
        OITM.ItemCode, 
        OITM.ItemName, 
        ITM1.PriceList, 
        ITM1.Price
     FROM 
        ITM1 
     JOIN 
        OITM ON ITM1.ItemCode = OITM.ItemCode) AS SourceTable
PIVOT
(
    MAX(Price)
    FOR PriceList IN ([1], [2], [3], [4], [5], [6], [7], [8],[9],
    [10], [11], [12], [13], [14], [15], [16])
) AS PivotTable


=======





SELECT 
    ItemCode AS 'Código de Producto',
    ItemName AS 'Nombre de Producto',
    [1] AS 'Precio Lista 1',
    [2] AS 'Precio Lista 2',
    [3] AS 'Precio Lista 3',
    [4] AS 'Precio Lista 4',
    [5] AS 'Precio Lista 5',
    [6] AS 'Precio Lista 6',
    [7] AS 'Precio Lista 7',
    [8] AS 'Precio Lista 8',
    [9] AS 'Precio Lista 9',
    [10] AS 'Precio Lista 10',
    [11] AS 'Precio Lista 11',
    [12] AS 'Precio Lista 12',
    [13] AS 'Precio Lista 13',
    [14] AS 'Precio Lista 14',
    [15] AS 'Precio Lista 15',
    [16] AS 'Precio Lista 16'
FROM 
    (SELECT 
        OITM.ItemCode, 
        OITM.ItemName, 
        ITM1.PriceList, 
        ITM1.Price
     FROM 
        ITM1 
     JOIN 
        OITM ON ITM1.ItemCode = OITM.ItemCode) AS SourceTable
PIVOT
(
    MAX(Price)
    FOR PriceList IN ([1], [2], [3], [4], [5], [6], [7], [8],[9],
    [10], [11], [12], [13], [14], [15], [16])
) AS PivotTable


>>>>>>> a84a4ce68ae780c85c754df6bd85d23338e1e163
