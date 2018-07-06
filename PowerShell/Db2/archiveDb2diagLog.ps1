# Archive the db2diag.log file and delete logs older than 15 days
$currentLocation = Get-Location

# Get instance directories
$InstanceList = .\listAllDb2Databases.ps1
$dblist = $InstanceList.Instances

# Set-up days to keep
$currentdate = Get-Date
$daysback    = "-15"
$deldate     = $currentdate.AddDays($daysback)

# Loop through instances and delete old logs
foreach ($instance in ($dblist.Instance | Get-Unique))
{
	$sqllib = $dblist.SQLLibCopyBin.Substring(0,13) | Get-Unique
	$logdir = $sqllib + "\" + $instance
	
	set-item -path env:DB2CLP      -value ($dblist.SQLLibCopyBin | Get-Unique)
    set-item -path env:DB2INSTANCE -value $instance
	Set-Location $env:DB2CLP
	
	.\db2diag.exe -archive
	
	Get-ChildItem db2diag*.log* -Path $logdir | Where-Object { $_.LastWriteTime -lt $deldate } | Remove-Item
	
} # End loop

Set-Location $currentLocation
