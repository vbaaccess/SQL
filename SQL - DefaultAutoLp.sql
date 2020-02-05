/*
  Trigger allowing to indicate a group of fields in which the number of orders will be automatically formed in another indicated field
*/

/* test table 
CREATE TABLE [dbo].[tTestAutoLp]
([Id] [INT] IDENTITY(1,1) NOT NULL
,[IdParent] [INT] NOT NULL																							--<-- One of the fields that describes the group
,[RowTag] [VARCHAR](10) NULL																										--<-- another fields that describes the group
,[Lp] [INT] NOT NULL																								--<-- Our destination field for auto LP 
,[RowDescription] [VARCHAR](1000) Not Null
,[CreatDate] [datetime] NOT NULL DEFAULT (GETDATE())
,CONSTRAINT [PK_[tTestAutoLp] PRIMARY KEY CLUSTERED ([Id] ASC ) ON [PRIMARY]
--,CONSTRAINT [FK_tTestAutoLp_IdParent]  FOREIGN KEY([IdParent]) References [dbo].[tParentTable]([Id])				-- uncheck after creating the parent table
,CONSTRAINT [FK_tEWOIssue_IdPracownika] FOREIGN KEY ([IdPracownika])  REFERENCES [dbo].[tPracownicy]([IdPracownika])
,CONSTRAINT [UK_tEWOIssue] UNIQUE ([IdEWO],[Lp],[Issue])
)
*/

/* test insert 
INSERT INTO tTestAutoLp (IdParent,RowTag,RowDescription) Values (1,'Test','Some Insert')
GO

INSERT INTO tTestAutoLp (IdParent,RowTag,RowDescription) 
Values (1,'Test','Next Insert')
     , (1,'Test','3th Insert')
GO

INSERT INTO tTestAutoLp (IdParent,RowTag,RowDescription) 
Values (1,'Test','IV Insert')
     , (1,Null,'Last Insert, without Tag')
	 , (2,Null,'Insert to ather parent group')
	 , (2,Null,'Second Insert to ather parent group')
GO
*/