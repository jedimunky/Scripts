# Enable Db2 CLP
set-item -path env:DB2CLP -value "**$$**"
# Shortcuts
function db2scripts {Set-Location D:\Scripts\Db2}
Set-Alias ds db2scripts
Set-Alias i db2ilist
Set-Alias np "D:\Program Files (x86)\Notepad++\notepad++.exe"
# Instance shortcuts
function setDB2WEB   {set-item -path env:DB2INSTANCE -value "DB2WEB"}
Set-Alias DB2WEB   setDB2WEB
function setDB2TIBS3 {set-item -path env:DB2INSTANCE -value "DB2TIBS3"}
Set-Alias DB2TIBS3 setDB2TIBS3
function setDB2TIBS2 {set-item -path env:DB2INSTANCE -value "DB2TIBS2"}
Set-Alias DB2TIBS2 setDB2TIBS2
function setDB2TIBD3 {set-item -path env:DB2INSTANCE -value "DB2TIBD3"}
Set-Alias DB2TIBD3 setDB2TIBD3
function setDB2OAUTH {set-item -path env:DB2INSTANCE -value "DB2OAUTH"}
Set-Alias DB2OAUTH setDB2OAUTH
function setDB2ECL   {set-item -path env:DB2INSTANCE -value "DB2ECL"}
Set-Alias DB2ECL   setDB2ECL
# Working directory
Set-Location D:\Scripts\Db2
