/*
   How to simply and efficiently display several normalized data in unnormalized form (pivot)
*/

SELECT tP.IdParent, tP.Parent
	 , STUFF(
				(
					SELECT ',' + tC.Children
					FROM tabChildren tC
					WHERE tC.IdParent=tP.IdParent
					FOR XML PATH('')
				),1,1,''
			) AS Children
FROM tabParent tP 