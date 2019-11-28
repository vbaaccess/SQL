/* https://tomaszkenig.pl/sql-server/mssql-pobieranie-danych-ze-stron-web-transact-sql/ */

--- CONFIGURATION ON SERVER 1 ---

USE [master];
go
EXEC sp_configure 'show advanced options', 1;  
GO  
RECONFIGURE;  
GO  
EXEC sp_configure 'xp_cmdshell', 1;  
GO  
RECONFIGURE;  
GO

--- SETEP 1 --- GET www wit link
DECLARE @OUTPUT TABLE(wwwrow NVARCHAR(max));

DECLARE @powershell_cmd NVARCHAR(255) --127
DECLARE @CMD      NVARCHAR(800);


--DECLARE @URLtoPars NVARCHAR(max);

DECLARE @URL       NVARCHAR(max);
DECLARE @urlWithLink NVARCHAR(MAX)
DECLARE @urlWithXML NVARCHAR(MAX)

DECLARE @stringBeforLinkToXML NVARCHAR(MAX)

SET @stringBeforLinkToXML = '/kursy/xml/'


SET @powershell_cmd = 'powershell "$ws=(New-Object System.Net.WebClient) ; $ws.Encoding = [System.Text.Encoding]::UTF8 ;$ws.Downloadstring(''{{URL}}'')"'

SET @URL= 'https://www.nbp.pl/Kursy/KursyC.html'
--SET @URL= 'https://sur.pl'
--SET @URL= 'https://www.nbp.pl/kursy/xml/c198z191011.xml'

--SET @CMD = 'powershell "$ws=(New-Object System.Net.WebClient) ; $ws.Encoding = [System.Text.Encoding]::UTF8 ;$ws.Downloadstring('''+@URL+''')"'
--SET @CMD = REPLACE(@powershell_cmd,'{{URL}}',@URL)
SET @CMD = REPLACE(@powershell_cmd,'{{URL}}',@URL)
--PRINT @CMD

INSERT INTO @OUTPUT EXEC master.dbo.xp_cmdshell @CMD 
--SELECT * FROM @OUTPUT WHERE wwwrow Like '%/kursy/xml/%'
SELECT @LinkToXML=wwwrow FROM @OUTPUT WHERE wwwrow Like '%' + @stringBeforLinkToXML + '%'


--- STEP 2 --- GET subpage name ---

/*
DECLARE @Test NVARCHAR(MAX)
SET @Test = '               <p class="file print_hidden"><a href="/kursy/xml/c201z191016.xml" target="_blank">Powy¿sza tabela w formacie .xml</a></p>'
SET @LinkToXML = @Test
*/

SELECT @LinkToXML=SUBSTRING(@LinkToXML,CHARINDEX(@stringBeforLinkToXML,@LinkToXML)+LEN(@stringBeforLinkToXML),LEN(@LinkToXML))
SELECT @LinkToXML=SUBSTRING(@LinkToXML,1,CHARINDEX('"',@LinkToXML)-1)

PRINT @LinkToXML

--- STEP 3 --- GET xml wit link
DECLARE @wwwPathToXML NVARCHAR(MAX)

SET @wwwPathToXML = ''