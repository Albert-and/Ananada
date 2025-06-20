SELECT
ItemCode,
CardCode
FROM OITM
Where ItmsGrpCod IN (101,102)
AND CardCode IS NULL







Select
ItemCode,
ItemName,
U_ReqMaq as Maquila,
U_Clasificacion as Clasificacion,
U_TipoProv as TipoProveedor,
U_CLASIF_STORE as Proveedor,
U_codigo as Categoria
from OITM
WHERE ItmsGrpCod IN (101,102)







SELECT
DocNum,
CardCode,
DocDate,
DocDueDate
FROM ORDR
WHERE Series = 9






SELECT
DocNum,
CardCode,
DocDate,
DocDueDate
FROM OPOR
WHERE Series = 9



SELECT *
  FROM [ANANDA_MAYOREO].[dbo].[@CATEGORIA]







Select
ItemCode,
ItemName,
U_ReqMaq as Maquila,
U_Clasificacion as Clasificacion,
U_TipoProv as TipoProveedor,
U_CLASIF_STORE as Proveedor,
U_codigo as Categoria
from OITM
WHERE ItmsGrpCod IN (101,102)




SELECT 
    T0.DocNum AS 'Número de Documento',
    T0.Series,
    T1.ItemCode AS 'Código de Artículo',
    T1.Dscription AS 'Descripción del Artículo',
    T1.Quantity AS 'Cantidad Solicitada',
    T2.SalPackUn AS 'Cantidad por Empaque de Ventas'
FROM 
    ORDR T0 -- Cabecera de la Orden de Venta
    INNER JOIN RDR1 T1 ON T0.DocEntry = T1.DocEntry -- Detalle de la Orden de Venta
    INNER JOIN OITM T2 ON T1.ItemCode = T2.ItemCode -- Datos Maestros de Artículos
WHERE 
T0.DocDate >= '20241217' AND
    T1.Quantity % T2.SalPackUn <> 0 -- Verifica si la cantidad no es múltiplo del empaque de ventas
    AND T2.SalPackUn > 0
    AND T0.CardCode <> 'CM100136'
    AND T0.Series <> 77
    AND T0.DocStatus = 'O'





Select *
FROM ORDR
where DocNum =    20001556







Select
ItemCode,
ItemName,
U_ReqMaq as Maquila,
U_Clasificacion as Clasificacion,
U_TipoProv as TipoProveedor,
U_CLASIF_STORE as Proveedor,
U_codigo as Categoria,
U_Componente1 as Componente1,
U_Componente2 as Componente2,
U_Componente3 as Componente3,
U_Componente4 as Componente4,
U_Componente5 as Componente5,
U_Componente6 as Componente6,
U_Componente7 as Componente7,
U_Componente8 as Componente8
from OITM
WHERE ItmsGrpCod IN (101,102)
AND U_ReqMaq IS NOT NULL
AND U_Componente1 IS NOT NULL





Select
ItemCode,
ItemName,
U_ReqMaq as Maquila,
U_Clasificacion as Clasificacion,
U_TipoProv as TipoProveedor,
U_CLASIF_STORE as Proveedor,
U_codigo as Categoria,
U_Componente1 as Componente1,
U_Componente2 as Componente2,
U_Componente3 as Componente3,
U_Componente4 as Componente4,
U_Componente5 as Componente5,
U_Componente6 as Componente6,
U_Componente7 as Componente7,
U_Componente8 as Componente8
from OITM
WHERE ItmsGrpCod IN (101,102)
AND U_ReqMaq = 'Sí'






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




SELECT *
  FROM [ANANDA_MAYOREO].[dbo].[@PROVEEDOR_M]



--------------- ORDENES de COMPRA Basado en Forecast ----

SELECT 
    d.ItemCode AS 'Código Artículo',
    c.DocDate AS 'Fecha Documento',
    c.Series AS 'Serie',
    c.DocNum AS 'Número Documento',
    d.LineNum AS 'Número Línea',
    d.Quantity AS 'Cantidad',
    c.DocDueDate AS 'Fecha Vencimiento'
FROM 
    POR1 d
INNER JOIN 
    OPOR c ON c.DocEntry = d.DocEntry
WHERE 
    EXISTS (SELECT 1 FROM FCT1 f WHERE f.ItemCode = d.ItemCode)
ORDER BY 
    c.DocDate, c.DocNum, d.LineNum;

--------------------Optimizado----------------


---Encabezado de Ordenes de compra--

SELECT DISTINCT 
    c.DocNum AS id,
    c.CardCode as tpartner_id,
    c.Series AS order_type,
     c.DocDate as order_creation_date,
    c.DocDueDate AS sunmitted_date
FROM 
    POR1 d
INNER JOIN 
    OPOR c ON c.DocEntry = d.DocEntry
WHERE 
    EXISTS (SELECT 1 FROM FCT1 f WHERE f.ItemCode = d.ItemCode);

-----------------------------------



-----Outobound Records----------
SELECT
e.DocNum as cust_order_id,
e.CardCode as customer_tpartner_id,
e.DocStatus as status,
e.DocDate as requested_delivery_date,
e.DocDueDate as order_date,
d.ItemCode as product_id,
d.Quantity
FROM OINV e
INNER JOIN INV1 d ON e.DocEntry = d.DocEntry
WHERE e.CANCELED = 'N'
AND
    EXISTS (SELECT 1 FROM FCT1 f WHERE f.ItemCode = d.ItemCode);
