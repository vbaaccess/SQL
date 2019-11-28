--- SETEP 1 --- GET www wit link
DECLARE @OUTPUT TABLE(wwwrow NVARCHAR(max));

DECLARE @powershell_cmd NVARCHAR(255) --127
DECLARE @CMD      NVARCHAR(800);

DECLARE @URL       NVARCHAR(max)
DECLARE @urlWithLink NVARCHAR(MAX)
DECLARE @urlWithXML NVARCHAR(MAX)

DECLARE @stringBeforLinkToXML NVARCHAR(MAX)

SET @URL					= 'https://www.nbp.pl'
SET @urlWithLink			= @URL + '/Kursy/KursyC.html'
SET @stringBeforLinkToXML	= '/kursy/xml/'

SET @powershell_cmd = 'powershell "$ws=(New-Object System.Net.WebClient) ; $ws.Encoding = [System.Text.Encoding]::UTF8 ;$ws.Downloadstring(''{{URL}}'')"'

--SET @CMD = 'powershell "$ws=(New-Object System.Net.WebClient) ; $ws.Encoding = [System.Text.Encoding]::UTF8 ;$ws.Downloadstring('''+@urlWithLink+''')"'
SET @CMD = REPLACE(@powershell_cmd,'{{URL}}',@urlWithLink)
PRINT @CMD

SET NOCOUNT ON
INSERT INTO @OUTPUT EXEC master.dbo.xp_cmdshell @CMD 
SET NOCOUNT OFF
--SELECT * FROM @OUTPUT WHERE wwwrow Like '%/kursy/xml/%'
SELECT @urlWithXML=wwwrow FROM @OUTPUT WHERE wwwrow Like '%' + @stringBeforLinkToXML + '%'

--- STEP 2 --- GET subpage name ---
/*
DECLARE @Test NVARCHAR(MAX)
SET @Test = '               <p class="file print_hidden"><a href="/kursy/xml/c201z191016.xml" target="_blank">Powy¿sza tabela w formacie .xml</a></p>'
SET @urlWithXML = @Test
*/

SELECT @urlWithXML=SUBSTRING(@urlWithXML,CHARINDEX(@stringBeforLinkToXML,@urlWithXML)+LEN(@stringBeforLinkToXML),LEN(@urlWithXML))
SELECT @urlWithXML=SUBSTRING(@urlWithXML,1,CHARINDEX('"',@urlWithXML)-1)
PRINT @urlWithXML
--PRINT @urlWithXML

--EXEC dbo.WriteToFile @FulPathToFile, @DataToFile
--EXEC devSURFBD_Pawel.dbo.WriteToFile 'C:\Temp\CurrentCourse.xml', 'https://www.nbp.pl/kursy/xml/c201z191016.xml'
  EXEC devSURFBD_Pawel.dbo.WriteToFile 'C:\Temp\CurrentCourse.xml',@urlWithXML


--- STEP 3 --- GET xml wit link
DECLARE @wwwPathToXML NVARCHAR(MAX)

SET @wwwPathToXML = @URL + @stringBeforLinkToXML + @urlWithXML
PRINT @wwwPathToXML 


--SET @CMD = REPLACE(@powershell_cmd,'{{URL}}',@wwwPathToXML)
--PRINT @CMD

--DECLARE @x xml

--SET @x = 
--SELECT * FROM (EXEC master.dbo.xp_cmdshell @CMD) vD

--PRINT @x
--INSERT INTO @OUTPUT EXEC master.dbo.xp_cmdshell @CMD
--SET @x = SELECT * FROM  ( )

DECLARE @wwwPathToXML NVARCHAR(MAX)
SET @wwwPathToXML = N'C:\Temp\' + 'c201z191016.xml'

DECLARE @XMLwithOpenXML TABLE(
Id INT IDENTITY PRIMARY KEY,
XMLData XML,
LoadedDateTime DATETIME
);

INSERT INTO @XMLwithOpenXML(XMLData, LoadedDateTime)
SELECT CONVERT(XML, BulkColumn) AS BulkColumn, GETDATE() 
--FROM OPENROWSET(BULK 'D:\OpenXMLTesting.xml', SINGLE_BLOB) AS x;
--FROM OPENROWSET(BULK @wwwPathToXML, SINGLE_BLOB) AS x;
--FROM OPENROWSET(BULK 'https://www.nbp.pl/kursy/xml/c198z191011.xml', SINGLE_BLOB) AS x;
--FROM OPENROWSET(BULK N'C:\Temp\c201z191016.xml', SINGLE_BLOB) AS x;
FROM OPENROWSET(BULK N'C:\Temp\CurrentCourse.xml', SINGLE_CLOB) AS x;



SELECT * FROM @XMLwithOpenXML

-- SHOW FILE FROM Folder
--EXECUTE master.dbo.xp_cmdshell 'DIR "C:\Temp\" /A-D /B'


/*
CREATE TABLE XMLwithOpenXML
(
Id INT IDENTITY PRIMARY KEY,
XMLData XML,
LoadedDateTime DATETIME
)

*/

USE master;
SELECT 
  name 'Logical Name', 
  physical_name 'File Location'
FROM sys.master_files;