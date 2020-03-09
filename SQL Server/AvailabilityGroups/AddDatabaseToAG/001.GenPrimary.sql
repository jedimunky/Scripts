--USE [master];
   
-- DBCSR variables
DECLARE @DBNAME         SYSNAME;       -- Database name
DECLARE @RECOVERYMODEL  NVARCHAR(60);  -- Recovery model description

-- Backup variables
DECLARE @MainBackupDir      varchar(500)
DECLARE @BackupDir          varchar(500)
DECLARE @BackupName         varchar(500)
DECLARE @BackupFileFullPath varchar(500)

-- Names
DECLARE @SqlInstance varchar(50) = CONVERT(varchar(50),SERVERPROPERTY ('InstanceName'))
IF @SqlInstance IS NULL SET @SqlInstance = 'MSSQLSERVER'
DECLARE @DAGName     varchar(50) = @SqlInstance + '_AG'

-- Print Header
PRINT '--***********************************'
PRINT '-- RUN THESE COMMANDS ON THE PRIMARY '
PRINT '--***********************************'
PRINT ''
PRINT 'USE [master];'
PRINT ''

-- Setup the backup path and name (use default backup path from the registry)
EXECUTE [master].dbo.xp_instance_regread 
   N'HKEY_LOCAL_MACHINE', 
   N'SOFTWARE\Microsoft\MSSQLServer\MSSQLServer', 
   N'BackupDirectory',
   @MainBackupDir output;

-- Create database backup directory  (if it's not there already)
SET @BackupDir = @MainBackupDir + '\AGInitialisation'
PRINT 'EXECUTE master.dbo.xp_create_subdir ''' + @BackupDir + ''''
PRINT ''
   
DECLARE DBCSR CURSOR FOR
   select name, recovery_model_desc
   from sys.databases 
   where replica_id is null 
   and name not in ('master', 'model', 'msdb', 'tempdb')
   and state_desc = 'ONLINE'
   order by name
;

OPEN DBCSR;

-- Loop through database cursor
FETCH NEXT FROM DBCSR INTO @DBNAME, @RECOVERYMODEL;

WHILE @@FETCH_STATUS=0
BEGIN
   
   PRINT '--Database: ' + SUBSTRING(@DBNAME,1,20) + ' Recovery Model: ' + @RECOVERYMODEL

   -- Set the recovery model to FULL (if it's not already) - then requires full backup before you can add it to the AG.
   IF @RECOVERYMODEL <> 'FULL' BEGIN 
      PRINT 'ALTER DATABASE [' + @DBNAME + '] SET RECOVERY FULL WITH NO_WAIT;'
	  
	  SET @BackupName = @DbName + '_backup_' + CONVERT(varchar,GETDATE(), 112)  + '_AGFULLX'
      SET @BackupFileFullPath = @BackupDir + '\' + @BackupName + '.bak'
      PRINT 'BACKUP DATABASE [' + @DBNAME + '] TO DISK=''' + @BackupFileFullPath + 
      ''' WITH NOFORMAT, INIT, NAME = ''' + @BackupName + ''', SKIP, NOREWIND, NOUNLOAD, STATS = 10;'
   END

   -- Add the database to the DAG
   PRINT 'ALTER AVAILABILITY GROUP ' + @DAGName + ' ADD DATABASE [' + @DBNAME + '];'

   -- Do a full database backup 
   SET @BackupName = @DbName + '_backup_' + CONVERT(varchar,GETDATE(), 112)  + '_AGFULL'
   SET @BackupFileFullPath = @BackupDir + '\' + @BackupName + '.bak'
   PRINT 'BACKUP DATABASE [' + @DBNAME + '] TO DISK=''' + @BackupFileFullPath + 
            ''' WITH NOFORMAT, INIT, NAME = ''' + @BackupName + ''', SKIP, NOREWIND, NOUNLOAD, STATS = 10;'
   
   -- Do a transaction log backup 
   SET @BackupName = @DbName + '_backup_' + CONVERT(varchar,GETDATE(), 112)  + '_AGTRAN'
   SET @BackupFileFullPath = @BackupDir + '\' + @BackupName + '.trn'
   PRINT 'BACKUP LOG [' + @DBNAME + '] TO DISK=''' + @BackupFileFullPath + 
            ''' WITH NOFORMAT, INIT, NAME = ''' + @BackupName + ''', SKIP, NOREWIND, NOUNLOAD, STATS = 10;'
   
   -- Get next database record
   FETCH NEXT FROM DBCSR INTO @DBNAME, @RECOVERYMODEL;
   PRINT ''
END

-- Close the database cursor
CLOSE DBCSR;

DEALLOCATE DBCSR;