-- After Sql Server Installation
--    1) Enable DAG's - via configuration manager
--    2) Create mirroring endpoint 
--    3) Create availability group
--    4) Create listener

-- Check Endpoint Sql (run on both servers)
SELECT name, port FROM sys.tcp_endpoints;

SELECT  a.name, a.role_desc, a.state_desc, b.port 
FROM sys.database_mirroring_endpoints a
JOIN sys.tcp_endpoints                b ON a.name = b.name;

-- Create Endpoint Sql (run on both servers)
CREATE ENDPOINT ENDPOINT_MSSQLSERVER_AG
    STATE=STARTED
    AS TCP ( LISTENER_PORT = 4024 ) -- this must be different for each endpoint on the server, start with 4022
    FOR DATABASE_MIRRORING (ROLE = ALL);

CREATE LOGIN [NTDOMAIN\svc_sqldbengine] FROM WINDOWS;
GRANT CONNECT ON ENDPOINT::[ENDPOINT_MSSQLSERVER_AG] TO [NTDOMAIN\svc_sqldbengine];

-- Create Availability Group sql (run on primary)
CREATE AVAILABILITY GROUP MSSQLSERVER_AG 
   WITH ( AUTOMATED_BACKUP_PREFERENCE = PRIMARY )  -- backups will run on primary instance only
   FOR  
   REPLICA ON 
      'HPVSQL23' WITH 
         (
         ENDPOINT_URL = 'TCP://HPVSQL23.corp.hbf.com.au:4024', 
         AVAILABILITY_MODE = SYNCHRONOUS_COMMIT, 
         FAILOVER_MODE = AUTOMATIC
         ),
      'HPVSQL24' WITH 
         (
         ENDPOINT_URL = 'TCP://HPVSQL24.corp.hbf.com.au:4024',
         AVAILABILITY_MODE = SYNCHRONOUS_COMMIT,
         FAILOVER_MODE = AUTOMATIC
         );

-- Create Availability Group sql (run on standby)
ALTER AVAILABILITY GROUP MSSQLSERVER_AG JOIN;

-- Create listener (run on primary)
ALTER AVAILABILITY GROUP MSSQLSERVER_AG 
      ADD LISTENER 'HPVSQLDEFAULT2' ( 
	     WITH IP ( ('192.168.32.112','255.255.255.0')) , 
		      PORT = 1455 -- this doesn't need to change
		 ) 
;