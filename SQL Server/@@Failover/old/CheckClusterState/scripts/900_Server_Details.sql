SET NOCOUNT ON 

-- Variables
DECLARE @SqlServerStartTime datetime;     -- Time the Sql server last started

DECLARE @SqlServerAgentRunning char(10);  -- Is the agent running?
DECLARE @TmpDBTable TABLE (SqlServerAgentRunning char(10)) -- table to store agent stored proc results

DECLARE @VersionNumber char(13);  -- Sql Server version number
DECLARE @VersionText   char(18);  -- Sql Server version text
DECLARE @Level         char(3);   -- Sql Server level
DECLARE @UpdateLevel   char(4);   -- Sql Server level
DECLARE @Edition       char(30);  -- Sql Server edition

DECLARE @CMD            NVARCHAR(2000); -- Commands to run
DECLARE @PARMS          NVARCHAR(500);  -- Parameters for commands 

-- Get agent status (nb: xp_servicecontrol is undocumentad and unsupported (master.dbo.sysprocesses is an alternative))
INSERT INTO @TmpDBTable
   EXEC master.dbo.xp_servicecontrol 'QUERYSTATE', 'SQLServerAgent'
;

SELECT @SqlServerAgentRunning = SqlServerAgentRunning FROM @TmpDBTable;

-- Get version details
SET @VersionNumber = CONVERT(char,SERVERPROPERTY('ProductVersion'));

SET @VersionText =
   CASE
      WHEN @VersionNumber LIKE '13.0%'  THEN 'Sql Server 2016' 
      WHEN @VersionNumber LIKE '12.0%'  THEN 'Sql Server 2014' 
      WHEN @VersionNumber LIKE '11.0%'  THEN 'Sql Server 2012' 
      WHEN @VersionNumber LIKE '10.50%' THEN 'Sql Server 2008 R2'
      WHEN @VersionNumber LIKE '10.0%'  THEN 'Sql Server 2008'
      WHEN @VersionNumber LIKE '9.0%'   THEN 'Sql Server 2005'
      WHEN @VersionNumber LIKE '8.0%'   THEN 'Sql Server 2000'
      WHEN @VersionNumber LIKE '7.0%'   THEN 'Sql Server 7'
      WHEN @VersionNumber LIKE '6.50%'  THEN 'Sql Server 6.5'
      ELSE 'Unknown Version'
END

SET @Level       = CONVERT(char,SERVERPROPERTY('ProductLevel'))
SET @UpdateLevel = COALESCE(CONVERT(char,SERVERPROPERTY('ProductUpdateLevel')),'')
SET @Edition     = CONVERT(char,SERVERPROPERTY('Edition'))

-- Get server start time (use tempdb for 2005 and lower, sqlserver_start_time for 2008 and higher)
IF CAST(SUBSTRING(@VersionNumber,1,2) as FLOAT) < 10
   set @CMD = 'select @SqlServerStartTime = create_date from sys.databases where name = ''tempdb'''
ELSE 	
   set @CMD = 'select @SqlServerStartTime = sqlserver_start_time from sys.dm_os_sys_info'
SET @PARMS = N'@SqlServerStartTime datetime OUTPUT'  
EXEC sp_executesql @CMD, @PARMS, @SqlServerStartTime = @SqlServerStartTime OUTPUT
   
-- Get server details and add the other bits we've already got
SELECT 
   CONVERT(char(30),'$(varConnectString)'),
   substring(name,1,30) AS SqlServer, 
   CONVERT(char(15),ServerProperty('ComputerNamePhysicalNetBIOS')) AS Server, 
   @SqlServerStartTime as StartTime, @SqlServerAgentRunning AS Agent, 
   @VersionText, @Level + ' ' + @UpdateLevel, @VersionNumber, @Edition
from master.sys.servers
where server_id = 0
;