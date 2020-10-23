# Backs up all databases

# Find and backup all active databases in all instances
Set-Location D:\scripts\Db2
.\buildDb2conf.ps1
$InstanceList = .\listAllDb2Databases.ps1
$dblist = $InstanceList.Instances

# Set up reports
$dirpath = "D:\scripts\db2\reports"
$oldpath = "$dirpath\Old"
if (!(Test-Path $oldpath))
{
	New-Item -ItemType Directory -Path $oldpath
} # end if

$fileList = Get-ChildItem -Path $dirpath -Filter *backup.out -Name
foreach($item in $fileList)
{
	Move-Item -Path $dirpath\$item -Destination $oldpath -force
} # end for loop

# Set-up backup command variables
$action   = "ONLINE"
$nblib    = "`'D:\Program Files\VERITAS\NetBackup\bin\nbdb2.dll`'"
$sessions = "OPEN 2 SESSIONS DEDUP_DEVICE WITH 4 BUFFERS BUFFER 1024"

# Clear down job list
Get-Job | Remove-Job -Force

# Kick off backups
$backupstart  = Get-Date -Format "dd/MM/yyyy HH:mm:ss"
$sleeptimer   = 20
$i            = 0
$MaxThreads   = 4

foreach ($item in $dblist)
{
    While ($(Get-Job -state running).count -ge $MaxThreads)
    {
        Write-Progress  -Activity "Creating Backup List" -Status "Waiting for threads to close" -PercentComplete ($i / $dblist.count * 100) -CurrentOperation "$i threads created - $($(Get-Job -state running).count) threads open" 
        Start-Sleep -Seconds $sleeptimer
    }

    $SQLLibCopyBin = $item.SQLLibCopyBin
	$Instance      = $item.Instance
	$dbname        = $item.Database
	$cmdline       = "/C `"db2 BACKUP DATABASE $dbname $action LOAD $nblib $sessions`""
	Set-Item -path env:DB2CLP      -value $SQLLibCopyBin
	Set-Item -path env:DB2INSTANCE -value $Instance

    $i++
    Start-Job  -ScriptBlock {
		param ($SQLLibCopyBin,$Instance,$cmdline,$dbname)
		Set-Item -path env:DB2CLP -value $SQLLibCopyBin
		Set-Item -path env:DB2INSTANCE -value $Instance
		Set-Location $SQLLibCopyBin
		Start-Process -FilePath "cmd.exe" -ArgumentList $cmdline -Wait -RedirectStandardOutput "D:\scripts\db2\reports\$Instance.$dbname`_backup.out" -NoNewWindow
	} -Name $dbname -ArgumentList @($SQLLibCopyBin,$Instance,$cmdline,$dbname)
    
    Write-Progress  -Activity "Creating Backup List" -Status "Starting threads" -PercentComplete ($i / $dblist.count * 100) -CurrentOperation "$i threads created - $($(Get-Job -state running).count) threads open" 

    Start-Sleep -Seconds $sleeptimer
}

# Wait for background jobs to complete
While (@(Get-Job -State Running).count -gt 0)
{
    $BackupsStillRunning = ""
    ForEach ($System  in $(Get-Job -state running))
    {
        $BackupsStillRunning += ", $($System.name)"
    }
    $BackupsStillRunning = $BackupsStillRunning.Substring(2)
    Write-Progress  -Activity "Creating Backup List" -Status "$($(Get-Job -State Running).count) backups remaining" -PercentComplete ($(Get-Job -State Completed).count / $(Get-Job).count * 100) -CurrentOperation "$BackupsStillRunning" 
	Start-Sleep -Seconds $sleeptimer
}

#Check output files have been written
$sleeptimer = 20
$timeout    = 0
$maxtime    = 3600 # 3600 seconds = 1 hr

