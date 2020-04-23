DECLARE @SoughtIdField VARCHAR(254)
DECLARE @SoughtId VARCHAR(254)

DECLARE @SearchStringCount INT

DECLARE @lp INT

PRINT 'Tested sql queries:' + CAST(@lp AS VARCHAR)
PRINT 'Number of occurrences of searched IDs: ' + CAST(@SearchStringCount AS VARCHAR)