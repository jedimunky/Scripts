use master;

-- If database is part of an availability group, remove it from the AG.
ALTER AVAILABILITY GROUP ITAM_DAG REMOVE DATABASE [DBATest];

-- Save login\user settings (usually only needed if refreshing lower environment)

--
-- If restoring in-place (ie. overwriting the existing database),
-- take a log backup with no recovery (to stop any further changes to the database)
-- 
ALTER DATABASE [DBATest] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

BACKUP LOG [DBATest] 
   TO  DISK = 'G:\SQLBackups\MSSQL11.ITAM\DBATest\DBATest_backup_2014_12_30_161000_0000000.trn'
   WITH NOFORMAT, NOINIT,  NAME = 'DBATest_backup_2014_12_30_1610000_0000000', 
        SKIP, REWIND, NOUNLOAD, STATS = 10, NORECOVERY
;

--
-- Check the backup file is ok
--
RESTORE HEADERONLY   FROM DISK = 'G:\SQLBackups\MSSQL11.ITAM\DBATest\DBATest_backup_2014_12_31_090038_0000801.bak';
RESTORE FILELISTONLY FROM DISK = 'G:\SQLBackups\MSSQL11.ITAM\DBATest\DBATest_backup_2014_12_31_090038_0000801.bak';

--
-- Restore the database from backup
--
RESTORE DATABASE [DBATest] 
   FROM DISK = 'G:\SQLBackups\MSSQL11.ITAM\DBATest\DBATest_backup_2014_12_31_090038_0000801.bak'
   WITH STATS=10
      --, MOVE 'DBATest'      TO 'G:\SQLData\MSSQL11.ITAM\DBATest.mdf'     -- MOVE statements needed if restoring to different location.
      --, MOVE 'DBATest_log'  TO 'G:\SQLLogs\MSSQL11.ITAM\DBATest.ldf'
	  , REPLACE                                                    -- REPLACE statement will overwrite existing database if it exists
--	  , FILE=2                                                     -- FILE statement needed if multiple backups on same backup file, default is FILE=1

--
-- Rename logical files (if neccessary, usually if restoring to different name)
--
ALTER DATABASE [DBATest] MODIFY FILE (NAME=N'DBATest'    , NEWNAME=N'DBATestNew')
ALTER DATABASE [DBATest] MODIFY FILE (NAME=N'DBATest_log', NEWNAME=N'DBATestNew_log')

-- Restore login\user settings (if needed)
-- And add it back to Availability group (if needed)