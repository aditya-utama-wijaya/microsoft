SELECT COUNT(*) AS Products,
	COUNT(DISTINCT ProductCategoryID) AS Categories,
	AVG(ListPrice) AS AveragePrice
FROM SalesLT.Product;

SELECT COUNT(p.ProductID) AS BikeModels,
	AVG(p.ListPrice) AS AveragePrice
FROM SalesLT.Product AS p
JOIN SalesLT.ProductCategory AS pc
ON p.ProductCategoryID = pc.ProductCategoryID
WHERE pc.Name LIKE '%Bikes';