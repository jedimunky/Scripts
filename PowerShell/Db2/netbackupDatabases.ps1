$dblist = "db_st3cp","db_st3ea","db_st3le","db_st3ua","db_st3ad","db_st3td","db_st3sm"

foreach ($database in $dblist) {
    Start-Process -FilePath "D:\temp\db2_backup_db_online.cmd" -ArgumentList $database
    Start-Sleep -Seconds 10
}

do {
    Start-Sleep -Seconds 360
} until ((db2 list utilities show detail) -like "*No data was returned by Database System Monitor*")

$Body = "<HTML><HEAD><META http-equiv=""Content-Type"" content=""text/html; charset=iso-8859-1"" /><TITLE></TITLE></HEAD>"
$Body += "<BODY bgcolor=""#FFFFFF"" style=""font-size: Small; font-family: TAHOMA; color: #000000""><P>"
$EmailTarget = "DBA Application Middleware <DBAApplicationMiddleware@hbf.com.au>"
$EmailFrom = "$env:COMPUTERNAME <$env:COMPUTERNAME@hbf.com.au>"
$EmailSubject = "$env:COMPUTERNAME NetBackup Report"
$EmailSMTPServer = "mail.corp.hbf.com.au"

$fileList = Get-ChildItem -Path D:\scripts\db2\reports\ -Filter *backup.out -Name

foreach($item in $fileList) {
    $file = Get-Content D:\scripts\db2\reports\$item
    $item = $item -Replace("_backup.out", "")
    $item = $item.ToUpper()
    $Body += "$item <br>"

    foreach($line in $file) {
        if ($line.length -gt 1) {
            $Body += "$line"
        }
    }
    $Body += "<br><br>"
}

Send-MailMessage -to $EmailTarget -from $EmailFrom -subject $EmailSubject -smtpserver $EmailSMTPServer -Body $Body -BodyAsHtml
