

--Archivos AWS Query Corregidos---



-----------ProductHierarchy_Records----------------

SELECT
    OITM.ItemCode AS 'Código de Artículo',
    OITM.ItemName AS 'Nombre del Artículo',
    OITB.ItmsGrpNam AS 'Nombre del Grupo',
    FORMAT(OITM.CreateDate, 'yy-MM-dd') AS 'Fecha de Creación',
    FORMAT(OITM.UpdateDate, 'yy-MM-dd') AS 'Fecha de Actualización',
    OITM.U_codigo AS 'Código Adicional'
FROM OITM
INNER JOIN OITB ON OITM.ItmsGrpCod = OITB.ItmsGrpCod
WHERE
    EXISTS (
        SELECT 1
        FROM FCT1 f
        WHERE f.ItemCode = OITM.ItemCode
    )  -- Filtrar por ItemCode en FCT1





-----InboundOrderLine_Records----

SELECT 
ODLN.CardCode AS tpartner_id,
DLN1.ItemCode AS product_id,
FORMAT(ODLN.DocDate, 'yy-MM-dd') AS line_creation_date,
ODLN.DocNum AS order_id,
DLN1.LineNum AS external_line_number,
DLN1.Quantity AS quantity_submitted,
DLN1.Quantity AS quantity_confirmed,
DLN1.Quantity AS quantity_received,
FORMAT(ODLN.DocDueDate, 'yy-MM-dd') AS order_receive_date,
FORMAT(ODLN.DocDueDate, 'yy-MM-dd') AS expected_delivery_date,
FORMAT(ODLN.DocDueDate, 'yy-MM-dd') AS submitted_date
FROM 
    ODLN  -- Delivery Header
    INNER JOIN DLN1 ON ODLN.DocEntry = DLN1.DocEntry  -- Delivery Items
    INNER JOIN OITM ON DLN1.ItemCode = OITM.ItemCode  -- Items
    INNER JOIN OCRD ON ODLN.CardCode = OCRD.CardCode  -- Business Partners
WHERE 
    ODLN.CANCELED = 'N'
    AND DLN1.LineStatus = 'O'
    AND EXISTS (
        SELECT 1 
        FROM FCT1 f 
        WHERE f.ItemCode = DLN1.ItemCode
    )  -- Filtrar por ItemCode en FCT1
ORDER BY 
    ODLN.DocNum, DLN1.LineNum;

-----InventoryLevel_Records-----TODAY

SELECT
    FORMAT(GETDATE(), 'yy-MM-dd') AS snapshot_date,  -- O usar una fecha específica
    OITW.WhsCode AS site_id,
    OITW.ItemCode AS product_id,
    -- Inventario disponible
    OITW.OnHand AS on_hand_inventory,
    -- Inventario asignado (committed)
    OITW.IsCommited AS allocated_inventory,
    -- Inventario pedido (ordered)
    OITW.OnOrder AS inv_condition
    -- Campos adicionales útiles
FROM 
    OITW
    INNER JOIN OITM ON OITW.ItemCode = OITM.ItemCode  -- Unir OITW con OITM para obtener detalles del producto
    INNER JOIN OWHS ON OITW.WhsCode = OWHS.WhsCode  -- Unir OITW con OWHS para obtener detalles del almacén
WHERE
    OITW.WhsCode = 'ALPM'  -- Solo registros con WhsCode = 'ALPM'
    AND (OITW.OnHand > 0  -- Solo registros con inventario
         OR OITW.IsCommited > 0  -- O con inventario comprometido
         OR OITW.OnOrder > 0)  -- O con órdenes pendientes
    AND EXISTS (SELECT 1 FROM FCT1 f WHERE f.ItemCode = OITW.ItemCode);  -- Filtrar por ItemCode en FCT1

-----


-----OutboundOrderLine_Records-------

SELECT
    d.ItemCode AS product_id,
    c.CardCode AS customer_tpartner_id,
    d.Quantity AS final_quantity_requested,
    FORMAT(c.DocDueDate, 'yy-MM-dd') AS requested_delivery_date,
    FORMAT(c.DocDate, 'yy-MM-dd') AS order_date,
    FORMAT(c.DocDueDate,'yy-MM-dd') AS actual_delivery_date,
    FORMAT(c.DocDueDate, 'yy-MM-dd') AS promised_delivery_date,
    c.DocStatus AS status,
    c.DocNum AS id,
    c.DocNum AS cust_order_id
FROM 
    OINV c 
INNER JOIN 
    INV1 d 
ON 
    c.DocEntry = d.DocEntry
WHERE 
    c.CANCELED <> 'Y' 
    AND EXISTS (SELECT 1
FROM FCT1 f
WHERE f.ItemCode = d.ItemCode)


---------------------------ForecastRecords-----


SELECT
    FCT1.ItemCode AS 'Código de Artículo',
    'CD01' AS SiteID,
    'AND' AS CompanyId,
    'LATAM' AS RegionId,
    --FORMAT(FCT1.Date, 'yy-MM-dd') AS 'Fecha',
    FORMAT(FCT1.Quantity, 'N0') AS 'Cantidad',
    FCT1.WhsCode AS 'Código de Almacén',
    OITB.ItmsGrpNam AS 'Nombre del Grupo',
    FORMAT(DATEFROMPARTS(YEAR(FCT1.Date), MONTH(FCT1.Date), 1), 'yyyy-MM-dd') AS 'Inicio del Mes',
    FORMAT(EOMONTH(FCT1.Date), 'yyyy-MM-dd') AS 'Fin del Mes'
FROM FCT1
INNER JOIN OITM ON FCT1.ItemCode = OITM.ItemCode
INNER JOIN OITB ON OITM.ItmsGrpCod = OITB.ItmsGrpCod
WHERE FCT1.AbsID = 3;




SELECT
    FCT1.ItemCode AS 'Código de Artículo',
    'CD01' AS SiteID,
    'AND' AS CompanyId,
    'LATAM' AS RegionId,
    --FORMAT(FCT1.Date, 'yy-MM-dd') AS 'Fecha',
    FORMAT(FCT1.Quantity, 'N0') AS 'Cantidad',
    FCT1.WhsCode AS 'Código de Almacén',
    OITB.ItmsGrpNam AS 'Nombre del Grupo',
    FORMAT(DATEFROMPARTS(YEAR(FCT1.Date), MONTH(FCT1.Date), 1), 'yyyy-MM-dd') AS 'Inicio del Mes',
    FORMAT(EOMONTH(FCT1.Date), 'yyyy-MM-dd') AS 'Fin del Mes'
FROM FCT1
INNER JOIN OITM ON FCT1.ItemCode = OITM.ItemCode
INNER JOIN OITB ON OITM.ItmsGrpCod = OITB.ItmsGrpCod
WHERE FCT1.AbsID = 3;



---Forecast Pivoteado---


WITH CTE_MonthlyData AS (
    SELECT
        ItemCode,
        FORMAT(Date, 'yyyy-MM') AS Month, -- Extrae el año y mes de la fecha
        SUM(Quantity) AS TotalQuantity -- Suma las cantidades por mes
    FROM FCT1
    WHERE AbsID = 3
    GROUP BY ItemCode, FORMAT(Date, 'yyyy-MM')
)
SELECT *
FROM CTE_MonthlyData
PIVOT (
    SUM(TotalQuantity) -- Agrega las cantidades
    FOR Month IN ([2025-01], [2025-02], [2025-03], [2025-04], [2025-05], [2025-06], 
                  [2025-07], [2025-08], [2025-09], [2025-10], [2025-11], [2025-12])
) AS PivotTable
ORDER BY ItemCode;

--------






-----------------ProductHierarchy_Records----------------

















-----PRODUCT_RECORDS------


SELECT 
    OITM.ItemCode, 
    OITM.ItemName, 
    OITB.ItmsGrpNam AS 'Grupo de Artículos', 
    OITM.SalUnitMsr,
    OITM.LastPurPrc,
    OITM.LastPurCur, 
    OITM.U_TipoProv, 
    OITM.U_Codigo, 
    OITM.U_CLASIF_STORE,
    OITM.U_Clasificacion,
    OITM.U_Comp01,
    OITM.U_Comp02,
    OITM.U_Comp03,
    OITM.U_Comp04,
    OITM.U_Comp05,
    OITM.U_Comp06,
    OITM.U_Comp07,
    OITM.U_Comp08,
    OITM.U_Comp09,
    OITM.U_Comp10,
    OITM.U_Componente11
FROM 
    OITM
INNER JOIN 
    OITB ON OITM.ItmsGrpCod = OITB.ItmsGrpCod -- Relación con el grupo de artículos
WHERE 
    OITM.ItemCode IN (SELECT DISTINCT ItemCode FROM FCT1) -- Filtrar por los ItemCode únicos de FCT1
ORDER BY 
    OITM.ItemCode;

---------------InBoundHeadDoc----------------------


SELECT
DocEntry,
ItemCode,
Quantity,
Price,
LineTotal,
Currency,
ShipDate
FROM POR1
WHERE
 POR1.ItemCode IN (SELECT DISTINCT ItemCode FROM FCT1)




 -------------------InBoundRecords------

SELECT
    P0.DocNum AS 'No. Pedido', -- Número de pedido de la orden de compra
    P0.DocDate AS 'Fecha de Creación',
    P0.CardCode AS 'Código del Proveedor',
    P0.CardName AS 'Nombre del Proveedor',
    P1.ItemCode AS 'Código del Artículo',
    P1.Quantity AS 'Cantidad Solicitada',
    P1.Price AS 'Precio Unitario',
    P1.LineTotal AS 'Total de Línea',
    P1.Currency AS 'Moneda',
    P1.ShipDate AS 'Fecha de Envío'
FROM 
    POR1 P1
INNER JOIN 
    OPOR P0 ON P1.DocEntry = P0.DocEntry -- Relación entre líneas y cabecera de órdenes de compra
WHERE 
    P1.ItemCode IN (SELECT DISTINCT ItemCode FROM FCT1) -- Filtrar por los ItemCode únicos de FCT1
ORDER BY 
    P1.DocEntry, P1.ItemCode;





***********

SELECT 
    DISTINCT m.ItemCode, 
    m.CreateDate, 
    m.OnHand 
FROM 
    OITM m
INNER JOIN
    FCT1 f ON m.ItemCode = f.ItemCode
WHERE 
    m.ItemCode IN (SELECT DISTINCT ItemCode FROM FCT1) -- Filtrar por los ItemCode únicos de FCT1





SELECT 
    m.ItemCode, 
    m.CreateDate, 
    m.OnHand 
FROM 
    OITM m
INNER JOIN
    FCT1 f ON m.ItemCode = f.ItemCode
GROUP BY 
    m.ItemCode, 
    m.CreateDate, 
    m.OnHand
ORDER BY 
    m.ItemCode;



----------Venta Mensual acumulada Pivoteada---

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
        c.CANCELED <> 'Y' 
        AND EXISTS (
            SELECT 1
            FROM FCT1 f
            WHERE f.ItemCode = d.ItemCode
        )
    GROUP BY 
        d.ItemCode, FORMAT(c.DocDate, 'yyyy-MM')
)
SELECT *
FROM CTE_MonthlyData
PIVOT (
    SUM(total_quantity_requested) -- Agrega las cantidades
    FOR order_month IN ([2025-01], [2025-02], [2025-03], [2025-04], [2025-05], [2025-06], 
                        [2025-07], [2025-08], [2025-09], [2025-10], [2025-11], [2025-12])
) AS PivotTable
ORDER BY product_id;