--
-- Show all connections
-- Includes details of wait types and blocking transactions
-- Includes SqlText
--

CREATE TABLE #sp_who2 (
	SPID        INT, 	      Status    VARCHAR(255),
	Login       VARCHAR(255), HostName  VARCHAR(255), 
	BlkBy       VARCHAR(255), DBName    VARCHAR(255), 
	Command     VARCHAR(255), CPUTime   INT, 
	DiskIO      INT,          LastBatch VARCHAR(255), 
	ProgramName VARCHAR(255), SPID2     INT, 
	REQUESTID   INT) 
      
INSERT INTO #sp_who2 EXEC sp_who2

select A.SPID, B.connect_time, A.LastBatch,
       A.Status, F.status, E.task_state,
       G.wait_type, H.wait_type, H.last_wait_type, A.BlkBy, 
       A.DBName, A.Login, A.HostName,
       B.num_reads, B.num_writes, A.CPUTime, A.DiskIO, 
       A.Command, B.text
from #sp_who2 A 
LEFT OUTER JOIN (
   SELECT * FROM sys.dm_exec_connections  
   CROSS APPLY sys.dm_exec_sql_text( most_recent_sql_handle ) B) B on B.session_id = A.SPID
LEFT OUTER JOIN sys.dm_os_tasks         E ON E.session_id = A.SPID
LEFT OUTER JOIN sys.dm_exec_sessions    F ON F.session_id = A.SPID
LEFT OUTER JOIN sys.dm_os_waiting_tasks G ON G.session_id = A.SPID
LEFT OUTER JOIN sys.dm_exec_requests    H ON H.session_id = A.SPID
WHERE    A.DBName not in ('master', 'msdb')   
ORDER BY A.DBName
;

DROP TABLE #sp_who2;