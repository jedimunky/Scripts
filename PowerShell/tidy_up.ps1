# Script to remove comment lines from Db2 restore ... redirect 

#Set-up variables
$infile  = "redirect.txt"
$outfile = "redirect.clp"

# Get the database name
$dbname = Select-String -Path .\redirect.txt -Pattern "database" -List
$dbname = $dbname.ToString().split("{ }")[2]

# Remove comments and empty lines, format nicely
$file = Get-Content $infile
foreach($line in $file) {
	if (($line.Length -gt 0) -and ($line -notlike "--*" -and $line -notlike "UPDATE COMMAND*" -and $line -notlike "SET CLIENT*") -or `
								  ($line -like "-- NEWLOG*" -or `
								   $line -like "-- LOGTAR*")) {
		$trim += "$line " -replace ("; ",";`n") `
						  -replace ("-- LOGTARGET '<directory>'","`nLOGTARGET 'F:\temp_backup\logtarget\$dbname'") `
						  -replace ("-- NEWLOGPATH","`nNEWLOGPATH") `
						  -replace ("REDIRECT","`nREDIRECT")
	}
}

$trim | Out-File $outfile
