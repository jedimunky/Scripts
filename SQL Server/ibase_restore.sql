use master;

-- Check backup details		   
RESTORE FILELISTONLY   FROM DISK = 'C:\Temp\ibase_prod_backup_2019_12_18.bak';

-- restore the database from backup
RESTORE DATABASE [ibase_test] 
   FROM DISK = 'C:\Temp\ibase_prod_backup_2019_12_18.bak'
   WITH STATS=10
      , MOVE 'ibase_prod'      TO 'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\ibase_test.mdf'
      , MOVE 'ftrow_i2Catalog' TO 'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\ibase_test.ndf'
      , MOVE 'ibase_prod_log'  TO 'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\ibase_test_log.ldf'
	  --, REPLACE

-- rename logical files
ALTER DATABASE [ibase_test] MODIFY FILE (NAME=N'ibase_prod',      NEWNAME=N'ibase_test')
ALTER DATABASE [ibase_test] MODIFY FILE (NAME=N'ibase_prod_log',  NEWNAME=N'ibase_test_log')

