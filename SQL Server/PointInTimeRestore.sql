--
-- Recover database to point in time
-- In short, restore database with NORECOVERY, then restore logs with NORECOVERY and STOPAT, then restore database with RECOVERY.
--

use [master];

-- Take tran log backup with NORECOVERY (puts db into restoring state, requires there to be no connections to the db)
ALTER DATABASE [DBATest] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
BACKUP LOG [DBATest] 
   TO  DISK = 'T:\SiteCoreCMS_Backups\SQLBackups\DBATest\DBATest_backup_2014_09_02_144600_0000000.trn'
   WITH NOFORMAT, NOINIT,  NAME = 'DBATest_backup_2014_09_02_144600_0000000', 
        SKIP, REWIND, NOUNLOAD, STATS = 10, NORECOVERY

-- Restore the full database backup, NORECOVERY
RESTORE DATABASE [DBATest] 
   FROM DISK = 'T:\SiteCoreCMS_Backups\SQLBackups\DBATest\DBATest_backup_2014_09_02_144312_1009506.bak'
   WITH NORECOVERY, STATS=10

-- Restore tran log backups, NORECOVERY, STOPAT (run as many times as needed, depending on number of tran log backups)
RESTORE LOG [DBATest] 
   FROM DISK = 'T:\SiteCoreCMS_Backups\SQLBackups\DBATest\DBATest_backup_2014_09_02_144404_7599814.trn'
   WITH NORECOVERY, STOPAT = '2014-09-02 14:45:00', STATS=10

RESTORE LOG [DBATest] 
   FROM DISK = 'T:\SiteCoreCMS_Backups\SQLBackups\DBATest\DBATest_backup_2014_09_02_144507_1113129.trn'
   WITH NORECOVERY, STOPAT = '2014-09-02 14:45:00', STATS=10

RESTORE LOG [DBATest] 
   FROM DISK = 'T:\SiteCoreCMS_Backups\SQLBackups\DBATest\DBATest_backup_2014_09_02_010000_0000000.trn'
   WITH NORECOVERY, STOPAT = '2014-09-02 14:45:00', STATS=10

-- Take it out of restoring state
RESTORE DATABASE [DBATest]  WITH RECOVERY;   