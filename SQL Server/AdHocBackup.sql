-- Generic adhoc backup script
-- 
--   NB: won't work for SQL2005, see note below.
--

USE master

DECLARE @DbName             varchar(500)  = 'SP13RLSE_MetaData';
DECLARE @BackupType         varchar(8)    = 'DATABASE';
--DECLARE @BackupType         varchar(8)    = 'LOG';     

-- Backup File Variables
DECLARE @BackupDir          varchar(500);
DECLARE @BackupName         varchar(500);
DECLARE @BackupExt          char(4);
DECLARE @BackupFileFullPath varchar(500);

-- Setup the backup path and name (use default backup path from the registry)
EXECUTE [master].dbo.xp_instance_regread 
   N'HKEY_LOCAL_MACHINE', 
   N'SOFTWARE\Microsoft\MSSQLServer\MSSQLServer', 
   N'BackupDirectory',
   @BackupDir output;
SET @BackupDir = @BackupDir + '\' + @DbName

IF @BackupType = 'DATABASE' SET @BackupExt = '.bak' ELSE SET @BackupExt = '.trn'

SET @BackupName = @DbName + '_backup_' + REPLACE(REPLACE(REPLACE(REPLACE(CONVERT(varchar,SYSDATETIME(), 121),'-','_'),':',''),' ','_'),'.','_')
SET @BackupFileFullPath = @BackupDir + '\' + @BackupName + @BackupExt

PRINT @DbName
PRINT @BackupDir
PRINT @BackupName
PRINT @BackupExt
PRINT @BackupFileFullPath

-- Create the directory (in case it don't exist)
EXECUTE master.dbo.xp_create_subdir @BackupDir

-- Backup the database   
IF @BackupType = 'DATABASE' 
   BACKUP DATABASE @DbName
      TO DISK=@BackupFileFullPath
      WITH NOFORMAT, INIT,  
           NAME = @BackupName,
           SKIP, NOREWIND, NOUNLOAD,  STATS = 5
ELSE
   BACKUP LOG @DbName
      TO DISK=@BackupFileFullPath
      WITH NOFORMAT, INIT,  
           NAME = @BackupName,
           SKIP, NOREWIND, NOUNLOAD,  STATS = 5
		   
-- Verify the backup		
RESTORE VERIFYONLY 
   FROM  DISK = @BackupFileFullPath 
   WITH  FILE = 1,  NOUNLOAD,  NOREWIND,  STATS = 5
  
--  
-- For Sql 2005 you can't set variables in the declare, it needs to be a seperate statement:
--    DECLARE @DbName             varchar(500);  SET @DbName     = 'SP13RLSE_MetaData';
--    DECLARE @BackupType         varchar(8)  ;  SET @BackupType = 'DATABASE';
--
-- Also for Sql 20005, SYSDATETIME is not available, you must use GETDATE
--    SET @BackupName = @DbName + '_backup_' + REPLACE(REPLACE(REPLACE(CONVERT(varchar,GETDATE(), 20),'-','_'),':',''),' ','_')
--