$Version = "0.1"
$Global:Backup_Script_UpdatePath = "\\NetworkPath\Backup_Client_w_Dedupe.ps1"
$Local_Backup_Script = "D:\LocalPath\Backup_Client_w_Dedupe.ps1"
$Backup_Path = "\\SomeFolder"

Function Check_For_Updates ()
{
    $CheckForUpdates = Get-Content -Path $Global:Backup_Script_UpdatePath
    If ($CheckForUpdates[0].Split('"')[1] -gt $Version)
    {Copy-Item -Path $Global:Backup_Script_UpdatePath -Destination $Local_Backup_Script -Force -Confirm:$false}
}

Check_For_Updates
