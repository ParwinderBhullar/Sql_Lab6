--TASK 2

CREATE TRIGGER trg_Product_PriceAudit
ON Production.Product
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
 
    INSERT INTO Training.ProductPriceAudit (ProductID, OldPrice, NewPrice, ChangedBy)
    SELECT d.ProductID, d.ListPrice, i.ListPrice, SUSER_SNAME()
    FROM deleted d
    JOIN inserted i ON d.ProductID = i.ProductID
    WHERE d.ListPrice <> i.ListPrice;
END;
GO

--TESTING TRIGGER-

UPDATE Production.Product SET ListPrice = ListPrice * 1.05 WHERE ProductID = 707;
SELECT * FROM Training.ProductPriceAudit;




