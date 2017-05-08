-- Create a view
CREATE VIEW SalesLT.vCustomerAddress
AS
SELECT c.CustomerID, c.FirstName, c.LastName, a.AddressLine1, a.City, a.StateProvince
FROM SalesLT.Customer AS c
JOIN SalesLT.CustomerAddress AS ca
ON c.CustomerID = ca.CustomerID
JOIN SalesLT.Address AS a
ON ca.AddressID = a.AddressID;

-- Query the view
SELECT CustomerID, City
FROM SalesLT.vCustomerAddress;

-- Join the view to a table
SELECT vca.StateProvince, vca.City, ISNULL(SUM(soh.TotalDue), 0.00) AS Revenue
FROM SalesLT.vCustomerAddress AS vca
LEFT JOIN SalesLT.SalesOrderHeader AS soh
ON vca.CustomerID = soh.CustomerID
GROUP BY vca.StateProvince, vca.City
ORDER BY vca.StateProvince, Revenue DESC;