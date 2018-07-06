$InstanceList = .\listAllDb2Databases.ps1
$dblist = $InstanceList.Instances
$currentLocation = Get-Location
$report = ""

foreach ($item in $dblist) 
{
	$SQLLibCopyBin = $item.SQLLibCopyBin
	$Instance      = $item.Instance
	$Database      = $item.Database
	
	set-item -path env:DB2CLP      -value $SQLLibCopyBin
	set-item -path env:DB2INSTANCE -value $Instance
    Set-Location -path $env:DB2CLP
	$db2pd = (.\db2pd -hadr -db $Database)
	
	if ($db2pd[4] -ne "HADR is not active.") {
		$hadrrole   = $db2pd.trim() | Select-String -Pattern "HADR_ROLE"
		$hadrstate  = $db2pd.trim() | Select-String -Pattern "HADR_STATE"
		$hadrstatus = $db2pd.trim() | Select-String -Pattern "HADR_CONNECT_STATUS "
		$hadrloggap = $db2pd.trim() | Select-String -Pattern "HADR_LOG_GAP"
		
		$role   = ($hadrrole.ToString()).Split("=")[1].Trim()
		$state  = ($hadrstate.ToString()).Split("=")[1].Trim()
		$status = ($hadrstatus.ToString()).Split("=")[1].Trim()
		$loggap = ($hadrloggap.ToString()).Split("=")[1].Trim()
		
		$report += "Database: $Database`n"
		$report += "$hadrrole`n"
		$report += "$hadrstate`n"
		$report += "$hadrstatus`n"
		$report += "$hadrloggap`n"
		if (($state -ne "PEER") -and ($status -ne "CONNECTED")) {
			$report += "WARNING: Unusual HADR state, please investigate.`n"
		}
		$report += "`n"
	} else {
		$report += "Database: $Database`n"
		$report += $db2pd[4]
		$report += "`n`n"
	}
}

Set-Location $currentLocation
$report
