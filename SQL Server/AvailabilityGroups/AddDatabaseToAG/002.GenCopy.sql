--USE [master];
   
-- Backup variables
DECLARE @MainBackupDir      varchar(500);
DECLARE @BackupDir          varchar(500);

DECLARE @StandbyNode        varchar(500);

PRINT 'echo **************************************'
PRINT 'echo * COPY THE BACKUP FILES TO THE STANDBY '
PRINT 'echo **************************************'
PRINT 'echo.'

-- Setup the backup path and name (use default backup path from the registry)
EXECUTE [master].dbo.xp_instance_regread 
   N'HKEY_LOCAL_MACHINE', 
   N'SOFTWARE\Microsoft\MSSQLServer\MSSQLServer', 
   N'BackupDirectory',
   @MainBackupDir output;

SET @BackupDir = @MainBackupDir + '\AGInitialisation'

select @StandbyNode = 
   CASE WHEN replica_server_name LIKE '%\%' THEN SUBSTRING(ar.replica_server_name, 1, (CHARINDEX('\', ar.replica_server_name)-1))
                                            ELSE ar.replica_server_name
   END
from            sys.availability_replicas  ar
left outer join sys.dm_hadr_availability_replica_states ars on ar.replica_id = ars.replica_id
where ars.role_desc = 'SECONDARY'
;

PRINT CONCAT('COPY ', @BackupDir, '\*.bak ', '\\', @StandbyNode, '\', REPLACE(@BackupDir, ':', '$'))
PRINT CONCAT('COPY ', @BackupDir, '\*.trn ', '\\', @StandbyNode, '\', REPLACE(@BackupDir, ':', '$'))