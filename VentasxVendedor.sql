


SELECT o.DocNum as 'PEDIDO',o.DocDate AS 'FECHA',o.CardCode AS 'CODIGOCLIENTE',o.CardName AS 'NOMBRE CLIENTE',o.DocTotal AS 'TOTAL DOCUMENTO', DocEntry,
o.Address2 AS 'ENVIO',f.lastName AS 'Empleado Ventas Apellido',f.firstName AS 'Empleado Ventas Apellido',O.SlpCode as 'NO EMPLEADO', o.U_EstatusOV, o.DocTotal
FROM ORDR o
INNER JOIN OHEM f ON f.empID = o.SlpCode
WHERE  o.DocNum = '564023'

1027


select *
from RDR1
WHERE DocEntry = '31886'



Select CardCode, CardName
FROM OCRD
Where CardType = 'C'




SELECT        T0.CardCode AS CodigoCliente, T0.E_Mail AS PortalUser, T0.Password AS PortalPass, T0.CardName AS RazonSocial, T0.CardFName AS NombreAlterno, T0.Currency AS Moneda, T0.LicTradNum AS RFC, T0.Phone1 AS Telefono1,
                          T0.Phone2 AS Telefono2, T0.E_Mail AS Email, CASE validFor WHEN 'Y' THEN 'A' ELSE 'N' END AS Estatus, T0.ListNum AS CodigoListaPrecio, T0.GroupNum AS CodigoCondPago, T0.Free_Text AS Comentarios, 
                         T0.CreditLine AS LimiteCredito, T0.DebtLine AS LimiteComprometido, T0.Balance AS Saldo, T0.DNotesBal AS SaldoEntrega, T0.OrdersBal AS SaldoPedidos, T1.SlpCode AS CodigoAsesor, T1.SlpName AS NombreAsesor, 
                         T1.Email AS EmailAsesor, T2.empID AS CodigoVendedor, ISNULL(T2.firstName, '') + ' ' + ISNULL(T2.middleName, '') + ' ' + ISNULL(T2.lastName, '') AS NombreVendedor, T2.email AS EmailVendedor
FROM            dbo.OCRD AS T0 LEFT OUTER JOIN
                         dbo.OSLP AS T1 ON T1.SlpCode = T0.SlpCode LEFT OUTER JOIN
                         dbo.OHEM AS T2 ON T2.empID = T0.DfTcnician
WHERE        (T0.CardType = 'C') ANd t0.CardCode = 137023




565

AND c.ItemCode = $[@CAL1.U_SKU.0]++





SELECT je1.TransId ,je.RefDate ,acc.AcctCode ,acc.AcctName ,je.Memo ,je1.Debit ,je1.Credit FROM JDT1 as je1

left join OPRC as prc on je1.ProfitCode = prc.PrcCode

left join OPRC as prc2 on je1.OcrCode2 = prc2.PrcCode

left join OPRC as prc3 on je1.OcrCode3 = prc3.PrcCode

left join OPRC as prc4 on je1.OcrCode4 = prc4.PrcCode

left join OPRC as prc5 on je1.OcrCode5 = prc5.PrcCode

inner join OACT as acc on je1.Account = acc.AcctCode

inner join OJDT as je on je1.TransId = je.TransId

----and je.RefDate >= '20220101'

GROUP BY je1.TransId ,je.RefDate ,acc.AcctCode ,acc.AcctName ,je.Memo ,je1.Debit ,je1.Credit