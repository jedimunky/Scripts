-- ***** Remove from Availability Group first *****
USE [master];
ALTER AVAILABILITY GROUP [SITECORE_AG] REMOVE DATABASE [SIT3_Sitecore_Core];
ALTER AVAILABILITY GROUP [SITECORE_AG] REMOVE DATABASE [SIT3_Sitecore_Master];
ALTER AVAILABILITY GROUP [SITECORE_AG] REMOVE DATABASE [SIT3_Sitecore_Web];


--*****************************************************************************
--
--  This script will refresh the SIT3 Sitecore environment from PROD backups.
--
--  Points to note:
--     PROD backups should be copied to the directory indicated in @TempBackupDir.
--     PROD backups should be renamed <dbname>_yyy_MM_DD.bak (ie: remove the time part of the backup name).
--     Script assumes backup date is yesterday.
--
--     We generally only refresh Core, Master and Web databases, but the script can be altered
--        to include or exclude others if required (refer @DbTable table variable)
--
--*****************************************************************************

use master;

SET NOCOUNT ON;

DECLARE @ENV         VARCHAR(10)   = 'SIT3';     -- The target environment
DECLARE @DOMAIN      VARCHAR(8)    = 'DEV';      -- Used when setting the database owner
DECLARE @EmailPfx    VARCHAR(4)    = 'T3';       -- Used when updating the email address in SharedFields table

DECLARE @CMD         NVARCHAR(1024) = '';
DECLARE @RC          INT;

-- Database variables
DECLARE @ProdDb       SYSNAME = '';
DECLARE @ProdFileName VARCHAR(1024) = '';
DECLARE @LocalDb      SYSNAME = '';

-- Backup variables
DECLARE @DefaultBackupDir   VARCHAR(1024) = null; -- default instance backup directory
DECLARE @BackupDir          VARCHAR(1024) = null; -- database backup directory

DECLARE @TempBackupDir      VARCHAR(1024) = 'G:\TempBackups';
DECLARE @BackupDate         CHAR(10)      = FORMAT(DATEADD(d,-1,GETDATE()),'yyyy_MM_dd'); -- ie. yesterday 

DECLARE @BackupName         VARCHAR(1024) = null;
DECLARE @BackupFileFullPath VARCHAR(1024) = null;

--
-- Setup Database table (comment out databases which do not need restoring)
-- 
DECLARE @DbTable TABLE (ProdDb SYSNAME, ProdFileName varchar(128), LocalDb SYSNAME);

INSERT INTO @DbTable VALUES ('PROD_Sitecore_Core'     , 'PROD_Sitecore_Core'      , @ENV + '_Sitecore_Core');
INSERT INTO @DbTable VALUES ('PROD_Sitecore_Master'   , 'PROD_Sitecore_Master'    , @ENV + '_Sitecore_Master');
INSERT INTO @DbTable VALUES ('PROD_Sitecore_Web'      , 'PROD_Sitecore_Web'       , @ENV + '_Sitecore_Web');
--INSERT INTO @DbTable VALUES ('PROD_Sitecore_Wffm'     , 'PROD_Sitecore_Wffm'      , @ENV + '_Sitecore_Wffm');
--INSERT INTO @DbTable VALUES ('PROD_Sitecore_Reporting', 'PROD_Sitecore_Reporting' , @ENV + '_Sitecore_Reporting');

DECLARE DBCSR CURSOR FOR SELECT ProdDb, ProdFileName, LocalDb FROM @DbTable ORDER BY ProdDb;


BEGIN TRY
--*****************************************************************************
--
--  Step 0: Initialize stuff
--
--*****************************************************************************

-- Get the instance default backup directory
EXECUTE [master].dbo.xp_instance_regread 
      N'HKEY_LOCAL_MACHINE', 
      N'SOFTWARE\Microsoft\MSSQLServer\MSSQLServer', 
      N'BackupDirectory',
      @DefaultBackupDir output;

--*****************************************************************************
--
--  Step 1: Kill connections, backup tran log and set to restoring state
--
--*****************************************************************************
OPEN DBCSR;
FETCH NEXT FROM DBCSR INTO @ProdDb, @ProdFileName, @LocalDb

