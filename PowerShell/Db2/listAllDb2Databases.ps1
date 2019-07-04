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

<#--
NodeName DatabaseName
-------- ------------
DB2ECL   DB_ECLP

Port  NodeName HostName
----  -------- --------
50002 DB2ECL   hpvudbtibweb1.corp.hbf.com.au

if ($a[0].NodeName -eq $b[0].NodeName) { $c = ("Database Name: " + $a.DatabaseName[0] + ", Node: " + $a.NodeName[0] + ", Server Name: " + $b. HostName[0] + ", Port Num: " + $b.Port[0] ) }

Database Name: DB_ECLP, Node: DB2ECL, Server Name: hpvudbtibweb1.corp.hbf.com.au, Port Num: 50002
--#>


