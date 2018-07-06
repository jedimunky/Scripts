--***********************************
-- EBS Restore from PROD backup  
-- NB: SIT is also known as SIT3
--***********************************

use master;

DECLARE @BackupToRestore         NVARCHAR(100) = 'hbf.ebs_backup_2018_07_03_191500_8350172.bak';
DECLARE @BackupToRestoreFullPath NVARCHAR(200) = CONCAT('G:\TempBackups\', @BackupToRestore)

-- Get the file list
RESTORE FILELISTONLY FROM DISK = @BackupToRestoreFullPath;

-- remove from availability group
ALTER AVAILABILITY GROUP [WEBAPPS_AG] REMOVE DATABASE [hbf.ebs.sit];   

-- Take log backup and leave in recovery pending
DECLARE @TranLogBackupName       NVARCHAR(100) = CONCAT('hbf.ebs.sit_backup_', format(getdate(),'yyyy_mm_dd_HHmmss_0000000'));
DECLARE @TranLogBackupFullPath   NVARCHAR(200) = CONCAT('G:\SQLBackups\MSSQL13.WEBAPPS\hbf.ebs.sit\', @TranLogBackupName, '.trn');

ALTER DATABASE [hbf.ebs.sit] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

BACKUP LOG [hbf.ebs.sit] TO  DISK = @TranLogBackupFullPath
   WITH NOFORMAT, NOINIT,  NAME = @TranLogBackupName, SKIP, REWIND, NOUNLOAD, STATS = 10, NORECOVERY;
   
-- Restore command 
RESTORE DATABASE [hbf.ebs.sit]
   FROM DISK = @BackupToRestoreFullPath
   WITH MOVE 'hbf.ebs'     TO 'E:\SQLData\MSSQL13.WEBAPPS\hbf.ebs.sit.mdf',
        MOVE 'hbf.ebs_log' TO 'F:\SQLLogs\MSSQL13.WEBAPPS\hbf.ebs.sit_log.ldf',
        STATS=10, REPLACE;

-- Alter logical names
ALTER DATABASE [hbf.ebs.sit] MODIFY FILE ( NAME = [hbf.ebs],     NEWNAME = [hbf.ebs.sit] );
ALTER DATABASE [hbf.ebs.sit] MODIFY FILE ( NAME = [hbf.ebs_log], NEWNAME = [hbf.ebs.sit_log] );

-- Shrink the files
use [master];
ALTER DATABASE [hbf.ebs.sit] SET RECOVERY SIMPLE WITH NO_WAIT;

use [hbf.ebs.sit];
truncate table dbo.Logs;
DBCC SHRINKFILE([hbf.ebs.sit],1024);
DBCC SHRINKFILE([hbf.ebs.sit_log],128); 

use [master];
ALTER DATABASE [hbf.ebs.sit] SET RECOVERY FULL WITH NO_WAIT;

-- Alter dbo user 
ALTER AUTHORIZATION ON DATABASE::[hbf.ebs.sit] TO [DEV\msqlcon];

-- Drop PROD users
use [hbf.ebs.sit];
DROP USER [NTDOMAIN\svc_ebsapp];
DROP USER [NTDOMAIN\svc_ebsweb];
DROP USER [NTDOMAIN\EBS-DB-READ-PROD];
DROP USER [svc_ebstib_prod];
DROP USER [svc_ebsdmz];

-- Create SIT users
use [hbf.ebs.sit];

CREATE USER [DEV\svc_ebsapp_sit]       FOR LOGIN [DEV\svc_ebsapp_sit] WITH DEFAULT_SCHEMA=[dbo];
EXEC sp_addrolemember N'db_ddladmin',   N'DEV\svc_ebsapp_sit';
EXEC sp_addrolemember N'db_datareader', N'DEV\svc_ebsapp_sit';
EXEC sp_addrolemember N'db_datawriter', N'DEV\svc_ebsapp_sit';

CREATE USER [DEV\svc_ebsweb_sit]       FOR LOGIN [DEV\svc_ebsweb_sit] WITH DEFAULT_SCHEMA=[dbo];
EXEC sp_addrolemember N'db_ddladmin',   N'DEV\svc_ebsweb_sit';
EXEC sp_addrolemember N'db_datareader', N'DEV\svc_ebsweb_sit';
EXEC sp_addrolemember N'db_datawriter', N'DEV\svc_ebsweb_sit';

CREATE USER [DEV\EBS-DB-READ-SIT]      FOR LOGIN [DEV\EBS-DB-READ-SIT] WITH DEFAULT_SCHEMA=[dbo];
EXEC sp_addrolemember N'db_datareader', N'DEV\EBS-DB-READ-SIT';

CREATE USER [DEV\EBS-DEV]               FOR LOGIN [DEV\EBS-DEV] WITH DEFAULT_SCHEMA=[dbo];
EXEC sp_addrolemember N'db_datareader', N'DEV\EBS-DEV';

CREATE USER [DevEbsAdmin]               FOR LOGIN [DevEbsAdmin] WITH DEFAULT_SCHEMA=[dbo];
EXEC sp_addrolemember N'db_owner',      N'DevEbsAdmin';
DENY BACKUP DATABASE TO [DevEbsAdmin]; DENY BACKUP LOG TO [DevEbsAdmin];

CREATE USER [WebDevRead]               FOR LOGIN [WebDevRead] WITH DEFAULT_SCHEMA=[dbo];
EXEC sp_addrolemember N'db_datareader', N'WebDevRead';

CREATE USER [WebDevWrite]               FOR LOGIN [WebDevWrite] WITH DEFAULT_SCHEMA=[dbo];
EXEC sp_addrolemember N'db_datareader', N'WebDevWrite';

-- Update email address
use [hbf.ebs.sit];

update [dbo].[Resource] 
set    EmailAddress = 'EBStest@hbf.com.au'
where  EmailAddress is not null
and    EmailAddress <> '';

update [dbo].[CompanyContact] 
set    Email = 'EBStest@hbf.com.au'
where  Email is not null
and    Email <> '';

update [dbo].[BusinessUnit] 
set    EmailAddress = 'EBStest@hbf.com.au'
where  EmailAddress is not null
and    EmailAddress <> '';

-- Take full backup
use [master];

DECLARE @FullBackupName       NVARCHAR(100) = CONCAT('hbf.ebs.sit_backup_', format(getdate(),'yyyy_mm_dd_HHmmss_0000000'));
DECLARE @FullBackupFullPath   NVARCHAR(200) = CONCAT('G:\SQLBackups\MSSQL13.WEBAPPS\hbf.ebs.sit\', @FullBackupName, '.bak');

BACKUP DATABASE [hbf.ebs.sit] TO DISK=@FullBackupFullPath
      WITH NOFORMAT, INIT, NAME = @FullBackupName, SKIP, NOREWIND, NOUNLOAD,  STATS = 5;
	  
-- Add back to AG	  