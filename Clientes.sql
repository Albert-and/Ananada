

select top(10)*
from OCRD


SELECT TOP(10) CardCode AS 'CV_CLIENTE',CardName AS 'NOMBRE',Cellular AS 'CELULAR',E_Mail AS 'EMAIL'
FROM OCRD


SELECT TOP(10)*
FROM CRD1
-------------------

SELECT f.firstName as 'Vtas_Nombre',f.lastName 'Vtas_Apellido',o.CardCode AS 'CV_CLIENTE',o.CardName AS 'NOMBRE',o.Cellular AS 'CELULAR',o.E_Mail AS 'EMAIL',
c.Address as 'Direccion',c.Street as 'Calle', c.Block as 'Colonia', c.ZipCode as 'Codigo Postal', c.City as 'Ciudad', c.Country as 'Alcaldia/Municipio'
FROM OCRD o
INNER JOIN CRD1 c ON o.CardCode = c.CardCode
INNER JOIN OHEM f ON o.OwnerCode = f.empID
Where o.CardType = 'C'


--------------------------/////*


select o.CardType,o.OwnerCode as 'EmpleadoVtas',o.CardCode AS 'CV_CLIENTE',o.CardName AS 'NOMBRE',o.Cellular AS 'CELULAR',o.E_Mail AS 'EMAIL',
c.Address as 'Direccion',c.Street as 'Calle', c.Block as 'Colonia', c.ZipCode as 'Codigo Postal', c.City as 'Ciudad', c.Country as 'Alcaldia/Municipio'
FROM OCRD o
INNER JOIN CRD1 c ON o.CardCode = c.CardCode
Where o.CardCode = 'P467'


*****************************************************

select o.CardCode,o.CardFName,t.ItemCode,t.ItemName
from OCRD o
inner join OITM t ON o.CardCode = t.CardCode
Where o.CardCode = 'P466'

*************************************************************
select *
from OITM
where CardCode = 'P466'


SELECT *
FROM INV1
WHERE ItemCode = '1009001' AND DocDate BETWEEN '05/01/2021' AND '05/20/2021'