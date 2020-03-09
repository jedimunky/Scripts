use master;

-- Check backup details		   
RESTORE FILELISTONLY   FROM DISK = 'G:\SQLBackups\MSSQL12.SITECORE\SIT3_Sitecore_Master\SIT3_Sitecore_Master_backup_2017_11_20_184535_2433325.bak';

-- **************************************
-- Master
-- **************************************

-- restore the database from backup
RESTORE DATABASE [INTG_Sitecore_Master] 
   FROM DISK = 'G:\SQLBackups\MSSQL12.SITECORE\SIT3_Sitecore_Master\SIT3_Sitecore_Master_backup_2017_11_20_184535_2433325.bak'
   WITH STATS=10
      , MOVE 'SIT3_Sitecore_Master'      TO 'E:\SQLData\MSSQL12.SITECORE\INTG_Sitecore_Master.mdf'
      , MOVE 'SIT3_Sitecore_Master_log'  TO 'F:\SQLLogs\MSSQL12.SITECORE\INTG_Sitecore_Master.ldf'
	  --, REPLACE

-- rename logical files
ALTER DATABASE [INTG_Sitecore_Master] MODIFY FILE (NAME=N'SIT3_Sitecore_Master',     NEWNAME=N'INTG_Sitecore_Master')
ALTER DATABASE [INTG_Sitecore_Master] MODIFY FILE (NAME=N'SIT3_Sitecore_Master_log', NEWNAME=N'INTG_Sitecore_Master_log')

-- Add users 
USE [INTG_Sitecore_Master]
DROP   USER [DEV\CMSUser_sit];
CREATE USER [DEV\CMSUser_intg] FOR LOGIN [DEV\CMSUser_intg]; ALTER ROLE [db_owner] ADD MEMBER [DEV\CMSUser_intg]
--CREATE USER [WebSIT3Read]      FOR LOGIN [WebSIT3Read]     ; ALTER ROLE [db_datareader] ADD MEMBER [WebSIT3Read];
--CREATE USER [NT SERVICE\HealthService] FOR LOGIN [NT SERVICE\HealthService];

-- **************************************
-- Core
-- **************************************

-- restore the database from backup
RESTORE DATABASE [INTG_Sitecore_Core] 
   FROM DISK = 'G:\SQLBackups\MSSQL12.SITECORE\SIT3_Sitecore_Core\SIT3_Sitecore_Core_backup_2017_11_20_184533_3009325.bak'
   WITH STATS=10
      , MOVE 'SIT3_Sitecore_Core'      TO 'E:\SQLData\MSSQL12.SITECORE\INTG_Sitecore_Core.mdf'
      , MOVE 'SIT3_Sitecore_Core_log'  TO 'F:\SQLLogs\MSSQL12.SITECORE\INTG_Sitecore_Core.ldf'
	  --, REPLACE

-- rename logical files
ALTER DATABASE [INTG_Sitecore_Core] MODIFY FILE (NAME=N'SIT3_Sitecore_Core',     NEWNAME=N'INTG_Sitecore_Core')
ALTER DATABASE [INTG_Sitecore_Core] MODIFY FILE (NAME=N'SIT3_Sitecore_Core_log', NEWNAME=N'INTG_Sitecore_Core_log')

-- Add users 
USE [INTG_Sitecore_Core]
DROP   USER [DEV\CMSUser_sit];
CREATE USER [DEV\CMSUser_intg] FOR LOGIN [DEV\CMSUser_intg]; ALTER ROLE [db_owner] ADD MEMBER [DEV\CMSUser_intg]
--CREATE USER [WebSIT3Read]      FOR LOGIN [WebSIT3Read]     ; ALTER ROLE [db_datareader] ADD MEMBER [WebSIT3Read];
--CREATE USER [NT SERVICE\HealthService] FOR LOGIN [NT SERVICE\HealthService];

-- **************************************
-- Web
-- **************************************

-- restore the database from backup
RESTORE DATABASE [INTG_Sitecore_Web] 
   FROM DISK = 'G:\SQLBackups\MSSQL12.SITECORE\SIT3_Sitecore_Web\SIT3_Sitecore_Web_backup_2017_11_20_184556_0319543.bak'
   WITH STATS=10
      , MOVE 'SIT3_Sitecore_Web'      TO 'E:\SQLData\MSSQL12.SITECORE\INTG_Sitecore_Web.mdf'
      , MOVE 'SIT3_Sitecore_Web_log'  TO 'F:\SQLLogs\MSSQL12.SITECORE\INTG_Sitecore_Web.ldf'
	  --, REPLACE

