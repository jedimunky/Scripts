$sleeptimer = 20
$timeout    = 0
$maxtime    = 30 # 7200 seconds = 2 hrs

While ((($(Get-Job -State Running).count -gt 0) -or @(Get-ChildItem *backup.out | where {$_.Length -eq 0 }).Count -gt 0) -and $timeout -le $maxtime)
{
    $BackupsStillRunning = ""
    ForEach ($jobbie  in $(Get-Job -state running))
    {
        $BackupsStillRunning += ", $($jobbie.name)"
    }
    $BackupsStillRunning = $BackupsStillRunning.Substring(2)
    Write-Progress  -Activity "Creating Backup List" -Status "$($(Get-Job -State Running).count) backups remaining" -PercentComplete ($(Get-Job -State Completed).count / $(Get-Job).count * 100) -CurrentOperation "$BackupsStillRunning" 
    $timeout += $sleeptimer
	"Total time is $timeout, Snoozing $sleeptimer seconds..."
	Start-Sleep -Seconds $sleeptimer
}
"And we're done."