While ((@(Get-ChildItem -Path D:\scripts\db2\reports\*backup.out) | Where-Object {$_.Length -eq 0}) -and $timeout -le $maxtime) {
    $totnumfiles     = @(Get-ChildItem -Path D:\scripts\db2\reports\*backup.out).Count
    $totnumfileszero = (@(Get-ChildItem -Path D:\scripts\db2\reports\*backup.out) | Where-Object {$_.Length -eq 0}).Count
    Write-Progress  -Activity "Creating Backup List" -Status "Waiting for outfile(s) to complete" -PercentComplete ($totnumfileszero / $totnumfiles * 100)
    $timeout += $sleeptimer
    Start-Sleep -Seconds $sleeptimer
}

# Copy Archive Logs to NetBackup - *** MUST RUN AS ADMIN ***
$month      = (Get-Date).Month
$dayofmonth = (Get-Date).Day
$dayofweek  = (Get-Date).DayOfWeek

switch ($env:COMPUTERNAME[1])
{
	{$env:COMPUTERNAME[1] -eq "T"} {$locale = "DEV"  ; break}
	{$env:COMPUTERNAME[1] -eq "R"} {$locale = "REL"  ; break}
	{$env:COMPUTERNAME[1] -eq "P"} {$locale = "PROD" ; break}
}

if ($dayofmonth -le 7 -and $dayofweek -eq "Friday") 
{
    if ($month -eq 1) # First Friday of the year 
    {
        $retain = "YEARLY"
    } else {          # First Friday of the month
        $retain = "MONTHLY"
    }
} else {              # Daily schedule 
	$retain = "DAILY"
} #end if
$schedule = "HO_" + $locale + "_USER_BACKUP_" + $retain

$logpath     = "F:\db2_archive_logs"
$Arguments   = "-S netbackup.corp.hbf.com.au -p HO_" + $locale + "_DB2_WINFS -s $schedule $logpath"
$StartBackup = "D:\Program Files\VERITAS\NetBackup\bin\bpbackup.exe"

# D:\Program Files\VERITAS\NetBackup\bin\bpbackup.exe -S netbackup.corp.hbf.com.au -p HO_DEV_DB2_WINFS -s HO_DEV_USER_BACKUP_DAILY F:\db2_archive_logs

Start-Process -FilePath $StartBackup -ArgumentList $Arguments

# Delete old backups and logs
& D:\scripts\Db2\deleteBackupsLogs.ps1

# Build email
$server          = $env:COMPUTERNAME.ToLower()
$EmailTarget     = "DBA Application Middleware <DBAApplicationMiddleware@hbf.com.au>"
$EmailFrom       = "$server <$server@hbf.com.au>"
$EmailSubject    = "$server - NetBackup Report"
$EmailSMTPServer = "wmail.corp.hbf.com.au"
$Body            = "<HTML><HEAD><META http-equiv=""Content-Type"" content=""text/html; charset=iso-8859-1"" /><TITLE></TITLE></HEAD>"
$Body           += "<BODY bgcolor=""#FFFFFF"" style=""font-size: x-small; font-family: TAHOMA; color: #000000""><P>"
$Body           += "Backup for $server started at $backupstart<br><br>"

$fileList        = Get-ChildItem -Path D:\scripts\db2\reports\ -Filter *backup.out -Name
$ctrlM           = "Backup successful"

foreach($item in $fileList) 
{
    $file  = Get-Content D:\scripts\db2\reports\$item
    $item  = $item -Replace("_backup.out", "")
    $item  = $item.ToUpper()
    $Body += "$item <br>"

    foreach($line in $file) 
    {
        if ($line.length -gt 1) 
        {
            $line = $line -Replace([char]12,"")
			$Body += "$line"
            if ($line -notlike "*Backup successful*") 
            {
				$ctrlM = "ERROR: $server backup failed for $item"
			}
        }
    }
    $Body += "<br><br>"
}

$backupend     = Get-Date -Format "dd/MM/yyyy HH:mm:ss"
$backupelapsed = New-TimeSpan -Start $backupstart -End $backupend
$Body         += "Backup for $server ended at $backupend<br>"
$Body         += "Total time taken for backup $backupelapsed<br>"

Send-MailMessage -to $EmailTarget -from $EmailFrom -subject $EmailSubject -smtpserver $EmailSMTPServer -Body $Body -BodyAsHtml

Write-Host $ctrlM
Set-Location D:\scripts\Db2