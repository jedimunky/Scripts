--------------------------------------------------------------------------------
--Part 1

--Investigating General issues

--This is a manual stop SQL Server Side Script Trace
--Run this script to generate the trace and part 2 to stop it 
--https://msdn.microsoft.com/en-us/library/ms186265.aspx
--------------------------------------------------------------------------------

DECLARE @rc int
DECLARE @TraceID int
DECLARE @maxfilesize bigint
DECLARE @Rollover int
DECLARE @filecount int
DECLARE @tracename nvarchar(150)
DECLARE @directoryPath nvarchar(75)
DECLARE @tracefilename nvarchar(75)

----------------------------------------------------------------------------------
--set up the parameters
----------------------------------------------------------------------------------

--Do not add the file extentions to Trace1. 
--I.e. Do not use GeneralIssueTrace.trc but GeneralIssueTrace for the trace name
set @tracename = N'any_name'
set @maxfilesize = 100 
set @Rollover = 2 -- Option value 2 = TRACE_FILE_ROLLOVER, 4 = SHUTDOWN_ON_ERROR , 8 = TRACE_PRODUCE_BLACKBOX
--to turn on both the options TRACE_FILE_ROLLOVER and SHUTDOWN_ON_ERROR,  specify 6 for option_value
set @filecount = 50 -- max_rollover_files
set @directoryPath = 'G:\TempBackups\Kapow_Trace'
set @tracefilename = 'Kapow_Trace' --Do not add the file extention to the trace name


----------------------------------------------------------------------------------
--Check parameters
---------------------------------------------------------------------------------
IF RIGHT(@directoryPath,1) = '\'
     set @tracename = @directoryPath + @tracefilename
else
     set @tracename = @directoryPath + '\' + @tracefilename

 
--Add DateTime stamp to trace file
set @tracename = @tracename + '-'+ replace(convert(varchar, getdate(),106),' ','') + '-' + replace(convert(varchar, getdate(),108),':','') 


----------------------------------------------------------------------------------
--start the profiler
----------------------------------------------------------------------------------

exec @rc = sp_trace_create @TraceID output, @rollover, @tracename, @maxfilesize, NULL, @filecount
if (@rc != 0) goto error


declare @on bit
set @on = 1

--------------------------------------------------------------------------
--Start
--Events and columns of the profiler trace
--sp_trace_setevent @traceid ,@eventid ,@columnid,@on
--------------------------------------------------------------------------

--RPC:Completed
EXEC sp_trace_setevent @TraceID, 10, 1, @on  -- TextData
EXEC sp_trace_setevent @TraceID, 10, 6, @on  -- NTUserName
EXEC sp_trace_setevent @TraceID, 10, 8, @on  -- HostName
EXEC sp_trace_setevent @TraceID, 10, 9, @on  -- ClientProcessID
EXEC sp_trace_setevent @TraceID, 10, 10, @on -- ApplicationName
EXEC sp_trace_setevent @TraceID, 10, 11, @on -- LoginName
EXEC sp_trace_setevent @TraceID, 10, 12, @on -- SPID
EXEC sp_trace_setevent @TraceID, 10, 13, @on -- Duration
EXEC sp_trace_setevent @TraceID, 10, 14, @on -- StartTime
EXEC sp_trace_setevent @TraceID, 10, 15, @on -- EndTime
EXEC sp_trace_setevent @TraceID, 10, 18, @on -- CPU
EXEC sp_trace_setevent @TraceID, 10, 26, @on -- ServerName (Name of the instance of SQL Server)
EXEC sp_trace_setevent @TraceID, 10, 27, @on -- EventClass
EXEC sp_trace_setevent @TraceID, 10, 28, @on -- ObjectType
EXEC sp_trace_setevent @TraceID, 10, 31, @on -- Error
EXEC sp_trace_setevent @TraceID, 10, 32, @on -- Mode (Lock mode of the lock acquired)
EXEC sp_trace_setevent @TraceID, 10, 33, @on -- Handle
EXEC sp_trace_setevent @TraceID, 10, 34, @on -- ObjectName
EXEC sp_trace_setevent @TraceID, 10, 35, @on -- DatabaseName
EXEC sp_trace_setevent @TraceID, 10, 48, @on -- RowCounts
EXEC sp_trace_setevent @TraceID, 10, 51, @on -- EventSequence

--RPC:Starting
EXEC sp_trace_setevent @TraceID, 11, 1, @on
EXEC sp_trace_setevent @TraceID, 11, 6, @on
EXEC sp_trace_setevent @TraceID, 11, 8, @on
EXEC sp_trace_setevent @TraceID, 11, 9, @on  
EXEC sp_trace_setevent @TraceID, 11, 10, @on  
EXEC sp_trace_setevent @TraceID, 11, 11, @on  
EXEC sp_trace_setevent @TraceID, 11, 12, @on  
EXEC sp_trace_setevent @TraceID, 11, 13, @on  
EXEC sp_trace_setevent @TraceID, 11, 14, @on  
EXEC sp_trace_setevent @TraceID, 11, 15, @on  
EXEC sp_trace_setevent @TraceID, 11, 18, @on  
EXEC sp_trace_setevent @TraceID, 11, 26, @on 
EXEC sp_trace_setevent @TraceID, 11, 27, @on
EXEC sp_trace_setevent @TraceID, 11, 28, @on
EXEC sp_trace_setevent @TraceID, 11, 32, @on 
EXEC sp_trace_setevent @TraceID, 11, 34, @on
EXEC sp_trace_setevent @TraceID, 11, 33, @on
EXEC sp_trace_setevent @TraceID, 11, 35, @on
EXEC sp_trace_setevent @TraceID, 11, 48, @on
EXEC sp_trace_setevent @TraceID, 11, 51, @on

--SQL:BatchCompleted event
EXEC sp_trace_setevent @TraceID, 12, 1, @on   
EXEC sp_trace_setevent @TraceID, 12, 6, @on   
EXEC sp_trace_setevent @TraceID, 12, 8, @on
EXEC sp_trace_setevent @TraceID, 12, 9, @on  
EXEC sp_trace_setevent @TraceID, 12, 10, @on  
EXEC sp_trace_setevent @TraceID, 12, 11, @on  
EXEC sp_trace_setevent @TraceID, 12, 12, @on  
EXEC sp_trace_setevent @TraceID, 12, 13, @on  
EXEC sp_trace_setevent @TraceID, 12, 14, @on  
EXEC sp_trace_setevent @TraceID, 12, 15, @on  
EXEC sp_trace_setevent @TraceID, 12, 18, @on  
EXEC sp_trace_setevent @TraceID, 12, 26, @on  
EXEC sp_trace_setevent @TraceID, 12, 27, @on  
EXEC sp_trace_setevent @TraceID, 12, 28, @on  
EXEC sp_trace_setevent @TraceID, 12, 31, @on  
EXEC sp_trace_setevent @TraceID, 12, 32, @on 
EXEC sp_trace_setevent @TraceID, 12, 33, @on 
EXEC sp_trace_setevent @TraceID, 12, 34, @on  
EXEC sp_trace_setevent @TraceID, 12, 35, @on  
EXEC sp_trace_setevent @TraceID, 12, 48, @on 
EXEC sp_trace_setevent @TraceID, 12, 51, @on  

