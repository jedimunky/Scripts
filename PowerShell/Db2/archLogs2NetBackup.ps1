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

Start-Process -FilePath $StartBackup -ArgumentList $Arguments
