SELECT T1.DocEntry, T1.DocNum,T1.NumAtCard, T1.Canceled, T1.DocDate,
T1.CardCode, T1.CardName, T1.DocTotal,T1.VatSum,T1.Series,U_DateLiberacion,
(select top 1 Descr from UFD1 where FieldID = 29 and fldvalue = T1.U_EstatusOV
and TableID = 'ORDR'
group by FieldID, indexid, fldvalue, Descr) AS 'Estatus ANANDA',
 T2.SlpName
FROM ORDR T1
LEFT JOIN OSLP T2 ON T1.SlpCode = T2.SlpCode