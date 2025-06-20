


SELECT distinct T1.DocNum as 'No. Documento', T1.DocDate as 'Fecha de Factura',
T1.CardCode as 'Código Cliente',
T1.CardName as 'Nombre Cliente',
(T1.DocTotal - t1.VatSum) as 'Total Factura sin IVA',
T3.ListNum as 'Lista Precios',
T3.State1 as 'Estado01',
T3.State2 as 'Estado01',
T2.SlpName as 'Vendedor'
FROM OINV T1
LEFT JOIN OSLP T2 ON T2.SlpCode = T1.SlpCode
LEFT JOIN OCRD T3 ON T3.CardCode = T1.CardCode
WHERE T1.Series <> 75 AND T1.DocDate BETWEEN '04/01/2021' AND '04/30/2021'



WHERE T1.Series <> 75 AND T1.DocDate >=[%0] and T1.DocDate <= [%1]