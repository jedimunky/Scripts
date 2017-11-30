# Build NetBackup db2.conf file for all databases

# Find all active databases in all instances
Set-Location D:\scripts\Db2
$dblist = .\listAllDb2Databases.ps1
$dblist = $dblist | Select-Object -Property SQLLibCopyBin, Instance, Database, DatabasePath | sort SQLLibCopyBin, Instance, Database
$db2conf = ""

# Determine schedule
$dayofmonth = (Get-Date).Day
$dayofweek  = (Get-Date).DayOfWeek

if ($dayofmonth -le 7 -and $dayofweek -eq "Friday")
{
	# Monthly schedule 14 days retention then to tape
	$schedule = "SCHEDULE HO_REL_APPLICATION_BACKUP_MONTHLY`n"
} else 
{
	# Daily schedule 14 days retention
	$schedule = "SCHEDULE HO_REL_APPLICATION_BACKUP_DAILY`n"
}
$objecttype   = "OBJECTTYPE DATABASE`n"
$policy       = "POLICY HO_REL_DB2_DB`n"
$endoper      = "ENDOPER`n"
$space        = "`n"

# Build db2.conf for each SQLLIB 
if (@($dblist).count -eq 1) { 
	$savedsqllib = $dblist.SQLLibCopyBin -Replace [regex]::escape("\BIN"), ""
} else { 
	$savedsqllib = $dblist[0].SQLLibCopyBin -Replace [regex]::escape("\BIN"), ""
}
$outfile     = "db2.conf"

foreach ($item in $dblist)
{
	if (($item.SQLLibCopyBin -Replace [regex]::escape("\BIN"), "") -ne $savedsqllib)
	{
		Set-Location $savedsqllib
		$db2conf | Out-File $outfile
		$db2conf = ""
		$savedsqllib = $item.SQLLibCopyBin -Replace [regex]::escape("\BIN"), ""
	}
	$db2conf += "DATABASE "+$item.Database+"`n"
	$db2conf += $objecttype
    $db2conf += $policy
	$db2conf += $schedule
	$db2conf += $endoper
	$db2conf += $space
}

Set-Location $savedsqllib
$db2conf | Out-File $outfile

Set-Location D:\scripts\Db2
