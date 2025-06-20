
SELECT 
    T0.DocNum AS Pago,
    T0.DocDate AS FechaPago,
    T1.DocEntry AS Factura,
    T1.SumApplied AS MontoPagado,
    T2.Series AS Serie,
    T5.ListName AS ListaPrecios,  -- Nombre de la lista desde OPLN
    T4.SlpName AS Vendedor
FROM ORCT T0
INNER JOIN RCT2 T1 ON T0.DocEntry = T1.DocNum          -- Pagos -> Aplicaciones
INNER JOIN OINV T2 ON T1.DocEntry = T2.DocEntry        -- Aplicaciones -> Facturas
INNER JOIN OCRD T3 ON T2.CardCode = T3.CardCode        -- Factura -> Socio de Negocio
INNER JOIN OPLN T5 ON T3.ListNum = T5.ListNum          -- Socio -> Lista de Precios
INNER JOIN OSLP T4 ON T2.SlpCode = T4.SlpCode          -- Factura -> Vendedor
WHERE T0.CANCELED = 'N' 
  AND MONTH(T0.DocDate) = MONTH(GETDATE()) 
  AND YEAR(T0.DocDate) = YEAR(GETDATE());


SELECT 
    T0.DocNum AS Pago,
    T0.DocDate AS FechaPago,
    T1.DocEntry AS Factura,
    T1.SumApplied AS MontoPagado,
    CASE T2.Series  -- Condicional para la serie
        WHEN 116 THEN 'Mayoreo'
        WHEN 118 THEN 'Pedidos Especiales'
        ELSE 'Otra Serie'  -- Opcional para otros valores
    END AS Serie,
    T5.ListName AS ListaPrecios,
    T4.SlpName AS Vendedor
FROM ORCT T0
INNER JOIN RCT2 T1 ON T0.DocEntry = T1.DocNum
INNER JOIN OINV T2 ON T1.DocEntry = T2.DocEntry
INNER JOIN OCRD T3 ON T2.CardCode = T3.CardCode
INNER JOIN OPLN T5 ON T3.ListNum = T5.ListNum
INNER JOIN OSLP T4 ON T2.SlpCode = T4.SlpCode
WHERE T0.CANCELED = 'N' 
  AND T0.DocDate >= DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1) 
  AND T0.DocDate < DATEADD(MONTH, 1, DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1));



SELECT 
    T0.DocNum AS Pago,
    T0.DocDate AS FechaPago,
    T1.DocEntry AS Factura,
    T1.SumApplied AS MontoPagado,
    T6.SeriesName AS Serie,  -- Nombre desde NNM1
    T5.ListName AS ListaPrecios,
    T4.SlpName AS Vendedor
FROM ORCT T0
INNER JOIN RCT2 T1 ON T0.DocEntry = T1.DocNum
INNER JOIN OINV T2 ON T1.DocEntry = T2.DocEntry
INNER JOIN OCRD T3 ON T2.CardCode = T3.CardCode
INNER JOIN OPLN T5 ON T3.ListNum = T5.ListNum
INNER JOIN OSLP T4 ON T2.SlpCode = T4.SlpCode
INNER JOIN NNM1 T6 ON T2.Series = T6.Series  -- Unión con la tabla de series
WHERE T0.CANCELED = 'N' 
  AND T2.Series IN (116, 118) 
  AND T0.DocDate >= DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1) 
  AND T0.DocDate < DATEADD(MONTH, 1, DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1));




  SELECT 
    T0.DocNum AS Pago,
    T0.DocDate AS FechaPago,
    T1.DocEntry AS Factura,
    T1.SumApplied AS MontoPagado,
    CASE T2.Series 
        WHEN 116 THEN 'Mayoreo'
        WHEN 118 THEN 'Pedidos Especiales' 
    END AS Serie,
    T5.ListName AS ListaPrecios,
    T4.SlpName AS Vendedor
FROM ORCT T0
INNER JOIN RCT2 T1 ON T0.DocEntry = T1.DocNum
INNER JOIN OINV T2 ON T1.DocEntry = T2.DocEntry
INNER JOIN OCRD T3 ON T2.CardCode = T3.CardCode
INNER JOIN OPLN T5 ON T3.ListNum = T5.ListNum
INNER JOIN OSLP T4 ON T2.SlpCode = T4.SlpCode
WHERE T0.CANCELED = 'N' 
  AND T2.Series IN (116, 118)  -- Filtramos solo Mayoreo y Pedidos Especiales
  AND T0.DocDate >= DATEADD(MONTH, -1, DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1))  -- Primer día del mes anterior
  AND T0.DocDate <= EOMONTH(DATEADD(MONTH, -1, GETDATE()));  -- Último día del mes anterior