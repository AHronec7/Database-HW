
select*		
from		AdventureWorks2012.person.person pp12
full join	AdventureWorks2014.Person.Person pp14
on			pp12.BusinessEntityID = pp14.BusinessEntityID
where		pp12.FirstName <> pp14.FirstName or pp12.FirstName <> pp14.FirstName



select* from HumanResources.Employee

use AdventureWorks2012
update		HumanResources.Employee
set			BirthDate = dateadd(year, 10, BirthDate), hiredate = dateadd(year, 10, hiredate)




select		concat(pp14.firstname, ',', pp14.lastname) [Name], datediff(year, e12.BirthDate, e14.BirthDate), datediff(year, e12.hiredate, e14.hiredate)
from		AdventureWorks2012.HumanResources.Employee e12
full join	AdventureWorks2014.HumanResources.Employee e14
on			e12.BusinessEntityID = e14.BusinessEntityID
inner join	AdventureWorks2014.Person.Person pp14
on			e12.BusinessEntityID = e14.BusinessEntityID
group by	concat(pp14.firstname, ',', pp14.lastname)




select		SUM(pod.ReceivedQty) [Recieved QTY],sum(pod.RejectedQty) [Rejected QTY], max(v.AccountNumber) [account number],
			sum(pod.RejectedQty) / SUM(pod.ReceivedQty) * 100 [percent],
			case max( v.creditrating)
									  when 1 then 'superior'
									  when 2 then 'excellent'
									  when 3 then 'above average'
									  when 4 then 'average'
									  when 5 then 'below average' 
END [credit rating], Name,  

case when v.PreferredVendorStatus = '1' then 'no' else 'yes' end [status]				
from		Purchasing.ProductVendor pv
inner join	Purchasing.PurchaseOrderDetail pod
on			pv.ProductID = pod.ProductID
inner join	Purchasing.Vendor v
on			v.BusinessEntityID = pv.BusinessEntityID
group by	Name, v.PreferredVendorStatus


			





					


