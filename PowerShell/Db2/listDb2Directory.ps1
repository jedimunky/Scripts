$RegistryPath = "HKLM:\SOFTWARE\IBM\DB2\InstalledCopies\"
$CurrentLocation = Get-Location

Function ListSQLLibCopies ([string]$RegistryPath)
{
    Set-Location -path $RegistryPath
    $ListofSQLLibCopies = get-childitem | Get-ItemProperty
    Return $ListofSQLLibCopies
}

Function GetSQLLibDetails ($item)
{
    Set-Location -Path ($item."DB2 Path Name" + "BIN")
    $SQLLibDetails = New-Object PSObject -Property @{
        "SQLLibCopyName" = $item.PSChildName
        "SQLLibCopyPath" = $item."DB2 Path Name"
        "SQLLibCopyBin" = $item."DB2 Path Name" + "BIN"
        "Instances" = (.\db2ilist)
    }
    return $SQLLibDetails
}

Function ListInstancesOfSQLLibs ([string]$RegistryPath)
{
    $CurrentLocation = Get-Location
    $ListofSQLLibCopies = ListSQLLibCopies -RegistryPath $RegistryPath
    $InstanceListTemp = @()
    
    foreach ($item in $ListofSQLLibCopies) 
    {
        $InstanceListTemp += GetSQLLibDetails -Item $item
    }

    Set-Location -Path $CurrentLocation
    return $InstanceListTemp
}

Function DatabaseListCleanup ($SQLLibInstanceItem)
{
    $DatabaseListTemp = @()
    set-item -path env:DB2INSTANCE -value $SQLLibInstanceItem
    Set-Location -path $env:DB2CLP
    $ActiveDatabases = (.\db2 list db directory | Select-String -Pattern "Database name","Local database","Node name")
    for ($intCounter=0;$intCounter -lt $ActiveDatabases.count; $intCounter += 2 )
    {
        $DBNameCleanup = ($ActiveDatabases[$intCounter]).tostring()
        $DBPathCleanup = ($ActiveDatabases[$intCounter+1]).tostring()
        $ActiveDatabasesHash = New-Object PSObject -Property @{
            "Instance" = $SQLLibInstanceItem
			"Database" = $DBNameCleanup.remove(0,$DBNameCleanup.indexof("=")+2)
			"Location" = $DBPathCleanup.remove(0,$DBPathCleanup.indexof("=")+2)
            "SQLLibCopyBin" = $env:DB2CLP                            
        }
        $DatabaseListTemp += $ActiveDatabasesHash
    }
    Return $DatabaseListTemp
}

Function GetInstanceDatabaseList ($SQLLib)
{
    $ActiveDatabasesList = @()
    If ($SQLLib.count -ge 1)
    {
        foreach($SQLLibItem in $SQLLib)
        {
            set-item -path env:DB2CLP -value $SQLLibItem.SQLLibCopyBin
            If ($SQLLibItem.Instances.count -ge 1)
            {
                foreach($SQLLibInstanceItem in $SQLLibItem.Instances)
                {
                    $ActiveDatabasesList += DatabaseListCleanup -SQLLibInstanceItem $SQLLibInstanceItem
                }        
            }else {
                $SQLLibInstanceItem = $SQLLibItem.Instances
                $ActiveDatabasesList += DatabaseListCleanup -SQLLibInstanceItem $SQLLibInstanceItem
            }
        }
    }else {
        If ($SQLLib.Instances.count -ge 1)
        {
            set-item -path env:DB2CLP -value $SQLLib.SQLLibCopyBin
            foreach($SQLLibInstanceItem in $SQLLib.Instances)
            {
                $ActiveDatabasesList += DatabaseListCleanup -SQLLibInstanceItem $SQLLibInstanceItem
            }        
        }else {
            set-item -path env:DB2CLP -value $SQLLib.SQLLibCopyBin
            $SQLLibInstanceItem = $SQLLib.Instances
            $ActiveDatabasesList += DatabaseListCleanup -SQLLibInstanceItem $SQLLibInstanceItem
        }
    }
    Return $ActiveDatabasesList | Sort-Object Instance
}

$InstanceList = New-Object PSObject -Property @{
    "SQLLibs" = $(ListInstancesOfSQLLibs -RegistryPath $RegistryPath)
    "Instances" = $(GetInstanceDatabaseList -SQLLib (ListInstancesOfSQLLibs -RegistryPath $RegistryPath))
}

Set-Location -Path $CurrentLocation

$InstanceList.Instances | Select-Object -Property SQLLibCopyBin, Instance, Database, Location | Where-Object {$_.Location -like "*:*" } | Sort-Object SQLLibCopyBin, Instance, Database
