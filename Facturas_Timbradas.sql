




---Timbradas ----
    SELECT 
        CAST(SUBSTRING(ObjectID, PATINDEX('%[0-9]%', ObjectID), LEN(ObjectID)) AS INT) AS NumericID,
        ObjectID,
        ReportID
    FROM ecm2
    Where CreateDate ='2024/09/26' AND ObjectID LIKE 'RF%'


---Facturas --- 


SELECT 
    DocNum,
    DocTotal,
    DocDate
FROM OINV
WHERE 
    CANCELED = 'N' ANd DocDate >= '2024/09/01'
ORDER BY 
    DocEntry DESC;


------
WITH Timbradas AS (
    SELECT 
        CAST(SUBSTRING(ObjectID, PATINDEX('%[0-9]%', ObjectID), LEN(ObjectID)) AS INT) AS NumericID,
        ObjectID,
        ReportID
    FROM ecm2
    WHERE  
        ObjectID LIKE 'RF%'
)

SELECT 
    f.DocNum,
    f.DocTotal,
    f.DocDate,
    f.CANCELED,
    t.ObjectID,
    t.ReportID
FROM 
    OINV f
LEFT JOIN 
    Timbradas t ON f.DocNum = t.NumericID

ORDER BY 
    f.DocEntry DESC;