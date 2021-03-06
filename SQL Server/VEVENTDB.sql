USE [master]
GO
/****** Object:  Database [VEVENTDB]    Script Date: 1/03/2016 10:04:22 AM ******/
CREATE DATABASE [VEVENTDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'VEVENTDB', FILENAME = N'E:\SQLData\DR_VDI\VEVENTDB.mdf' , SIZE = 163840KB , MAXSIZE = UNLIMITED, FILEGROWTH = 131072KB )
 LOG ON 
( NAME = N'VEVENTDB_log', FILENAME = N'F:\SQLLogs\DR_VDI\VEVENTDB_log.ldf' , SIZE = 32768KB , MAXSIZE = 2048GB , FILEGROWTH = 131072KB )
GO
ALTER DATABASE [VEVENTDB] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [VEVENTDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [VEVENTDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [VEVENTDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [VEVENTDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [VEVENTDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [VEVENTDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [VEVENTDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [VEVENTDB] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [VEVENTDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [VEVENTDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [VEVENTDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [VEVENTDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [VEVENTDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [VEVENTDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [VEVENTDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [VEVENTDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [VEVENTDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [VEVENTDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [VEVENTDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [VEVENTDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [VEVENTDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [VEVENTDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [VEVENTDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [VEVENTDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [VEVENTDB] SET RECOVERY FULL 
GO
ALTER DATABASE [VEVENTDB] SET  MULTI_USER 
GO
ALTER DATABASE [VEVENTDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [VEVENTDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [VEVENTDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [VEVENTDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [VEVENTDB]
GO
/****** Object:  User [vmadmin]    Script Date: 1/03/2016 10:04:22 AM ******/
CREATE USER [vmadmin] FOR LOGIN [vmadmin] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [vmadmin]
GO
/****** Object:  Table [dbo].[VE_event]    Script Date: 1/03/2016 10:04:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VE_event](
	[EventID] [int] IDENTITY(1,1) NOT NULL,
	[Module] [nvarchar](512) NULL,
	[EventType] [nvarchar](512) NULL,
	[ModuleAndEventText] [nvarchar](512) NULL,
	[Time] [datetime] NULL,
	[Source] [nvarchar](512) NULL,
	[Severity] [nvarchar](512) NULL,
	[Node] [nvarchar](512) NULL,
	[Acknowledged] [int] NULL,
	[UserSID] [nvarchar](512) NULL,
	[DesktopId] [nvarchar](512) NULL,
	[MachineId] [nvarchar](512) NULL,
	[FolderPath] [nvarchar](512) NULL,
	[LUNId] [nvarchar](512) NULL,
	[ThinAppId] [nvarchar](512) NULL,
	[EndpointId] [nvarchar](512) NULL,
	[UserDiskPathId] [nvarchar](512) NULL,
	[GroupId] [nvarchar](512) NULL,
PRIMARY KEY CLUSTERED 
(
	[EventID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[VE_event_data]    Script Date: 1/03/2016 10:04:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VE_event_data](
	[EventID] [int] NULL,
	[Name] [nvarchar](512) NULL,
	[Type] [int] NULL,
	[IntValue] [int] NULL,
	[StrValue] [nvarchar](512) NULL,
	[TimeValue] [datetime] NULL,
	[BooleanValue] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[VE_event_data_historical]    Script Date: 1/03/2016 10:04:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VE_event_data_historical](
	[EventID] [int] NULL,
	[Name] [nvarchar](512) NULL,
	[Type] [int] NULL,
	[IntValue] [int] NULL,
	[StrValue] [nvarchar](512) NULL,
	[TimeValue] [datetime] NULL,
	[BooleanValue] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[VE_event_historical]    Script Date: 1/03/2016 10:04:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VE_event_historical](
	[EventID] [int] IDENTITY(1,1) NOT NULL,
	[Module] [nvarchar](512) NULL,
	[EventType] [nvarchar](512) NULL,
	[ModuleAndEventText] [nvarchar](512) NULL,
	[Time] [datetime] NULL,
	[Source] [nvarchar](512) NULL,
	[Severity] [nvarchar](512) NULL,
	[Node] [nvarchar](512) NULL,
	[Acknowledged] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[EventID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[VE_props]    Script Date: 1/03/2016 10:04:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VE_props](
	[Name] [nvarchar](512) NULL,
	[Value] [nvarchar](512) NULL
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[VE_config_changes]    Script Date: 1/03/2016 10:04:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VE_config_changes] AS (SELECT [VE_event].EventID,[VE_event].Module,[VE_event].EventType,[VE_event].Time,[VE_event].Source,[VE_event].Severity,[VE_event].ModuleAndEventText,UserDisplayName.StrValue AS UserDisplayName,UserSID.StrValue AS UserSID,DesktopId.StrValue AS DesktopId,DesktopDisplayName.StrValue AS DesktopDisplayName,ThinAppId.StrValue AS ThinAppId,ThinAppDisplayName.StrValue AS ThinAppDisplayName,EntitlementSID.StrValue AS EntitlementSID,EntitlementDisplay.StrValue AS EntitlementDisplay,PolicyDisplayName.StrValue AS PolicyDisplayName,PolicyId.StrValue AS PolicyId FROM [VE_event] LEFT OUTER JOIN (SELECT EventID, StrValue FROM [VE_event_data] WHERE name = 'UserDisplayName')AS UserDisplayName ON [VE_event].EventID = UserDisplayName.EventID LEFT OUTER JOIN (SELECT EventID, StrValue FROM [VE_event_data] WHERE name = 'UserSID')AS UserSID ON [VE_event].EventID = UserSID.EventID LEFT OUTER JOIN (SELECT EventID, StrValue FROM [VE_event_data] WHERE name = 'DesktopId')AS DesktopId ON [VE_event].EventID = DesktopId.EventID LEFT OUTER JOIN (SELECT EventID, StrValue FROM [VE_event_data] WHERE name = 'DesktopDisplayName')AS DesktopDisplayName ON [VE_event].EventID = DesktopDisplayName.EventID LEFT OUTER JOIN (SELECT EventID, StrValue FROM [VE_event_data] WHERE name = 'ThinAppId')AS ThinAppId ON [VE_event].EventID = ThinAppId.EventID LEFT OUTER JOIN (SELECT EventID, StrValue FROM [VE_event_data] WHERE name = 'ThinAppDisplayName')AS ThinAppDisplayName ON [VE_event].EventID = ThinAppDisplayName.EventID LEFT OUTER JOIN (SELECT EventID, StrValue FROM [VE_event_data] WHERE name = 'EntitlementSID')AS EntitlementSID ON [VE_event].EventID = EntitlementSID.EventID LEFT OUTER JOIN (SELECT EventID, StrValue FROM [VE_event_data] WHERE name = 'EntitlementDisplay')AS EntitlementDisplay ON [VE_event].EventID = EntitlementDisplay.EventID LEFT OUTER JOIN (SELECT EventID, StrValue FROM [VE_event_data] WHERE name = 'PolicyDisplayName')AS PolicyDisplayName ON [VE_event].EventID = PolicyDisplayName.EventID LEFT OUTER JOIN (SELECT EventID, StrValue FROM [VE_event_data] WHERE name = 'PolicyId')AS PolicyId ON [VE_event].EventID = PolicyId.EventID WHERE ([VE_event].EventType = 'ADMIN_ADD_DESKTOP_ENTITLEMENT' OR [VE_event].EventType = 'ADMIN_REMOVE_DESKTOP_ENTITLEMENT' OR [VE_event].EventType = 'ADMIN_ADD_THINAPP_ENTITLEMENT' OR [VE_event].EventType = 'ADMIN_REMOVE_THINAPP_ENTITLEMENT' OR [VE_event].EventType = 'ADMIN_GLOBAL_POLICY_UPDATED' OR [VE_event].EventType = 'ADMIN_GLOBAL_POLICY_UPDATE_FAILED' OR [VE_event].EventType = 'ADMIN_POOL_POLICY_UPDATED' OR [VE_event].EventType = 'ADMIN_POOL_POLICY_UPDATE_FAILED' OR [VE_event].EventType = 'ADMIN_USER_POLICY_UPDATED' OR [VE_event].EventType = 'ADMIN_USER_POLICY_UPDATE_FAILED' OR [VE_event].EventType = 'ADMIN_VC_ADDED' OR [VE_event].EventType = 'ADMIN_SECURITY_SERVER_ADDED' OR [VE_event].EventType = 'ADMIN_DESKTOP_ADDED' OR [VE_event].EventType = 'ADMIN_TRANSFER_SERVER_ADDED' OR [VE_event].EventType = 'ADMIN_VC_REMOVED' OR [VE_event].EventType = 'ADMIN_SECURITY_SERVER_REMOVED' OR [VE_event].EventType = 'ADMIN_REMOVE_DESKTOP_SUCCEEDED' OR [VE_event].EventType = 'ADMIN_TRANSFER_SERVER_REMOVED' OR [VE_event].EventType = 'ADMIN_VC_EDITED' OR [VE_event].EventType = 'ADMIN_SECURITY_SERVER_EDITED' OR [VE_event].EventType = 'ADMIN_DESKTOP_EDITED' OR [VE_event].EventType = 'ADMIN_TRANSFER_SERVER_EDITED') );
GO
/****** Object:  View [dbo].[VE_config_changes_hist]    Script Date: 1/03/2016 10:04:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VE_config_changes_hist] AS (SELECT [VE_event_historical].EventID,[VE_event_historical].Module,[VE_event_historical].EventType,[VE_event_historical].Time,[VE_event_historical].Source,[VE_event_historical].Severity,[VE_event_historical].ModuleAndEventText,UserDisplayName.StrValue AS UserDisplayName,UserSID.StrValue AS UserSID,DesktopId.StrValue AS DesktopId,DesktopDisplayName.StrValue AS DesktopDisplayName,ThinAppId.StrValue AS ThinAppId,ThinAppDisplayName.StrValue AS ThinAppDisplayName,EntitlementSID.StrValue AS EntitlementSID,EntitlementDisplay.StrValue AS EntitlementDisplay,PolicyDisplayName.StrValue AS PolicyDisplayName,PolicyId.StrValue AS PolicyId FROM [VE_event_historical] LEFT OUTER JOIN (SELECT EventID, StrValue FROM [VE_event_data_historical] WHERE name = 'UserDisplayName')AS UserDisplayName ON [VE_event_historical].EventID = UserDisplayName.EventID LEFT OUTER JOIN (SELECT EventID, StrValue FROM [VE_event_data_historical] WHERE name = 'UserSID')AS UserSID ON [VE_event_historical].EventID = UserSID.EventID LEFT OUTER JOIN (SELECT EventID, StrValue FROM [VE_event_data_historical] WHERE name = 'DesktopId')AS DesktopId ON [VE_event_historical].EventID = DesktopId.EventID LEFT OUTER JOIN (SELECT EventID, StrValue FROM [VE_event_data_historical] WHERE name = 'DesktopDisplayName')AS DesktopDisplayName ON [VE_event_historical].EventID = DesktopDisplayName.EventID LEFT OUTER JOIN (SELECT EventID, StrValue FROM [VE_event_data_historical] WHERE name = 'ThinAppId')AS ThinAppId ON [VE_event_historical].EventID = ThinAppId.EventID LEFT OUTER JOIN (SELECT EventID, StrValue FROM [VE_event_data_historical] WHERE name = 'ThinAppDisplayName')AS ThinAppDisplayName ON [VE_event_historical].EventID = ThinAppDisplayName.EventID LEFT OUTER JOIN (SELECT EventID, StrValue FROM [VE_event_data_historical] WHERE name = 'EntitlementSID')AS EntitlementSID ON [VE_event_historical].EventID = EntitlementSID.EventID LEFT OUTER JOIN (SELECT EventID, StrValue FROM [VE_event_data_historical] WHERE name = 'EntitlementDisplay')AS EntitlementDisplay ON [VE_event_historical].EventID = EntitlementDisplay.EventID LEFT OUTER JOIN (SELECT EventID, StrValue FROM [VE_event_data_historical] WHERE name = 'PolicyDisplayName')AS PolicyDisplayName ON [VE_event_historical].EventID = PolicyDisplayName.EventID LEFT OUTER JOIN (SELECT EventID, StrValue FROM [VE_event_data_historical] WHERE name = 'PolicyId')AS PolicyId ON [VE_event_historical].EventID = PolicyId.EventID WHERE ([VE_event_historical].EventType = 'ADMIN_ADD_DESKTOP_ENTITLEMENT' OR [VE_event_historical].EventType = 'ADMIN_REMOVE_DESKTOP_ENTITLEMENT' OR [VE_event_historical].EventType = 'ADMIN_ADD_THINAPP_ENTITLEMENT' OR [VE_event_historical].EventType = 'ADMIN_REMOVE_THINAPP_ENTITLEMENT' OR [VE_event_historical].EventType = 'ADMIN_GLOBAL_POLICY_UPDATED' OR [VE_event_historical].EventType = 'ADMIN_GLOBAL_POLICY_UPDATE_FAILED' OR [VE_event_historical].EventType = 'ADMIN_POOL_POLICY_UPDATED' OR [VE_event_historical].EventType = 'ADMIN_POOL_POLICY_UPDATE_FAILED' OR [VE_event_historical].EventType = 'ADMIN_USER_POLICY_UPDATED' OR [VE_event_historical].EventType = 'ADMIN_USER_POLICY_UPDATE_FAILED' OR [VE_event_historical].EventType = 'ADMIN_VC_ADDED' OR [VE_event_historical].EventType = 'ADMIN_SECURITY_SERVER_ADDED' OR [VE_event_historical].EventType = 'ADMIN_DESKTOP_ADDED' OR [VE_event_historical].EventType = 'ADMIN_TRANSFER_SERVER_ADDED' OR [VE_event_historical].EventType = 'ADMIN_VC_REMOVED' OR [VE_event_historical].EventType = 'ADMIN_SECURITY_SERVER_REMOVED' OR [VE_event_historical].EventType = 'ADMIN_REMOVE_DESKTOP_SUCCEEDED' OR [VE_event_historical].EventType = 'ADMIN_TRANSFER_SERVER_REMOVED' OR [VE_event_historical].EventType = 'ADMIN_VC_EDITED' OR [VE_event_historical].EventType = 'ADMIN_SECURITY_SERVER_EDITED' OR [VE_event_historical].EventType = 'ADMIN_DESKTOP_EDITED' OR [VE_event_historical].EventType = 'ADMIN_TRANSFER_SERVER_EDITED') );
GO
/****** Object:  View [dbo].[VE_user_auth_failures]    Script Date: 1/03/2016 10:04:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VE_user_auth_failures] AS (SELECT [VE_event].EventID,[VE_event].Module,[VE_event].EventType,[VE_event].Time,[VE_event].Source,[VE_event].Severity,[VE_event].ModuleAndEventText,UserDisplayName.StrValue AS UserDisplayName,UserSID.StrValue AS UserSID,DesktopId.StrValue AS DesktopId,DesktopDisplayName.StrValue AS DesktopDisplayName,MachineId.StrValue AS MachineId FROM [VE_event] LEFT OUTER JOIN (SELECT EventID, StrValue FROM [VE_event_data] WHERE name = 'UserDisplayName')AS UserDisplayName ON [VE_event].EventID = UserDisplayName.EventID LEFT OUTER JOIN (SELECT EventID, StrValue FROM [VE_event_data] WHERE name = 'UserSID')AS UserSID ON [VE_event].EventID = UserSID.EventID LEFT OUTER JOIN (SELECT EventID, StrValue FROM [VE_event_data] WHERE name = 'DesktopId')AS DesktopId ON [VE_event].EventID = DesktopId.EventID LEFT OUTER JOIN (SELECT EventID, StrValue FROM [VE_event_data] WHERE name = 'DesktopDisplayName')AS DesktopDisplayName ON [VE_event].EventID = DesktopDisplayName.EventID LEFT OUTER JOIN (SELECT EventID, StrValue FROM [VE_event_data] WHERE name = 'MachineId')AS MachineId ON [VE_event].EventID = MachineId.EventID WHERE ([VE_event].EventType = 'BROKER_USER_AUTHFAILED_BAD_USER_PASSWORD' OR [VE_event].EventType = 'BROKER_USER_AUTHFAILED_RADIUS_ACCESS_DENIED' OR [VE_event].EventType = 'BROKER_USER_AUTHFAILED_ACCOUNT_LOCKED_OUT' OR [VE_event].EventType = 'BROKER_USER_AUTHFAILED_SECUREID_ACCESS_DENIED' OR [VE_event].EventType = 'BROKER_USER_AUTHFAILED_SAML_ACCESS_REQUIRED' OR [VE_event].EventType = 'BROKER_USER_AUTHFAILED_SAML_ACCESS_DENIED') );
GO
/****** Object:  View [dbo].[VE_user_auth_failures_hist]    Script Date: 1/03/2016 10:04:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VE_user_auth_failures_hist] AS (SELECT [VE_event_historical].EventID,[VE_event_historical].Module,[VE_event_historical].EventType,[VE_event_historical].Time,[VE_event_historical].Source,[VE_event_historical].Severity,[VE_event_historical].ModuleAndEventText,UserDisplayName.StrValue AS UserDisplayName,UserSID.StrValue AS UserSID,DesktopId.StrValue AS DesktopId,DesktopDisplayName.StrValue AS DesktopDisplayName,MachineId.StrValue AS MachineId FROM [VE_event_historical] LEFT OUTER JOIN (SELECT EventID, StrValue FROM [VE_event_data_historical] WHERE name = 'UserDisplayName')AS UserDisplayName ON [VE_event_historical].EventID = UserDisplayName.EventID LEFT OUTER JOIN (SELECT EventID, StrValue FROM [VE_event_data_historical] WHERE name = 'UserSID')AS UserSID ON [VE_event_historical].EventID = UserSID.EventID LEFT OUTER JOIN (SELECT EventID, StrValue FROM [VE_event_data_historical] WHERE name = 'DesktopId')AS DesktopId ON [VE_event_historical].EventID = DesktopId.EventID LEFT OUTER JOIN (SELECT EventID, StrValue FROM [VE_event_data_historical] WHERE name = 'DesktopDisplayName')AS DesktopDisplayName ON [VE_event_historical].EventID = DesktopDisplayName.EventID LEFT OUTER JOIN (SELECT EventID, StrValue FROM [VE_event_data_historical] WHERE name = 'MachineId')AS MachineId ON [VE_event_historical].EventID = MachineId.EventID WHERE ([VE_event_historical].EventType = 'BROKER_USER_AUTHFAILED_BAD_USER_PASSWORD' OR [VE_event_historical].EventType = 'BROKER_USER_AUTHFAILED_RADIUS_ACCESS_DENIED' OR [VE_event_historical].EventType = 'BROKER_USER_AUTHFAILED_ACCOUNT_LOCKED_OUT' OR [VE_event_historical].EventType = 'BROKER_USER_AUTHFAILED_SECUREID_ACCESS_DENIED' OR [VE_event_historical].EventType = 'BROKER_USER_AUTHFAILED_SAML_ACCESS_REQUIRED' OR [VE_event_historical].EventType = 'BROKER_USER_AUTHFAILED_SAML_ACCESS_DENIED') );
GO
/****** Object:  View [dbo].[VE_user_count_events]    Script Date: 1/03/2016 10:04:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VE_user_count_events] AS (SELECT [VE_event].EventID,[VE_event].Module,[VE_event].EventType,[VE_event].Time,[VE_event].Source,[VE_event].Severity,[VE_event].ModuleAndEventText,UserCount.StrValue AS UserCount,CCUCount.StrValue AS CCUCount,NUCount.StrValue AS NUCount FROM [VE_event] LEFT OUTER JOIN (SELECT EventID, StrValue FROM [VE_event_data] WHERE name = 'UserCount')AS UserCount ON [VE_event].EventID = UserCount.EventID LEFT OUTER JOIN (SELECT EventID, StrValue FROM [VE_event_data] WHERE name = 'CCUCount')AS CCUCount ON [VE_event].EventID = CCUCount.EventID LEFT OUTER JOIN (SELECT EventID, StrValue FROM [VE_event_data] WHERE name = 'NUCount')AS NUCount ON [VE_event].EventID = NUCount.EventID WHERE ([VE_event].EventType = 'BROKER_DAILY_MAX_DESKTOP_SESSIONS' OR [VE_event].EventType = 'BROKER_DAILY_MAX_APP_USERS' OR [VE_event].EventType = 'BROKER_DAILY_MAX_CCU_USERS' OR [VE_event].EventType = 'BROKER_DAILY_MAX_NU_USERS') );
GO
/****** Object:  View [dbo].[VE_user_count_events_hist]    Script Date: 1/03/2016 10:04:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VE_user_count_events_hist] AS (SELECT [VE_event_historical].EventID,[VE_event_historical].Module,[VE_event_historical].EventType,[VE_event_historical].Time,[VE_event_historical].Source,[VE_event_historical].Severity,[VE_event_historical].ModuleAndEventText,UserCount.StrValue AS UserCount,CCUCount.StrValue AS CCUCount,NUCount.StrValue AS NUCount FROM [VE_event_historical] LEFT OUTER JOIN (SELECT EventID, StrValue FROM [VE_event_data_historical] WHERE name = 'UserCount')AS UserCount ON [VE_event_historical].EventID = UserCount.EventID LEFT OUTER JOIN (SELECT EventID, StrValue FROM [VE_event_data_historical] WHERE name = 'CCUCount')AS CCUCount ON [VE_event_historical].EventID = CCUCount.EventID LEFT OUTER JOIN (SELECT EventID, StrValue FROM [VE_event_data_historical] WHERE name = 'NUCount')AS NUCount ON [VE_event_historical].EventID = NUCount.EventID WHERE ([VE_event_historical].EventType = 'BROKER_DAILY_MAX_DESKTOP_SESSIONS' OR [VE_event_historical].EventType = 'BROKER_DAILY_MAX_APP_USERS' OR [VE_event_historical].EventType = 'BROKER_DAILY_MAX_CCU_USERS' OR [VE_event_historical].EventType = 'BROKER_DAILY_MAX_NU_USERS') );
GO
/****** Object:  View [dbo].[VE_user_events]    Script Date: 1/03/2016 10:04:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VE_user_events] AS (SELECT [VE_event].EventID,[VE_event].Module,[VE_event].EventType,[VE_event].Time,[VE_event].Source,[VE_event].Severity,[VE_event].ModuleAndEventText,UserDisplayName.StrValue AS UserDisplayName,UserSID.StrValue AS UserSID,DesktopId.StrValue AS DesktopId,DesktopDisplayName.StrValue AS DesktopDisplayName,MachineId.StrValue AS MachineId,PoolId.StrValue AS PoolId,SessionType.StrValue AS SessionType FROM [VE_event] LEFT OUTER JOIN (SELECT EventID, StrValue FROM [VE_event_data] WHERE name = 'UserDisplayName')AS UserDisplayName ON [VE_event].EventID = UserDisplayName.EventID LEFT OUTER JOIN (SELECT EventID, StrValue FROM [VE_event_data] WHERE name = 'UserSID')AS UserSID ON [VE_event].EventID = UserSID.EventID LEFT OUTER JOIN (SELECT EventID, StrValue FROM [VE_event_data] WHERE name = 'DesktopId')AS DesktopId ON [VE_event].EventID = DesktopId.EventID LEFT OUTER JOIN (SELECT EventID, StrValue FROM [VE_event_data] WHERE name = 'DesktopDisplayName')AS DesktopDisplayName ON [VE_event].EventID = DesktopDisplayName.EventID LEFT OUTER JOIN (SELECT EventID, StrValue FROM [VE_event_data] WHERE name = 'MachineId')AS MachineId ON [VE_event].EventID = MachineId.EventID LEFT OUTER JOIN (SELECT EventID, StrValue FROM [VE_event_data] WHERE name = 'PoolId')AS PoolId ON [VE_event].EventID = PoolId.EventID LEFT OUTER JOIN (SELECT EventID, StrValue FROM [VE_event_data] WHERE name = 'SessionType')AS SessionType ON [VE_event].EventID = SessionType.EventID WHERE ([VE_event].EventType = 'BROKER_USERLOGGEDIN' OR [VE_event].EventType = 'BROKER_USERLOGGEDOUT' OR [VE_event].EventType = 'AGENT_CONNECTED' OR [VE_event].EventType = 'AGENT_DISCONNECTED' OR [VE_event].EventType = 'AGENT_ENDED' OR [VE_event].EventType = 'AGENT_RECONNECTED') );
GO
/****** Object:  View [dbo].[VE_user_events_hist]    Script Date: 1/03/2016 10:04:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VE_user_events_hist] AS (SELECT [VE_event_historical].EventID,[VE_event_historical].Module,[VE_event_historical].EventType,[VE_event_historical].Time,[VE_event_historical].Source,[VE_event_historical].Severity,[VE_event_historical].ModuleAndEventText,UserDisplayName.StrValue AS UserDisplayName,UserSID.StrValue AS UserSID,DesktopId.StrValue AS DesktopId,DesktopDisplayName.StrValue AS DesktopDisplayName,MachineId.StrValue AS MachineId,PoolId.StrValue AS PoolId,SessionType.StrValue AS SessionType FROM [VE_event_historical] LEFT OUTER JOIN (SELECT EventID, StrValue FROM [VE_event_data_historical] WHERE name = 'UserDisplayName')AS UserDisplayName ON [VE_event_historical].EventID = UserDisplayName.EventID LEFT OUTER JOIN (SELECT EventID, StrValue FROM [VE_event_data_historical] WHERE name = 'UserSID')AS UserSID ON [VE_event_historical].EventID = UserSID.EventID LEFT OUTER JOIN (SELECT EventID, StrValue FROM [VE_event_data_historical] WHERE name = 'DesktopId')AS DesktopId ON [VE_event_historical].EventID = DesktopId.EventID LEFT OUTER JOIN (SELECT EventID, StrValue FROM [VE_event_data_historical] WHERE name = 'DesktopDisplayName')AS DesktopDisplayName ON [VE_event_historical].EventID = DesktopDisplayName.EventID LEFT OUTER JOIN (SELECT EventID, StrValue FROM [VE_event_data_historical] WHERE name = 'MachineId')AS MachineId ON [VE_event_historical].EventID = MachineId.EventID LEFT OUTER JOIN (SELECT EventID, StrValue FROM [VE_event_data_historical] WHERE name = 'PoolId')AS PoolId ON [VE_event_historical].EventID = PoolId.EventID LEFT OUTER JOIN (SELECT EventID, StrValue FROM [VE_event_data_historical] WHERE name = 'SessionType')AS SessionType ON [VE_event_historical].EventID = SessionType.EventID WHERE ([VE_event_historical].EventType = 'BROKER_USERLOGGEDIN' OR [VE_event_historical].EventType = 'BROKER_USERLOGGEDOUT' OR [VE_event_historical].EventType = 'AGENT_CONNECTED' OR [VE_event_historical].EventType = 'AGENT_DISCONNECTED' OR [VE_event_historical].EventType = 'AGENT_ENDED' OR [VE_event_historical].EventType = 'AGENT_RECONNECTED') );
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IDX_113150312_1165289939]    Script Date: 1/03/2016 10:04:23 AM ******/
CREATE NONCLUSTERED INDEX [IDX_113150312_1165289939] ON [dbo].[VE_event]
(
	[FolderPath] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IDX_113150312_1272616931]    Script Date: 1/03/2016 10:04:23 AM ******/
CREATE NONCLUSTERED INDEX [IDX_113150312_1272616931] ON [dbo].[VE_event]
(
	[ThinAppId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IDX_113150312_1517507811]    Script Date: 1/03/2016 10:04:23 AM ******/
CREATE NONCLUSTERED INDEX [IDX_113150312_1517507811] ON [dbo].[VE_event]
(
	[UserSID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IDX_113150312_155709872]    Script Date: 1/03/2016 10:04:23 AM ******/
CREATE NONCLUSTERED INDEX [IDX_113150312_155709872] ON [dbo].[VE_event]
(
	[EndpointId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IDX_113150312_1958081498]    Script Date: 1/03/2016 10:04:23 AM ******/
CREATE NONCLUSTERED INDEX [IDX_113150312_1958081498] ON [dbo].[VE_event]
(
	[GroupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IDX_113150312_2106320280]    Script Date: 1/03/2016 10:04:23 AM ******/
CREATE NONCLUSTERED INDEX [IDX_113150312_2106320280] ON [dbo].[VE_event]
(
	[UserDiskPathId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IDX_113150312_560061897]    Script Date: 1/03/2016 10:04:23 AM ******/
CREATE NONCLUSTERED INDEX [IDX_113150312_560061897] ON [dbo].[VE_event]
(
	[DesktopId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IDX_113150312_560166818]    Script Date: 1/03/2016 10:04:23 AM ******/
CREATE NONCLUSTERED INDEX [IDX_113150312_560166818] ON [dbo].[VE_event]
(
	[MachineId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IDX_113150312_72797152]    Script Date: 1/03/2016 10:04:23 AM ******/
CREATE NONCLUSTERED INDEX [IDX_113150312_72797152] ON [dbo].[VE_event]
(
	[LUNId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
USE [master]
GO
ALTER DATABASE [VEVENTDB] SET  READ_WRITE 
GO