--SQL:BatchStarting event
EXEC sp_trace_setevent @TraceID, 13, 1, @on
EXEC sp_trace_setevent @TraceID, 13, 6, @on  
EXEC sp_trace_setevent @TraceID, 13, 8, @on
EXEC sp_trace_setevent @TraceID, 13, 9, @on
EXEC sp_trace_setevent @TraceID, 13, 10, @on  
EXEC sp_trace_setevent @TraceID, 13, 11, @on  
EXEC sp_trace_setevent @TraceID, 13, 12, @on  
EXEC sp_trace_setevent @TraceID, 13, 13, @on  
EXEC sp_trace_setevent @TraceID, 13, 14, @on  
EXEC sp_trace_setevent @TraceID, 13, 15, @on  
EXEC sp_trace_setevent @TraceID, 13, 18, @on  
EXEC sp_trace_setevent @TraceID, 13, 26, @on 
EXEC sp_trace_setevent @TraceID, 13, 27, @on
EXEC sp_trace_setevent @TraceID, 13, 28, @on
EXEC sp_trace_setevent @TraceID, 13, 32, @on 
EXEC sp_trace_setevent @TraceID, 13, 33, @on
EXEC sp_trace_setevent @TraceID, 13, 34, @on
EXEC sp_trace_setevent @TraceID, 13, 35, @on
EXEC sp_trace_setevent @TraceID, 13, 48, @on
EXEC sp_trace_setevent @TraceID, 13, 51, @on


----Lock:Released event 
--EXEC sp_trace_setevent @TraceID, 23, 1, @on
--EXEC sp_trace_setevent @TraceID, 23, 6, @on  
--EXEC sp_trace_setevent @TraceID, 23, 8, @on
--EXEC sp_trace_setevent @TraceID, 23, 9, @on
--EXEC sp_trace_setevent @TraceID, 23, 10, @on  
--EXEC sp_trace_setevent @TraceID, 23, 11, @on  
--EXEC sp_trace_setevent @TraceID, 23, 12, @on  
--EXEC sp_trace_setevent @TraceID, 23, 13, @on  
--EXEC sp_trace_setevent @TraceID, 23, 14, @on  
--EXEC sp_trace_setevent @TraceID, 23, 15, @on  
--EXEC sp_trace_setevent @TraceID, 23, 18, @on  
--EXEC sp_trace_setevent @TraceID, 23, 26, @on 
--EXEC sp_trace_setevent @TraceID, 23, 27, @on
--EXEC sp_trace_setevent @TraceID, 23, 28, @on
--EXEC sp_trace_setevent @TraceID, 23, 32, @on 
--EXEC sp_trace_setevent @TraceID, 23, 33, @on
--EXEC sp_trace_setevent @TraceID, 23, 34, @on
--EXEC sp_trace_setevent @TraceID, 23, 35, @on
--EXEC sp_trace_setevent @TraceID, 23, 48, @on
--EXEC sp_trace_setevent @TraceID, 23, 51, @on


----Lock:Acquired event 
--EXEC sp_trace_setevent @TraceID, 24, 1, @on
--EXEC sp_trace_setevent @TraceID, 24, 6, @on  
--EXEC sp_trace_setevent @TraceID, 24, 8, @on
--EXEC sp_trace_setevent @TraceID, 24, 9, @on
--EXEC sp_trace_setevent @TraceID, 24, 10, @on  
--EXEC sp_trace_setevent @TraceID, 24, 11, @on  
--EXEC sp_trace_setevent @TraceID, 24, 12, @on  
--EXEC sp_trace_setevent @TraceID, 24, 13, @on  
--EXEC sp_trace_setevent @TraceID, 24, 14, @on  
--EXEC sp_trace_setevent @TraceID, 24, 15, @on  
--EXEC sp_trace_setevent @TraceID, 24, 18, @on  
--EXEC sp_trace_setevent @TraceID, 24, 26, @on 
--EXEC sp_trace_setevent @TraceID, 24, 27, @on
--EXEC sp_trace_setevent @TraceID, 24, 28, @on
--EXEC sp_trace_setevent @TraceID, 24, 32, @on 
--EXEC sp_trace_setevent @TraceID, 24, 33, @on
--EXEC sp_trace_setevent @TraceID, 24, 34, @on
--EXEC sp_trace_setevent @TraceID, 24, 35, @on
--EXEC sp_trace_setevent @TraceID, 24, 48, @on
--EXEC sp_trace_setevent @TraceID, 24, 51, @on

--Lock:Deadlock event 
EXEC sp_trace_setevent @TraceID, 25, 1, @on
EXEC sp_trace_setevent @TraceID, 25, 6, @on  
EXEC sp_trace_setevent @TraceID, 25, 8, @on
EXEC sp_trace_setevent @TraceID, 25, 9, @on
EXEC sp_trace_setevent @TraceID, 25, 10, @on  
EXEC sp_trace_setevent @TraceID, 25, 11, @on  
EXEC sp_trace_setevent @TraceID, 25, 12, @on  
EXEC sp_trace_setevent @TraceID, 25, 13, @on  
EXEC sp_trace_setevent @TraceID, 25, 14, @on  
EXEC sp_trace_setevent @TraceID, 25, 15, @on  
EXEC sp_trace_setevent @TraceID, 25, 18, @on  
EXEC sp_trace_setevent @TraceID, 25, 26, @on 
EXEC sp_trace_setevent @TraceID, 25, 27, @on
EXEC sp_trace_setevent @TraceID, 25, 28, @on
EXEC sp_trace_setevent @TraceID, 25, 32, @on 
EXEC sp_trace_setevent @TraceID, 25, 33, @on
EXEC sp_trace_setevent @TraceID, 25, 34, @on
EXEC sp_trace_setevent @TraceID, 25, 35, @on
EXEC sp_trace_setevent @TraceID, 25, 48, @on
EXEC sp_trace_setevent @TraceID, 25, 51, @on

