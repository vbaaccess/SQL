/*
   Struktura analizujaca i przechowujaca dane historyczen walut
*/
--ALTE TABLE tWaluty ADD Bud BIT 

SELECT * FROM tWaluty



SELECT tW.IdWaluty,tW.Waluta FROM tWaluty tW 
LEFT JOIN tWalutyHistoria tH ON tW.IdWaluty=tH.IdWaluty
WHERE tW.IdWaluty>1


SELECT * FROM tWalutyHistoria




-- USD
INSERT INTO tWalutyHistoria (IdWaluty,KursSredni,KursKupna,KursSprzedazy,DataKursu) VALUES (2,3.9145,2019-10-11)
INSERT INTO tWalutyHistoria (IdWaluty,KursSredni,KursKupna,KursSprzedazy,DataKursu) VALUES (2,3.8958,2019-10-14)
INSERT INTO tWalutyHistoria (IdWaluty,KursSredni,KursKupna,KursSprzedazy,DataKursu) VALUES (2,3.8952,2019-10-15)


INSERT INTO tWalutyHistoria (IdWaluty,Kurs,DataKursu) VALUES (2,3.8952,GETDATE())

-- EUR
INSERT INTO tWalutyHistoria (IdWaluty,Kurs,DataKursu) VALUES (3,4.3097,2019-10-11)
INSERT INTO tWalutyHistoria (IdWaluty,Kurs,DataKursu) VALUES (3,4.2969,2019-10-14)
INSERT INTO tWalutyHistoria (IdWaluty,Kurs,DataKursu) VALUES (3,4.2949,2019-10-15)
INSERT INTO tWalutyHistoria (IdWaluty,Kurs,DataKursu) VALUES (3,4.2949,GETDATE())


-- CHF
INSERT INTO tWalutyHistoria (IdWaluty,Kurs,DataKursu) VALUES (7,3.9192,2019-10-11)
INSERT INTO tWalutyHistoria (IdWaluty,Kurs,DataKursu) VALUES (7,3.9104,2019-10-14)
INSERT INTO tWalutyHistoria (IdWaluty,Kurs,DataKursu) VALUES (7,3.9000,2019-10-15)
INSERT INTO tWalutyHistoria (IdWaluty,Kurs,DataKursu) VALUES (7,3.9000,GETDATE())

--- Brak daty-biezaca data
ProcPobierzKursWaluty(IdWaluty,KodWaluty,WeryfikowanaData)

/*
 http://rss.nbp.pl/kursy/TabRss.aspx?n=2019/a/19a200
 */

 --- https://www.nbp.pl/Kursy/KursyC.html lub https://www.nbp.pl/kursy/xml/c201z191016.xml



 /*
 DECLARE
@xmlObject INT,
@vResponseText VARCHAR(MAX),
@vStatus INT,
@vStatusText VARCHAR(200)

EXEC sp_OACreate 'MSXML2.ServerXMLHTTP', @xmlObject OUTPUT
--EXEC sp_OAMethod @xmlObject, 'open', NULL, 'GET',  'https://www.nbp.pl/Kursy/KursyC.html'
EXEC sp_OAMethod @xmlObject, 'send'
EXEC sp_OAMethod @xmlObject, 'responseText', --@vResponseText OUTPUT
EXEC sp_OAMethod @xmlObject, 'Status', @vStatus OUTPUT
EXEC sp_OAMethod @xmlObject, 'StatusText', @vStatusText OUTPUT
EXEC sp_OADestroy @xmlObject
SELECT @vResponseText
 */