# Refresh Tibco in SIT2 from Production
$currentLocation = Get-Location
# Get current security
Set-Location D:\scripts\Db2
$InstanceList = .\listAllDb2Databases.ps1
$dblist = $InstanceList.Instances

foreach($item in $dblist)
{
    
}
# Restore redirect
# Rollforward
# Post refresh changes

Set-Location $currentLocation
