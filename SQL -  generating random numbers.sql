--- GENEROWANIE LOSWOEJ LICZBY Z WYBRANEGO PRZEDZIALU OD DO 
DECLARE @FromNumber INT
DECLARE @ToNumber INT
DECLARE @NumbersValues INT

SET @FromNumber = 3
SET @ToNumber   = 11
SET @NumbersValues = @ToNumber - @FromNumber + 1

SELECT (ABS(CHECKSUM(NEWID()))%(@NumbersValues) + @FromNumber) AS NumberFromTo,* FROM tPracownicy

---- W PROCEDURZE
--- GENEROWANIE LOSWOEJ LICZBY Z WYBRANEGO PRZEDZIALU OD DO 
DECLARE @FromNumber INT
DECLARE @ToNumber INT
DECLARE @NumbersValues INT

SET @FromNumber = 3
SET @ToNumber   = 11
SET @NumbersValues = @ToNumber - @FromNumber + 1

SELECT (ABS(CHECKSUM(NEWID()))%(@NumbersValues) + @FromNumber) AS NumberFromTo
,* FROM tTableName

/* testowe dane pomocnicze

SELECT RAND()
SELECT RAND(),NEWID() AS RandomNumber,CHECKSUM(NEWID()),ABS(CHECKSUM(NEWID())),ABS(CHECKSUM(NEWID()))%10 + 1,* FROM tPracownicy

-- <Number of Values in Range> + <Lowest Value in Range> + 1

*/