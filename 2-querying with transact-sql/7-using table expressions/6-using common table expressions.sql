-- using a CTE
WITH ProductsByCategory(ProductID, ProductName, Category)
AS (
	SELECT p.ProductID, p.Name, pc.Name
	FROM SalesLT.Product AS p
	JOIN SalesLT.ProductCategory AS pc
	ON p.ProductCategoryID = pc.ProductCategoryID
)
SELECT Category, COUNT(ProductID) AS Products
FROM ProductsByCategory
GROUP BY Category
ORDER BY Category;


-- using the CTE to perform a recursion
WITH OrgReport(ManagerID, EmployeeID, EmployeeName, Level)
AS (
	-- anchor query
	SELECT ManagerID, EmployeeID, EmployeeName, 0
	FROM SalesLT.Employee
	WHERE ManagerID IS NULL

	UNION ALL

	-- recursive query
	SELECT e.ManagerID, e.EmployeeID, e.EmployeeName, o.Level + 1
	FROM SalesLT.Employee AS e
	JOIN OrgReport AS o
	ON e.ManagerID = o.EmployeeID
)
SELECT * FROM OrgReport
OPTION(MAXRECURSION 3);


WITH YTD_Orders(OrderMonth, SalesOrderID)
AS (
	SELECT MONTH(OrderDate), SalesOrderID
	FROM SalesLT.SalesOrderHeader
	WHERE YEAR(OrderDate) = YEAR(GETDATE())
)
SELECT OrderMonth, COUNT(SalesOrderID) AS Orders
FROM YTD_Orders
GROUP BY OrderMonth;