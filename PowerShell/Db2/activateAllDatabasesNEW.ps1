# activates all databases
Set-Item -Path env:DB2CLP -Value "**$$**"

$currentLocation = Get-Location
$outFile = "D:\scripts\Db2\reports\PSactivate.out"
Out-File $outfile -Force

# find all databases in all instances
$iList = db2ilist
foreach ($i in $iList)
{
	Set-Item -path env:DB2INSTANCE -value $i
	$dbDirectory = db2 list db directory on d | Select-String "Alias"
	# activate each database
	foreach ($alias in $dbDirectory)
	{
		[string]$dbString = $alias
		$dbName = ($dbString.Split("=")[1]).trim()
		"Activating $dbName..." | Out-File $outFile -Append
		db2 activate db $dbName | Out-File $outFile -Append
	}
} # end activate loop

Set-Location $currentLocation
Get-Content $outFile
