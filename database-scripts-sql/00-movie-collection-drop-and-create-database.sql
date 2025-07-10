
USE master
GO

DECLARE @sql nvarchar(1000);
DECLARE @db_name nvarchar(1000);
SET @db_name = N'MovieCollection';

IF EXISTS (SELECT 1 FROM sys.databases WHERE name = @db_name)

BEGIN
    SET @sql = N'USE ' + @db_name + ';

                 ALTER DATABASE ' + @db_name + ' SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
                 USE master;

                 DROP DATABASE ' + @db_name + ';';
    EXEC (@sql);
END;

CREATE DATABASE MovieCollection
GO

USE MovieCollection
GO

CREATE SCHEMA Movies
GO
