




SELECT * 
  FROM [ANANDA_BD].[dbo].[@MANIFIESTOC]
  Where UpdateDate >= CONVERT(DATE, GETDATE()-180)


  SELECT TOP(10)* 
  FROM [ANANDA_BD].[dbo].[@MANIFIESTOC]


  -----------------------------

SELECT
----d.U_NEntrega AS 'No.Entrega',
d.U_Pedido AS 'No.Pedido',
d.U_Tienda AS 'Nombre',
d.U_Direccion AS 'Direccion',
d.U_Guia AS 'Guia',
c.U_Servicio AS 'Paqueteria',
c.CreateDate AS 'Fecha de creacion',
o.DocTotal AS 'Total Documento'
FROM [ANANDA_BD].[dbo].[@MANIFIESTOD] d
INNER JOIN[ANANDA_BD].[dbo].[@MANIFIESTOC] c ON c.DocEntry = d.DocEntry
INNER JOIN ORDR o ON o.DocNum = d.U_Pedido
Where c.CreateDate BETWEEN CONVERT(DATE, GETDATE()-4) AND CONVERT(DATE, GETDATE())





WHERE d.U_Pedido = 620023


WHERE d.U_NEntrega = 321212


321212
WHERE d.U_Pedido = 620023

Where c.CreateDate BETWEEN CONVERT(DATE, GETDATE()-4) AND CONVERT(DATE, GETDATE())

-----------------------------------

  


-----------------Entrega------------------
 select *
 from ODLN
 where DocNum= 321212
 --------------------------------------
 
 ----------Pedidos-------------------
 select *
 from ORDR
 where DocNum= 620023
 --------------------------------------


 select *
 from RDR1 
 where DocEntry = 620023

 ------------------

  SELECT DISTINCT
	M1.ItemCode as [Codigo]
	, M1.ItemName as [Descripcion]
	, T5.DocDate as [F. Necesaria]
	, T1.DocDate as [F. Pedido]
	, T3.DocDate as [F. Entrada]
FROM
	[dbo].[POR1] T0
	INNER JOIN [dbo].[OITM] M1 ON M1.ItemCode = T0.ItemCode
	INNER JOIN [dbo].[OPOR] T1 ON T1.DocEntry = T0.DocEntry 
	INNER JOIN [dbo].[PDN1] T2 ON T2.ObjType = T0.TargetType AND T2.DocEntry = T0.TrgetEntry
	INNER JOIN [dbo].[OPDN] T3 ON T3.DocEntry = T2.DocEntry
	INNER JOIN [dbo].[PQT1] T4 ON T4.TargetType = T0.ObjType AND T4.TrgetEntry = T0.DocEntry
	INNER JOIN [dbo].[OPQT] T5 ON T5.DocEntry = T4.DocEntry
WHERE
	T1.DocNum = 1020





 -------------------------------------------

 SELECT TOP(10)* 
  FROM [ANANDA_BD].[dbo].[@MANIFIESTOD]
  Where UpdateDate = '2021-09-22'
  



  select *
 from ODLN 
 Where DocNum = 137933


 INNER JOIN [ANANDA_BD].[dbo].[@MANIFIESTOD] c ON o.DocEntry = c.DocEntry
INNER JOIN [ANANDA_BD].[dbo].[@MANIFIESTOC] c ON o.DocEntry = c.DocEntry


--------------------------

SELECT DISTINCT
d.U_Pedido AS 'No.Pedido',
d.U_Tienda AS 'Nombre',
d.U_Direccion AS 'Direccion',
d.U_Guia AS 'Guia',
c.U_Servicio AS 'Paqueteria',
c.CreateDate AS 'Fecha de creacion',
o.DocTotal AS 'Total Documento'
FROM [ANANDA_BD].[dbo].[@MANIFIESTOD] d
INNER JOIN[ANANDA_BD].[dbo].[@MANIFIESTOC] c ON c.DocEntry = d.DocEntry
INNER JOIN ORDR o ON o.DocNum = d.U_Pedido
Where c.CreateDate BETWEEN CONVERT(DATE, GETDATE()-4) AND CONVERT(DATE, GETDATE()) AND d.U_Pedido LIKE '5%'
ORDER BY c.CreateDate




------------------------------

SELECT distinct

T0.[DocNum] 'Orden de Venta',

T0.[DocDate] 'Fecha OV',

T7.[SlpName] 'Vendedor',

T8.[lastName]+' '+T8.[firstName] 'DP',

T0.[U_FCOrden] 'Instalador',

T0.[Project] 'UN',

T0.[U_OrdTecni] 'Fecha Fin',

T0.[DocTotal] 'Monto',

T0.[DiscPrcnt] 'Desc OV',

T4.[DocNum] 'Factura',

T4.[DiscPrcnt] 'Desc Fac'

FROM ORDR T0

INNER JOIN DLN1 T1 ON T1.[BaseEntry] = T0.[DocEntry] and t0.[ObjType] = t1.[BaseType]

INNER JOIN ODLN T2 ON T2.[DocEntry] = T1.[DocEntry]

INNER JOIN INV1 T3 ON T3.[BaseEntry] = T2.[DocEntry] and t2.[ObjType] = t3.[BaseType]

INNER JOIN OINV T4 ON T4.[DocEntry] = T3.[DocEntry]

INNER JOIN OSLP T7 ON T0.[SlpCode] = T7.[SlpCode]

INNER JOIN OHEM T8 ON T0.[OwnerCode] = T8.[EmpID]

WHERE T0.[DocDate] between [%0] and [%1]