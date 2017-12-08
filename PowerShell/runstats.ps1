# Reads a control file, prepare a list of tables to runstat, then execute the list

Set-Location D:\scripts\Db2

function mainControl () # build statements for schema
{
    $starttime     = Get-Date -Format "dd/MM/yyyy HH:mm:ss"
    $list          = Get-Content runstats.control



    $endtime       = Get-Date -Format "dd/MM/yyyy HH:mm:ss"
    $backupelapsed = New-TimeSpan -Start $backupstart -End $backupend
    
    emailResults $?
}

function buildStatements ($list) # build statements for schema
{
    foreach ($line in $list) # Do something
    {
        $instance = ($line.split(",")[0])
        $dbname   = ($line.split(",")[1])
        $schema   = ($line.split(",")[2])
        
        "In the $instance instance, for $dbname database, runstat all tables in schema $schema"
    }
}

function execRunstats () # step through runstat list
{
    
}

function emailResults () # build statements for schema
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
    $Body += "Backup for $server ended at $backupend<br>"
    $Body += "Total time taken for backup $backupelapsed<br>"
    }
}

Set-Location D:\scripts\Db2