--Lock:Cancel event 
EXEC sp_trace_setevent @TraceID, 26, 1, @on
EXEC sp_trace_setevent @TraceID, 26, 6, @on  
EXEC sp_trace_setevent @TraceID, 26, 8, @on
EXEC sp_trace_setevent @TraceID, 26, 9, @on
EXEC sp_trace_setevent @TraceID, 26, 10, @on  
EXEC sp_trace_setevent @TraceID, 26, 11, @on  
EXEC sp_trace_setevent @TraceID, 26, 12, @on  
EXEC sp_trace_setevent @TraceID, 26, 13, @on  
EXEC sp_trace_setevent @TraceID, 26, 14, @on  
EXEC sp_trace_setevent @TraceID, 26, 15, @on  
EXEC sp_trace_setevent @TraceID, 26, 18, @on  
EXEC sp_trace_setevent @TraceID, 26, 26, @on 
EXEC sp_trace_setevent @TraceID, 26, 27, @on
EXEC sp_trace_setevent @TraceID, 26, 28, @on
EXEC sp_trace_setevent @TraceID, 26, 32, @on 
EXEC sp_trace_setevent @TraceID, 26, 33, @on
EXEC sp_trace_setevent @TraceID, 26, 34, @on
EXEC sp_trace_setevent @TraceID, 26, 35, @on
EXEC sp_trace_setevent @TraceID, 26, 48, @on
EXEC sp_trace_setevent @TraceID, 26, 51, @on

--Lock:Timeout event 
EXEC sp_trace_setevent @TraceID, 27, 1, @on
EXEC sp_trace_setevent @TraceID, 27, 6, @on  
EXEC sp_trace_setevent @TraceID, 27, 8, @on
EXEC sp_trace_setevent @TraceID, 27, 9, @on
EXEC sp_trace_setevent @TraceID, 27, 10, @on  
EXEC sp_trace_setevent @TraceID, 27, 11, @on  
EXEC sp_trace_setevent @TraceID, 27, 12, @on  
EXEC sp_trace_setevent @TraceID, 27, 13, @on  
EXEC sp_trace_setevent @TraceID, 27, 14, @on  
EXEC sp_trace_setevent @TraceID, 27, 15, @on  
EXEC sp_trace_setevent @TraceID, 27, 18, @on  
EXEC sp_trace_setevent @TraceID, 27, 26, @on 
EXEC sp_trace_setevent @TraceID, 27, 27, @on
EXEC sp_trace_setevent @TraceID, 27, 28, @on
EXEC sp_trace_setevent @TraceID, 27, 32, @on
EXEC sp_trace_setevent @TraceID, 27, 33, @on 
EXEC sp_trace_setevent @TraceID, 27, 34, @on
EXEC sp_trace_setevent @TraceID, 27, 35, @on
EXEC sp_trace_setevent @TraceID, 27, 48, @on
EXEC sp_trace_setevent @TraceID, 27, 51, @on

--Exception event 
EXEC sp_trace_setevent @TraceID, 33, 1, @on
EXEC sp_trace_setevent @TraceID, 33, 6, @on  
EXEC sp_trace_setevent @TraceID, 33, 8, @on
EXEC sp_trace_setevent @TraceID, 33, 9, @on
EXEC sp_trace_setevent @TraceID, 33, 10, @on  
EXEC sp_trace_setevent @TraceID, 33, 11, @on  
EXEC sp_trace_setevent @TraceID, 33, 12, @on  
EXEC sp_trace_setevent @TraceID, 33, 13, @on  
EXEC sp_trace_setevent @TraceID, 33, 14, @on  
EXEC sp_trace_setevent @TraceID, 33, 15, @on  
EXEC sp_trace_setevent @TraceID, 33, 18, @on  
EXEC sp_trace_setevent @TraceID, 33, 26, @on 
EXEC sp_trace_setevent @TraceID, 33, 27, @on
EXEC sp_trace_setevent @TraceID, 33, 28, @on
EXEC sp_trace_setevent @TraceID, 33, 32, @on 
EXEC sp_trace_setevent @TraceID, 33, 33, @on
EXEC sp_trace_setevent @TraceID, 33, 34, @on
EXEC sp_trace_setevent @TraceID, 33, 35, @on
EXEC sp_trace_setevent @TraceID, 33, 48, @on
EXEC sp_trace_setevent @TraceID, 33, 51, @on


--SQL:StmtStarting event
EXEC sp_trace_setevent @TraceID, 40, 1, @on
EXEC sp_trace_setevent @TraceID, 40, 6, @on  
EXEC sp_trace_setevent @TraceID, 40, 8, @on
EXEC sp_trace_setevent @TraceID, 40, 9, @on
EXEC sp_trace_setevent @TraceID, 40, 10, @on  
EXEC sp_trace_setevent @TraceID, 40, 11, @on  
EXEC sp_trace_setevent @TraceID, 40, 12, @on  
EXEC sp_trace_setevent @TraceID, 40, 13, @on  
EXEC sp_trace_setevent @TraceID, 40, 14, @on  
EXEC sp_trace_setevent @TraceID, 40, 15, @on  
EXEC sp_trace_setevent @TraceID, 40, 18, @on  
EXEC sp_trace_setevent @TraceID, 40, 26, @on 
EXEC sp_trace_setevent @TraceID, 40, 27, @on
EXEC sp_trace_setevent @TraceID, 40, 28, @on
EXEC sp_trace_setevent @TraceID, 40, 32, @on 
EXEC sp_trace_setevent @TraceID, 40, 33, @on
EXEC sp_trace_setevent @TraceID, 40, 34, @on
EXEC sp_trace_setevent @TraceID, 40, 35, @on
EXEC sp_trace_setevent @TraceID, 40, 48, @on
EXEC sp_trace_setevent @TraceID, 40, 51, @on


--SQL:StmtCompleted event
EXEC sp_trace_setevent @TraceID, 41, 1, @on
EXEC sp_trace_setevent @TraceID, 41, 6, @on  
EXEC sp_trace_setevent @TraceID, 41, 8, @on
EXEC sp_trace_setevent @TraceID, 41, 9, @on
EXEC sp_trace_setevent @TraceID, 41, 10, @on  
EXEC sp_trace_setevent @TraceID, 41, 11, @on  
EXEC sp_trace_setevent @TraceID, 41, 12, @on  
EXEC sp_trace_setevent @TraceID, 41, 13, @on  
EXEC sp_trace_setevent @TraceID, 41, 14, @on  
EXEC sp_trace_setevent @TraceID, 41, 15, @on  
EXEC sp_trace_setevent @TraceID, 41, 18, @on  
EXEC sp_trace_setevent @TraceID, 41, 26, @on 
EXEC sp_trace_setevent @TraceID, 41, 27, @on
EXEC sp_trace_setevent @TraceID, 41, 28, @on
EXEC sp_trace_setevent @TraceID, 41, 32, @on 
EXEC sp_trace_setevent @TraceID, 41, 33, @on
EXEC sp_trace_setevent @TraceID, 41, 34, @on
EXEC sp_trace_setevent @TraceID, 41, 35, @on
EXEC sp_trace_setevent @TraceID, 41, 48, @on
EXEC sp_trace_setevent @TraceID, 41, 51, @on


