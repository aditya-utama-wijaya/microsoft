CREATE TABLE SalesLT.DemoTable (
	Description varchar(10) NULL
);
GO

DECLARE @Counter AS int = 1;
WHILE @Counter <= 5
BEGIN
	INSERT INTO SalesLT.DemoTable(Description)
	VALUES ('ROW ' + CONVERT(varchar(5), @Counter))
	SET @Counter += 1
END

SELECT Description
FROM SalesLT.DemoTable;

--
CREATE TABLE #Orders (
	d DATETIME NULL,
	CustomerID nvarchar(50) NOT NULL,
	ProductID nvarchar(50) NOT NULL
);

DECLARE @d AS DATETIME = DATEADD(dd, -365, GETDATE());
WHILE @d < GETDATE()
BEGIN
	INSERT INTO #Orders
	SELECT @d, c.CustomerID, p.ProductID
	FROM SalesLT.Customer AS c
	CROSS JOIN SalesLT.Product AS p;

	DECLARE @c INT;
	SELECT @c = COUNT(*) FROM #Orders;

	IF @c > 1000000
	BREAK;

	SET @d = DATEADD(dd, 1, @d);
END

SELECT * FROM #Orders;