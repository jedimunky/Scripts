# List all the installed Db2 copies
Function global:copyList ()
{
	$instList = .\listAllDb2Databases
	$SQLLibs  = $instList.SQLLibs
	Return $SQLLibs
}

# Get current path
Function global:getPath ()
{
	$origPath = $env:Path
	Return $origPath
}

# Get noSQL path
Function global:noSQLPath ()
{
	$origPath  = getPath
	$pathList  = $origPath.Split(";")
	$noSQLPath = $pathList | Select-String -Pattern "SQLLIB" -notmatch
	$newPath   = ""
	foreach ($i in $noSQLPath)
	{
		$newPath += $i
		$newPath += ";"
	}
	$newPath = $newPath.TrimEnd(";")
	Return $newPath
}

# Change path based on selected Db2 copy
Function global:setCopy ($copyName, $copyPath)
{
	$noSQLPath = noSQLPath
	$bin  = $copyPath+"BIN"
	$func = $copyPath+"FUNCTION"
	$repl = $copyPath+"SAMPLES\REPL"
	$SQLPath = $bin+";"+$func+";"+$repl+";"
	$db2CopyPath = $SQLPath + $noSQLPath
	Set-Item -Path env:Path -Value $db2CopyPath
	Set-Item -Path env:DB2CLP -Value $bin
	Return "Switched to $copyName"
}

# Set up: reads copyList, creates functions to amend path for each
$copylist = copyList
foreach ($copy in $copylist)
{
	$copyName = $copy.SQLLibCopyName
	$copyPath = $copy.SQLLibCopyPath
	$setCopy  = "{setCopy $copyName $copyPath}"
	$runFunction = "Function global:$copyName $setCopy"
	Invoke-Expression $runFunction
}