--SP:Starting event
EXEC sp_trace_setevent @TraceID, 42, 1, @on
EXEC sp_trace_setevent @TraceID, 42, 6, @on  
EXEC sp_trace_setevent @TraceID, 42, 8, @on
EXEC sp_trace_setevent @TraceID, 42, 9, @on
EXEC sp_trace_setevent @TraceID, 42, 10, @on  
EXEC sp_trace_setevent @TraceID, 42, 11, @on  
EXEC sp_trace_setevent @TraceID, 42, 12, @on  
EXEC sp_trace_setevent @TraceID, 42, 13, @on  
EXEC sp_trace_setevent @TraceID, 42, 14, @on  
EXEC sp_trace_setevent @TraceID, 42, 15, @on  
EXEC sp_trace_setevent @TraceID, 42, 18, @on  
EXEC sp_trace_setevent @TraceID, 42, 26, @on 
EXEC sp_trace_setevent @TraceID, 42, 27, @on
EXEC sp_trace_setevent @TraceID, 42, 28, @on
EXEC sp_trace_setevent @TraceID, 42, 32, @on 
EXEC sp_trace_setevent @TraceID, 42, 33, @on
EXEC sp_trace_setevent @TraceID, 42, 34, @on
EXEC sp_trace_setevent @TraceID, 42, 35, @on
EXEC sp_trace_setevent @TraceID, 42, 48, @on
EXEC sp_trace_setevent @TraceID, 42, 51, @on

--SP:Completed event
EXEC sp_trace_setevent @TraceID, 43, 1, @on
EXEC sp_trace_setevent @TraceID, 43, 6, @on  
EXEC sp_trace_setevent @TraceID, 43, 8, @on
EXEC sp_trace_setevent @TraceID, 43, 9, @on
EXEC sp_trace_setevent @TraceID, 43, 10, @on  
EXEC sp_trace_setevent @TraceID, 43, 11, @on  
EXEC sp_trace_setevent @TraceID, 43, 12, @on  
EXEC sp_trace_setevent @TraceID, 43, 13, @on  
EXEC sp_trace_setevent @TraceID, 43, 14, @on  
EXEC sp_trace_setevent @TraceID, 43, 15, @on  
EXEC sp_trace_setevent @TraceID, 43, 18, @on  
EXEC sp_trace_setevent @TraceID, 43, 26, @on 
EXEC sp_trace_setevent @TraceID, 43, 27, @on
EXEC sp_trace_setevent @TraceID, 43, 28, @on
EXEC sp_trace_setevent @TraceID, 43, 32, @on 
EXEC sp_trace_setevent @TraceID, 43, 33, @on
EXEC sp_trace_setevent @TraceID, 43, 34, @on
EXEC sp_trace_setevent @TraceID, 43, 35, @on
EXEC sp_trace_setevent @TraceID, 43, 48, @on
EXEC sp_trace_setevent @TraceID, 43, 51, @on

--SP:StmtStarting event
EXEC sp_trace_setevent @TraceID, 44, 1, @on
EXEC sp_trace_setevent @TraceID, 44, 6, @on  
EXEC sp_trace_setevent @TraceID, 44, 8, @on
EXEC sp_trace_setevent @TraceID, 44, 9, @on
EXEC sp_trace_setevent @TraceID, 44, 10, @on  
EXEC sp_trace_setevent @TraceID, 44, 11, @on  
EXEC sp_trace_setevent @TraceID, 44, 12, @on  
EXEC sp_trace_setevent @TraceID, 44, 13, @on  
EXEC sp_trace_setevent @TraceID, 44, 14, @on  
EXEC sp_trace_setevent @TraceID, 44, 15, @on  
EXEC sp_trace_setevent @TraceID, 44, 18, @on  
EXEC sp_trace_setevent @TraceID, 44, 26, @on 
EXEC sp_trace_setevent @TraceID, 44, 27, @on
EXEC sp_trace_setevent @TraceID, 44, 28, @on
EXEC sp_trace_setevent @TraceID, 44, 32, @on 
EXEC sp_trace_setevent @TraceID, 44, 33, @on
EXEC sp_trace_setevent @TraceID, 44, 34, @on
EXEC sp_trace_setevent @TraceID, 44, 35, @on
EXEC sp_trace_setevent @TraceID, 44, 48, @on
EXEC sp_trace_setevent @TraceID, 44, 51, @on

--SP:StmtCompleted event
EXEC sp_trace_setevent @TraceID, 45, 1, @on
EXEC sp_trace_setevent @TraceID, 45, 6, @on  
EXEC sp_trace_setevent @TraceID, 45, 8, @on
EXEC sp_trace_setevent @TraceID, 45, 9, @on
EXEC sp_trace_setevent @TraceID, 45, 10, @on  
EXEC sp_trace_setevent @TraceID, 45, 11, @on  
EXEC sp_trace_setevent @TraceID, 45, 12, @on  
EXEC sp_trace_setevent @TraceID, 45, 13, @on  
EXEC sp_trace_setevent @TraceID, 45, 14, @on  
EXEC sp_trace_setevent @TraceID, 45, 15, @on  
EXEC sp_trace_setevent @TraceID, 45, 18, @on  
EXEC sp_trace_setevent @TraceID, 45, 26, @on 
EXEC sp_trace_setevent @TraceID, 45, 27, @on
EXEC sp_trace_setevent @TraceID, 45, 28, @on
EXEC sp_trace_setevent @TraceID, 45, 32, @on 
EXEC sp_trace_setevent @TraceID, 45, 33, @on
EXEC sp_trace_setevent @TraceID, 45, 34, @on
EXEC sp_trace_setevent @TraceID, 45, 35, @on
EXEC sp_trace_setevent @TraceID, 45, 48, @on
EXEC sp_trace_setevent @TraceID, 45, 51, @on

