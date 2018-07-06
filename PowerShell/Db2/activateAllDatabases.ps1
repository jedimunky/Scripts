# activates all databases

# find all instances
$instlist = db2ilist

# activate each database
foreach ($i in $instlist) { # step through each instance
	Set-Item -path env:DB2INSTANCE -value $i
	$dblist = db2 list db directory on d |sls "name"
	
	foreach ($j in $dblist) { # activate each database
		$db = $j.ToString().Split("=").Trim()[1]
		"Activating $db"
		db2 activate db $db
	}
} # end activate loop
