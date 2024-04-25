USE [master]
GO

DECLARE @SQLDataFolder nvarchar(max) = cast(SERVERPROPERTY('InstanceDefaultDataPath') as nvarchar(max))
DECLARE @SQLLogFolder nvarchar(max) = cast(SERVERPROPERTY('InstanceDefaultLogPath') as nvarchar(max))
DECLARE @SQL nvarchar(max) = N'';

SET @SQL = N'
CREATE DATABASE [ASPState]
 CONTAINMENT = NONE
 ON  PRIMARY
	(NAME = N''ASPState'', FILENAME = N''' + @SQLDataFolder + 'ASPState.mdf'' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ),
 FILEGROUP [ASPState_mod] CONTAINS MEMORY_OPTIMIZED_DATA  DEFAULT
	(NAME = N''ASPState_mod'', FILENAME = N''' + @SQLLogFolder + 'ASPState_mod'' , MAXSIZE = UNLIMITED)
 LOG ON
	(NAME = N''ASPState_log'', FILENAME = N''' + @SQLLogFolder + 'ASPState_log.ldf'' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB );

ALTER DATABASE [ASPState] SET COMPATIBILITY_LEVEL = 130; ALTER DATABASE [ASPState] SET MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT=ON;'

EXECUTE (@SQL)
GO