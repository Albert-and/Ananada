-----COBRANZA APLICADA---



----COBRANZA SOLO AYER----


-- Primer bloque: Pagos aplicados a facturas
SELECT 
    T4.[SeriesName], 
    CASE 
        WHEN T3.[ExtraDays] = 0 THEN 'Contado' 
        ELSE 'Crédito' 
    END AS "Condición", 
    SUM(T1.[SumApplied]) AS "Importe"
FROM ORCT T0  
INNER JOIN RCT2 T1 ON T0.[DocEntry] = T1.[DocNum]
LEFT JOIN OINV T2 ON T1.[DocEntry] = T2.[DocEntry] 
LEFT JOIN OCTG T3 ON T2.[GroupNum] = T3.[GroupNum]
INNER JOIN NNM1 T4 ON T0.[Series] = T4.[Series]
WHERE 
    T0.[Canceled] = 'N' 
    AND T0.[DocType] = 'C' 
    AND (T0.[CashAcct] = '110100020001' OR T0.[TrsfrAcct] = '110300010001')
    AND (
        CASE 
            WHEN T0.[TrsfrDate] IS NULL THEN T0.[DocDate] 
            ELSE T0.[TrsfrDate] 
        END = DATEADD(DAY, -2, CAST(GETDATE() AS DATE)) -- Solo día de ayer
    )
GROUP BY 
    T4.[SeriesName], 
    CASE 
        WHEN T3.[ExtraDays] = 0 THEN 'Contado' 
        ELSE 'Crédito' 
    END

UNION ALL

-- Segundo bloque: Pagos no identificados
SELECT 
    T1.[SeriesName], 
    'No Identificado' AS "Condición", 
    SUM(T0.[NoDocSum]) AS "Importe" 
FROM ORCT T0
INNER JOIN NNM1 T1 ON T0.[Series] = T1.[Series]
WHERE 
    T0.[Canceled] = 'N' 
    AND T0.[DocType] = 'C' 
    AND T0.[NoDocSum] > 0
    AND (T0.[CashAcct] = '110100020001' OR T0.[TrsfrAcct] = '110300010001')
    AND T0.[DocDate] = DATEADD(DAY, -2, CAST(GETDATE() AS DATE)) -- Solo día de ayer
GROUP BY 
    T1.[SeriesName];


---------------------------------------------------

-- Primer bloque: Pagos aplicados a facturas
SELECT 
    T4.[SeriesName], 
    CASE 
        WHEN T3.[ExtraDays] = 0 THEN 'Contado' 
        ELSE 'Crédito' 
    END AS "Condición", 
    SUM(T1.[SumApplied]) AS "Importe"
FROM ORCT T0  
INNER JOIN RCT2 T1 ON T0.[DocEntry] = T1.[DocNum]
LEFT JOIN OINV T2 ON T1.[DocEntry] = T2.[DocEntry] 
LEFT JOIN OCTG T3 ON T2.[GroupNum] = T3.[GroupNum]
INNER JOIN NNM1 T4 ON T0.[Series] = T4.[Series]
WHERE 
    T0.[Canceled] = 'N' 
    AND T0.[DocType] = 'C' 
    AND (T0.[CashAcct] = '110100020001' OR T0.[TrsfrAcct] = '110300010001')
    AND (
        CASE 
            WHEN T0.[TrsfrDate] IS NULL THEN T0.[DocDate] 
            ELSE T0.[TrsfrDate] 
        END BETWEEN DATEADD(DAY, -5, CAST(GETDATE() AS DATE)) AND CAST(GETDATE() AS DATE)
    )
GROUP BY 
    T4.[SeriesName], 
    CASE 
        WHEN T3.[ExtraDays] = 0 THEN 'Contado' 
        ELSE 'Crédito' 
    END

UNION ALL

-- Segundo bloque: Pagos no identificados
SELECT 
    T1.[SeriesName], 
    'No Identificado' AS "Condición", 
    SUM(T0.[NoDocSum]) AS "Importe" 
FROM ORCT T0
INNER JOIN NNM1 T1 ON T0.[Series] = T1.[Series]
WHERE 
    T0.[Canceled] = 'N' 
    AND T0.[DocType] = 'C' 
    AND T0.[NoDocSum] > 0
    AND (T0.[CashAcct] = '110100020001' OR T0.[TrsfrAcct] = '110300010001')
    AND T0.[DocDate] BETWEEN DATEADD(DAY, -5, CAST(GETDATE() AS DATE)) AND CAST(GETDATE() AS DATE)
GROUP BY 
    T1.[SeriesName];


----COBRANZA SIN FIN DE SEMANA---
-- Primer bloque: Pagos aplicados a facturas
SELECT 
    T4.[SeriesName], 
    CASE 
        WHEN T3.[ExtraDays] = 0 THEN 'Contado' 
        ELSE 'Crédito' 
    END AS "Condición", 
    SUM(T1.[SumApplied]) AS "Importe"
FROM ORCT T0  
INNER JOIN RCT2 T1 ON T0.[DocEntry] = T1.[DocNum]
LEFT JOIN OINV T2 ON T1.[DocEntry] = T2.[DocEntry] 
LEFT JOIN OCTG T3 ON T2.[GroupNum] = T3.[GroupNum]
INNER JOIN NNM1 T4 ON T0.[Series] = T4.[Series]
WHERE 
    T0.[Canceled] = 'N' 
    AND T0.[DocType] = 'C' 
    AND (T0.[CashAcct] = '110100020001' OR T0.[TrsfrAcct] = '110300010001')
    AND (
        CASE 
            -- Si hoy es lunes, tomar el viernes anterior
            WHEN DATEPART(WEEKDAY, GETDATE()) = 2 THEN DATEADD(DAY, -3, CAST(GETDATE() AS DATE))
            -- Si hoy es cualquier otro día, tomar el día anterior
            ELSE DATEADD(DAY, -1, CAST(GETDATE() AS DATE))
        END
    ) = 
    CASE 
        WHEN T0.[TrsfrDate] IS NULL THEN T0.[DocDate] 
        ELSE T0.[TrsfrDate] 
    END
