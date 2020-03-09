@echo off
cls

set MoveDirection=Failback

cd /D D:\SqlServerStuff\@@Failover

echo.
powershell .\scripts\Move.Cluster.ps1 %MoveDirection% > output\%MoveDirection%.out 2>&1

echo.
echo Errorlevel: %errorlevel%

notepad output\%MoveDirection%.out

goto :EOF
