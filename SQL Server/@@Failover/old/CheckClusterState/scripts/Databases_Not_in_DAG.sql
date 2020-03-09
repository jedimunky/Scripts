SET NOCOUNT ON 
SET ANSI_WARNINGS OFF

DECLARE @CountDatabases INT = 0;

--select substring(@@SERVERNAME,1,30), substring(name,1,30) 
select @CountDatabases = count(*)
from sys.databases 
where replica_id is null 
and name not in ('master', 'model', 'msdb', 'tempdb')
and name not in ('hbf.ebs.prodcopy', 'BI.PROD_MyHBFLogs')
and state_desc <> 'OFFLINE'
;

IF @CountDatabases <> 0 RAISERROR ('Count not 0',11,11)