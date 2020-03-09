--------------------------------------------------------------------------------
--Part 2
--Run this script to manually stop a SQL Server Side Script Trace
--------------------------------------------------------------------------------
DECLARE @TraceID int

--Enter the TraceID
SET @TraceID = 2


--Stop the trace
EXEC sp_trace_setstatus @TraceID, 0

-- Close the trace and delete its definition from the server.
WAITFOR DELAY '00:00:05'
EXEC sp_trace_setstatus @TraceID, 2
