


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
    DATEDIFF(HOUR, GETDATE(), CONVERT(DATETIME, CONVERT(NVARCHAR(MAX), T1.U_DateLiberacion), 120)) AS HorasRestantes,
    DATEDIFF(HOUR, GETDATE(), DATEADD(HOUR, 24, CONVERT(DATETIME, CONVERT(NVARCHAR(MAX), T1.U_DateLiberacion), 120))) AS CuentaRegresiva,
    (SELECT TOP 1 Descr 
     FROM UFD1 
     WHERE FieldID = 29 
       AND fldvalue = T1.U_EstatusOV
       AND TableID = 'ORDR'
     ORDER BY FieldID, indexid, fldvalue) AS 'Estatus ANANDA'
FROM ORDR T1
LEFT JOIN OSLP T2 ON T1.SlpCode = T2.SlpCode
WHERE T1.U_DateLiberacion IS NOT NULL 
  AND T1.DocDate >= DATEADD(DAY, -1, GETDATE());



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
    
    -- Horas que han transcurrido desde la fecha de liberación hasta ahora
    DATEDIFF(HOUR, CONVERT(DATETIME, CONVERT(NVARCHAR(MAX), T1.U_DateLiberacion), 120), GETDATE()) AS HorasConsumidas,

    -- Cuenta regresiva: tiempo restante para cumplir las 24 horas desde la liberación
    24 - DATEDIFF(HOUR, CONVERT(DATETIME, CONVERT(NVARCHAR(MAX), T1.U_DateLiberacion), 120), GETDATE()) AS CuentaRegresiva,

    (SELECT TOP 1 Descr 
     FROM UFD1 
     WHERE FieldID = 29 
       AND fldvalue = T1.U_EstatusOV
       AND TableID = 'ORDR'
     ORDER BY FieldID, indexid, fldvalue) AS 'Estatus ANANDA'
FROM ORDR T1
LEFT JOIN OSLP T2 ON T1.SlpCode = T2.SlpCode
WHERE T1.U_DateLiberacion IS NOT NULL 
  AND T1.DocDate >= DATEADD(DAY, -3, GETDATE());
