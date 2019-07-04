$currentLocation = Get-Location

Function GetTimestampAndSize ($RestoreItemsPart) 
{
    $RestoreInstance = ([String]$RestoreItemsPart.split("\")[4]).Split(".")[2]
    $RestoreDBName = [String]$RestoreItemsPart.split("\")[1]
    $FirstPart = '-rw------- SYSTEM    SYSTEM'
    $PartSize = $RestoreItemsPart.split("\")
    $PartSize = $PartSize[0].remove(0,$FirstPart.length).TrimStart(" ").split(" ")[0]
    If ($PartSize.Substring($PartSize.length - 1, 1) -eq "K")
    {
        $PartSize = [int32]$PartSize.replace("K","") * 1024
    }else{
        $PartSize = [int32]$PartSize
    }
	$BackupTimeStamp = $RestoreItemsPart.split("\")[3]
	$BackupDateTime = Get-Date([datetime]::ParseExact($BackupTimeStamp,'yyyyMMddHHmmss', $null)) -Format 'dd MMMM yyyy HH:mm:ss'
    $Line = New-Object PSObject -Property @{
			"DatabaseInstance" = $RestoreInstance
            "DatabaseName" = $RestoreDBName
            "BackupDateTime" = $BackupDateTime
            "DatabasePartSize" = $PartSize
            "BackupTimeStamp" = $BackupTimeStamp
        }
    Return $Line
}

Function GetAvailableRestores ($RestoreFromFQDN,$NetbackupInstallDir)
{
    Set-Location -Path "D:\Program Files\VERITAS\Netbackup\Bin"
	$server    = $env:COMPUTERNAME.ToLower()
	$domain    = $env:USERDNSDOMAIN.ToLower()
    $RestoreFromFQDN = "$server.$domain"
    $RestoreItems = (.\bplist.exe -l -C $RestoreFromFQDN -t 18 -R /) | ForEach-Object{GetTimestampAndSize -RestoreItemsPart $_}
    Return $RestoreItems
}

$RestoreDetails = New-Object PSObject -Property @{
    "DatabasesAvailable" = $(GetAvailableRestores -RestoreFromFQDN $RestoreFromFQDN -NetbackupInstallDir $NetbackupInstallDir)    
}

Set-Location $currentLocation

$RestoreDetails.DatabasesAvailable | Select-Object -Property DatabaseInstance, DatabaseName, BackupDateTime, BackupTimeStamp -unique | Sort-Object DatabaseInstance, DatabaseName, BackupDateTime | Format-Table -AutoSize
