USE AdventureWorks2022;
GO
 
CREATE SCHEMA Training AUTHORIZATION dbo;
GO
 
CREATE TABLE Training.ProductPriceAudit (
    AuditID INT IDENTITY PRIMARY KEY,
    ProductID INT,
    OldPrice MONEY,
    NewPrice MONEY,
    ChangedBy NVARCHAR(100),
    ChangeDate DATETIME DEFAULT GETDATE()
);
 
CREATE TABLE Training.SchemaChangeLog (
    LogID INT IDENTITY PRIMARY KEY,
    EventType NVARCHAR(100),
    ObjectName NVARCHAR(100),
    PerformedBy NVARCHAR(100),
    EventDate DATETIME DEFAULT GETDATE()
);



