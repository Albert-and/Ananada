


SELECT
DocNum,
U_DateLiberacion,
(select top 1 Descr from UFD1 where FieldID = 29 and fldvalue = U_EstatusOV
and TableID = 'ORDR'
group by FieldID, indexid, fldvalue, Descr) AS 'Estatus ANANDA'
FROM ORDR
WHERE U_DateLiberacion Is NOT NULL




SELECT
DocNum,
CardCode,
CardName,
U_DateLiberacion,
(select top 1 Descr from UFD1 where FieldID = 29 and fldvalue = U_EstatusOV
and TableID = 'ORDR'
group by FieldID, indexid, fldvalue, Descr) AS 'Estatus ANANDA'
FROM ORDR
WHERE U_DateLiberacion Is NOT NULL





SELECT TOP(10)*
FROM ORDR


