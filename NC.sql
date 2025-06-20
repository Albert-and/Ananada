


SELECT
d.DocNum,
CONVERT(varchar, d.DocDate, 23) AS fecha_formateada,
d.CardName,
CONVERT(varchar, CAST(d.DocTotal AS money), 1) as 'Monto',
s.SeriesName,
v.SlpName
FROM ORIN d
INNER JOIN OSLP v ON v.SlpCode = d.SlpCode
INNER JOIN NNM1 s ON s.Series = d.Series
WHERE d.DocDate >= CAST(GETDATE()-3 as date)


