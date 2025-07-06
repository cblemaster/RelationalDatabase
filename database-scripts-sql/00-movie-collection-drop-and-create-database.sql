
USE master
GO

-- drop database if exists
DECLARE @sql nvarchar(1000);

IF EXISTS (SELECT 1 FROM sys.databases WHERE name = N'MovieCollection') -- TODO: use variable for db name

BEGIN
    SET @sql = N'USE MovieCollection;

                 ALTER DATABASE MovieCollection SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
                 USE master;

                 DROP DATABASE MovieCollection;';
    EXEC (@sql);
END;

CREATE DATABASE MovieCollection
GO

-- create database
USE MovieCollection
GO

-- create schema
CREATE SCHEMA Movies
GO

-- create application role
CREATE APPLICATION ROLE MoviesAppRole WITH PASSWORD = 'Dm4332!HCI1Wkk', DEFAULT_SCHEMA = Movies
GO
