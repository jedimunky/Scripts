# Sets up shortcuts to connect to databases

$dblist = db2 list db directory | Select-String alias | Sort-Object

# set up connect to database
foreach ($item in $dblist)
{
	[string]$dbname = $item
	$dbname         = ($dbname.split("=")[1]).trim()
	$connDb         = "{db2 connect to $dbname user $env:USERNAME}"
	$runFunction    = "Function global:$dbname $connDb"
	Invoke-Expression $runFunction
} # end connect loop
