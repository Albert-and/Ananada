WITH Ventas AS (
    SELECT
        T0.DocDate AS Fecha,
        T5.ItmsGrpNam AS Grupo_Articulo,
        T1.seriesname AS Serie,
        SUM(T3.LineTotal) AS Total
    FROM
        OINV T0
        INNER JOIN NNM1 T1 ON T0.Series = T1.Series
        INNER JOIN INV1 T3 ON T0.DocEntry = T3.DocEntry
        INNER JOIN OITM T4 ON T4.itemcode = T3.Itemcode
        INNER JOIN OITB T5 ON T5.ItmsGrpCod = T4.ItmsGrpCod
    WHERE
        T0.CANCELED = 'N' AND T1.SeriesName <> 'SI'
    GROUP BY
        T0.DocDate, T5.ItmsGrpNam, T1.seriesname
),
Notas_Credito AS (
    SELECT
        T0.DocDate AS Fecha,
        T5.ItmsGrpNam AS Grupo_Articulo,
        T1.seriesname AS Serie,
        SUM(T3.LineTotal) AS Total
    FROM
        ORIN T0
        INNER JOIN NNM1 T1 ON T0.Series = T1.Series
        INNER JOIN INV1 T3 ON T0.DocEntry = T3.DocEntry
        INNER JOIN OITM T4 ON T4.itemcode = T3.Itemcode
        INNER JOIN OITB T5 ON T5.ItmsGrpCod = T4.ItmsGrpCod
    WHERE
        T0.CANCELED = 'N' AND T1.SeriesName <> 'SI'
    GROUP BY
        T0.DocDate, T5.ItmsGrpNam, T1.seriesname
)
SELECT
    v.Fecha,
    v.Grupo_Articulo,
    v.Serie,
    v.Total - COALESCE(nc.Total, 0) AS Total_Neto,
    COALESCE(nc.Total, 0) AS Notas_Credito
FROM
    Ventas v
    LEFT JOIN Notas_Credito nc ON v.Fecha = nc.Fecha AND v.Grupo_Articulo = nc.Grupo_Articulo AND v.Serie = nc.Serie
ORDER BY
    v.Fecha, v.Grupo_Articulo, v.Serie;