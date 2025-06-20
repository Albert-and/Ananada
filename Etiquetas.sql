SELECT
    DOCNUM,
    UPPER(Cardname) AS Cardname,
    CASE 
        WHEN Series = 9 THEN 'Mayoreo'
        WHEN Series = 76 THEN 'OnLine'
        WHEN Series = 77 THEN 'Pedidos especiales'
        ELSE 'Otro'
    END AS Series
FROM ORDR
WHERE DocStatus = 'O' AND U_EstatusOV = 1







SELECT *
FROM OPKL





SELECT DocNum, U_Cajas
FROM ODLN




SELECT DISTINCT
    ee.DocNum AS 'No. Entrega',
    de.BaseDocNum AS 'No. Ov',
    UPPER(ee.CardName) as Cliente,
    ee.U_Cajas,
    CASE
        WHEN ee.Series = 119 THEN 'Mayoreo'
        WHEN ee.Series = 120 THEN 'OnLine'
        ELSE 'Otro'
    END AS 'UN'
FROM ODLN ee
INNER JOIN DLN1 de ON ee.DocEntry = de.DocEntry
WHERE  ee.Series <> 121
ORDER BY UN,'No. Ov'





SELECT DISTINCT
    ee.DocNum AS 'No. Entrega',
    de.BaseDocNum AS 'No. Ov',
    UPPER(ee.CardName) as Cliente,
    ee.U_Cajas,
    CASE
        WHEN ee.Series = 119 THEN 'Mayoreo'
        WHEN ee.Series = 120 THEN 'OnLine'
        ELSE 'Otro'
    END AS 'UN'
FROM ODLN ee
INNER JOIN DLN1 de ON ee.DocEntry = de.DocEntry
WHERE  ee.Series <> 121 AND ee.DocDate = CONVERT(DATE, GETDATE()-5)
ORDER BY UN,'No. Ov'


AND ee.DocDate = CONVERT(DATE, GETDATE()-5)




SELECT DISTINCT
    ee.DocNum AS 'No. Entrega',
    de.BaseDocNum AS 'No. Ov',
    UPPER(ee.CardName) as Cliente,
    ee.U_Cajas,
    CASE
        WHEN ee.Series = 119 THEN 'Mayoreo'
        WHEN ee.Series = 120 THEN 'OnLine'
        ELSE 'Otro'
    END AS 'UN'
FROM ODLN ee
INNER JOIN DLN1 de ON ee.DocEntry = de.DocEntry
WHERE ee.Series <> 121 AND ee.DocDate = CONVERT(DATE, GETDATE()-5)
ORDER BY UN,'No. Ov'



SELECT DISTINCT
    de.BaseDocNum AS 'No. Ov',
    ee.DocDate,
    UPPER(ee.CardName) as Cliente,
    ee.U_Cajas,
    CASE
        WHEN ee.Series = 119 THEN 'Mayoreo'
        WHEN ee.Series = 120 THEN 'OnLine'
        WHEN ee.Series = 121 THEN 'PE'
        ELSE 'Otro'
    END AS 'UN',
    CASE
        WHEN ee.U_EstatusOV = 1 THEN 'Por surtir'
        WHEN ee.U_EstatusOV = 2 THEN 'Inicio surtido'
        WHEN ee.U_EstatusOV = 3 THEN 'Termino surtido'
        WHEN ee.U_EstatusOV = 4 THEN 'Inicio verificado'
        WHEN ee.U_EstatusOV = 5 THEN 'Termino verificado'
        WHEN ee.U_EstatusOV = 8 THEN 'Remisionado'
        ELSE 'Otro'
    END AS 'Estatus'    
FROM ODLN ee
INNER JOIN DLN1 de ON ee.DocEntry = de.DocEntry
WHERE ee.DocDate >= CONVERT(DATE, GETDATE() - 5) 
ORDER BY 'UN', 'No. Ov'



SELECT DISTINCT
    de.BaseDocNum AS 'No. Ov',
    ee.DocDate,
    UPPER(ee.CardName) as Cliente,
    ee.U_Cajas,
    CASE
        WHEN ee.Series = 119 THEN 'Mayoreo'
        WHEN ee.Series = 120 THEN 'OnLine'
        WHEN ee.Series = 121 THEN 'PE'
        ELSE 'Otro'
    END AS 'UN',
    CASE
        WHEN ee.U_EstatusOV = 1 THEN 'Por surtir'
        WHEN ee.U_EstatusOV = 2 THEN 'Inicio surtido'
        WHEN ee.U_EstatusOV = 3 THEN 'Termino surtido'
        WHEN ee.U_EstatusOV = 4 THEN 'Inicio verificado'
        WHEN ee.U_EstatusOV = 5 THEN 'Termino verificado'
        WHEN ee.U_EstatusOV = 8 THEN 'Remisionado'
        ELSE 'Otro'
    END AS 'Estatus'    
FROM ODLN ee
INNER JOIN DLN1 de ON ee.DocEntry = de.DocEntry
WHERE ee.DocDate >= CONVERT(DATE, DATEADD(day, -5, GETDATE()))
  AND de.BaseDocNum IS NOT NULL
  AND ee.DocDate IS NOT NULL
ORDER BY 'UN', 'No. Ov';
