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

SET @cur = CURSOR FOR(
					select
						  'SELECT @quantity = Count(*) FROM [' + tbl.name + '] WHERE NOT [' + c.name + '] Is Null AND [' + c.name + '] ' + @SoughtId AS TestSQL
						 ,'SELECT [' + c.name +  '] FROM [' + tbl.name + '] WHERE NOT [' + c.name + '] Is Null AND [' + c.name + '] ' + @SoughtId AS ShowSQL
					from sys.columns c
							 inner join sys.types t 
						  on c.system_type_id = t.system_type_id 
							 inner join sys.tables tbl
						  on c.object_id = tbl.object_id
					where
						  t.name IN ('int')
					)

IF LEN(@SoughtIdField)>0
SET @cur = CURSOR FOR(
					select
						  'SELECT @quantity = Count(*) FROM [' + tbl.name + '] WHERE NOT [' + c.name + '] Is Null AND [' + c.name + '] ' + @SoughtId AS TestSQL
						 ,'SELECT [' + c.name +  '] FROM [' + tbl.name + '] WHERE NOT [' + c.name + '] Is Null AND [' + c.name + '] ' + @SoughtId AS ShowSQL
					from sys.columns c
							 inner join sys.types t 
						  on c.system_type_id = t.system_type_id 
							 inner join sys.tables tbl
						  on c.object_id = tbl.object_id
					where
						  t.name IN ('int')
						  AND c.name = @SoughtIdField
					)

DECLARE @lp INT
SET @lp = 0
SET @SearchStringCount = 0

DECLARE @pom NVARCHAR(3000)

IF LEN(@SoughtId)>0
	PRINT 'Searched ID: ' + @SoughtId
ELSE
	PRINT 'All ID'

IF LEN(@SoughtIdField)>0
	PRINT 'Search field with ID: ' + @SoughtIdField
ELSE
	PRINT 'All Fields with ID'
	

OPEN @cur
FETCH NEXT FROM @cur INTO @cur_SQLToTest,@cur_SQLToShow
WHILE @@FETCH_STATUS = 0
BEGIN
    /* loop - Start */

	SET @lp = @lp + 1
	SET @rccount = 0

	EXECUTE sp_executesql @cur_SQLToTest , N'@quantity INT out', @rccount out
	
	IF @rccount>0
	BEGIN
		SET @SearchStringCount = @SearchStringCount + @rccount
		PRINT CAST(@lp AS VARCHAR) + ' (instances/records: ' + CAST(@rccount AS VARCHAR) + ') ' + @cur_SQLToShow
	END
    /* loop - End */
    FETCH NEXT FROM @cur INTO @cur_SQLToTest,@cur_SQLToShow
End
CLOSE @cur
DEALLOCATE @cur

PRINT 'Tested sql queries:' + CAST(@lp AS VARCHAR)
PRINT 'Number of occurrences of searched IDs: ' + CAST(@SearchStringCount AS VARCHAR)