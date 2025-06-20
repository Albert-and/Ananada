




SELECT *
FROM CUFD
Where TableID = 'OITM'
AND FieldID = 3


SELECT *
FROM UFD1
Where TableID = 'OITM'
AND FieldID =3




SELECT 
    CUFD.TableID, 
    CUFD.AliasID, 
    CUFD.Descr AS FieldDescription, 
    UFD1.FldValue AS ValidValue, 
    UFD1.Descr AS ValueDescription
FROM 
    CUFD
INNER JOIN 
    UFD1
ON 
    CUFD.TableID = UFD1.TableID 
    AND CUFD.FieldID = UFD1.FieldID
WHERE 
    CUFD.TableID = 'OITM' -- Tabla de artículos
    AND CUFD.FieldID = 1; -- Campo específico