--Lock:Deadlock Chain event 
EXEC sp_trace_setevent @TraceID, 59, 1, @on
EXEC sp_trace_setevent @TraceID, 59, 6, @on  
EXEC sp_trace_setevent @TraceID, 59, 8, @on
EXEC sp_trace_setevent @TraceID, 59, 9, @on
EXEC sp_trace_setevent @TraceID, 59, 10, @on  
EXEC sp_trace_setevent @TraceID, 59, 11, @on  
EXEC sp_trace_setevent @TraceID, 59, 12, @on  
EXEC sp_trace_setevent @TraceID, 59, 13, @on  
EXEC sp_trace_setevent @TraceID, 59, 14, @on  
EXEC sp_trace_setevent @TraceID, 59, 15, @on  
EXEC sp_trace_setevent @TraceID, 59, 18, @on  
EXEC sp_trace_setevent @TraceID, 59, 26, @on 
EXEC sp_trace_setevent @TraceID, 59, 27, @on
EXEC sp_trace_setevent @TraceID, 59, 28, @on
EXEC sp_trace_setevent @TraceID, 59, 32, @on 
EXEC sp_trace_setevent @TraceID, 59, 33, @on
EXEC sp_trace_setevent @TraceID, 59, 34, @on
EXEC sp_trace_setevent @TraceID, 59, 35, @on
EXEC sp_trace_setevent @TraceID, 59, 48, @on
EXEC sp_trace_setevent @TraceID, 59, 51, @on

--Lock:Escalation event 
EXEC sp_trace_setevent @TraceID, 60, 1, @on
EXEC sp_trace_setevent @TraceID, 60, 6, @on  
EXEC sp_trace_setevent @TraceID, 60, 8, @on
EXEC sp_trace_setevent @TraceID, 60, 9, @on
EXEC sp_trace_setevent @TraceID, 60, 10, @on  
EXEC sp_trace_setevent @TraceID, 60, 11, @on  
EXEC sp_trace_setevent @TraceID, 60, 12, @on  
EXEC sp_trace_setevent @TraceID, 60, 13, @on  
EXEC sp_trace_setevent @TraceID, 60, 14, @on  
EXEC sp_trace_setevent @TraceID, 60, 15, @on  
EXEC sp_trace_setevent @TraceID, 60, 18, @on  
EXEC sp_trace_setevent @TraceID, 60, 26, @on 
EXEC sp_trace_setevent @TraceID, 60, 27, @on
EXEC sp_trace_setevent @TraceID, 60, 28, @on
EXEC sp_trace_setevent @TraceID, 60, 32, @on 
EXEC sp_trace_setevent @TraceID, 60, 33, @on
EXEC sp_trace_setevent @TraceID, 60, 34, @on
EXEC sp_trace_setevent @TraceID, 60, 35, @on
EXEC sp_trace_setevent @TraceID, 60, 48, @on
EXEC sp_trace_setevent @TraceID, 60, 51, @on


--Execution Warnings event
EXEC sp_trace_setevent @TraceID, 67, 1, @on
EXEC sp_trace_setevent @TraceID, 67, 6, @on  
EXEC sp_trace_setevent @TraceID, 67, 8, @on
EXEC sp_trace_setevent @TraceID, 67, 9, @on
EXEC sp_trace_setevent @TraceID, 67, 10, @on  
EXEC sp_trace_setevent @TraceID, 67, 11, @on  
EXEC sp_trace_setevent @TraceID, 67, 12, @on  
EXEC sp_trace_setevent @TraceID, 67, 13, @on  
EXEC sp_trace_setevent @TraceID, 67, 14, @on  
EXEC sp_trace_setevent @TraceID, 67, 15, @on  
EXEC sp_trace_setevent @TraceID, 67, 18, @on  
EXEC sp_trace_setevent @TraceID, 67, 26, @on 
EXEC sp_trace_setevent @TraceID, 67, 27, @on
EXEC sp_trace_setevent @TraceID, 67, 28, @on
EXEC sp_trace_setevent @TraceID, 67, 32, @on 
EXEC sp_trace_setevent @TraceID, 67, 33, @on
EXEC sp_trace_setevent @TraceID, 67, 34, @on
EXEC sp_trace_setevent @TraceID, 67, 35, @on
EXEC sp_trace_setevent @TraceID, 67, 48, @on
EXEC sp_trace_setevent @TraceID, 67, 51, @on

--Showplan Text (Unencoded) event 
EXEC sp_trace_setevent @TraceID, 68, 1, @on
EXEC sp_trace_setevent @TraceID, 68, 6, @on  
EXEC sp_trace_setevent @TraceID, 68, 8, @on
EXEC sp_trace_setevent @TraceID, 68, 9, @on
EXEC sp_trace_setevent @TraceID, 68, 10, @on  
EXEC sp_trace_setevent @TraceID, 68, 11, @on  
EXEC sp_trace_setevent @TraceID, 68, 12, @on  
EXEC sp_trace_setevent @TraceID, 68, 13, @on  
EXEC sp_trace_setevent @TraceID, 68, 14, @on  
EXEC sp_trace_setevent @TraceID, 68, 15, @on  
EXEC sp_trace_setevent @TraceID, 68, 18, @on  
EXEC sp_trace_setevent @TraceID, 68, 26, @on 
EXEC sp_trace_setevent @TraceID, 68, 27, @on
EXEC sp_trace_setevent @TraceID, 68, 28, @on
EXEC sp_trace_setevent @TraceID, 68, 32, @on 
EXEC sp_trace_setevent @TraceID, 68, 33, @on
EXEC sp_trace_setevent @TraceID, 68, 34, @on
EXEC sp_trace_setevent @TraceID, 68, 35, @on
EXEC sp_trace_setevent @TraceID, 68, 48, @on
EXEC sp_trace_setevent @TraceID, 68, 51, @on

--CursorPrepare event
EXEC sp_trace_setevent @TraceID, 70, 1, @on
EXEC sp_trace_setevent @TraceID, 70, 6, @on  
EXEC sp_trace_setevent @TraceID, 70, 8, @on
EXEC sp_trace_setevent @TraceID, 70, 9, @on
EXEC sp_trace_setevent @TraceID, 70, 10, @on  
EXEC sp_trace_setevent @TraceID, 70, 11, @on  
EXEC sp_trace_setevent @TraceID, 70, 12, @on  
EXEC sp_trace_setevent @TraceID, 70, 13, @on  
EXEC sp_trace_setevent @TraceID, 70, 14, @on  
EXEC sp_trace_setevent @TraceID, 70, 15, @on  
EXEC sp_trace_setevent @TraceID, 70, 18, @on  
EXEC sp_trace_setevent @TraceID, 70, 26, @on 
EXEC sp_trace_setevent @TraceID, 70, 27, @on
EXEC sp_trace_setevent @TraceID, 70, 28, @on
EXEC sp_trace_setevent @TraceID, 70, 32, @on 
EXEC sp_trace_setevent @TraceID, 70, 33, @on
EXEC sp_trace_setevent @TraceID, 70, 34, @on
EXEC sp_trace_setevent @TraceID, 70, 35, @on
EXEC sp_trace_setevent @TraceID, 70, 48, @on
EXEC sp_trace_setevent @TraceID, 70, 51, @on

