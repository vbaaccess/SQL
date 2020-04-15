/*
   How to simply and efficiently display several normalized data in unnormalized form (pivot)
*/

CREATE Table tabParent
(
 IdParent INT
,Parent VARCHAR(254)
,CONSTRAINT [PK_tabParent] PRIMARY KEY CLUSTERED ([IdParent]) ON [PRIMARY]
)
GO

CREATE Table tabChildren
(
 IdChildren INT 
,IdParent INT
,Children VARCHAR(254)
,CONSTRAINT [PK_tabParent] PRIMARY KEY CLUSTERED ([IdParent]) ON [PRIMARY]
,CONSTRAINT [FK_IdParent] FOREIGN KEY ([IdParent]) REFERENCES [tabParent].[Parent]
)
GO
INSERT INTO tabParent (Parent) VALUES('Parent 1'),('Parent 2')

INSERT INTO tabChildren (IdParent,Children)
VALUES (1,'Child 1')
     , (1,'Child 2')
     , (1,'Child 3')
     , (2,'4 Child')
     , (2,'5 Child')

GO

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
