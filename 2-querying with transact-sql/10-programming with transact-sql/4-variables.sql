-- Search by city using a variable
DECLARE @City AS VARCHAR(20) = 'Toronto'
SET @City = 'Bellevue'

SELECT c.FirstName + ' ' + c.LastName AS Name, a.AddressLine1 AS Address, a.City
FROM SalesLT.Customer AS c
JOIN SalesLT.CustomerAddress AS ca
ON c.CustomerID = ca.CustomerID
JOIN SalesLT.Address AS a
ON ca.AddressID = a.AddressID
WHERE a.City = @City;

-- Use a variable as an output
DECLARE @Result AS MONEY

SELECT @Result = MAX(TotalDue)
FROM SalesLT.SalesOrderHeader

PRINT @Result;