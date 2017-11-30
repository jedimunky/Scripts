# Backs up all databases

# Find and backup all active databases in all instances
Set-Location D:\scripts\Db2
.\buildDb2conf.ps1
$dblist = .\listAllDb2Databases.ps1

# Set up reports
$dirpath = "D:\scripts\db2\reports\"
$oldpath = "$dirpath\Old"
if (!(Test-Path $oldpath)) {
	New-Item -ItemType Directory -Path $oldpath
}

$fileList = Get-ChildItem -Path $dirpath -Filter *backup.out -Name
foreach($item in $fileList) {
	Move-Item -Path $dirpath\$item -Destination $oldpath -force
}

# Kick off backups
$backupstart = Get-Date -Format "dd/MM/yyyy HH:mm:ss"
foreach ($item in $dblist) {
    set-item -path env:DB2CLP -value $item.SQLLibCopyBin
    set-item -path env:DB2INSTANCE -value $item.Instance
    Start-Process -FilePath "D:\scripts\db2\db2_backup_db_online.cmd" -ArgumentList $item.SQLLibCopyBin, $item.Database, $item.Instance
    Start-Sleep -Seconds 10
}

# Wait for all backups to complete
foreach ($item in $dblist) {
    set-item -path env:DB2CLP -value $item.SQLLibCopyBin
    set-item -path env:DB2INSTANCE -value $item.Instance
	$bin = $env:DB2CLP
	Set-Location $bin
    while ((.\db2.exe list utilities show detail) -notlike "*No data was returned by Database System Monitor*") {Start-Sleep -Seconds 300}
}

# Copy Archive Logs to NetBackup - *** MUST RUN AS ADMIN ***
$dayofmonth = (Get-Date).Day
$dayofweek  = (Get-Date).DayOfWeek
if ($dayofmonth -le 7 -and $dayofweek -eq "Friday")
{
	# Monthly schedule 14 days retention then to tape
	$schedule = "HO_REL_USER_BACKUP_MONTHLY"
} else 
{
	# Daily schedule 14 days retention
	$schedule = "HO_REL_USER_BACKUP_DAILY"
}
$logpath     = "F:\db2_archive_logs"
$Arguments   = "-S netbackup.corp.hbf.com.au -p HO_REL_DB2_WINFS -s $schedule $logpath"
$StartBackup = "D:\Program Files\VERITAS\NetBackup\bin\bpbackup.exe"

Start-Process -FilePath $StartBackup -ArgumentList $Arguments

# Build email
$server = $env:COMPUTERNAME.ToLower()
$EmailTarget = "DBA Application Middleware <DBAApplicationMiddleware@hbf.com.au>"
$EmailFrom = "$server <$server@hbf.com.au>"
$EmailSubject = "$server - NetBackup Report"
$EmailSMTPServer = "mail.corp.hbf.com.au"
$Body = "<HTML><HEAD><META http-equiv=""Content-Type"" content=""text/html; charset=iso-8859-1"" /><TITLE></TITLE></HEAD>"
$Body += "<BODY bgcolor=""#FFFFFF"" style=""font-size: x-small; font-family: TAHOMA; color: #000000""><P>"
$Body += "Backup for $server started at $backupstart<br><br>"

$fileList = Get-ChildItem -Path D:\scripts\db2\reports\ -Filter *backup.out -Name
$ctrlM = "Backup successful"

foreach($item in $fileList) {
    $file = Get-Content D:\scripts\db2\reports\$item
    $item = $item -Replace("_backup.out", "")
    $item = $item.ToUpper()
    $Body += "$item <br>"

    foreach($line in $file) {
        if ($line.length -gt 1) {
            $line = $line -Replace([char]12,"")
			$Body += "$line"
			if ($line -notlike "*Backup successful*") {
				$ctrlM = "ERROR: $server backup failed, please investigate"
			}
        }
    }
    $Body += "<br><br>"
}

$backupend = Get-Date -Format "dd/MM/yyyy HH:mm:ss"
$Body += "Backup for $server ended at $backupend<br>"
$backupelapsed = New-TimeSpan -Start $backupstart -End $backupend
$Body += "Total time taken for backup $backupelapsed<br>"

Send-MailMessage -to $EmailTarget -from $EmailFrom -subject $EmailSubject -smtpserver $EmailSMTPServer -Body $Body -BodyAsHtml

Write-Host $ctrlM
Set-Location D:\scripts\Db2
