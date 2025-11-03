EXEC sp_configure 'nested triggers', 1;
RECONFIGURE;


--Table creation for trigger

CREATE TABLE dbo.CategoryTest (
    CategoryID INT IDENTITY PRIMARY KEY,
    CategoryName NVARCHAR(50),
    LastModified DATETIME
);

--Inserting Data 

INSERT INTO dbo.CategoryTest (CategoryName, LastModified)
VALUES ('Bikes', GETDATE()), ('Components', GETDATE());

--CREATING TRIGGER 
CREATE TRIGGER trg_CategoryTest_Update
ON dbo.CategoryTest
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    PRINT 'Trigger fired... updating LastModified again.';

    UPDATE c
    SET c.LastModified = GETDATE()
    FROM dbo.CategoryTest c
    JOIN inserted i ON c.CategoryID = i.CategoryID;
END;
GO

--TESTING RECURSIVE BEHAVIOR

UPDATE dbo.CategoryTest
SET CategoryName = 'New Bikes'
WHERE CategoryID = 1;

select * from dbo.CategoryTest;


--DISABLE RECURSION

EXEC sp_configure 'nested triggers', 0;
RECONFIGURE;

