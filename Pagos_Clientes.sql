
SELECT
c.CardCode,
dp.RefDate AS 'Fecha Factura',
case dp.transtype
    when '13' then 'Factura'
    when '14' then 'Nota Credito'
    when '24' then 'Pagos'
else 'Otro'
end 'Tipo Trans',
dp.BaseRef AS 'Factura Origen',
f.Series,
CASE f.DocStatus
    When 'C' then 'Cerrado'
    When 'O' then 'Abierto'
end 'Estatus',
dp.Debit,
dp.Credit
FROM JDT1 dp
INNER JOIN OCRD c ON dp.shortname = c.cardCode
INNER JOIN OINV f ON f.DocNum = dp.BaseRef 
Where c.CardCode NOT LIKE 'P%'