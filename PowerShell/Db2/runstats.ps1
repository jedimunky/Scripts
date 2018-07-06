# Reads a control file, prepare a list of tables to runstat, then execute the list

Set-Location D:\scripts\Db2

function mainControl () # read control file
{
    $starttime  = Get-Date -Format "dd/MM/yyyy HH:mm:ss"
    $runlist    = Get-Content -Path runstats.control

    buildStatements $runlist

    $endtime    = Get-Date -Format "dd/MM/yyyy HH:mm:ss"
    $runelapsed = New-TimeSpan -Start $starttime -End $endtime
    
    emailResults $starttime $endtime $runelapsed
}

function buildStatements ($runlist) # build statements for schema
{
    foreach ($line in $runlist) # Do something
    {
        $instance = ($line.split(",")[0])
        $dbname   = ($line.split(",")[1])
        $schema   = ($line.split(",")[2])
        
        $outfile  = .\db2 +o "connect to $dbname"

		$stmt = .\db2 +o ""
        
        "In the $instance instance, for $dbname database, runstat all tables in schema $schema"
    }
}
function execRunstats () # step through runstat list
{
    
}

function emailResults ($starttime, $endtime, $runelapsed) # build statements for schema
{
    $server          = $env:COMPUTERNAME.ToLower()
    $EmailTarget     = "DBA Application Middleware <DBAApplicationMiddleware@hbf.com.au>"
    $EmailFrom       = "$server <$server@hbf.com.au>"
    $EmailSubject    = "$server - Runstats Report"
    $EmailSMTPServer = "mail.corp.hbf.com.au"
    $Body = "<HTML><HEAD><META http-equiv=""Content-Type"" content=""text/html; charset=iso-8859-1"" /><TITLE></TITLE></HEAD>"
    $Body += "<BODY bgcolor=""#FFFFFF"" style=""font-size: x-small; font-family: TAHOMA; color: #000000""><P>"
    $Body += "Runstats for $server started at $starttime<br><br>"
    
    $Body += "<br><br>"
    $Body += "Backup for $server ended at $endtime<br>"
    $Body += "Total time taken for backup $runelapsed<br>"

    Send-MailMessage -to $EmailTarget -from $EmailFrom -subject $EmailSubject -smtpserver $EmailSMTPServer -Body $Body -BodyAsHtml
}

mainControl 
Set-Location D:\scripts\Db2
