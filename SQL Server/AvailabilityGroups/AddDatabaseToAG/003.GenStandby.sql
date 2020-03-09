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

PRINT '--***********************************'
PRINT '-- RUN THESE COMMANDS ON THE STANDBY '
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

-- Set the database backup directory
SET @BackupDir = @MainBackupDir + '\AGInitialisation'   
   
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
   
   PRINT '--Database: ' + SUBSTRING(@DBNAME,1,20) 

   -- Restore the full database backup 
   SET @BackupName = @DbName + '_backup_' + CONVERT(varchar,GETDATE(), 112) + '_AGFULL'
   SET @BackupFileFullPath = @BackupDir + '\' + @BackupName + '.bak'
   PRINT 'RESTORE DATABASE [' + @DBNAME + '] FROM DISK=''' + @BackupFileFullPath + 
            ''' WITH NORECOVERY, STATS = 10;'
 
   -- Restore the transaction log backup 
   SET @BackupName = @DbName + '_backup_' + CONVERT(varchar,GETDATE(), 112)  + '_AGTRAN'
   SET @BackupFileFullPath = @BackupDir + '\' + @BackupName + '.trn'
   PRINT 'RESTORE LOG [' + @DBNAME + '] FROM DISK=''' + @BackupFileFullPath + 
         ''' WITH NORECOVERY, STATS = 10;'
   
   -- Now add the database to the DAG
   PRINT 'ALTER DATABASE [' + @DBNAME + '] SET HADR AVAILABILITY GROUP = ' + @DAGName + ';'
   
   -- Get next database record
   FETCH NEXT FROM DBCSR INTO @DBNAME, @RECOVERYMODEL;
   PRINT ''
END

-- Close the database cursor
CLOSE DBCSR;

DEALLOCATE DBCSR;