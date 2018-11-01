USE [master]
GO
/****** Object:  Database [LUCADB]    Script Date: 11/1/2018 10:42:55 ******/
CREATE DATABASE [LUCADB]
GO
ALTER DATABASE [LUCADB] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [LUCADB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [LUCADB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [LUCADB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [LUCADB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [LUCADB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [LUCADB] SET ARITHABORT OFF 
GO
ALTER DATABASE [LUCADB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [LUCADB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [LUCADB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [LUCADB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [LUCADB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [LUCADB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [LUCADB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [LUCADB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [LUCADB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [LUCADB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [LUCADB] SET ALLOW_SNAPSHOT_ISOLATION ON 
GO
ALTER DATABASE [LUCADB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [LUCADB] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [LUCADB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [LUCADB] SET  MULTI_USER 
GO
ALTER DATABASE [LUCADB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [LUCADB] SET ENCRYPTION ON
GO
ALTER DATABASE [LUCADB] SET QUERY_STORE = ON
GO
ALTER DATABASE [LUCADB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 7), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 10, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO)
GO
USE [LUCADB]
GO
/****** Object:  Table [dbo].[cedents]    Script Date: 11/1/2018 10:42:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cedents](
	[id] [varchar](40) NOT NULL,
	[name] [varchar](36) NULL,
	[country] [varchar](50) NULL,
 CONSTRAINT [fcedent_primarykey] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[claim]    Script Date: 11/1/2018 10:42:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[claim](
	[id] [varchar](40) NOT NULL,
	[orig_firstname] [varchar](50) NULL,
	[orig_lastname] [varchar](50) NULL,
	[eventdate] [date] NULL,
	[code] [varchar](50) NULL,
	[policy_id] [varchar](40) NULL,
	[cedent_id] [varchar](40) NULL,
 CONSTRAINT [claim_primarykey] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[persons]    Script Date: 11/1/2018 10:42:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[persons](
	[id] [varchar](40) NOT NULL,
	[first_name] [varchar](50) NULL,
	[last_name] [varchar](50) NULL,
	[gender] [varchar](50) NULL,
	[dob] [date] NULL,
	[branch] [varchar](50) NULL,
	[cedent] [varchar](50) NULL,
 CONSTRAINT [person_primarykey] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[policy]    Script Date: 11/1/2018 10:42:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[policy](
	[id] [varchar](40) NOT NULL,
	[person_id] [varchar](40) NULL,
	[inception] [date] NULL,
	[cedent_id] [varchar](40) NULL,
	[productcode] [int] NULL,
	[orig_lastname] [varchar](50) NULL,
	[orig_firstname] [varchar](50) NULL,
 CONSTRAINT [policy_primarykey] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[claim]  WITH CHECK ADD FOREIGN KEY([policy_id])
REFERENCES [dbo].[policy] ([id])
GO
ALTER TABLE [dbo].[claim]  WITH CHECK ADD  CONSTRAINT [FK_cedent] FOREIGN KEY([cedent_id])
REFERENCES [dbo].[cedents] ([id])
GO
ALTER TABLE [dbo].[claim] CHECK CONSTRAINT [FK_cedent]
GO
ALTER TABLE [dbo].[claim]  WITH CHECK ADD  CONSTRAINT [FK_policy] FOREIGN KEY([policy_id])
REFERENCES [dbo].[policy] ([id])
GO
ALTER TABLE [dbo].[claim] CHECK CONSTRAINT [FK_policy]
GO
ALTER TABLE [dbo].[policy]  WITH CHECK ADD  CONSTRAINT [fk_person] FOREIGN KEY([person_id])
REFERENCES [dbo].[persons] ([id])
GO
ALTER TABLE [dbo].[policy] CHECK CONSTRAINT [fk_person]
GO
USE [master]
GO
ALTER DATABASE [LUCADB] SET  READ_WRITE 
GO
