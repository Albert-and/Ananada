SELECT
ItemCode AS 'SKU',
CardCode AS 'Proveedor',
FrgnName AS 'Nombre Foraneo',
ItmsGrpCod AS 'Grupo de Articulo',
CodeBars AS 'Codigo de Barras',
SWeight1 AS 'Peso',
SHeight1 AS 'Altura',
SWidth1 AS 'Ancho',
SLength1 AS 'Longitud',
Svolume AS 'Volumen',
OnHand AS 'Disponible',
IsCommited AS 'Comprometido',
OnOrder AS 'Ordenado',
BuyUnitMsr AS 'Unidad de Medida',
LastPurPrc AS 'Ultimo Precio',
LastPurDat AS 'Fecha Ultima Compra'
FROM OITM 
