# Deletes backup files older than *n* days

# Set-up variables
$backupdir   = "G:\Backups"
$daysback    = "-7"

$currentdate = Get-Date
$deldate     = $currentdate.AddDays($daysback)

# Perform delete
Get-ChildItem -Path $backupdir | Where-Object {	$_.LastWriteTime -lt $deldate } | Remove-Item
