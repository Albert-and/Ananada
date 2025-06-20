SELECT
    T1.DocNum,
    UPPER(T1.CardName) AS Cliente,
    CASE 
        WHEN T1.Series = 9 THEN 'Mayoreo'
        WHEN T1.Series = 76 THEN 'Online'
        WHEN T1.Series = 77 THEN 'Pedidos Especiales'
        ELSE 'Otro'
    END AS Tipo_Serie,
    T1.U_DateLiberacion AS T_Liberacion,
    CONVERT(DATETIME, CONVERT(NVARCHAR(MAX), U_DateLiberacion), 120) AS FechaHora,
    (SELECT TOP 1 Descr 
     FROM UFD1 
     WHERE FieldID = 29 
       AND fldvalue = T1.U_EstatusOV
       AND TableID = 'ORDR'
     GROUP BY FieldID, indexid, fldvalue, Descr) AS 'Estatus ANANDA',
    T2.SlpName
FROM ORDR T1
LEFT JOIN OSLP T2 ON T1.SlpCode = T2.SlpCode
WHERE T1.U_DateLiberacion IS NOT NULL 
  AND T1.DocDate >= DATEADD(DAY, -5, GETDATE())