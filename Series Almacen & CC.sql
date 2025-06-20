


-----Almacen por series----


--Original------
SELECT
CASE
WHEN $[$88.1] = 77 THEN 'ALPE'
WHEN $[$88.1] = 76 THEN 'ALPO'
ELSE 'ALPM' END


SELECT
CASE
WHEN $[$88.1] = 77 THEN 'ALPE'
WHEN $[$88.1] = 76 THEN 'ALPO'
WHEN $[$88.1] = 155 THEN 'ALMK'
ELSE 'ALPM' END


----------------

--Canal de ventas por serie---

---Original---
SELECT CASE WHEN $[$88.1] = 77 THEN 'A003' WHEN $[$88.1] = 76 THEN 'A002' ELSE 'A001' END


SELECT
CASE
WHEN $[$88.1] = 77 THEN 'A003'
WHEN $[$88.1] = 76 THEN 'A002'
WHEN $[$88.1] = 155 THEN 'A005'
ELSE 'A001' END

------




Select
DocNum,
Series
FROM ORDR
WHERE DocNum = 40000000



Select
DocNum,
Series
FROM ORDR
WHERE DocNum = 30000792