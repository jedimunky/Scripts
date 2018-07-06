# Script to remove comment lines from Db2 restore ... redirect 

#Set-up variables
$inFile  = "redirect.txt"
$outFile = "redirect.clp"

# Get the database name
$oldDbName = (Select-String -Path $inFile -Pattern "database" -List).ToString().split("{ }")[2]
$newDbName = (Select-String -Path $inFile -Pattern "INTO " -List).ToString().split("{ }")[1]

# Remove comments and empty lines, format nicely
$file = Get-Content $inFile
foreach($line in $file) {
	if (($line.Length -gt 0) -and ($line -notlike "--*" -and $line -notlike "UPDATE COMMAND*" -and $line -notlike "SET CLIENT*") `
							 -or  ($line -like "-- NEWLOG*" `
							 -or   $line -like "-- LOGTAR*" `
							 -or   $line -like "-- SET*" `
							 -or   $line -like "-- ON*" `
							 -or   $line -like "-- ;*")) 
	{
		$trim += "$line " -replace ("-- ; ","; ") `
						  -replace ("; ",";`n") `
						  -replace ("-- SET ","`nSET ") `
						  -replace ("-- ON ","ON ") `
						  -replace ("-- LOGTARGET '<directory>'","`nLOGTARGET 'F:\temp_backup\logtarget\$newDbName'") `
						  -replace ("-- NEWLOGPATH ","`nNEWLOGPATH ") `
  						  -replace ("\\$oldDbName","\$newDbName") `
						  -replace ("NODE0000\\LOGSTREAM0000\\","") `
						  -replace ("REDIRECT","`nREDIRECT")
	}
}

# Clean up Storage Group if present
if ($trim -match "STORAGE_GROUPS")
{
	$lines = (($trim -split '\n'))
	$lines[0] = $lines[0] -replace "ON\s['\w\\\:]+\s"
	New-Item -Path 'E:\STORAGE_GROUPS\'    -Name $newDbName -ItemType directory -Force
}

# Create required directories
New-Item -Path 'E:\CONTAINERS\'            -Name $newDbName -ItemType directory -Force
New-Item -Path 'F:\temp_backup\logtarget\' -Name $newDbName -ItemType directory -Force
New-Item -Path 'L:\db2_logs\'              -Name $newDbName -ItemType directory -Force

$lines | Out-File $outFile -Encoding ASCII
np $outFile
