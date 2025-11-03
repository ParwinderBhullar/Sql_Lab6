CREATE TRIGGER trg_Product_PreventDelete
ON Production.Product
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;
 
    IF EXISTS (
        SELECT 1 FROM deleted d
        JOIN Sales.SalesOrderDetail s ON s.ProductID = d.ProductID
    )
    BEGIN
        PRINT 'Cannot delete products linked to existing sales orders.';
        RETURN;
    END
 
    DELETE p
    FROM Production.Product p
    JOIN deleted d ON p.ProductID = d.ProductID;
END;
GO


--TESTING
SELECT p.ProductID, p.Name
FROM Production.Product p
JOIN Sales.SalesOrderDetail s ON p.ProductID = s.ProductID;

DELETE FROM Production.Product WHERE ProductID = 878;

DELETE FROM Production.Product WHERE ProductID = 707;

SELECT p.ProductID, p.Name
FROM Production.Product p
WHERE p.ProductID NOT IN (
    SELECT s.ProductID
    FROM Sales.SalesOrderDetail s
);

DELETE FROM Production.Product WHERE ProductID = 324;




