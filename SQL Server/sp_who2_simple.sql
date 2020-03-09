CREATE TABLE #sp_who2 (
	SPID        INT, 	      Status    VARCHAR(255),
	Login       VARCHAR(255), HostName  VARCHAR(255), 
	BlkBy       VARCHAR(255), DBName    VARCHAR(255), 
	Command     VARCHAR(255), CPUTime   INT, 
	DiskIO      INT,          LastBatch VARCHAR(255), 
	ProgramName VARCHAR(255), SPID2     INT, 
	REQUESTID   INT);	
      
INSERT INTO #sp_who2 EXEC sp_who2;

SELECT *
--SELECT distinct CONVERT(char(15),ServerProperty('ComputerNamePhysicalNetBIOS')) AS Server, HostName
FROM #sp_who2
WHERE DBName not in ('master', 'msdb')   
ORDER BY DBName, HostName;

--SELECT login, HostName, DBName, count(*) as NumConns
--FROM #sp_who2
--WHERE DBName not in ('master', 'msdb')   
--GROUP BY login, HostName, DBName 
--ORDER BY DBName, HostName;

DROP TABLE #sp_who2;