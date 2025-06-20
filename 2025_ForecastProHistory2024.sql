




WITH CTE_MonthlyData AS (
    SELECT
        d.ItemCode AS product_id,
        FORMAT(c.DocDate, 'yyyy-MM') AS order_month, -- Extrae el año y mes de la fecha
        SUM(d.Quantity) AS total_quantity_requested -- Suma las cantidades por mes
    FROM 
        OINV c
    INNER JOIN 
        INV1 d 
    ON 
        c.DocEntry = d.DocEntry
    WHERE 
        d.ItemCode NOT LIKE 'FL%' -- Excluye productos que comienzan con 'FL'
        AND d.ItemCode NOT LIKE 'IN%' -- Excluye productos que comienzan con 'IN'
        AND d.ItemCode NOT LIKE 'F%' -- Excluye productos que comienzan con 'F'
        AND d.ItemCode NOT LIKE 'GA%' -- Excluye productos que comienzan con 'GA'
        AND d.ItemCode NOT LIKE 'PE%' -- Excluye productos que comienzan con 'PE'
        AND c.CANCELED <> 'Y' -- Excluye documentos cancelados
        AND c.Series IN (4, 116) -- Filtra por series específicas
        AND c.DocDate >= '2024-01-01' -- Filtra desde el 01/01/2024
        AND c.DocDate <= GETDATE() -- Hasta la fecha actual
    GROUP BY 
        d.ItemCode, FORMAT(c.DocDate, 'yyyy-MM')
)
SELECT *
FROM CTE_MonthlyData
PIVOT (
    SUM(total_quantity_requested) -- Agrega las cantidades
    FOR order_month IN (
        [2024-01], [2024-02], [2024-03], [2024-04], [2024-05], [2024-06], 
        [2024-07], [2024-08], [2024-09], [2024-10], [2024-11], [2024-12]
    )
) AS PivotTable
WHERE product_id IN (
    SELECT DISTINCT product_id
    FROM CTE_MonthlyData
    WHERE total_quantity_requested > 0 -- Filtra productos con ventas
)
ORDER BY product_id;

-------------------------



WITH CTE_MonthlyData AS (
    SELECT
        d.ItemCode AS product_id,
        FORMAT(c.DocDate, 'yyyy-MM') AS order_month, -- Extrae el año y mes de la fecha
        SUM(d.Quantity) AS total_quantity_requested, -- Suma las cantidades por mes
        o.CardCode AS customer_code, -- Código del cliente
        o.CardName AS customer_name, -- Nombre del cliente
        i.ItemName AS item_name, -- Nombre del artículo
        b.ItmsGrpNam AS item_group -- Grupo de artículos
    FROM 
        OINV c
    INNER JOIN 
        INV1 d 
    ON 
        c.DocEntry = d.DocEntry
    INNER JOIN 
        OITM i
    ON 
        d.ItemCode = i.ItemCode
    INNER JOIN 
        OITB b
    ON 
        i.ItmsGrpCod = b.ItmsGrpCod
    INNER JOIN 
        OCRD o
    ON 
        c.CardCode = o.CardCode
    WHERE 
        d.ItemCode NOT LIKE 'FL%' -- Excluye productos que comienzan con 'FL'
        AND d.ItemCode NOT LIKE 'IN%' -- Excluye productos que comienzan con 'IN'
        AND d.ItemCode NOT LIKE 'F%' -- Excluye productos que comienzan con 'F'
        AND d.ItemCode NOT LIKE 'GA%' -- Excluye productos que comienzan con 'GA'
        AND d.ItemCode NOT LIKE 'PE%' -- Excluye productos que comienzan con 'PE'
        AND c.CANCELED <> 'Y' -- Excluye documentos cancelados
        AND c.Series IN (4, 116) -- Filtra por series específicas
        AND c.DocDate >= '2024-01-01' -- Filtra desde el 01/01/2024
        AND c.DocDate <= GETDATE() -- Hasta la fecha actual
    GROUP BY 
        d.ItemCode, FORMAT(c.DocDate, 'yyyy-MM'), o.CardCode, o.CardName, i.ItemName, b.ItmsGrpNam
)
SELECT 
    product_id,
    customer_code,
    customer_name,
    item_name,
    item_group,
    [2024-01], [2024-02], [2024-03], [2024-04], [2024-05], [2024-06], 
    [2024-07], [2024-08], [2024-09], [2024-10], [2024-11], [2024-12]