--Prepare SQL event
EXEC sp_trace_setevent @TraceID, 71, 1, @on
EXEC sp_trace_setevent @TraceID, 71, 6, @on  
EXEC sp_trace_setevent @TraceID, 71, 8, @on
EXEC sp_trace_setevent @TraceID, 71, 9, @on
EXEC sp_trace_setevent @TraceID, 71, 10, @on  
EXEC sp_trace_setevent @TraceID, 71, 11, @on  
EXEC sp_trace_setevent @TraceID, 71, 12, @on  
EXEC sp_trace_setevent @TraceID, 71, 13, @on  
EXEC sp_trace_setevent @TraceID, 71, 14, @on  
EXEC sp_trace_setevent @TraceID, 71, 15, @on  
EXEC sp_trace_setevent @TraceID, 71, 18, @on  
EXEC sp_trace_setevent @TraceID, 71, 26, @on 
EXEC sp_trace_setevent @TraceID, 71, 27, @on
EXEC sp_trace_setevent @TraceID, 71, 28, @on
EXEC sp_trace_setevent @TraceID, 71, 32, @on 
EXEC sp_trace_setevent @TraceID, 71, 33, @on
EXEC sp_trace_setevent @TraceID, 71, 34, @on
EXEC sp_trace_setevent @TraceID, 71, 35, @on
EXEC sp_trace_setevent @TraceID, 71, 48, @on
EXEC sp_trace_setevent @TraceID, 71, 51, @on

--Exec Prepared SQL event
EXEC sp_trace_setevent @TraceID, 72, 1, @on
EXEC sp_trace_setevent @TraceID, 72, 6, @on  
EXEC sp_trace_setevent @TraceID, 72, 8, @on
EXEC sp_trace_setevent @TraceID, 72, 9, @on
EXEC sp_trace_setevent @TraceID, 72, 10, @on  
EXEC sp_trace_setevent @TraceID, 72, 11, @on  
EXEC sp_trace_setevent @TraceID, 72, 12, @on  
EXEC sp_trace_setevent @TraceID, 72, 13, @on  
EXEC sp_trace_setevent @TraceID, 72, 14, @on  
EXEC sp_trace_setevent @TraceID, 72, 15, @on  
EXEC sp_trace_setevent @TraceID, 72, 18, @on  
EXEC sp_trace_setevent @TraceID, 72, 26, @on 
EXEC sp_trace_setevent @TraceID, 72, 27, @on
EXEC sp_trace_setevent @TraceID, 72, 28, @on
EXEC sp_trace_setevent @TraceID, 72, 32, @on 
EXEC sp_trace_setevent @TraceID, 72, 33, @on
EXEC sp_trace_setevent @TraceID, 72, 34, @on
EXEC sp_trace_setevent @TraceID, 72, 35, @on
EXEC sp_trace_setevent @TraceID, 72, 48, @on
EXEC sp_trace_setevent @TraceID, 72, 51, @on

--Showplan Text event 
EXEC sp_trace_setevent @TraceID, 96, 1, @on
EXEC sp_trace_setevent @TraceID, 96, 6, @on  
EXEC sp_trace_setevent @TraceID, 96, 8, @on
EXEC sp_trace_setevent @TraceID, 96, 9, @on
EXEC sp_trace_setevent @TraceID, 96, 10, @on  
EXEC sp_trace_setevent @TraceID, 96, 11, @on  
EXEC sp_trace_setevent @TraceID, 96, 12, @on  
EXEC sp_trace_setevent @TraceID, 96, 13, @on  
EXEC sp_trace_setevent @TraceID, 96, 14, @on  
EXEC sp_trace_setevent @TraceID, 96, 15, @on  
EXEC sp_trace_setevent @TraceID, 96, 18, @on  
EXEC sp_trace_setevent @TraceID, 96, 26, @on 
EXEC sp_trace_setevent @TraceID, 96, 27, @on
EXEC sp_trace_setevent @TraceID, 96, 28, @on
EXEC sp_trace_setevent @TraceID, 96, 32, @on
EXEC sp_trace_setevent @TraceID, 96, 33, @on 
EXEC sp_trace_setevent @TraceID, 96, 34, @on
EXEC sp_trace_setevent @TraceID, 96, 35, @on
EXEC sp_trace_setevent @TraceID, 96, 48, @on
EXEC sp_trace_setevent @TraceID, 96, 51, @on

--Showplan All event 
EXEC sp_trace_setevent @TraceID, 97, 1, @on
EXEC sp_trace_setevent @TraceID, 97, 6, @on  
EXEC sp_trace_setevent @TraceID, 97, 8, @on
EXEC sp_trace_setevent @TraceID, 97, 9, @on
EXEC sp_trace_setevent @TraceID, 97, 10, @on  
EXEC sp_trace_setevent @TraceID, 97, 11, @on  
EXEC sp_trace_setevent @TraceID, 97, 12, @on  
EXEC sp_trace_setevent @TraceID, 97, 13, @on  
EXEC sp_trace_setevent @TraceID, 97, 14, @on  
EXEC sp_trace_setevent @TraceID, 97, 15, @on  
EXEC sp_trace_setevent @TraceID, 97, 18, @on  
EXEC sp_trace_setevent @TraceID, 97, 26, @on 
EXEC sp_trace_setevent @TraceID, 97, 27, @on
EXEC sp_trace_setevent @TraceID, 97, 28, @on
EXEC sp_trace_setevent @TraceID, 97, 32, @on
EXEC sp_trace_setevent @TraceID, 97, 33, @on 
EXEC sp_trace_setevent @TraceID, 97, 34, @on
EXEC sp_trace_setevent @TraceID, 97, 35, @on
EXEC sp_trace_setevent @TraceID, 97, 48, @on
EXEC sp_trace_setevent @TraceID, 97, 51, @on

--Showplan Statistics Profile event 
EXEC sp_trace_setevent @TraceID, 98, 1, @on
EXEC sp_trace_setevent @TraceID, 98, 6, @on  
EXEC sp_trace_setevent @TraceID, 98, 8, @on
EXEC sp_trace_setevent @TraceID, 98, 9, @on
EXEC sp_trace_setevent @TraceID, 98, 10, @on  
EXEC sp_trace_setevent @TraceID, 98, 11, @on  
EXEC sp_trace_setevent @TraceID, 98, 12, @on  
EXEC sp_trace_setevent @TraceID, 98, 13, @on  
EXEC sp_trace_setevent @TraceID, 98, 14, @on  
EXEC sp_trace_setevent @TraceID, 98, 15, @on  
EXEC sp_trace_setevent @TraceID, 98, 18, @on  
EXEC sp_trace_setevent @TraceID, 98, 26, @on 
EXEC sp_trace_setevent @TraceID, 98, 27, @on
EXEC sp_trace_setevent @TraceID, 98, 28, @on
EXEC sp_trace_setevent @TraceID, 98, 32, @on 
EXEC sp_trace_setevent @TraceID, 98, 33, @on
EXEC sp_trace_setevent @TraceID, 98, 34, @on
EXEC sp_trace_setevent @TraceID, 98, 35, @on
EXEC sp_trace_setevent @TraceID, 98, 48, @on
EXEC sp_trace_setevent @TraceID, 98, 51, @on

