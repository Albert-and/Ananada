


---Relacion de Proveedores con Facturas y Articulos -----
SELECT 
    T0."DocNum" AS "No. Factura",          -- Número de factura
    T0."CardName" AS "Nombre Proveedor",   -- Nombre del proveedor
    T1."ItemCode" AS "Código Artículo",    -- Código del artículo
    T1."Dscription" AS "Descripción Artículo", -- Descripción del artículo
    T1."LineTotal" AS "Valor Línea",       -- Valor total de la línea
    T1."AcctCode" AS "Código Cuenta",      -- Código de la cuenta referenciada
    T2."AcctName" AS "Nombre Cuenta"       -- Nombre de la cuenta referenciada
FROM 
    OPCH T0
INNER JOIN 
    PCH1 T1 ON T0."DocEntry" = T1."DocEntry" -- Relación entre cabecera y detalle
LEFT JOIN 
    OACT T2 ON T1."AcctCode" = T2."AcctCode" -- Relación con la cuenta contable
WHERE 
    T0."DocDate" >= '2025-01-01' 
    AND T0."DocDate" <= '2025-01-31'        -- Rango de fechas (ajustar según necesidad)
ORDER BY 
    T0."DocNum", T1."LineNum";              -- Ordenar por número de factura y línea

----------------------------------