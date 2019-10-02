$EmailTarget = "DBA Application Middleware <DBAApplicationMiddleware@hbf.com.au>"
$EmailFrom = "$env:COMPUTERNAME <$env:COMPUTERNAME@hbf.com.au>"
$EmailSubject = "$env:COMPUTERNAME Backup Report"
$EmailSMTPServer = "mail.corp.hbf.com.au"

$Body = "<HTML><HEAD><META http-equiv=""Content-Type"" content=""text/html; charset=iso-8859-1"" /><TITLE></TITLE></HEAD>"
$Body += "<BODY bgcolor=""#FFFFFF"" style=""font-size: x-small; font-family: TAHOMA; color: #000000""><P>"
$Body += Get-Content -Path "G:\Backups\backup_output.txt"

$Attachment =  "G:\Backups\backup_output.txt"

Send-MailMessage -SmtpServer "$EmailSMTPServer" -To "$EmailTarget" -From "$EmailFrom" -Subject "$EmailSubject" -Body "$Body" -Attachments "$Attachment" -BodyAsHtml