--RPC Output Parameter event 
EXEC sp_trace_setevent @TraceID, 100, 1, @on
EXEC sp_trace_setevent @TraceID, 100, 6, @on  
EXEC sp_trace_setevent @TraceID, 100, 8, @on
EXEC sp_trace_setevent @TraceID, 100, 9, @on
EXEC sp_trace_setevent @TraceID, 100, 10, @on  
EXEC sp_trace_setevent @TraceID, 100, 11, @on  
EXEC sp_trace_setevent @TraceID, 100, 12, @on  
EXEC sp_trace_setevent @TraceID, 100, 13, @on  
EXEC sp_trace_setevent @TraceID, 100, 14, @on  
EXEC sp_trace_setevent @TraceID, 100, 15, @on  
EXEC sp_trace_setevent @TraceID, 100, 18, @on  
EXEC sp_trace_setevent @TraceID, 100, 26, @on 
EXEC sp_trace_setevent @TraceID, 100, 27, @on
EXEC sp_trace_setevent @TraceID, 100, 28, @on
EXEC sp_trace_setevent @TraceID, 100, 32, @on 
EXEC sp_trace_setevent @TraceID, 100, 33, @on
EXEC sp_trace_setevent @TraceID, 100, 34, @on
EXEC sp_trace_setevent @TraceID, 100, 35, @on
EXEC sp_trace_setevent @TraceID, 100, 48, @on
EXEC sp_trace_setevent @TraceID, 100, 51, @on

--OLEDB Call Event event 
EXEC sp_trace_setevent @TraceID, 119, 1, @on
EXEC sp_trace_setevent @TraceID, 119, 6, @on  
EXEC sp_trace_setevent @TraceID, 119, 8, @on
EXEC sp_trace_setevent @TraceID, 119, 9, @on
EXEC sp_trace_setevent @TraceID, 119, 10, @on  
EXEC sp_trace_setevent @TraceID, 119, 11, @on  
EXEC sp_trace_setevent @TraceID, 119, 12, @on  
EXEC sp_trace_setevent @TraceID, 119, 13, @on  
EXEC sp_trace_setevent @TraceID, 119, 14, @on  
EXEC sp_trace_setevent @TraceID, 119, 15, @on  
EXEC sp_trace_setevent @TraceID, 119, 18, @on  
EXEC sp_trace_setevent @TraceID, 119, 26, @on 
EXEC sp_trace_setevent @TraceID, 119, 27, @on
EXEC sp_trace_setevent @TraceID, 119, 28, @on
EXEC sp_trace_setevent @TraceID, 119, 32, @on 
EXEC sp_trace_setevent @TraceID, 119, 33, @on
EXEC sp_trace_setevent @TraceID, 119, 34, @on
EXEC sp_trace_setevent @TraceID, 119, 35, @on
EXEC sp_trace_setevent @TraceID, 119, 48, @on
EXEC sp_trace_setevent @TraceID, 119, 51, @on

--OLEDB QueryInterface Event
EXEC sp_trace_setevent @TraceID, 120, 1, @on
EXEC sp_trace_setevent @TraceID, 120, 6, @on  
EXEC sp_trace_setevent @TraceID, 120, 8, @on
EXEC sp_trace_setevent @TraceID, 120, 9, @on
EXEC sp_trace_setevent @TraceID, 120, 10, @on  
EXEC sp_trace_setevent @TraceID, 120, 11, @on  
EXEC sp_trace_setevent @TraceID, 120, 12, @on  
EXEC sp_trace_setevent @TraceID, 120, 13, @on  
EXEC sp_trace_setevent @TraceID, 120, 14, @on  
EXEC sp_trace_setevent @TraceID, 120, 15, @on  
EXEC sp_trace_setevent @TraceID, 120, 18, @on  
EXEC sp_trace_setevent @TraceID, 120, 26, @on 
EXEC sp_trace_setevent @TraceID, 120, 27, @on
EXEC sp_trace_setevent @TraceID, 120, 28, @on
EXEC sp_trace_setevent @TraceID, 120, 32, @on 
EXEC sp_trace_setevent @TraceID, 120, 33, @on
EXEC sp_trace_setevent @TraceID, 120, 34, @on
EXEC sp_trace_setevent @TraceID, 120, 35, @on
EXEC sp_trace_setevent @TraceID, 120, 48, @on
EXEC sp_trace_setevent @TraceID, 120, 51, @on

--OLEDB DataRead Event
EXEC sp_trace_setevent @TraceID, 121, 1, @on
EXEC sp_trace_setevent @TraceID, 121, 6, @on  
EXEC sp_trace_setevent @TraceID, 121, 8, @on
EXEC sp_trace_setevent @TraceID, 121, 9, @on
EXEC sp_trace_setevent @TraceID, 121, 10, @on  
EXEC sp_trace_setevent @TraceID, 121, 11, @on  
EXEC sp_trace_setevent @TraceID, 121, 12, @on  
EXEC sp_trace_setevent @TraceID, 121, 13, @on  
EXEC sp_trace_setevent @TraceID, 121, 14, @on  
EXEC sp_trace_setevent @TraceID, 121, 15, @on  
EXEC sp_trace_setevent @TraceID, 121, 18, @on  
EXEC sp_trace_setevent @TraceID, 121, 26, @on 
EXEC sp_trace_setevent @TraceID, 121, 27, @on
EXEC sp_trace_setevent @TraceID, 121, 28, @on
EXEC sp_trace_setevent @TraceID, 121, 32, @on 
EXEC sp_trace_setevent @TraceID, 121, 33, @on
EXEC sp_trace_setevent @TraceID, 121, 34, @on
EXEC sp_trace_setevent @TraceID, 121, 35, @on
EXEC sp_trace_setevent @TraceID, 121, 48, @on
EXEC sp_trace_setevent @TraceID, 121, 51, @on
  
