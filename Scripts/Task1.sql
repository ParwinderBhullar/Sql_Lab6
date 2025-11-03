USE AdventureWorks2022;
GO

-- Create schema if it doesn't exist
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'Training')
BEGIN
    EXEC('CREATE SCHEMA Training AUTHORIZATION dbo;');
END
GO

-- Create ProductPriceAudit table if it doesn't exist
IF NOT EXISTS (
    SELECT * FROM sys.tables t
    JOIN sys.schemas s ON t.schema_id = s.schema_id
    WHERE t.name = 'ProductPriceAudit' AND s.name = 'Training'
)
BEGIN
    CREATE TABLE Training.ProductPriceAudit (
        AuditID INT IDENTITY PRIMARY KEY,
        ProductID INT,
        OldPrice MONEY,
        NewPrice MONEY,
        ChangedBy NVARCHAR(100),
        ChangeDate DATETIME DEFAULT GETDATE()
    );
END
GO

-- Create SchemaChangeLog table if it doesn't exist
IF NOT EXISTS (
    SELECT * FROM sys.tables t
    JOIN sys.schemas s ON t.schema_id = s.schema_id
    WHERE t.name = 'SchemaChangeLog' AND s.name = 'Training'
)
BEGIN
    CREATE TABLE Training.SchemaChangeLog (
        LogID INT IDENTITY PRIMARY KEY,
        EventType NVARCHAR(100),
        ObjectName NVARCHAR(100),
        PerformedBy NVARCHAR(100),
        EventDate DATETIME DEFAULT GETDATE()
    );
END
GO
