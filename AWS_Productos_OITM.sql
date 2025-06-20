

SELECT 
    OITM.ItemCode, 
    OITM.ItemName, 
    OITB.ItmsGrpNam AS 'Grupo de Artículos', 
    OITM.SalUnitMsr,
    OITM.LastPurPrc,
    OITM.LastPurCur, 
    OITM.U_TipoProv, 
    OITM.U_Codigo, 
    OITM.U_CLASIF_STORE,
    OITM.U_Clasificacion
FROM 
    OITM
INNER JOIN 
    OITB ON OITM.ItmsGrpCod = OITB.ItmsGrpCod -- Relación con el grupo de artículos
WHERE 
    OITM.ItmsGrpCod in (104,105) and OITM.ItemCode NOT LIKE 'E%' and OITM.ItemCode NOT LIKE 'G%' and OITM.ItemCode NOT LIKE 'T%'
ORDER BY 
    OITM.ItemCode;