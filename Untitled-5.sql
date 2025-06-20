SELECT *
  FROM [Power_BI].[dbo].[temporal]



  SELECT TOP(10)*
  FROM dm_db_objects_disabled_on_compatibility_level_change()

  




  Select
  c.ItemCode,e.DocDate, c.LineTotal,c.Quantity,e.CardCode
  FROM OPDN e
  INNER JOIN PDN1 c ON c.DocEntry = e.DocEntry