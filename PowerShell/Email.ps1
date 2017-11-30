# Build email
$server = $env:COMPUTERNAME.ToLower()
$EmailFrom = "$server <$server@hbf.com.au>"
$EmailSubject = "$server - NetBackup Report"
$EmailTarget = "DBA Application Middleware <DBAApplicationMiddleware@hbf.com.au>"
$EmailSMTPServer = "mail.corp.hbf.com.au"
$Body = "<HTML><HEAD><META http-equiv=""Content-Type"" content=""text/html; charset=iso-8859-1"" /><TITLE></TITLE></HEAD>"
$Body += "<BODY bgcolor=""#FFFFFF"" style=""font-size: Small; font-family: TAHOMA; color: #000000""><P>"

$fileList = Get-ChildItem -Path D:\scripts\db2\reports\ -Filter *backup.out -Name
$rc = 0

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
				$rc = 1
			}
        }
    }
    $Body += "<br><br>"
}

Send-MailMessage -to $EmailTarget -from $EmailFrom -subject $EmailSubject -smtpserver $EmailSMTPServer -Body $Body -BodyAsHtml
