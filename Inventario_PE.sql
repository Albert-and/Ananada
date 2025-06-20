


SELECT
ItemCode AS 'SKU',
ItemName AS 'Descripcion',
OnHand AS 'En Stock',
LastPurPrc AS 'Ultimo Precio',
LastPurDat AS 'Fecha Ultima Compra',
BuyUnitMsr AS 'Unidad de Medida',
CardCode AS 'Proveedor',
SalPackMsr as 'INNER',
TaxCodeAR AS 'Impuesto',
NCMCode as 'Codigo SAT',
CodeBars AS 'Codigo de Barras',
FrgnName as 'ID Adicional'
FROM OITM
WHERE ItemCode LIKE 'P%'

,
FrgnName AS 'Nombre Foraneo',
ItmsGrpCod AS 'Grupo de Articulo',

SWeight1 AS 'Peso',
SHeight1 AS 'Altura',
SWidth1 AS 'Ancho',
SLength1 AS 'Longitud',
Svolume AS 'Volumen',

IsCommited AS 'Comprometido',
OnOrder AS 'Ordenado',



SELECT
ItemCode AS 'SKU',
ItemName AS 'Descripcion'
FROM OITM 