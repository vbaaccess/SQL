DECLARE @SoughtIdField VARCHAR(254)
DECLARE @SoughtId VARCHAR(254)

SET @SoughtId = ''		-- variable initialization
SET @SoughtIdField = ''	-- variable initialization

SET @SoughtIdField='IdPracownika' --- search field, e.g.: IdType,Id
SET @SoughtId = 'IS NOT NULL'     --- search phrase in the search field: IN (123) , IS NULL, >100

DECLARE @cur CURSOR
DECLARE @cur_SQLToTest NVARCHAR(MAX)
DECLARE @cur_SQLToShow NVARCHAR(MAX)
DECLARE @rccount INT
DECLARE @SearchStringCount INT

DECLARE @lp INT

PRINT 'Tested sql queries:' + CAST(@lp AS VARCHAR)
PRINT 'Number of occurrences of searched IDs: ' + CAST(@SearchStringCount AS VARCHAR)