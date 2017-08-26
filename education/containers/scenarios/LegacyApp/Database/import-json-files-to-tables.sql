USE MASTER 
GO 

CREATE DATABASE HistoricEvents ON  
  PRIMARY  
  (  
   NAME       = HistoricEvents_Data , 
   FILENAME   = 'c:\HistoricEvents.MDF' , 
   SIZE       = 12MB      , 
   MAXSIZE    = UNLIMITED , 
   FILEGROWTH = 10MB 
  ) 
  LOG ON  
  ( 
   NAME       = HistoricEvents_Log , 
   FILENAME   = 'c:\HistoricEvents.LDF'  ,
   SIZE       = 12MB      , 
   MAXSIZE    = UNLIMITED , 
   FILEGROWTH = 10MB   
  ) 
GO

------------------------------------------------
USE HistoricEvents;
GO 

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[FrenchRevolution]( [date] [nvarchar](max) NULL, [description] [nvarchar](max) NULL ) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY] ;
GO

DECLARE @tmp  VARCHAR(MAX); SELECT @tmp = BulkColumn FROM OPENROWSET(BULK'C:\frenchrevolution.json', SINGLE_BLOB) JSON; INSERT INTO FrenchRevolution SELECT [date],[description] from OPENJSON(@tmp) WITH ( [date] nvarchar(max) '$.date', [description] nvarchar(max) '$.description' )
GO

CREATE TABLE [dbo].[Renaissance]( [date] [nvarchar](max) NULL, [description] [nvarchar](max) NULL ) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY] ;
GO

DECLARE @tmp  VARCHAR(MAX); SELECT @tmp = BulkColumn FROM OPENROWSET(BULK'C:\renaissance.json', SINGLE_BLOB) JSON; INSERT INTO Renaissance SELECT [date],[description] from OPENJSON(@tmp) WITH ( [date] nvarchar(max) '$.date', [description] nvarchar(max) '$.description' )
GO

CREATE TABLE [dbo].[WW1]( [date] [nvarchar](max) NULL, [description] [nvarchar](max) NULL ) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY] ;
GO

DECLARE @tmp  VARCHAR(MAX); SELECT @tmp = BulkColumn FROM OPENROWSET(BULK'C:\ww1.json', SINGLE_BLOB) JSON; INSERT INTO WW1 SELECT [date],[description] from OPENJSON(@tmp) WITH ( [date] nvarchar(max) '$.date', [description] nvarchar(max) '$.description' )
GO

CREATE TABLE [dbo].[WW2]( [date] [nvarchar](max) NULL, [description] [nvarchar](max) NULL ) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY] ;
GO

DECLARE @tmp  VARCHAR(MAX); SELECT @tmp = BulkColumn FROM OPENROWSET(BULK'C:\ww2.json', SINGLE_BLOB) JSON; INSERT INTO WW2 SELECT [date],[description] from OPENJSON(@tmp) WITH ( [date] nvarchar(max) '$.date', [description] nvarchar(max) '$.description' )
GO