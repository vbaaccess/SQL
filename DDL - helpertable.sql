/*
  A structure useful for testing triggers
*/

DROP TABLE tTest
GO
CREATE TABLE tTest
([Id] [INT] IDENTITY(1,1) NOT NULL
,[Test] [VARCHAR](MAX)
,[CreatDate] [datetime] NOT NULL DEFAULT (GETDATE())
,CONSTRAINT [PK_tTest] PRIMARY KEY CLUSTERED ([Id] ASC ) ON [PRIMARY]
)
GO
SELECT * FROM tTest