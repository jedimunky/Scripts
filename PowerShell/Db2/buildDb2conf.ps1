# Build NetBackup db2.conf file for all databases

# Get NetBackup install location, Db2 extension folder
$currentLocation = Get-Location
$registryPath    = "HKLM:\SOFTWARE\Veritas\NetBackup"
Set-Location $registryPath

$registryDetails = Get-ChildItem | Get-ItemProperty
$netbackupDir    = $registryDetails."INI Directory"
$DbExtDb2        = "\DbExt\DB2"
$DbExtDb2dir     = $netbackupDir + $DbExtDb2

# Find all active databases in all instances
Set-Location D:\scripts\Db2
$InstanceList = .\listAllDb2Databases.ps1
$dblist = $InstanceList.Instances
$dblist = $dblist | Select-Object -Property SQLLibCopyBin, Instance, Database, DatabasePath | sort SQLLibCopyBin, Instance, Database
$db2conf = @()

# Determine schedule
$dayofmonth = (Get-Date).Day
$month      = (Get-Date).Month
$dayofweek  = (Get-Date).DayOfWeek

switch ($env:COMPUTERNAME[1])
{
	{$env:COMPUTERNAME[1] -eq "T"} {$locale = "DEV"  ; break}
	{$env:COMPUTERNAME[1] -eq "R"} {$locale = "REL"  ; break}
	{$env:COMPUTERNAME[1] -eq "P"} {$locale = "PROD" ; break}
}

if ($dayofmonth -le 7 -and $dayofweek -eq "Friday") 
{
    if ($month -eq 1) # First Friday of the year 
    {
        $retain = "YEARLY"
    } else {          # First Friday of the month
        $retain = "MONTHLY"
    }
} else {              # Daily schedule 
	$retain = "DAILY"
} #end if

$objecttype   = "OBJECTTYPE DATABASE"
$policy       = "POLICY HO_" + $locale + "_DB2_DB"
$schedule     = "SCHEDULE HO_" + $locale + "_APPLICATION_BACKUP_" + $retain + ""
$endoper      = "ENDOPER"
$space        = ""

# Build db2.conf for each SQLLIB 
$outfile      = "db2.conf"
foreach ($item in $dblist)
{
	$db2conf += "DATABASE "+$item.Database
	$db2conf += $objecttype
        $db2conf += $policy
	$db2conf += $schedule
	$db2conf += $endoper
	$db2conf += $space
}

Set-Location $DbExtDb2dir
$db2conf | Out-File $outfile -Encoding ascii

Set-Location $currentLocation
