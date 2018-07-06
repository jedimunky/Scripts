# Deletes backup files older than *n* days

# Set-up variables
$backupdir   = "F:\backup"
$logsdir     = "F:\db2_archive_logs"
$daysback    = "-3"

$currentdate = Get-Date
$deldate     = $currentdate.AddDays($daysback)

# Perform delete
Get-ChildItem -File *.001 -Path $backupdir -Recurse | Where-Object { $_.LastWriteTime -lt $deldate } | Remove-Item
Get-ChildItem -File *.LOG -Path $logsdir   -Recurse | Where-Object { $_.LastWriteTime -lt $deldate } | Remove-Item