-- rename logical files
ALTER DATABASE [INTG_Sitecore_Web] MODIFY FILE (NAME=N'SIT3_Sitecore_Web',     NEWNAME=N'INTG_Sitecore_Web')
ALTER DATABASE [INTG_Sitecore_Web] MODIFY FILE (NAME=N'SIT3_Sitecore_Web_log', NEWNAME=N'INTG_Sitecore_Web_log')

-- Add users 
USE [INTG_Sitecore_Web]
DROP   USER [DEV\CMSUser_sit];
CREATE USER [DEV\CMSUser_intg] FOR LOGIN [DEV\CMSUser_intg]; ALTER ROLE [db_owner] ADD MEMBER [DEV\CMSUser_intg]
--CREATE USER [WebSIT3Read]      FOR LOGIN [WebSIT3Read]     ; ALTER ROLE [db_datareader] ADD MEMBER [WebSIT3Read];
--CREATE USER [NT SERVICE\HealthService] FOR LOGIN [NT SERVICE\HealthService];

-- **************************************
-- Wffm
-- **************************************

-- restore the database from backup
RESTORE DATABASE [INTG_Sitecore_Wffm] 
   FROM DISK = 'G:\SQLBackups\MSSQL12.SITECORE\SIT3_Sitecore_Wffm\SIT3_Sitecore_Wffm_backup_2017_11_20_184604_5324020.bak'
   WITH STATS=10
      , MOVE 'SIT3_Sitecore_Wffm'      TO 'E:\SQLData\MSSQL12.SITECORE\INTG_Sitecore_Wffm.mdf'
      , MOVE 'SIT3_Sitecore_Wffm_log'  TO 'F:\SQLLogs\MSSQL12.SITECORE\INTG_Sitecore_Wffm.ldf'
	  --, REPLACE

-- rename logical files
ALTER DATABASE [INTG_Sitecore_Wffm] MODIFY FILE (NAME=N'SIT3_Sitecore_Wffm',     NEWNAME=N'INTG_Sitecore_Wffm')
ALTER DATABASE [INTG_Sitecore_Wffm] MODIFY FILE (NAME=N'SIT3_Sitecore_Wffm_log', NEWNAME=N'INTG_Sitecore_Wffm_log')

-- Add users 
USE [INTG_Sitecore_Wffm]
DROP   USER [DEV\CMSUser_sit];
CREATE USER [DEV\CMSUser_intg] FOR LOGIN [DEV\CMSUser_intg]; ALTER ROLE [db_owner] ADD MEMBER [DEV\CMSUser_intg]
--CREATE USER [WebSIT3Read]      FOR LOGIN [WebSIT3Read]     ; ALTER ROLE [db_datareader] ADD MEMBER [WebSIT3Read];
--CREATE USER [NT SERVICE\HealthService] FOR LOGIN [NT SERVICE\HealthService];

-- **************************************
-- Reporting
-- **************************************

-- restore the database from backup
RESTORE DATABASE [INTG_Sitecore_Reporting] 
   FROM DISK = 'G:\SQLBackups\MSSQL12.SITECORE\SIT3_Sitecore_Reporting\SIT3_Sitecore_Reporting_backup_2017_11_20_184555_7506974.bak'
   WITH STATS=10
      , MOVE 'SIT3_Sitecore_Reporting'      TO 'E:\SQLData\MSSQL12.SITECORE\INTG_Sitecore_Reporting.mdf'
      , MOVE 'SIT3_Sitecore_Reporting_log'  TO 'F:\SQLLogs\MSSQL12.SITECORE\INTG_Sitecore_Reporting.ldf'
	  --, REPLACE

-- rename logical files
ALTER DATABASE [INTG_Sitecore_Reporting] MODIFY FILE (NAME=N'SIT3_Sitecore_Reporting',     NEWNAME=N'INTG_Sitecore_Reporting')
ALTER DATABASE [INTG_Sitecore_Reporting] MODIFY FILE (NAME=N'SIT3_Sitecore_Reporting_log', NEWNAME=N'INTG_Sitecore_Reporting_log')

-- Add users 
USE [INTG_Sitecore_Reporting]
DROP   USER [DEV\CMSUser_sit];
CREATE USER [DEV\CMSUser_intg] FOR LOGIN [DEV\CMSUser_intg]; ALTER ROLE [db_owner] ADD MEMBER [DEV\CMSUser_intg]
--CREATE USER [WebSIT3Read]      FOR LOGIN [WebSIT3Read]     ; ALTER ROLE [db_datareader] ADD MEMBER [WebSIT3Read];
--CREATE USER [NT SERVICE\HealthService] FOR LOGIN [NT SERVICE\HealthService];