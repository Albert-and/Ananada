

----Por descripcion de articulo ----
-------Actualizacion automatica si se producen modificaciones + Visualizar valores definidos por usuario ----


---Unidad de medida ---

Select DISTINCT InvntryUom
FROM OITM
WHERE InvntryUom LIKE 'H87'


----IVA en Productos---
---------------Impuesto indirecto

Impuesto Indirecto
-----------------
Select DISTINCT TaxCodeAP
FROM OITM
WHERE TaxCodeAP LIKE 'IVAP16'

Select DISTINCT TaxCodeAR
FROM OITM
WHERE TaxCodeAR LIKE 'IVAC16'
-----------------------------
----Inner ---
Select DISTINCT SalPackMsr
FROM OITM
WHERE SalPackMsr LIKE 'INNER'


--------------
----Ma_Demanda---
-------Actualizacion automatica si se producen modificaciones + Visualizar valores definidos por usuario ----
--------------------

Select DISTINCT PlaningSys
FROM OITM
WHERE PlaningSys LIKE 'M'



