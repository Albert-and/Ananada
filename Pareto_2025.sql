
WITH VentasMensuales AS (
    SELECT
        DATENAME(YEAR, OINV.DocDate) AS 'Año', -- Año de la venta
        DATENAME(MONTH, OINV.DocDate) AS 'Mes', -- Mes de la venta
        OINV.CardCode AS 'Código Cliente', -- Código del cliente
        OINV.CardName AS 'Nombre Cliente', -- Nombre del cliente
        SUM(OINV.DocTotal) AS 'Total_Ventas' -- Total de ventas por cliente en el mes
    FROM 
        OINV -- Tabla de facturas
    WHERE 
        OINV.CANCELED = 'N' -- Excluir facturas canceladas
        AND OINV.DocDate >= DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0) -- Primer día del mes actual
        AND OINV.DocDate < DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()) + 1, 0) -- Primer día del próximo mes
    GROUP BY 
        DATENAME(YEAR, OINV.DocDate), 
        DATENAME(MONTH, OINV.DocDate), 
        OINV.CardCode, 
        OINV.CardName
),
VentasTotalesMes AS (
    SELECT
        Año,
        Mes,
        SUM(Total_Ventas) AS 'Ventas_Totales_Mes' -- Total de ventas en el mes
    FROM 
        VentasMensuales
    GROUP BY 
        Año, 
        Mes
),
VentasConPorcentaje AS (
    SELECT
        VM.Año,
        VM.Mes,
        VM.[Código Cliente],
        VM.[Nombre Cliente],
        VM.[Total_Ventas],
        (VM.[Total_Ventas] * 100.0 / VTM.[Ventas_Totales_Mes]) AS 'Porcentaje_Ventas' -- Porcentaje de ventas del cliente
    FROM 
        VentasMensuales VM
    INNER JOIN 
        VentasTotalesMes VTM ON VM.Año = VTM.Año AND VM.Mes = VTM.Mes
),
VentasAcumuladas AS (
    SELECT
        Año,
        Mes,
        [Código Cliente],
        [Nombre Cliente],
        [Total_Ventas],
        [Porcentaje_Ventas],
        SUM([Porcentaje_Ventas]) OVER (PARTITION BY Año, Mes ORDER BY [Total_Ventas] DESC) AS 'Porcentaje_Acumulado' -- Porcentaje acumulado
    FROM 
        VentasConPorcentaje
)
SELECT 
    Año,
    Mes,
    [Código Cliente],
    [Nombre Cliente],
    [Total_Ventas],
    [Porcentaje_Ventas],
    [Porcentaje_Acumulado]
FROM 
    VentasAcumuladas
ORDER BY 
    Año, 
    Mes, 
    [Porcentaje_Acumulado];