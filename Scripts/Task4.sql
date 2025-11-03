CREATE TRIGGER trg_Database_SchemaLog
ON DATABASE
FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
AS
BEGIN
    SET NOCOUNT ON;
 
    INSERT INTO Training.SchemaChangeLog (EventType, ObjectName, PerformedBy)
    SELECT EVENTDATA().value('(/EVENT_INSTANCE/EventType)[1]', 'NVARCHAR(100)'),
           EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]', 'NVARCHAR(100)'),
           SUSER_SNAME();
END;
GO

--TESTING

CREATE TABLE Training.TempTest (ID INT);
DROP TABLE Training.TempTest;

SELECT * FROM Training.SchemaChangeLog;