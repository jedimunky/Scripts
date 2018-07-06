@echo off
CD /D D:\scripts\db2\
set outfile=reports\roll_db2diag.out

set successFlag=SUCCESS

call :ARCHIVE_DB2DIAG LPRODEXT >  %outfile%
call :ARCHIVE_DB2DIAG LPRODINT >> %outfile%

if %successFlag% == FAILED (
   call :EMAIL_DBAS
   exit -1
)

goto :EOF

:ARCHIVE_DB2DIAG

set db2instance=%1

echo Rolling db2diag for %db2instance% ... 

D:\IBM\SQLLIB\BIN\db2diag -archive "D:\db2diag_archive\%db2instance%"
if %errorlevel% neq 0 (
   echo Error rolling db2diag
   set successFlag=FAILED
)

echo.

goto :EOF

:EMAIL_DBAS
set EmailFrom=ServiceDesk@corp.hbf.com.au
set EmailTo=hk-dba@corp.hbf.com.au
set EmailSubject=\"%ComputerName% - roll_db2diag.bat failed\"
::set EmailBody="(Get-Content TestEmailPowershell.txt)"
set EmailBody=\"Please investigate - %cd%\%outfile%\"
set EmailServer=mail.corp.hbf.com.au

::powershell "Send-MailMessage -From %EmailFrom% -To %EmailTo% -Subject %EmailSubject% -Body (%EmailBody% | out-string) -SmtpServer %EmailServer%" 
powershell "Send-MailMessage -From %EmailFrom% -To %EmailTo% -Subject %EmailSubject% -Body %EmailBody% -SmtpServer %EmailServer%" 

goto :EOF