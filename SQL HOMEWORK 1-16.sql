use AdventureWorks2012
--1
SELECT * FROM HumanResources.Employee

SELECT  e.BusinessEntityID AS EMPLOYEEID , p.lastname AS [Employeelastname], p.firstname AS [Employeefirstname], e.gender AS [M/F], e.JobTitle AS JOB, e.HireDate AS [DATE OF HIRE]
INTO    #humantemptable
FROM   HumanResources.Employee e
INNER JOIN  person.person P
on     e.BusinessEntityID = p.BusinessEntityID
ORDER BY e.HireDate desc



SELECT     ph.BusinessEntityID, ph.ratechangedate, ph.rate
INTO       #emptemptable
FROM       HumanResources.EmployeePayHistory ph
INNER JOIN HumanResources.Employee e
ON         ph.BusinessEntityID = e.BusinessEntityID








--2
use AdventureWorks2012

DECLARE pocursor CURSOR SCROLL STATIC
FOR    SELECT TOP 25 purchaseorderID, revisionnumber, [status], employeeID, vendorID, shipmethodID, orderdate, shipdate,
                     subtotal, taxAmt, freight, totaldue
FROM    purchasing.PurchaseOrderHeader
ORDER BY PurchaseOrderID desc


OPEN pocursor




	WHILE @@FETCH_STATUS = 0
	FETCH NEXT FROM pocursor
	

		--FETCH FIRST FROM pocursor --Fetches the first record
		--FETCH PRIOR FROM pocursor-- Fetches the previous record 
		--FETCH ABSOLUTE 10	FROM pocursor-- Fetches the 10th record
		--FETCH RELATIVE 10 FROM pocursor-- moves through 10 records at a time 

CLOSE pocursor
DEALLOCATE pocursor


		




--3
SELECT * FROM sales.SalesOrderHeader

ALTER TABLE sales.salesorderheader 
DROP CONSTRAINT DF_SalesOrderHeader_OrderDate

--Drops the constraint on the orderdate 



--4

SELECT TOP 1000
	    CONCAT(a.addressline1, ',',  a.addressline2, ',',  a.city,',',  sp.[name],',',  cr.[name])
FROM
	person.Address a
INNER JOIN
	person.StateProvince sp
ON  sp.StateProvinceID = a.StateProvinceID
INNER JOIN person.CountryRegion cr
ON	sp.CountryRegionCode = cr.CountryRegionCode



use AdventureWorks2012
GO

CREATE FUNCTION fnaddress
(

	@businessentityID INT 
	
)

RETURNS VARCHAR(MAX)
AS
BEGIN

DECLARE @address   VARCHAR(MAX)
SET     @address = 

(	SELECT 
	    CONCAT(a.addressline1, ',',  a.addressline2, ',',  a.city,',',  sp.[name],',',  cr.[name])
FROM
	person.Address a
INNER JOIN
	person.StateProvince sp
ON  sp.StateProvinceID = a.StateProvinceID
INNER JOIN person.CountryRegion cr
ON	sp.CountryRegionCode = cr.CountryRegionCode
INNER JOIN person.businessentity be
ON        a.addressID = be.businessentityID
INNER JOIN  person.person p
ON          p.BusinessEntityID = be.BusinessEntityID
WHERE     p.businessentityID = @businessentityID AND a.AddressID IS NOT NULL

)




RETURN @address
END
GO
	
--TEST
SELECT TOP 1000  [dbo].fnaddress(p.BusinessEntityID) FROM person.person p
INNER JOIN     person.BusinessEntityAddress bea
ON             p.BusinessEntityID = bea.BusinessEntityID
WHERE          bea.AddressID IS NOT NULL


--second method query 

SELECT		  P.LastName, p.FirstName, dbo.fnaddress(p.BusinessEntityID)
FROM		  Person.BusinessEntityAddress bea
INNER JOIN	  Person.person p
ON			  bea.BusinessEntityID = P.BusinessEntityID
     

  

















