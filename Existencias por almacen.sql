


SELECT
ItemCode AS SKU,
CASE
    WHEN WhsCode = 'ALC' THEN 'Calidad y Desarrollo'
    WHEN WhsCode = 'ALCM' THEN 'Componentes Maquila'
    WHEN WhsCode = 'ALDC' THEN 'Devoluciones Clientes'
    WHEN WhsCode = 'ALDP' THEN 'Devoluciones Proveedores'
    WHEN WhsCode = 'ALEE' THEN 'Expos y Eventos'
    WHEN WhsCode = 'ALIN' THEN 'Insumos'
    WHEN WhsCode = 'ALM' THEN 'Merma'
    WHEN WhsCode = 'ALMQE' THEN 'Maquila Externa (WIP)'
    WHEN WhsCode = 'ALMQI' THEN 'Maquila Interna (WIP)'
    WHEN WhsCode = 'ALOB' THEN 'Obsoletos'
    WHEN WhsCode = 'ALPE' THEN 'UN Pedidos Especiales'
    WHEN WhsCode = 'ALPM' THEN 'UN Mayoreo'
    WHEN WhsCode = 'ALPO' THEN 'UN OnLine'
    WHEN WhsCode = 'ALPRO' THEN 'Promociones'
    WHEN WhsCode = 'ALQ' THEN 'Cuarentena'
    WHEN WhsCode = 'ALR' THEN 'Recibo'
    END AS 'Almacen',
    AvgPrice AS 'Precio Promedio',
    OnHand AS 'Existencia',
    IsCommited as 'Comprometido',
    OnHand - IsCommited as 'Disponible',
    AvgPrice*OnHand AS 'Valor Almacen'
FROM OITW
Where ItemCode = 53476