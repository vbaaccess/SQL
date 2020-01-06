--- Podejzenie danych o pliku backupu (bak)
RESTORE HEADERONLY FROM DISK = N'C:\Katalog\MojBackupBazy.bak' 

--- Utworzeni backup z opcja nadpisania
BACKUP DATABASE [MojaBaza_PROD] 
TO DISK ='C:\Katalog\MojaBaza_PROD Backup_YYMMDD_hhmi.bak'
WITH INIT

--- Odtworzenie backupu z opcja nadpisania,zamkniecia polaczen i skazanie gdzie sa pliki
USE [master]
ALTER DATABASE [MojaBaza_PROD] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
RESTORE DATABASE [MojaBaza_PROD] 
FROM  DISK = N'C:\Katalog\MojaBaza_PROD Backup_YYMMDD_hhmi.bak' 
WITH  FILE = 1
,  MOVE N'MojaBaza_PROD_dat' TO N'X:\BazySQL\MojaBaza_PROD.mdf'
,  MOVE N'MojaBaza_PROD_log' TO N'X:\BazySQL\MojaBaza_PROD_log.LDF'
,  NOUNLOAD,  REPLACE,  STATS = 5
ALTER DATABASE [MojaBaza_PROD] SET MULTI_USER