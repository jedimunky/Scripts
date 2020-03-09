--use [master];

SET NOCOUNT ON 
SET ANSI_WARNINGS OFF

DECLARE @AGHealth CHAR(10)     = null;
DECLARE @AGErrors VARCHAR(100) = null;

DECLARE @AGId   CHAR(36)
DECLARE @AGName NVARCHAR(128);

DECLARE @primary_replica           NVARCHAR(128);  
DECLARE @primary_recovery_health   TINYINT; 
DECLARE @secondary_recovery_health TINYINT;
DECLARE @synchronization_health    TINYINT;

DECLARE @NodeRole      CHAR(10);
DECLARE @NodeReplicaId CHAR(36);

DECLARE @Count  INT;

DECLARE csrAG CURSOR STATIC READ_ONLY FOR
   SELECT [group_id], [name]
   FROM   [sys].[availability_groups]
;



OPEN csrAG

FETCH NEXT FROM csrAG INTO @AGId, @AGName;
WHILE @@FETCH_STATUS=0
BEGIN

   SET @AGHealth = null;
   SET @AGErrors = null;

   -- Get the replica id for this server
   SELECT @NodeReplicaId = [replica_id]
   FROM [sys].[availability_replicas]
   WHERE [group_id]            = @AGId
   AND   [replica_server_name] = @@SERVERNAME
   ;

   --
   --  Availability group state
   --
   select @primary_replica           = primary_replica
        , @primary_recovery_health   = primary_recovery_health
        , @secondary_recovery_health = secondary_recovery_health
	    , @synchronization_health    = synchronization_health
   from sys.dm_hadr_availability_group_states
   where group_id = @AGId
   ;
   
   IF @@ROWCOUNT <> 1 SET @AGErrors = CONCAT(@AGErrors, 'more than 1 row in dm_hadr_availability_group_states;  ')

   IF @primary_replica = @@SERVERNAME SET @NodeRole = 'PRIMARY'
                                ELSE  SET @NodeRole = 'SECONDARY'

   IF @NodeRole = 'PRIMARY' BEGIN
      IF @primary_recovery_health   <> 1 SET @AGErrors = CONCAT(@AGErrors, 'primary_recovery_health is not online;  ')
	  IF @synchronization_health    <> 2 SET @AGErrors = CONCAT(@AGErrors, 'synchronization_health is not healthy;  ')
   END ELSE BEGIN
      IF @secondary_recovery_health <> 1 SET @AGErrors = CONCAT(@AGErrors, 'secondary_recovery_health is not online;  ')
   END

   --
   --  Replica state
   --
   select @Count = count(*)
   from sys.dm_hadr_availability_replica_states
   where group_id   = @AGId
   and   replica_id = @NodeReplicaId
   and   (operational_state_desc <> 'ONLINE' OR connected_state_desc <> 'CONNECTED' OR recovery_health_desc <> 'ONLINE' OR synchronization_health_desc <> 'HEALTHY')
   ;

   IF @Count <> 0 SET @AGErrors = CONCAT(@AGErrors, 'replica unhealthy;  ')

   --
   --  Database state
   --
   select @Count = count(*)
   from sys.dm_hadr_database_replica_states a
   where group_id = @AGId
   and replica_id = @NodeReplicaId
   and (synchronization_state_desc  <> 'SYNCHRONIZED'
   or   synchronization_health_desc <> 'HEALTHY'
   or   database_state_desc         <> 'ONLINE' -- or null, but null will not be picked up
   or   last_sent_time     < DATEADD(dd,-1,getdate())
   or   last_received_time < DATEADD(dd,-1,getdate())
   or   last_hardened_time < DATEADD(dd,-1,getdate()))
   ;

   IF @Count <> 0 SET @AGErrors = CONCAT(@AGErrors, 'database unhealthy;  ');

   IF @AGErrors is not null RAISERROR ('AG Errors',11,11)

   FETCH NEXT FROM csrAG INTO @AGId, @AGName;
END

CLOSE csrAG
DEALLOCATE csrAG
