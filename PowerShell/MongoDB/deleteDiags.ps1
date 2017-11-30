# Deletes backup files older than *n* days

# Set-up variables
$logdir   = "E:\data\diagnostic.data"
$daysback = "-30"

$currentdate = Get-Date
$deldate     = $currentdate.AddDays($daysback)

# Perform delete
Get-ChildItem -Path $logdir | Where-Object { $_.LastWriteTime -lt $deldate } | Remove-Item
