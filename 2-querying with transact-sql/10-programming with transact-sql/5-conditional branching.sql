-- Change code based on a condition
UPDATE SalesLT.Product
SET DiscontinuedDate = GETDATE()
WHERE ProductID = 680

IF @@ROWCOUNT < 1
BEGIN
	PRINT 'Product was not found'
END
ELSE
BEGIN
	PRINT 'Product updated'
END