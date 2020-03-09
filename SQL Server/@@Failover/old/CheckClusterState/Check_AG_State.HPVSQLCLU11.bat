@echo off
cls

CALL conSize 150 85 180 250

:MAINLOOP
cls

:: Initialise variables
set error=FALSE
set input=
set file=


echo.
echo ***
echo ***  HPVSQL23/24
echo ***
echo.

::              Listener                      Active Server            Passive Server 
CALL :CHECK_DAG HPVSQLDEFAULT2\               HPVSQL23\                HPVSQL24\
CALL :CHECK_DAG HPVSQL16BI\BUSINESSINTEL      HPVSQL23\BUSINESSINTEL   HPVSQL24\BUSINESSINTEL
CALL :CHECK_DAG HPVSQL14CLOG\CARDIOLOG        HPVSQL23\CARDIOLOG       HPVSQL24\CARDIOLOG
::CALL :CHECK_DAG HPVSQL14SP\SHAREPOINT         HPVSQL23\SHAREPOINT      HPVSQL24\SHAREPOINT
CALL :CHECK_DAG HPVSQL16SPPR\SHAREPOINTPROD   HPVSQL23\SHAREPOINTPROD  HPVSQL24\SHAREPOINTPROD
echo.

echo Connect String                 Sql Server                     Virtual Server  Start Time              Agent      Version            Level    VL Number     Edition
echo ------------------------------ ------------------------------ --------------- ----------------------- ---------- ------------------ -------- ------------- --------------------------- 

:: AG Listener
CALL :RUN_SQL HPVSQLDEFAULT2\               
CALL :RUN_SQL HPVSQL16BI\BUSINESSINTEL      
CALL :RUN_SQL HPVSQL14CLOG\CARDIOLOG        
::CALL :RUN_SQL HPVSQL14SP\SHAREPOINT         
CALL :RUN_SQL HPVSQL16SPPR\SHAREPOINTPROD
echo. 

pause
cls
goto :MAINLOOP

goto :EOF

:RUN_SQL
set sqlinstance=%1
sqlcmd -S %sqlinstance% -h -1 -i scripts\900_Server_Details.sql -v varConnectString="%sqlinstance%"

goto :EOF


:CHECK_DAG
SET ERRORS=FALSE
SET ERRLIST= 
::CALL conSize 150 75 180 250

SET DAGNAME=%1
SET SERVER1=%2
SET SERVER2=%3

CALL :AG_State
CALL :Databases_Not_in_DAG %SERVER1%
CALL :Databases_Not_in_DAG %SERVER2%
CALL :Mismatched_Logins 


call scripts\PadString DAGNAME DAGNAMEpad 27


IF %ERRORS% equ FALSE echo %DAGNAMEpad%: HEALTHY
IF %ERRORS% equ TRUE  echo %DAGNAMEpad%: UNHEALTHY (%ERRLIST%)

goto :EOF

:AG_State
sqlcmd -S %DAGNAME% -d master %LOGIN% -h -1 -m 12 -b -i scripts\AG_State.sql
if %errorlevel% neq 0 (
   SET ERRORS=TRUE
   SET ERRLIST=%ERRLIST%AG Errors; 
) 

goto :EOF

:Databases_Not_in_DAG

set SERVER=%1

sqlcmd -S %SERVER% -d master %LOGIN% -h -1 -m 12 -b -i scripts\Databases_Not_in_DAG.sql 
if %errorlevel% neq 0 (
   SET ERRORS=TRUE
   SET ERRLIST=%ERRLIST%DB not in DAG; 
) 

goto :EOF

:Mismatched_Logins

set S1OUT=temp\%SERVER1:\=_%.logins.out
set S2OUT=temp\%SERVER2:\=_%.logins.out

sqlcmd -S %SERVER1% -d master %LOGIN% -h -1 -i scripts\GetLogins.sql -o %S1OUT%
sqlcmd -S %SERVER2% -d master %LOGIN% -h -1 -i scripts\GetLogins.sql -o %S2OUT%

fc %S1OUT% %S2OUT% > nul

if %errorlevel% neq 0 (
   SET ERRORS=TRUE
   SET ERRLIST=%ERRLIST%Mismatched Logins; 
) 

goto :EOF

