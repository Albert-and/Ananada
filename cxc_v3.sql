
select
T1.cardcode 'Codigo',
T1.CardFName AS 'Codigo anterior',
T0.Ref2,
case T0.transtype
when '13' then 'Factura'
when '14' then 'Nota Credito'
when '24' then 'Pagos'
else 'Otro'
end 'Tipo Trans',
t0.Ref1 'Referencia',
t2.TransCode AS 'Codigo tRANS',
CONVERT(VARCHAR(10), t0.RefDate, 103) 'Fecha Docto' ,
CONVERT(VARCHAR(10), t0.DueDate, 103) 'Vence Docto',
DATEDIFF(day,t0.refdate,t0.duedate) as 'Dias',
CASE
when (DATEDIFF(dd,t0.RefDate,current_timestamp))+1 < 31
then
case
when syscred <> 0 then isnull(-BALDUECRED,0)
else isnull(sysdeb,0)
end
end "0-30 Dias",
case when ((datediff(dd,t0.RefDate,current_timestamp))+1 > 30
and (datediff(dd,t0.RefDate,current_timestamp))+1< 61)
then
case
when syscred <> 0 then isnull(-BALDUECRED,0)
else isnull(sysdeb,0)
end
end "31 to 60 Dias",
case when ((datediff(dd,t0.RefDate,current_timestamp))+1 > 60
and (datediff(dd,t0.RefDate,current_timestamp))+1< 91)
then
case
when syscred <> 0 then isnull(-BALDUECRED,0)
else isnull(sysdeb,0)
end
end "61 to 90 Dias",
CASE
when (DATEDIFF(dd,t0.RefDate,current_timestamp))+1 > 90
then
case
when syscred= 0 then isnull(sysdeb,0)
when sysdeb= 0 then isnull(-BALDUECRED,0)
end
end "90 + Dias"
from          dbo.JDT1 T0 with(nolock)
INNER JOIN
dbo.OCRD T1  with(nolock)
ON T0.shortname = T1.cardcode
and T1.cardtype = 'C'
inner join
ojdt t2 on t0.transid=t2.transid
where  T0.intrnmatch = '0'