WHILE @@FETCH_STATUS=0
BEGIN
   -- Boot off all connections
   SET @CMD = 'ALTER DATABASE [' + @LocalDb + '] SET SINGLE_USER WITH ROLLBACK IMMEDIATE'
   PRINT @CMD
   EXEC sp_executesql @CMD
   
   -- Setup the backup name and location
   SET @BackupName = @LocalDb + '_backup_' 
                   + REPLACE(REPLACE(REPLACE(REPLACE(CONVERT(varchar,SYSDATETIME(), 121),'-','_'),':',''),' ','_'),'.','_')
   SET @BackupDir = @DefaultBackupDir + '\' + @LocalDb
   SET @BackupFileFullPath = @BackupDir + '\' + @BackupName + '.trn'
	   
   EXECUTE master.dbo.xp_create_subdir @BackupDir
   
   -- Backup the transaction log (with no recovery to set it to restoring state)
   BACKUP LOG @LocalDb 
	       TO DISK = @BackupFileFullPath
		 WITH NORECOVERY, NOFORMAT, NOINIT, NAME = @BackupName, SKIP, REWIND, NOUNLOAD,  STATS = 10
   
   PRINT ''
   FETCH NEXT FROM DBCSR INTO @ProdDb, @ProdFileName, @LocalDb
END

CLOSE DBCSR;

--*****************************************************************************
--
--  Step 2: Restore the Database, Update filenames, Update Users\Logins
--
--*****************************************************************************
OPEN DBCSR;
FETCH NEXT FROM DBCSR INTO @ProdDb, @ProdFileName, @LocalDb


WHILE @@FETCH_STATUS=0
BEGIN

   -- Determine the backup name
   SET @BackupName = @ProdDb + '_backup_' + @BackupDate + '.bak'
   
   -- Restore the database 
   SET @CMD = 'RESTORE DATABASE [' + @LocalDb + '] ' +
              'FROM DISK = ''' + @TempBackupDir + '\' + @BackupName  + ''' ' +
              'WITH MOVE ''' + @ProdFileName + '''     TO ''E:\SQLData\MSSQL12.SITECORE\' + @LocalDb + '.mdf'', ' +
			  '     MOVE ''' + @ProdFileName + '_log'' TO ''F:\SQLLogs\MSSQL12.SITECORE\' + @LocalDb + '.ldf'', ' +
              '     STATS=10, REPLACE '
   PRINT @CMD
   EXEC sp_executesql @CMD

   -- Modify logical file names to reflect environment
   SET @CMD = 'ALTER DATABASE [' + @LocalDb + '] MODIFY FILE ( NAME = ' + @ProdFileName + ', NEWNAME = ' + @LocalDb + ' )'
   PRINT @CMD   
   EXEC sp_executesql @CMD

   SET @CMD = 'ALTER DATABASE [' + @LocalDb + '] MODIFY FILE ( NAME = ' + @ProdFileName + '_log, NEWNAME = ' + @LocalDb + '_log )'
   PRINT @CMD   
   EXEC sp_executesql @CMD
   
   -- Drop NTDOMAIN\CMSUser_prod
   SET @CMD = 'USE [' + @LocalDb + ']; DROP USER [NTDOMAIN\CMSUser_prod];'
   PRINT @CMD   
   EXEC sp_executesql @CMD
   
   -- Drop CDUser (not used in DEV domain) 
   SET @CMD = 'USE [' + @LocalDb + ']; DROP USER CDUser;'
   PRINT @CMD   
   EXEC sp_executesql @CMD
   
   -- Add DEV\CMSUser_SIT
   SET @CMD = 'USE [' + @LocalDb + ']; CREATE USER [DEV\CMSUser_SIT] FOR LOGIN [DEV\CMSUser_SIT]; ALTER ROLE [db_owner] ADD MEMBER [DEV\CMSUser_SIT];'
   PRINT @CMD   
   EXEC sp_executesql @CMD
   
   -- Add WebDevRead
   SET @CMD = 'USE [' + @LocalDb + ']; CREATE USER [WebDevRead] FOR LOGIN [WebDevRead]; ALTER ROLE [db_datareader] ADD MEMBER [WebDevRead];'
   PRINT @CMD   
   EXEC sp_executesql @CMD
   
   PRINT ''
   FETCH NEXT FROM DBCSR INTO @ProdDb, @ProdFileName, @LocalDb
END


CLOSE DBCSR;

--*****************************************************************************
--
--  Step 3: Run environment specific SQL
--
--*****************************************************************************
SET @CMD = 'USE [' + @ENV + '_Sitecore_Core];                       ' +
           'UPDATE [aspnet_Membership]                              ' + 
           'SET    [Password]     =''qOvF8m8F2IcWMvfOBjJYHmfLABc='' ' + 
		   '     , [PasswordSalt] =''OM5gu45RQuJ76itRvkSPFw==''     ' + 
		   'WHERE UserId IN (SELECT UserId FROM   dbo.aspnet_Users WHERE UserName = ''sitecore\Admin'');'
