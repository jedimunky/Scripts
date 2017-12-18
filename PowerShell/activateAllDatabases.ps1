# activates all databases

# find all databases in all instances
$currentLocation = Get-Location
$dblist  = .\listDb2Directory.ps1
$outFile = "D:\scripts\Db2\reports\PSactivate.out"
Out-File $outfile -Force

# activate each database
foreach ($item in $dblist) {
    $SQLLibCopyBin = $item.SQLLibCopyBin
	$Instance      = $item.Instance
	$dbname        = $item.Database
	$cmdline       = "ACTIVATE DATABASE $dbname"
	
	set-item -path env:DB2CLP      -value $SQLLibCopyBin
    set-item -path env:DB2INSTANCE -value $Instance
	Set-Location $SQLLibCopyBin
	
	$stdErrLog = "D:\temp\stderr.log"
	$stdOutLog = "D:\temp\stdout.log"
	$dbname | Out-File $outFile -Append
	Start-Process -FilePath "$SQLLibCopyBin\db2.exe" -ArgumentList $cmdline -RedirectStandardOutput $stdOutLog -RedirectStandardError $stdErrLog -NoNewWindow -wait
	Get-Content $stdErrLog, $stdOutLog | Out-File $outFile -Append
} # end activate loop

Set-Location $currentLocation
Get-Content $outFile
