/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [Code]
      ,[LineId]
      ,[Object]
      ,[LogInst]
      ,[U_Cantidad]
      ,[U_Articulo]
      ,[U_Desc_Incidencia]
  FROM [Pruebas_V10].[dbo].[@ACAL1]

  SELECT *
  FROM [Pruebas_V10].[dbo].[@OCAL]

  SELECT *
  FROM [Pruebas_V10].[dbo].[@ACAL1]
  
  SELECT *
  FROM [Pruebas_V10].[dbo].[@ACAL2]


  SELECT e.Code,e.U_Estatus,e.CreateDate,d.U_Cantidad,
  d.U_Articulo,d.U_Desc_Incidencia,f.U_Costo,f.U_Responsable_Investigacion,f.U_Resumen_Investigacion,f.U_Solucion
  FROM [Pruebas_V10].[dbo].[@OCAL] e
  INNER JOIN [Pruebas_V10].[dbo].[@ACAL1] d ON e.Code = d.Code
  INNER JOIN [Pruebas_V10].[dbo].[@ACAL2] f ON e.Code = f.Code