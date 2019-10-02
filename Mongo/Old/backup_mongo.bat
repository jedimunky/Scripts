::echo off

G:
cd G:\Backups

:: format the date
for /f "tokens=1-2 delims= " %%X in ('echo %DATE%')     do set DDMMYYYY=%%Y
for /f "tokens=1-3 delims=/" %%A in ('echo %DDMMYYYY%') do set YYYYMMDD=%%C%%B%%A
:: format the time
for /f "tokens=1-3 delims=:" %%D in ('echo %TIME%')     do set HHMMSS=%%D%%E%%F
:: remove split seconds
for /f "tokens=1-2 delims=." %%G in ('echo %HHMMSS%')   do set HHMMSS=%%G

mongodump --host %COMPUTERNAME%.corp.hbf.com.au --port 27017 --archive=%computername%.backup.%YYYYMMDD%.%HHMMSS%.gz --gzip 2>backup_output.txt

powershell -ExecutionPolicy ByPass -File D:\Scripts\ps_email.ps1
