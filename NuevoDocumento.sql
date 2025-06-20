

DECLARE @CONT AS INT ---CONTADOR
DECLARE @STAT AS NVARCHAR(2) --- ESTATUS DE DOCUMENTO ABIERTO O CERRADO
DECLARE @ULTDOC AS INT ---NUMERO ULTIMO DOCUMENTO
 SET @CONT = (SELECT COUNT(T4.[DocNum]) FROM ORDR T4)
SET @ULTDOC = (SELECT MAX(T4.[DocNum]) FROM ORDR T4)
SET @STAT = (SELECT T4.DocStatus FROM ORDR T4 WHERE T4.[DocNum] = @ULTDOC)
IF @STAT = 'O'
BEGIN 
SELECT DISTINCT T4.[DocNum] as 'N° Orden de Venta a Facturar' FROM [dbo].[OPDN]
T0 INNER JOIN PDN1 T1 ON T0.DocEntry = T1.DocEntry INNER JOIN OPOR T2 ON T1.BaseRef = T2.DocEntry
INNER JOIN POR1 T3 ON T2.DocEntry = T3.DocEntry INNER JOIN ORDR T4 ON T3.BaseRef = T4.DocEntry 
WHERE @CONT > '0' AND T4.[DocStatus] = 'O'
END


-----Solicitud de Devoluciones ----------------------- ORDN

SELECT T0.[DocNum], T0.[CardName], T0.DocDate
FROM ORDR T0
LEFT JOIN ALR3 TB ON convert(char,T0.DocNum) = TB.Value and  TB.ObjType = 20
LEFT JOIN OALR TA ON TB.Code = TA.Code WHERE ( TA.Subject = 'Pedidos' or  TA.Subject is null) and
( TA.Type = 'A' or TA.Type is null) and (TB.Location = '0' or TB.Location is null)
and TB.Code is null