FROM CTE_MonthlyData
PIVOT (
    SUM(total_quantity_requested) -- Agrega las cantidades
    FOR order_month IN (
        [2024-01], [2024-02], [2024-03], [2024-04], [2024-05], [2024-06], 
        [2024-07], [2024-08], [2024-09], [2024-10], [2024-11], [2024-12]
    )
) AS PivotTable
WHERE product_id IN (
    SELECT DISTINCT product_id
    FROM CTE_MonthlyData
    WHERE total_quantity_requested > 0 -- Filtra productos con ventas
)
ORDER BY product_id;




------------




WITH CTE_MonthlyData AS (
    SELECT
        d.ItemCode AS product_id, -- Código del producto
        o.CardCode AS customer_code, -- Código del cliente
        o.CardName AS customer_name, -- Nombre del cliente
        i.ItemName AS item_name, -- Nombre del artículo
        b.ItmsGrpNam AS item_group, -- Grupo de artículos
        FORMAT(c.DocDate, 'yyyy-MM') AS order_month, -- Extrae el año y mes de la fecha
        SUM(d.Quantity) AS total_quantity_requested -- Suma las cantidades por mes
    FROM 
        OINV c
    INNER JOIN 
        INV1 d 
    ON 
        c.DocEntry = d.DocEntry
    INNER JOIN 
        OITM i
    ON 
        d.ItemCode = i.ItemCode
    INNER JOIN 
        OITB b
    ON 
        i.ItmsGrpCod = b.ItmsGrpCod
    INNER JOIN 
        OCRD o
    ON 
        c.CardCode = o.CardCode
    WHERE 
        d.ItemCode NOT LIKE 'FL%' -- Excluye productos que comienzan con 'FL'
        AND d.ItemCode NOT LIKE 'IN%' -- Excluye productos que comienzan con 'IN'
        AND d.ItemCode NOT LIKE 'F%' -- Excluye productos que comienzan con 'F'
        AND d.ItemCode NOT LIKE 'GA%' -- Excluye productos que comienzan con 'GA'
        AND d.ItemCode NOT LIKE 'PE%' -- Excluye productos que comienzan con 'PE'
        AND c.CANCELED <> 'Y' -- Excluye documentos cancelados
        AND c.Series IN (4, 116) -- Filtra por series específicas
        AND c.DocDate >= '2024-01-01' -- Filtra desde el 01/01/2024
        AND c.DocDate <= GETDATE() -- Hasta la fecha actual
    GROUP BY 
        d.ItemCode, o.CardCode, o.CardName, i.ItemName, b.ItmsGrpNam, FORMAT(c.DocDate, 'yyyy-MM')
)
SELECT 
    product_id, -- Código del producto
    customer_code, -- Código del cliente
    customer_name, -- Nombre del cliente
    item_name, -- Nombre del artículo
    item_group, -- Grupo del artículo
    [2024-01], [2024-02], [2024-03], [2024-04], [2024-05], [2024-06], 
    [2024-07], [2024-08], [2024-09], [2024-10], [2024-11], [2024-12]
FROM CTE_MonthlyData
PIVOT (
    SUM(total_quantity_requested) -- Agrega las cantidades
    FOR order_month IN (
        [2024-01], [2024-02], [2024-03], [2024-04], [2024-05], [2024-06], 
        [2024-07], [2024-08], [2024-09], [2024-10], [2024-11], [2024-12]
    )
) AS PivotTable
WHERE product_id IN (
    SELECT DISTINCT product_id
    FROM CTE_MonthlyData
    WHERE total_quantity_requested > 0 -- Filtra productos con ventas
)
ORDER BY product_id, customer_code;