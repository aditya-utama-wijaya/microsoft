SELECT gag.ParentProductCategoryName, gag.ProductCategoryName, COUNT(p.ProductID) AS Products
FROM SalesLT.vGetAllCategories AS gag
JOIN SalesLT.Product AS p
ON gag.ProductCategoryID = p.ProductCategoryID
--GROUP BY gag.ParentProductCategoryName, gag.ProductCategoryName
--GROUP BY GROUPING SETS(gag.ParentProductCategoryName, gag.ProductCategoryName, ())
--GROUP BY ROLLUP(gag.ParentProductCategoryName, gag.ProductCategoryName)
GROUP BY CUBE(gag.ParentProductCategoryName, gag.ProductCategoryName)
ORDER BY gag.ParentProductCategoryName, gag.ProductCategoryName;

--
SELECT a.CountryRegion, a.StateProvince, SUM(soh.TotalDue) AS Revenue
FROM SalesLT.Address AS a
JOIN SalesLT.CustomerAddress AS ca
ON a.AddressID = ca.AddressID
JOIN SalesLT.SalesOrderHeader AS soh
ON ca.CustomerID = soh.CustomerID
--GROUP BY ROLLUP(a.CountryRegion, a.StateProvince)
GROUP BY GROUPING SETS(a.CountryRegion, (a.CountryRegion, a.StateProvince), ())
ORDER BY a.CountryRegion, a.StateProvince;