PRINT @CMD
EXEC sp_executesql @CMD

SET @CMD = 'USE [' + @ENV + '_Sitecore_Master]; ' +
           'UPDATE VersionedFields ' +
           'SET    VALUE = ''T3Memberservices@hbf.com.au'' ' +
           'WHERE  VALUE LIKE ''%@hbf.com.au'' ' +
           'AND   (FieldId = ''{E126A5A2-14F5-4D10-B718-B172BB74E7E7}''  ' +  -- contact page     (ToEmailAddress)
           '    OR FieldId = ''{8C056B55-EF08-4E5A-9D2C-5961DCD72875}''  ' +  -- contact page     (FromEmailAddress)
           '    OR FieldId = ''{8530BA52-65BF-40BC-A58C-2A79E55F8400}''  ' +  -- contact settings (ContactUsEmailAddress)
           '    OR FieldId = ''{4790E9DA-92B2-4BD7-AAC6-53FF6BA19CE1}''  ' +  -- contact settings (ContactUsFromAddress)
           '    OR FieldId = ''{EEF3D6FF-1F5C-4549-9A9F-8909B7A5C0EC}''  ' +  -- blog             (BlogContactFormEmailAddress)
           '      ); '
PRINT @CMD   
EXEC sp_executesql @CMD

SET @CMD = 'USE [' + @ENV + '_Sitecore_Master]; ' +
           'UPDATE VersionedFields ' +
           'SET    VALUE = ''https://secure.cardaccess.com.au/ecom/casconnect/hbf_test/index_A.py'' ' +
           'WHERE  VALUE = ''https://secure.cardaccess.com.au/ecom/casconnect/hbf/index_A.py'' ' +
           'AND   (FieldId = ''{A64BA797-8C19-44DA-84F8-69E684FF672F}''  ' +  -- Environments Config (OnlinePaymentPostUrl)
           '    OR FieldId = ''{458A9565-6A8D-42ED-AD67-D6E9D15E698B}''  ' +  -- MyHBF config (Payment Gateway URL)
           '      ); '
PRINT @CMD   
EXEC sp_executesql @CMD

SET @CMD = 'USE [' + @ENV + '_Sitecore_Master];  ' +
           'UPDATE [dbo].[SharedFields]  ' +
           'SET    VALUE   = REPLACE(Value, ''gt;memberservices@hbf.com.au'', ''gt;' + @EmailPfx + 'memberservices@hbf.com.au'') ' +  -- Send email quote destination
           'WHERE  ItemId  = ''C037ACB5-F56D-4702-BAB8-7CC158497084''  ' +
           'AND    FieldId = ''A7F779B9-5FCF-45CC-866B-7C973F5C4FAC''  ' + 
           '; '                                                                                                                        
PRINT @CMD   
EXEC sp_executesql @CMD


--*****************************************************************************
--
--  Step 4: Backup target databases (not absolutely neccessary but nice to have)
--
--*****************************************************************************
OPEN DBCSR;
FETCH NEXT FROM DBCSR INTO @ProdDb, @ProdFileName, @LocalDb

WHILE @@FETCH_STATUS=0
BEGIN
   -- Setup the backup name and location
   SET @BackupName = @LocalDb + '_backup_' 
                   + REPLACE(REPLACE(REPLACE(REPLACE(CONVERT(varchar,SYSDATETIME(), 121),'-','_'),':',''),' ','_'),'.','_')
   SET @BackupDir = @DefaultBackupDir + '\' + @LocalDb
   SET @BackupFileFullPath = @BackupDir + '\' + @BackupName + '.bak'
	   
   EXECUTE master.dbo.xp_create_subdir @BackupDir
   
   -- Backup the database
   BACKUP DATABASE @LocalDb 
	       TO DISK = @BackupFileFullPath
		 WITH NOFORMAT, NOINIT, NAME = @BackupName, SKIP, REWIND, NOUNLOAD,  STATS = 10
   
   PRINT ''
   FETCH NEXT FROM DBCSR INTO @ProdDb, @ProdFileName, @LocalDb
END

CLOSE DBCSR;

--*****************************************************************************
--
--  Step 999: Tidy Up
--
--*****************************************************************************
DEALLOCATE DBCSR;
-- NB: no need to set database back to multi-user as the restore will sort this

PRINT ''
PRINT '*************************************************************************'
PRINT '*'
PRINT '*          ***  ADD DATABASES BACK TO AVAILABILITY GROUP ***  ' 
PRINT '*'
PRINT '*************************************************************************'
PRINT ''

END TRY

BEGIN CATCH
   THROW;
END CATCH