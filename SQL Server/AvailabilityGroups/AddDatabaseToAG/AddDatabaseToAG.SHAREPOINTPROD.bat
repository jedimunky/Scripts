@echo off

cd /D D:\SqlServerStuff\AvailabilityGroups\AddDatabaseToAG

set PrimaryInstance=HPVSQL23\SHAREPOINTPROD
set StandbyInstance=HPVSQL24\SHAREPOINTPROD

sqlcmd -S %PrimaryInstance% -d master -b -h -1 -i 001.GenPrimary.sql -o 010.RunPrimary.sql
sqlcmd -S %PrimaryInstance% -d master -b -h -1 -i 002.GenCopy.sql    -o 020.RunCopy.bat
sqlcmd -S %PrimaryInstance% -d master -b -h -1 -i 003.GenStandby.sql -o 030.RunStandby.sql

call "D:\Program Files (x86)\Notepad++\Notepad++.exe" -multiInst -n100000 010.RunPrimary.sql 020.RunCopy.bat 030.RunStandby.sql

sqlcmd -S %PrimaryInstance% -d master -b -h -1 -i 010.RunPrimary.sql -o 110.RunPrimary.out
notepad 110.RunPrimary.out

call 020.RunCopy.bat > 120.RunCopy.out
notepad 120.RunCopy.out

sqlcmd -S %StandbyInstance% -d master -b -h -1 -i 030.RunStandby.sql -o 130.RunStandby.out
notepad 130.RunStandby.out

goto :EOF