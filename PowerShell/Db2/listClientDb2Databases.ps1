# Lists cataloged databases on a client
Function global:db ()
{
	$line   = ""
	$dblist = @()

	db2 list db directory | select-string 'alias|node' | convertfrom-stringdata | foreach-object { 
		if ($_."Database alias") { $alias = $_."Database alias" }
		if ($_."Node name")      { $node  = $_."Node name" }
		if ((-not [string]::IsNullOrEmpty($alias)) -and (-not [string]::IsNullOrEmpty($node)))
		{
			$line = New-Object PSObject -Property @{
				"DatabaseName" = $alias
				"NodeName"     = $node
			}
			$dblist += $line
			clear-variable alias
			clear-variable node
		} # end if on alias and node 
	} # end foreach-object

	$dblist | Sort-Object NodeName, DatabaseName
}

# Same shit but for nodes
Function global:nl ()
{
	$hostname = ""
	$nodename = ""
	$portnum  = ""
	$line     = ""
	$nodelist = @()

	db2 list node directory | select-string -NotMatch 'entry|directory' | select-string 'node|host|service' | convertfrom-stringdata | foreach-object { 
		if ($_."Hostname")     { $hostname = $_."Hostname" }
		if ($_."Node name")    { $nodename = $_."Node name" }
		if ($_."Service Name") { $portnum  = $_."Service Name" }
		if ((-not [string]::IsNullOrEmpty($hostname)) -and (-not [string]::IsNullOrEmpty($nodename)) -and (-not [string]::IsNullOrEmpty($portnum)))
		{
			$line = New-Object PSObject -Property @{
				"HostName" = $hostname
				"Port"     = $portnum
				"NodeName" = $nodename
			}
			$nodelist += $line
			clear-variable hostname
			clear-variable nodename
			clear-variable portnum
		} # end if on alias and node 
	} # end foreach-object

	$nodelist | Sort-Object NodeName, HostName, Port
}

# Merge db and nl into one
Function global:alldbs ($search) # Optional search string
{
	$dblist   = db
	$nodelist = nl
	$dbinfo   = @()

	foreach ($db in $dblist)
	{
		$dbnode = $db.NodeName
		$dbname = $db.Databasename
			
		foreach ($node in $nodelist)
		{
			if ($db.NodeName -eq $node.NodeName)
			{
				$line = New-Object PSObject -Property @{
					"HostName" = $node.hostname
					"Port"     = $node.port
					"NodeNode" = $node.nodename
					"DBNode"   = $db.nodename
					"DBName"   = $db.databasename
				}
				$dbinfo += $line
			} # end if nodename match
		} # end foreach node
	} # end foreach database
	
	if ([string]::IsNullOrEmpty($search))
	{
		$dbinfo | Select-Object -Property HostName, Port, DBNode, DBName | Sort-Object HostName, Port, DBNode, DBName | Format-Table -AutoSize
	} else {
		$dbinfo | Where-Object {$_ -match $search} | Select-Object -Property HostName, Port, DBNode, DBName | Sort-Object HostName, Port, DBNode, DBName | Format-Table -AutoSize
	}		
}
