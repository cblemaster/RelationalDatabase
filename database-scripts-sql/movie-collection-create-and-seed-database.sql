
USE master
GO

DECLARE @sql nvarchar(1000);

IF EXISTS (SELECT 1 FROM sys.databases WHERE name = N'MovieCollection')

BEGIN
    SET @sql = N'USE MovieCollection;

                 ALTER DATABASE MovieCollection SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
                 USE master;

                 DROP DATABASE MovieCollection;';
    EXEC (@sql);
END;

CREATE DATABASE MovieCollection
GO

USE MovieCollection
GO


-- create tables (1.5h)
-- seed data when tables created (1.5h)
-- define and create views (4h)
-- define and create sprocs (4h)
-- define and create tests (8h)
-- does the script need to be split up? (0-8h)
-- max effort 27.5h
