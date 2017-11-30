# Backs up all databases in MongoDB

# Set-up variables
$server    = $env:COMPUTERNAME.ToLower()
$domain    = $env:USERDNSDOMAIN.ToLower()
$hostname  = "$server.$domain"
$portnum   = 27017
$datetime  = Get-Date -Format yyyymmdd.hhmmss
$archive   = "$server.backup.$datetime.gz"
$workdir   = "G:\Backups\"
$outfile   = "G:\Backups\backup_output.txt"
$mongodump = "mongodump.exe"
$mongoauth = "--username `"svc_MongoDB`" --password `"nRo2ZWbvFxQVouKO`" --authenticationDatabase `"admin`""
$arguments = "--host $hostname --port $portnum --archive=$archive --gzip $mongoauth"

# Run backup command
Start-Process -FilePath $mongodump -ArgumentList $arguments -WorkingDirectory $workdir -RedirectStandardError $outfile -Wait

# Set-up email
$EmailTarget = "DBA Application Middleware <DBAApplicationMiddleware@hbf.com.au>"
$EmailFrom = "$server <$server@hbf.com.au>"
$EmailSubject = "$server - Backup Report"
$EmailSMTPServer = "mail.corp.hbf.com.au"
$Body = "<HTML><HEAD><META http-equiv=""Content-Type"" content=""text/html; charset=iso-8859-1"" /><TITLE></TITLE></HEAD>"
$Body += "<BODY bgcolor=""#FFFFFF"" style=""font-size: x-small; font-family: TAHOMA; color: #000000""><P>"
$Attachment =  $outfile

$file = Get-Content $Attachment
foreach($line in $file) {
	$Body += "$line<br>"
}

# Send email
Send-MailMessage -to $EmailTarget -from $EmailFrom -subject $EmailSubject -smtpserver $EmailSMTPServer -Body $Body -BodyAsHtml -Attachments $Attachment
