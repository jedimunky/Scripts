@REM $Revision$
 
@REM bcpyrght
@REM *************************************************************************** 
@REM * $Copyright: Copyright (c) 2016 Veritas Technologies LLC. All rights reserved VT25-0977-2658-84-51-3 $ * 
@REM *************************************************************************** 
@REM ecpyrght
 
@REM ---------------------------------------------------------------------------
@REM 
@REM This script is provided as an example.  See the instructions below
@REM for making customizations to work within your environment.
@REM
@REM Please copy this script to a safe location before customizing it.
@REM Modifications to the original files will be lost during product updates.
@REM 
@REM This script performs an online backup of the database.  An online backup
@REM requires that the database is configured for forward recovery (see the
@REM DB2 USEREXIT and LOGRETAIN settings).  DB2 users can remain connected
@REM while performing an online backup.
@REM
@REM To back up a database or a database partition, the user must have SYSADM, 
@REM SYSCTRL, or SYSMAINT authority.
@REM ---------------------------------------------------------------------------

@echo off
@setlocal

@REM !!!!! START CUSTOMIZATIONS !!!!!
@REM
@REM The following changes need to be made to make this script work with your
@REM environment:
@REM 
@REM ---------------------------------------------------------------------------
@REM (1) NetBackup for DB2 shared library:
@REM ---------------------------------------------------------------------------
@REM	This is the NetBackup library that backs up and restores DB2 databases
@REM	Set db2_nblib below to the correct NetBackup library path for your host
@REM	
@REM Example: @set db2_nblib=C:\progra~1\veritas\netbackup\bin\nbdb2.dll
@set db2_nblib="D:\Program Files\VERITAS\NetBackup\bin\nbdb2.dll"
@echo db2_nblib = %db2_nblib%

@REM ---------------------------------------------------------------------------
@REM (2) DB2 home directory (the system catalog node): 
@REM ---------------------------------------------------------------------------
@REM 	This is the DB2 home directory where DB2 is installed
@REM	Set db2_home to DB2 home directory
@REM 
@REM Example: @set db2_home=D:\sqllib
@set db2_home=%~1
@echo db2_home = %db2_home%

@REM ---------------------------------------------------------------------------
@REM (3) Database to backup:
@REM ---------------------------------------------------------------------------
@REM	Set db2_name to the name of the database to backup:
@REM
@REM Example: @set db2_name=SAMPLE	
@set db2_name=%~2
@echo db2_name = %db2_name%

@REM ---------------------------------------------------------------------------
@REM (4) Multiple Sessions:
@REM ---------------------------------------------------------------------------
@REM	Concurrency can improve backup performance of large databases.
@REM	Multiple sessions are used to perform the backup, with each session
@REM	backing up a subset of the database.  The sessions operate
@REM	concurrently, reducing the overall time to backup the database.
@REM	This approach assumes there are adequate resources available, like
@REM	multiple tape devices and/or multiplexing enabled.
@REM
@REM	For more information on configuring NetBackup multiplexing,
@REM	refer to the "Veritas NetBackup System Administrator's Guide".
@REM	
@REM	If using multiple sessions change db2_sessions to use multiple sessions
@REM
@REM Example: @set db2_sessions="OPEN 2 SESSIONS WITH 4 BUFFERS BUFFER 1024"
@set db2_sessions=OPEN 2 SESSIONS WITH 4 BUFFERS BUFFER 1024



@REM !!!!! END CUSTOMIZATIONS !!!!!

@REM ---------------------------------------------------------------------------
@REM Exit now if the sample script has not been customized
@REM ---------------------------------------------------------------------------
if "%db2_name%" == "" goto custom_err_msg

@REM ---------------------------------------------------------------------------
@REM These environmental variables are created by Netbackup (bphdb)
@REM ---------------------------------------------------------------------------

@echo DB2_POLICY = %DB2_POLICY%
@echo DB2_SCHED = %DB2_SCHED%
@echo DB2_CLIENT = %DB2_CLIENT%
@echo DB2_SERVER = %DB2_SERVER%
@echo DB2_USER_INITIATED = %DB2_USER_INITIATED%
@echo DB2_FULL = %DB2_FULL%
@echo DB2_CINC = %DB2_CINC%
@echo DB2_INCR = %DB2_INCR%
@echo DB2_SCHEDULED = %DB2_SCHEDULED%
@echo STATUS_FILE = %STATUS_FILE%

@REM ---------------------------------------------------------------------------
@REM Type of Backup:
@REM ---------------------------------------------------------------------------
@REM	NetBackup policies for DB2  recognize different
@REM	backup types, i.e. full, cumulative, and differential.
@REM	For more information on NetBackup backup types, please refer to the
@REM    NetBackup for DB2 System Administrator's Guide.
@REM
@REM	Use NetBackup variables to set DB2 full or incremental options
@REM 

@set db2_action=ONLINE
if "%DB2_FULL%" == "1" @set db2_action=ONLINE
if "%DB2_CINC%" == "1" @set db2_action=ONLINE INCREMENTAL
if "%DB2_INCR%" == "1" @set db2_action=ONLINE INCREMENTAL DELTA
@echo db2_action = %db2_action%

@REM ---------------------------------------------------------------------------
@REM Actual command that will be used to execute a backup
@REM Note: the parameters /c /w /i and db2 should be used with db2cmd.exe
@REM Without them, NetBackup job monitor may not function properly.
@REM ---------------------------------------------------------------------------

@set CMD_FILE=%temp%\cmd_file
@echo CMD_FILE = %CMD_FILE%

@set CMD_LINE=%db2_home%\db2cmd.exe /c /w /i db2 -f %CMD_FILE%
@echo CMD_LINE = %CMD_LINE%

@echo BACKUP DATABASE %db2_name% %db2_action% LOAD %db2_nblib% %db2_sessions%
@echo BACKUP DATABASE %db2_name% %db2_action% LOAD %db2_nblib% %db2_sessions% > %CMD_FILE%

@REM ---------------------------------------------------------------------------
@REM Execute the command
@REM ---------------------------------------------------------------------------
 
@echo Executing CMD=%CMD_LINE%
@set db2_inst=%~3


%CMD_LINE% > D:\scripts\db2\reports\%db2_inst%.%db2_name%_backup.out


@REM Successful Backup
if errorlevel 1 goto errormsg
echo BACKUP SUCCESSFUL
if "%STATUS_FILE%" == "" goto end
if exist "%STATUS_FILE%" echo 0 > "%STATUS_FILE%"
goto end
 
:custom_err_msg
echo This script must be customized for proper operation in your environment.


@REM Backup command unsuccessful
:errormsg
echo Execution of BACKUP command FAILED - exiting
if "%STATUS_FILE%" == "" goto end
if exist "%STATUS_FILE%" echo 1 > "%STATUS_FILE%"
 
:end

@endlocal