GROUP BY 
    T4.[SeriesName], 
    CASE 
        WHEN T3.[ExtraDays] = 0 THEN 'Contado' 
        ELSE 'Crédito' 
    END

UNION ALL

-- Segundo bloque: Pagos no identificados
SELECT 
    T1.[SeriesName], 
    'No Identificado' AS "Condición", 
    SUM(T0.[NoDocSum]) AS "Importe" 
FROM ORCT T0
INNER JOIN NNM1 T1 ON T0.[Series] = T1.[Series]
WHERE 
    T0.[Canceled] = 'N' 
    AND T0.[DocType] = 'C' 
    AND T0.[NoDocSum] > 0
    AND (T0.[CashAcct] = '110100020001' OR T0.[TrsfrAcct] = '110300010001')
    AND (
        CASE 
            -- Si hoy es lunes, tomar el viernes anterior
            WHEN DATEPART(WEEKDAY, GETDATE()) = 2 THEN DATEADD(DAY, -3, CAST(GETDATE() AS DATE))
            -- Si hoy es cualquier otro día, tomar el día anterior
            ELSE DATEADD(DAY, -1, CAST(GETDATE() AS DATE))
        END
    ) = T0.[DocDate]
GROUP BY 
    T1.[SeriesName];



----SALDOS GENERALES POR CUENTA A UNA FECHA DETERMINADA---

SELECT 
    T2.[AcctName], 
    SUM(T1.[Debit] - T1.[Credit]) AS "Saldo"
FROM OJDT T0  
INNER JOIN JDT1 T1 ON T0.[TransId] = T1.[TransId] 
INNER JOIN OACT T2 ON T1.[Account] = T2.[AcctCode] 
WHERE 
    T0.[RefDate] <= 
    CASE 
        -- Si hoy es lunes, tomar el viernes anterior
        WHEN DATEPART(WEEKDAY, GETDATE()) = 2 THEN DATEADD(DAY, -3, CAST(GETDATE() AS DATE))
        -- Para cualquier otro día, tomar el día anterior
        ELSE DATEADD(DAY, -1, CAST(GETDATE() AS DATE))
    END
    AND (T1.[Account] LIKE '11010002%' OR T1.[Account] LIKE '11010003%' OR T1.[Account] LIKE '11010005%')
GROUP BY 
    T2.[AcctName];





----INGRESOS CONSIDERANDO FIN DE SEMANA---
SELECT 
    SUM(T1.[Debit]) AS "Ingresos"
FROM OJDT T0  
INNER JOIN JDT1 T1 ON T0.[TransId] = T1.[TransId] 
INNER JOIN OACT T2 ON T1.[Account] = T2.[AcctCode] 
WHERE 
    T0.[RefDate] = 
    CASE 
        -- Si hoy es lunes, tomar el viernes anterior
        WHEN DATEPART(WEEKDAY, GETDATE()) = 2 THEN DATEADD(DAY, -3, CAST(GETDATE() AS DATE))
        -- Si hoy es domingo, tomar el viernes anterior
        WHEN DATEPART(WEEKDAY, GETDATE()) = 1 THEN DATEADD(DAY, -2, CAST(GETDATE() AS DATE))
        -- Si hoy es cualquier otro día, tomar el día anterior
        ELSE DATEADD(DAY, -1, CAST(GETDATE() AS DATE))
    END
    AND (T1.[Account] LIKE '11010002%' OR T1.[Account] LIKE '11010003%' OR T1.[Account] LIKE '11010005%');

---EGRESOS CONSIDERANDO FIN DE SEMANA---

SELECT 
    SUM(T1.[Credit]) AS "Egresos"
FROM OJDT T0  
INNER JOIN JDT1 T1 ON T0.[TransId] = T1.[TransId] 
INNER JOIN OACT T2 ON T1.[Account] = T2.[AcctCode] 
WHERE 
    T0.[RefDate] = 
    CASE 
        -- Si hoy es lunes, tomar el viernes anterior
        WHEN DATEPART(WEEKDAY, GETDATE()) = 2 THEN DATEADD(DAY, -3, CAST(GETDATE() AS DATE))
        -- Si hoy es domingo, tomar el viernes anterior
        WHEN DATEPART(WEEKDAY, GETDATE()) = 1 THEN DATEADD(DAY, -2, CAST(GETDATE() AS DATE))
        -- Si hoy es cualquier otro día, tomar el día anterior
        ELSE DATEADD(DAY, -1, CAST(GETDATE() AS DATE))
    END
    AND (T1.[Account] LIKE '11010002%' OR T1.[Account] LIKE '11010003%' OR T1.[Account] LIKE '11010005%');




--------Saldo en cuentas mes Anterior ---
SELECT 
    T2.[AcctName], 
    SUM(T1.[Debit] - T1.[Credit]) AS "Saldo"
FROM OJDT T0  
INNER JOIN JDT1 T1 ON T0.[TransId] = T1.[TransId] 
INNER JOIN OACT T2 ON T1.[Account] = T2.[AcctCode] 
WHERE 
    T0.[RefDate] <= EOMONTH(GETDATE(), -1) -- Último día del mes anterior
    AND (T1.[Account] LIKE '11010002%' OR T1.[Account] LIKE '11010003%' OR T1.[Account] LIKE '11010005%')
GROUP BY 
    T2.[AcctName];

----Saldo en cuentas del mes anterior ----