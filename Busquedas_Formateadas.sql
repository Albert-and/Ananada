

if $[ORDR.U_EstatusOV] = 1
BEGIN
DECLARE @D DATETIME 
SET @D = GETDATE()
SELECT CONVERT(varchar(20), @D , 120)
END


SELECT 
    CASE 
        WHEN EXISTS (SELECT 1 
                     FROM OINV T0 
                     INNER JOIN INV1 T1 ON T0.DocEntry = T1.DocEntry 
                     WHERE T1.BaseEntry = $[ORDR.DocEntry] 
                     AND T1.BaseType = '17') 
        THEN CONVERT(varchar(20), GETDATE(), 120)
        ELSE NULL 
    END
