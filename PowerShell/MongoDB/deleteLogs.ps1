# Deletes backup files older than *n* days

# Set-up variables
$logdir   = "F:\MongoDB"
$daysback = "-7"

$currentdate = Get-Date
$deldate     = $currentdate.AddDays($daysback)

# Perform delete
Get-ChildItem -Path $logdir -Recurse | Where-Object { $_.LastWriteTime -lt $deldate } | Remove-Item
