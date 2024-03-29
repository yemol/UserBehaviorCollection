USE [UserBehavior]
GO
/****** Object:  Table [dbo].[PageVisit]    Script Date: 12/13/2013 17:07:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PageVisit](
	[PageIdentity] [uniqueidentifier] NOT NULL,
	[UserIdentity] [uniqueidentifier] NOT NULL,
	[PagePath] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[StartAccess] [datetime] NULL,
	[LastActiveTime] [datetime] NULL,
	[Actions] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_PageVisit] PRIMARY KEY CLUSTERED 
(
	[PageIdentity] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF