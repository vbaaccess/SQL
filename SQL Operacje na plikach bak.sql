--- Podejzenie danych o pliku backupu (bak)
RESTORE HEADERONLY FROM DISK = N'C:\Katalog\MojBackupBazy.bak' 

/*
identyfikacja wersji:

SQL Server Version	Database Version
SQL 2019	895
SQL 2017	868
SQL 2016	841
SQL 2014	782
SQL 2012	706
SQL 2008 R2	661
SQL 2008	655
SQL 2005	611
SQL 2000	539

linki:
https://sqlserverbuilds.blogspot.com/2014/01/sql-server-internal-database-versions.html
https://blog.sqlauthority.com/2018/03/17/sql-server-identify-version-of-sql-server-from-backup-file/
https://sqlrus.com/2014/10/compatibility-level-vs-database-version/
*/


/* Please run below sql and check logical names */
RESTORE FILELISTONLY 
FROM DISK = N'C:\Katalog\MojBackupBazy.bak' 

--- Utworzeni backup z opcja nadpisania
BACKUP DATABASE [MojaBaza_PROD] 
TO DISK ='C:\Katalog\MojaBaza_PROD Backup_YYMMDD_hhmi.bak'
WITH INIT

--- Odtworzenie backupu gdy baza jeszce nie istnieje
USE [master]
RESTORE DATABASE [MojaBaza_PROD] 
FROM  DISK = N'C:\Katalog\MojaBaza_PROD Backup_YYMMDD_hhmi.bak' 
WITH  FILE = 1
,  MOVE N'MojaBaza_PROD_dat' TO N'X:\BazySQL\MojaBaza_PROD.mdf'
,  MOVE N'MojaBaza_PROD_log' TO N'X:\BazySQL\MojaBaza_PROD_log.LDF'
,  NOUNLOAD,  REPLACE,  STATS = 5

--- Odtworzenie backupu z opcja nadpisania,zamkniecia polaczen i wkazaniem gdzie sa pliki
USE [master]
ALTER DATABASE [MojaBaza_PROD] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
RESTORE DATABASE [MojaBaza_PROD] 
FROM  DISK = N'C:\Katalog\MojaBaza_PROD Backup_YYMMDD_hhmi.bak' 
WITH  FILE = 1
,  MOVE N'MojaBaza_PROD_dat' TO N'X:\BazySQL\MojaBaza_PROD.mdf'
,  MOVE N'MojaBaza_PROD_log' TO N'X:\BazySQL\MojaBaza_PROD_log.LDF'
,  NOUNLOAD,  REPLACE,  STATS = 5
ALTER DATABASE [MojaBaza_PROD] SET MULTI_USER


--- lista baz, katalogi backupow i data ostaniego wykonania
SELECT  DatabaseName = x.database_name,
        LastBackupFileName = x.physical_device_name,
        LastBackupDatetime = x.backup_start_date
FROM (  SELECT  bs.database_name,
                bs.backup_start_date,
                bmf.physical_device_name,
                  Ordinal = ROW_NUMBER() OVER( PARTITION BY bs.database_name ORDER BY bs.backup_start_date DESC )
          FROM  msdb.dbo.backupmediafamily bmf
                  JOIN msdb.dbo.backupmediaset bms ON bmf.media_set_id = bms.media_set_id
                  JOIN msdb.dbo.backupset bs ON bms.media_set_id = bs.media_set_id
          WHERE   bs.[type] = 'D'
                  AND bs.is_copy_only = 0 ) x
WHERE x.Ordinal = 1
ORDER BY DatabaseName;