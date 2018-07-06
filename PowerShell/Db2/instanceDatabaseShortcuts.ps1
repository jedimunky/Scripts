# Sets up shortcuts to change instance and connect to databases

Set-Location D:\scripts\Db2
$InstanceList = .\listAllDb2Databases.ps1

if ($PSVersionTable.PSVersion.Major -le 2)
{
	$a = $InstanceList.Instances | Select Instance | Sort-Object Instance | Get-Unique -AsString
	$instances = foreach ($i in $a) { $i.Instance }
	$b = $InstanceList.Instances | Select Database | Sort-Object Database | Get-Unique -AsString
	$databases = foreach ($j in $b) { $j.Database }
} else {
	$dblist    = $InstanceList.Instances
	$instances = $dblist.Instance | Get-Unique
	$databases = $dblist.Database | Get-Unique
}

# set up instance shortcuts
foreach ($instance in $instances)
{
	if ($instance -ne "DB2")
	{
		$setInst     = "{Set-Item -path env:DB2INSTANCE -value `"$instance`"
						 Write-Host ""set DB2INSTANCE=$instance""}"
		$runFunction = "Function global:$instance $setInst"
		Invoke-Expression $runFunction
	}
} # end instance loop

# set up connect to database
foreach ($database in $databases)
{
	$connDb      = "{db2 connect to $database}"
	$runFunction = "Function global:$database $connDb"
	Invoke-Expression $runFunction
} # end connect loop
