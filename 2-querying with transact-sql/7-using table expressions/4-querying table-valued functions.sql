CREATE FUNCTION SalesLT.udfCustomersByCity(@City AS VARCHAR(20))
RETURNS TABLE
AS
RETURN
(SELECT c.CustomerID, c.FirstName, c.LastName, a.AddressLine1, a.City, a.StateProvince
FROM SalesLT.Customer AS c
JOIN SalesLT.CustomerAddress AS ca
ON c.CustomerID = ca.CustomerID
JOIN SalesLT.Address AS a
ON ca.AddressID = a.AddressID
WHERE a.City = @City);

SELECT * FROM SalesLT.udfCustomersByCity('Bellevue');