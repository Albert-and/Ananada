SELECT 
    T2.ItemCode, 
    T2.ItemName, 
    OITB.ItmsGrpNam AS 'Grupo de Artículos', 
    T2.SalUnitMsr,
    T2.LastPurPrc,
    T2.LastPurCur, 
    T2.U_TipoProv, 
    T2.U_Codigo, 
    T2.U_CLASIF_STORE,
    T2.U_Clasificacion
 
    FROM ANANDA_MAYOREO.dbo.OITM AS T2
INNER JOIN 
    OITB ON T2.ItmsGrpCod = OITB.ItmsGrpCod -- Relación con el grupo de artículos
WHERE T2.ItemCode IN 
(SELECT T1.ItemCode
FROM ANANDA_BD.dbo.OITM AS T1
WHERE T1.ItmsGrpCod IN (104, 105)  and T1.ItemCode NOT LIKE 'E%' and T1.ItemCode NOT LIKE 'G%' and T1.ItemCode NOT LIKE 'T%')