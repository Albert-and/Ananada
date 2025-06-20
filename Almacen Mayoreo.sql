
----------Reporte Almacen--------------

SELECT o.ItemCode,
o.ItemName,
s.OnHand as 'Stock',
s.IsCommited as 'Comprometido',
s.OnHand - s.IsCommited as 'Disponible',
s.WhsCode
FROM OITW s
INNER JOIN OITM o ON s.ItemCode = o.ItemCode
WHERE  s.WhsCode = 'ALPM' AND s.OnHand - s.IsCommited > 0
order by o.ItemCode

-------------------

SELECT o.ItemCode,
o.ItemName,
s.OnHand as 'Stock',
s.IsCommited as 'Comprometido',
s.OnHand - s.IsCommited as 'Disponible',
s.WhsCode
FROM OITW s
INNER JOIN OITM o ON s.ItemCode = o.ItemCode
WHERE  s.WhsCode = 'ALPC' AND s.OnHand - s.IsCommited > 0
order by o.ItemCode

---------------------------

SELECT o.ItemCode,
o.ItemName,
s.OnHand as 'Stock',
s.IsCommited as 'Comprometido',
s.OnHand - s.IsCommited as 'Disponible',
s.WhsCode
FROM OITW s
INNER JOIN OITM o ON s.ItemCode = o.ItemCode
WHERE  s.WhsCode = 'ALIN' AND s.OnHand - s.IsCommited > 0
order by o.ItemCode