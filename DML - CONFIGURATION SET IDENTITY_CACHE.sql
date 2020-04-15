IF EXISTS(SELECT * FROM sys.database_scoped_configurations WHERE [name]='IDENTITY_CACHE' AND value=1)
	ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = OFF

SELECT * FROM sys.database_scoped_configurations WHERE [name]='IDENTITY_CACHE'