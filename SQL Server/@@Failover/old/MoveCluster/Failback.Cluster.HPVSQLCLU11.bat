@echo off
cls

set ClusterName=HPVSQLCLU11
set MoveDirection=Failback

cd /D D:\SqlServerStuff\@@Failover\MoveCluster

echo.
powershell .\Move.Cluster.%ClusterName%.ps1 %MoveDirection% > %MoveDirection%.out 2>&1

echo.
echo Errorlevel: %errorlevel%

notepad %MoveDirection%.out

goto :EOF
