  SELECT
  orden_venta,
  DATEADD(hour, -1,hora_inicio_surtido) as 'h_inc_surtido',
  DATEADD(hour, -1,hora_termino_surtido) as 'h_term_surtido',
  DATEADD(hour, -1,hora_inicio_verificado) as 'h_inc_verif',
  DATEADD(hour, -1,hora_termino_verificado) as 'h_term_verif',
  fecha_surtir,
  fecha_inicio_surtido,
  fecha_termino_surtido,
  fecha_inicio_verificado,
  fecha_termino_verificado
  FROM [bd_dalia_test].[dbo].[tbl_registro]
  Where fecha_surtir >= '2024-03-01' AND orden_venta > 800000


-----------------------------------------------------------------------
  SELECT
  orden_venta,
  CONCAT(CONVERT(varchar, fecha_surtir, 103), ' ', CONVERT(varchar, hora_inicio_surtido, 108)) as 'fecha_hora_inicio_surtido',
  CONCAT(CONVERT(varchar, fecha_surtir, 103), ' ', CONVERT(varchar, hora_termino_surtido, 108)) as 'fecha_hora_termino_surtido',
  CONCAT(CONVERT(varchar, fecha_surtir, 103), ' ', CONVERT(varchar, hora_inicio_verificado, 108)) as 'fecha_hora_inicio_verif',
  CONCAT(CONVERT(varchar, fecha_surtir, 103), ' ', CONVERT(varchar, hora_termino_verificado, 108)) as 'fecha_hora_termino_verif'
FROM [bd_dalia_test].[dbo].[tbl_registro]
Where fecha_surtir >= '2024-03-01' AND orden_venta > 800000

-----------------------------------------------------------------------------