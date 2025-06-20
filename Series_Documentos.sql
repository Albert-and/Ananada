
SELECT
Series,
SeriesName,
BeginStr,
CONCAT(SeriesName,'-',BeginStr) AS TIPO
FROM NNM1
WHERE BeginStr LIKE 'F%' or BeginStr LIKE 'P%'



Busquedas formateadas ALMACEN por OC
SELECT CASE WHEN $[$88.1] = 77 THEN 'ALPE' WHEN $[$88.1] = 76 THEN 'ALPO' ELSE 'ALPM' END

Cambio
SELECT CASE
 WHEN $[$88.1] = 77 THEN 'ALPE'
 WHEN $[$88.1] = 76 THEN 'ALPO'
 WHEN $[$88.1] = 121 THEN 'ALMP'
 ELSE 'ALPM' END

Busqueda formateada por Centro de Costos
SELECT CASE WHEN $[$88.1] = 77 THEN 'A003' WHEN $[$88.1] = 76 THEN 'A002' ELSE 'A001' END


Canmbio
SELECT CASE
WHEN $[$88.1] = 77 THEN 'A003'
WHEN $[$88.1] = 76 THEN 'A002'
WHEN $[$88.1] = 121 THEN 'A004'
ELSE 'A001' END
