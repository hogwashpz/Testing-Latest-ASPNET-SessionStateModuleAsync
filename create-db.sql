USE [master]
GO

DECLARE @SQLDataFolder nvarchar(max) = cast(SERVERPROPERTY('InstanceDefaultDataPath') as nvarchar(max))
DECLARE @SQLLogFolder nvarchar(max) = cast(SERVERPROPERTY('InstanceDefaultLogPath') as nvarchar(max))
DECLARE @SQL nvarchar(max) = N'';

SET @SQL = N'
CREATE DATABASE [ASPStateInMemory]
 CONTAINMENT = NONE
 ON  PRIMARY
	(NAME = N''ASPStateInMemory'', FILENAME = N''' + @SQLDataFolder + 'ASPStateInMemory.mdf'' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ),
 FILEGROUP [ASPStateInMemory_mod] CONTAINS MEMORY_OPTIMIZED_DATA  DEFAULT
	(NAME = N''ASPStateInMemory_mod'', FILENAME = N''' + @SQLLogFolder + 'ASPStateInMemory_mod'' , MAXSIZE = UNLIMITED)
 LOG ON
	(NAME = N''ASPStateInMemory_log'', FILENAME = N''' + @SQLLogFolder + 'ASPStateInMemory_log.ldf'' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB );

ALTER DATABASE [ASPStateInMemory] SET COMPATIBILITY_LEVEL = 130; ALTER DATABASE [ASPStateInMemory] SET MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT=ON;'

EXECUTE (@SQL)
GO