USE [UserBehavior]
GO
/****** Object:  Table [dbo].[UserVisit]    Script Date: 12/13/2013 17:08:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserVisit](
	[UserIdentity] [uniqueidentifier] NOT NULL,
	[browser] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[os] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ip] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OtherUserInfo] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_UserVisit] PRIMARY KEY CLUSTERED 
(
	[UserIdentity] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF