IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'News')
	DROP DATABASE [News]
GO

CREATE DATABASE [News]  ON (NAME = N'News_Data', FILENAME = N'D:\数据库\News_Data.MDF' , SIZE = 3, FILEGROWTH = 10%) LOG ON (NAME = N'News_Log', FILENAME = N'D:\数据库\News_log.LDF' , FILEGROWTH = 10%)
 COLLATE Chinese_PRC_CI_AS
GO

exec sp_dboption N'News', N'autoclose', N'false'
GO

exec sp_dboption N'News', N'bulkcopy', N'false'
GO

exec sp_dboption N'News', N'trunc. log', N'true'
GO

exec sp_dboption N'News', N'torn page detection', N'true'
GO

exec sp_dboption N'News', N'read only', N'false'
GO

exec sp_dboption N'News', N'dbo use', N'false'
GO

exec sp_dboption N'News', N'single', N'false'
GO

exec sp_dboption N'News', N'autoshrink', N'false'
GO

exec sp_dboption N'News', N'ANSI null default', N'false'
GO

exec sp_dboption N'News', N'recursive triggers', N'false'
GO

exec sp_dboption N'News', N'ANSI nulls', N'false'
GO

exec sp_dboption N'News', N'concat null yields null', N'false'
GO

exec sp_dboption N'News', N'cursor close on commit', N'false'
GO

exec sp_dboption N'News', N'default to local cursor', N'false'
GO

exec sp_dboption N'News', N'quoted identifier', N'false'
GO

exec sp_dboption N'News', N'ANSI warnings', N'false'
GO

exec sp_dboption N'News', N'auto create statistics', N'true'
GO

exec sp_dboption N'News', N'auto update statistics', N'true'
GO

if( (@@microsoftversion / power(2, 24) = 8) and (@@microsoftversion & 0xffff >= 724) )
	exec sp_dboption N'News', N'db chaining', N'false'
GO

use [News]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Re]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Re]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[admin]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[admin]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[class]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[class]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[news]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[news]
GO

CREATE TABLE [dbo].[Re] (
	[ID] [int] IDENTITY (1, 1) NOT FOR REPLICATION  NOT NULL ,
	[UserName] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[ATxt] [nvarchar] (4000) COLLATE Chinese_PRC_CI_AS NULL ,
	[BTxt] [nvarchar] (4000) COLLATE Chinese_PRC_CI_AS NULL ,
	[Act] [int] NULL ,
	[PostDate] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[admin] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[admin] [nvarchar] (100) COLLATE Chinese_PRC_CI_AS NULL ,
	[password] [nvarchar] (100) COLLATE Chinese_PRC_CI_AS NULL ,
	[classcode] [nvarchar] (100) COLLATE Chinese_PRC_CI_AS NULL ,
	[classname] [nvarchar] (100) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[class] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[classcode] [nvarchar] (100) COLLATE Chinese_PRC_CI_AS NULL ,
	[classname] [nvarchar] (100) COLLATE Chinese_PRC_CI_AS NULL ,
	[classpic] [nvarchar] (100) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[news] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[classcode] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[newstitle] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[newsdate] [smalldatetime] NULL ,
	[newsinfo] [ntext] COLLATE Chinese_PRC_CI_AS NULL ,
	[newscu] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[newszz] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[pl] [bit] NULL ,
	[counts] [int] NULL ,
	[keyword] [nvarchar] (60) COLLATE Chinese_PRC_CI_AS NULL ,
	[gd] [bit] NULL ,
	[ts] [smalldatetime] NULL ,
	[down] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[top2] [bit] NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[Re] WITH NOCHECK ADD 
	CONSTRAINT [PK_Re] PRIMARY KEY  CLUSTERED 
	(
		[ID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[news] WITH NOCHECK ADD 
	CONSTRAINT [PK_news] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Re] ADD 
	CONSTRAINT [DF_Re_PostDate] DEFAULT (getdate()) FOR [PostDate]
GO

ALTER TABLE [dbo].[admin] ADD 
	CONSTRAINT [PK_admin] PRIMARY KEY  NONCLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[class] ADD 
	CONSTRAINT [PK_class] PRIMARY KEY  NONCLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[news] ADD 
	CONSTRAINT [DF_news_pl] DEFAULT (0) FOR [pl],
	CONSTRAINT [DF_news_gd] DEFAULT (0) FOR [gd],
	CONSTRAINT [DF_news_top2] DEFAULT (0) FOR [top2]
GO

