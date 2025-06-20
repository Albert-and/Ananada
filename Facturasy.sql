

SELECT
    T0.DocNum AS 'No.Factura',
    T0.DocDate AS 'FechaFactura',
    T0.CardCode AS 'No.Cliente',
    T2.SlpCode AS 'Cod_Vendedor',
    T3.ItemCode AS 'SKU',
    T3.Quantity AS 'Cantidad',
    T3.LineTotal AS 'TotalLinea',
    T3.Quantity * T3.LineTotal AS 'ValorTotal',
    CASE
        WHEN T1.SeriesName IN ('Online', 'B') THEN 'Online'
        WHEN T1.SeriesName IN ('Mayoreo', 'A') THEN 'Mayoreo'
        WHEN T1.SeriesName IN ('PedEsp', 'C') THEN 'PedidosEspeciales'
        ELSE 'Otro'
    END AS 'Tipo de Venta'
FROM
    (
        SELECT '13' AS ObjType, DocEntry, DocNum, DocDate, CardCode, SlpCode, Series FROM OINV WHERE CANCELED = 'N' AND DocDate >= '20240901'
        UNION ALL
        SELECT '14' AS ObjType, DocEntry, DocNum, DocDate, CardCode, SlpCode, Series FROM ORIN WHERE CANCELED = 'N' AND DocDate >= '20240901'
    ) T0
INNER JOIN NNM1 T1 ON T0.Series = T1.Series
INNER JOIN OSLP T2 ON T0.SlpCode = T2.SlpCode
INNER JOIN (
    SELECT DocEntry, ItemCode, Quantity, LineTotal FROM INV1 WHERE ItemCode NOT LIKE 'F%'
    UNION ALL
    SELECT DocEntry, ItemCode, Quantity, LineTotal FROM RIN1 WHERE ItemCode NOT LIKE 'F%'
) T3 ON T0.DocEntry = T3.DocEntry
ORDER BY
    T0.DocDate,
    T0.DocNum,
    T3.ItemCode