--Showplan XML event 
EXEC sp_trace_setevent @TraceID, 122, 1, @on
EXEC sp_trace_setevent @TraceID, 122, 6, @on  
EXEC sp_trace_setevent @TraceID, 122, 8, @on
EXEC sp_trace_setevent @TraceID, 122, 9, @on
EXEC sp_trace_setevent @TraceID, 122, 10, @on  
EXEC sp_trace_setevent @TraceID, 122, 11, @on  
EXEC sp_trace_setevent @TraceID, 122, 12, @on  
EXEC sp_trace_setevent @TraceID, 122, 13, @on  
EXEC sp_trace_setevent @TraceID, 122, 14, @on  
EXEC sp_trace_setevent @TraceID, 122, 15, @on  
EXEC sp_trace_setevent @TraceID, 122, 18, @on  
EXEC sp_trace_setevent @TraceID, 122, 26, @on 
EXEC sp_trace_setevent @TraceID, 122, 27, @on
EXEC sp_trace_setevent @TraceID, 122, 28, @on
EXEC sp_trace_setevent @TraceID, 122, 32, @on 
EXEC sp_trace_setevent @TraceID, 122, 33, @on
EXEC sp_trace_setevent @TraceID, 122, 34, @on
EXEC sp_trace_setevent @TraceID, 122, 35, @on
EXEC sp_trace_setevent @TraceID, 122, 48, @on
EXEC sp_trace_setevent @TraceID, 122, 51, @on

--Deadlock Graph event 
EXEC sp_trace_setevent @TraceID, 148, 1, @on
EXEC sp_trace_setevent @TraceID, 148, 6, @on  
EXEC sp_trace_setevent @TraceID, 148, 8, @on
EXEC sp_trace_setevent @TraceID, 148, 9, @on
EXEC sp_trace_setevent @TraceID, 148, 10, @on  
EXEC sp_trace_setevent @TraceID, 148, 11, @on  
EXEC sp_trace_setevent @TraceID, 148, 12, @on  
EXEC sp_trace_setevent @TraceID, 148, 13, @on  
EXEC sp_trace_setevent @TraceID, 148, 14, @on  
EXEC sp_trace_setevent @TraceID, 148, 15, @on  
EXEC sp_trace_setevent @TraceID, 148, 18, @on  
EXEC sp_trace_setevent @TraceID, 148, 26, @on 
EXEC sp_trace_setevent @TraceID, 148, 27, @on
EXEC sp_trace_setevent @TraceID, 148, 28, @on
EXEC sp_trace_setevent @TraceID, 148, 32, @on 
EXEC sp_trace_setevent @TraceID, 148, 33, @on
EXEC sp_trace_setevent @TraceID, 148, 34, @on
EXEC sp_trace_setevent @TraceID, 148, 35, @on
EXEC sp_trace_setevent @TraceID, 148, 48, @on
EXEC sp_trace_setevent @TraceID, 148, 51, @on
  
--User Error Message event 
EXEC sp_trace_setevent @TraceID, 162, 1, @on
EXEC sp_trace_setevent @TraceID, 162, 6, @on  
EXEC sp_trace_setevent @TraceID, 162, 8, @on
EXEC sp_trace_setevent @TraceID, 162, 9, @on
EXEC sp_trace_setevent @TraceID, 162, 10, @on  
EXEC sp_trace_setevent @TraceID, 162, 11, @on  
EXEC sp_trace_setevent @TraceID, 162, 12, @on  
EXEC sp_trace_setevent @TraceID, 162, 13, @on  
EXEC sp_trace_setevent @TraceID, 162, 14, @on  
EXEC sp_trace_setevent @TraceID, 162, 15, @on  
EXEC sp_trace_setevent @TraceID, 162, 18, @on  
EXEC sp_trace_setevent @TraceID, 162, 26, @on 
EXEC sp_trace_setevent @TraceID, 162, 27, @on
EXEC sp_trace_setevent @TraceID, 162, 28, @on
EXEC sp_trace_setevent @TraceID, 162, 32, @on 
EXEC sp_trace_setevent @TraceID, 162, 33, @on
EXEC sp_trace_setevent @TraceID, 162, 34, @on
EXEC sp_trace_setevent @TraceID, 162, 35, @on
EXEC sp_trace_setevent @TraceID, 162, 48, @on
EXEC sp_trace_setevent @TraceID, 162, 51, @on

--OLEDB Provider Information
EXEC sp_trace_setevent @TraceID, 194, 1, @on
EXEC sp_trace_setevent @TraceID, 194, 6, @on  
EXEC sp_trace_setevent @TraceID, 194, 8, @on
EXEC sp_trace_setevent @TraceID, 194, 9, @on
EXEC sp_trace_setevent @TraceID, 194, 10, @on  
EXEC sp_trace_setevent @TraceID, 194, 11, @on  
EXEC sp_trace_setevent @TraceID, 194, 12, @on  
EXEC sp_trace_setevent @TraceID, 194, 13, @on  
EXEC sp_trace_setevent @TraceID, 194, 14, @on  
EXEC sp_trace_setevent @TraceID, 194, 15, @on  
EXEC sp_trace_setevent @TraceID, 194, 18, @on  
EXEC sp_trace_setevent @TraceID, 194, 26, @on 
EXEC sp_trace_setevent @TraceID, 194, 27, @on
EXEC sp_trace_setevent @TraceID, 194, 28, @on
EXEC sp_trace_setevent @TraceID, 194, 32, @on 
EXEC sp_trace_setevent @TraceID, 194, 33, @on
EXEC sp_trace_setevent @TraceID, 194, 34, @on
EXEC sp_trace_setevent @TraceID, 194, 35, @on
EXEC sp_trace_setevent @TraceID, 194, 48, @on
EXEC sp_trace_setevent @TraceID, 194, 51, @on
  
  --------------------------------------------------------------------------
  --End
  --Events and columns of the profiler trace
  --------------------------------------------------------------------------
  
  --------------------------------------------------------------------------
  -- Start
  -- Set the Filters
  -- DEFINING THE Filter condition
   --sp_trace_setfilter @traceid ,@columnid,@logical_operator,@comparison_operator,@value

  --------------------------------------------------------------------------
  declare @intfilter int
  declare @bigintfilter bigint
  
  exec sp_trace_setfilter @TraceID, 10, 0, 7, N'SQL Server Profiler%'
  --EXEC sp_trace_setfilter @TraceID,8,0,0,N''MyAppServer''  --Hostname
  EXEC sp_trace_setfilter @TraceID,35,0,0,N'Kapow' --Database name to be filtered, e.g. EnterpriseVaultDirectory
  --EXEC sp_trace_setfilter @TraceID,35,1,0,N''EVVSVaultStore_x'' --''Or'' another database name to be filtered 
  --EXEC sp_trace_setfilter @TraceID,11,0,0,N''MyAppUser'' --SQL login
  

  --------------------------------------------------------------------------
  -- End
  -- Set the Filters
  --------------------------------------------------------------------------



  -- Set the trace status to start
  exec sp_trace_setstatus @TraceID, 1

  -- display trace id for future references
  select TraceID=@TraceID, TraceLocation=@tracename + '.trc'
  
  goto finish

error: 
select ErrorCode=@rc

finish:
go
