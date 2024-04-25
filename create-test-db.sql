USE [master]
GO

DECLARE @SQLDataFolder nvarchar(max) = cast(SERVERPROPERTY('InstanceDefaultDataPath') as nvarchar(max))
DECLARE @SQLLogFolder nvarchar(max) = cast(SERVERPROPERTY('InstanceDefaultLogPath') as nvarchar(max))
DECLARE @SQL nvarchar(max) = N'';

SET @SQL = N'
CREATE DATABASE [ASPSessionStateInMemoryTest]
 CONTAINMENT = NONE
 ON  PRIMARY
	(NAME = N''ASPSessionStateInMemoryTest'', FILENAME = N''' + @SQLDataFolder + 'ASPSessionStateInMemoryTest.mdf'' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ),
 FILEGROUP [ASPSessionStateInMemoryTest_mod] CONTAINS MEMORY_OPTIMIZED_DATA  DEFAULT
	(NAME = N''ASPSessionStateInMemoryTest_mod'', FILENAME = N''' + @SQLLogFolder + 'ASPSessionStateInMemoryTest_mod'' , MAXSIZE = UNLIMITED)
 LOG ON
	(NAME = N''ASPSessionStateInMemoryTest_log'', FILENAME = N''' + @SQLLogFolder + 'ASPSessionStateInMemoryTest_log.ldf'' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB );

ALTER DATABASE [ASPSessionStateInMemoryTest] SET COMPATIBILITY_LEVEL = 130; ALTER DATABASE [ASPSessionStateInMemoryTest] SET MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT=ON;'

EXECUTE (@SQL)
GO