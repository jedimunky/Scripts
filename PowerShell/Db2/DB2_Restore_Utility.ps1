$RegistryPath = "HKLM:\SOFTWARE\IBM\DB2\InstalledCopies\"
$NetbackupInstallDir = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Veritas\NetBackup\CurrentVersion").INSTALLDIR
$DB2ConfRestoreFile = "$NetbackupInstallDir" + "NetBackup\DbExt\DB2\db2.conf"
$DB2ConfRestoreFileRename = "$NetbackupInstallDir" + "NetBackup\DbExt\DB2\db2_$(get-date -f yyyy-MMM-dd).conf"
$global:NetbackupRegConfig = "HKLM:\SOFTWARE\Veritas\NetBackup\CurrentVersion\Config"
$global:NetbackupClientName = (Get-ItemProperty -Path $global:NetbackupRegConfig).Client_Name
$Global:RestoreFromFQDN = ""
$Global:LocalFQDN = ([System.Net.Dns]::GetHostEntry([string]$env:computername).HostName).tolower()
$CurrentLocation = Get-Location
$global:RestoreDetails = $null
$global:SourceDatabaseSize = $null
$global:DB2RestoreOut = "C:\temp\db2restore.out"
$global:InstanceList = ""
$TempLocation = "$env:ProgramData\RestoreUtility\$env:USERNAME"
$TempLocationRoot = "$env:ProgramData\RestoreUtility"
if (!(Test-Path -Path $TempLocation))
{
	if (!(Test-Path -Path $TempLocationRoot))
	{
		New-Item -Path $env:ProgramData\ -Name "RestoreUtility" -ItemType Directory
	}
	New-Item -Path "$env:ProgramData\RestoreUtility" -name $env:USERNAME -ItemType Directory
}
Get-ChildItem $TempLocation | Remove-Item -Force -Confirm:$false -ErrorAction SilentlyContinue
Function ListSQLLibCopies ([string]$RegistryPath)
{
    Set-Location -path $RegistryPath
    $ListofSQLLibCopies = get-childitem | Get-ItemProperty
    Return $ListofSQLLibCopies
}
Function GetSQLLibDetails ($item)
{
	#Set-Location -Path ($item."DB2 Path Name" + "BIN")
	$tempPath = $item."DB2 Path Name" + "BIN"
	#Start-Process "$tempPath\db2ilist.exe" -RedirectStandardOutput $TempLocation\DB2_Instances.tmp -wait
	#$TempIn = Get-Content -Path $TempLocation\DB2_Instances.tmp

	$FileEXE = "$tempPath\db2ilist.exe"
	#$Parms = "list active databases"
	$TempIn = & "$FileEXE"# $Parms

    $SQLLibDetails = New-Object PSObject -Property @{
        "SQLLibCopyName" = $item.PSChildName
        "SQLLibCopyPath" = $item."DB2 Path Name"
        "SQLLibCopyBin" = $item."DB2 Path Name" + "BIN"
        "Instances" = $TempIn
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
Function DatabaseListCleanup ($SQLLibInstanceItem,$SQLLibCopy)
{
	$DatabaseListTemp = @()
	$ActiveDatabases = ""
	set-item -path env:DB2INSTANCE -value $SQLLibInstanceItem
    #Set-Location -path $env:DB2CLP
	#$ActiveDatabases 
	#$ActiveDatabasesTemp = (.\db2 list active databases | Select-String -Pattern "Database name","Database path")
	#Start-Process "$env:DB2CLP\db2.exe" -ArgumentList "list active databases" -wait -RedirectStandardOutput "$TempLocation\DB2_ActiveDatabases.$SQLLibCopy.$SQLLibInstanceItem.tmp"

	#$TempIn = Get-Content -Path "$TempLocation\DB2_ActiveDatabases.$SQLLibCopy.$SQLLibInstanceItem.tmp"
	$FileEXE = "$env:DB2CLP\db2.exe"
	$Parms = "list active databases"
	$TempIn = & "$FileEXE" $Parms
	$ActiveDatabases = $TempIn | Select-String -Pattern "Database name","Database path"
	#Write-host "Vars: TempInstances = $TempInstances"
	#Write-host "Vars: TempSQLLibCopyName = $TempSQLLibCopyName"
    for ($intCounter=0;$intCounter -lt $ActiveDatabases.count; $intCounter += 2 )
    {
        # $DBNameCleanup = ((.\db2 list active databases | Select-String -Pattern "Database name","Database path")[$intCounter]).tostring()
        # $DBPathCleanup = ((.\db2 list active databases | Select-String -Pattern "Database name","Database path")[$intCounter+1]).tostring()
        $DBNameCleanup = ($ActiveDatabases[$intCounter]).tostring()
        $DBPathCleanup = ($ActiveDatabases[$intCounter+1]).tostring()
        #Write-host "Instance Variable $SQLLibInstanceItem"
        $ActiveDatabasesHash = New-Object PSObject -Property @{
            "Instance" = $SQLLibInstanceItem
            "Database" = $DBNameCleanup.remove(0,$DBNameCleanup.indexof("=")+2)
            "DatabasePath" = $DBPathCleanup.remove(0,$DBPathCleanup.indexof("=")+2)
            "SQLLibCopyBin" = $env:DB2CLP                            
        }
        $DatabaseListTemp += $ActiveDatabasesHash
	}
	#gci $TempLocation\DB2_ActiveDatabases.txt | Remove-Item -Force -Confirm:$false	
    Return $DatabaseListTemp
}
Function GetInstanceDatabaseList ($SQLLib)
{
    $ActiveDatabasesList = @()
    If ($SQLLib.count -ge 1)
    {
        #Write-host "Step 1.1"
        foreach($SQLLibItem in $SQLLib)
        {
            set-item -path env:DB2CLP -value $SQLLibItem.SQLLibCopyBin
            If ($SQLLibItem.Instances.count -ge 1)
            {
				#Write-host "Step 1.1.1"
				If ($SQLLibItem.Instances.count -eq 1)
				{
					#Write-host "Step 1.1.1.1"
					#Write-host "Vars: SQLLibItem.Instances = $SQLLibItem.Instances"
					#Write-host "Vars: SQLLibItem.SQLLibCopyName = $SQLLibItem.SQLLibCopyName"
					#$TempInstances = $SQLLibItem.Instances
					#$TempSQLLibCopyName = $SQLLibItem.SQLLibCopyName
					#Write-host "Vars: TempInstances = $TempInstances"
					#Write-host "Vars: TempSQLLibCopyName = $TempSQLLibCopyName"
					#Write-Host "$ActiveDatabasesList += DatabaseListCleanup -SQLLibInstanceItem $SQLLibItem.Instances -SQLLibCopy $SQLLibItem.SQLLibCopyName"
					$ActiveDatabasesList += DatabaseListCleanup -SQLLibInstanceItem $SQLLibItem.Instances -SQLLibCopy $SQLLibItem.SQLLibCopyName
					#$ActiveDatabasesList += DatabaseListCleanup -SQLLibInstanceItem $TempInstances -SQLLibCopy $TempSQLLibCopyName
					
					#Write-host "Exiting : Step 1.1.1.1"
				}else{
					#Write-host "Step 1.1.1.2"
					foreach($SQLLibInstanceItem in $SQLLibItem.Instances)
					{
						$ActiveDatabasesList += DatabaseListCleanup -SQLLibInstanceItem $SQLLibInstanceItem
					} 
					#Write-host "Exiting : Step 1.1.1.2"
				} 
				#Write-host "Exiting : Step 1.1.1"      
            }else {
                #Write-host "Step 1.1.2"
                $SQLLibInstanceItem = $SQLLibItem.Instances
				$ActiveDatabasesList += DatabaseListCleanup -SQLLibInstanceItem $SQLLibInstanceItem
				#Write-host "Exiting : Step 1.1.2"
            }
		}
		#Write-host "Exiting : Step 1.1"
    }else {
        #Write-host "Step 1.2"
        If ($SQLLib.Instances.count -ge 1)
        {
            #Write-host "Step 1.2.1"
			set-item -path env:DB2CLP -value $SQLLib.SQLLibCopyBin
			If ($SQLLibItem.Instances.count -eq 1)
			{
				$ActiveDatabasesList += DatabaseListCleanup -SQLLibInstanceItem $SQLLibItem.Instances
			}else{
            	foreach($SQLLibInstaneItem in $SQLLib.Instances)
            	{
					$ActiveDatabasesList += DatabaseListCleanup -SQLLibInstanceItem $SQLLibInstanceItem
				}
			}   
			#Write-host "Exiting : Step 1.2.1"     
        }else {
            #Write-host "Step 1.2.2"
            set-item -path env:DB2CLP -value $SQLLib.SQLLibCopyBin
            $SQLLibInstanceItem = $SQLLib.Instances
			$ActiveDatabasesList += DatabaseListCleanup -SQLLibInstanceItem $SQLLibInstanceItem
			#Write-host "Exiting : Step 1.2.2"
		}
		#Write-host "Exiting : Step 1.2"
	}
	#$ActiveDatabasesList = $ActiveDatabasesList | sort Database

    Return $ActiveDatabasesList #| sort Database #| Sort DatabasePath
}
Function GetTimestampAndSize ($RestoreItemsPart) 
{
    #$RestoreItemsPart = $RestoreItems[0]
    $RestoreDBName = [String]$RestoreItemsPart.split("\")[1]
    $FirstPart = '-rw------- SYSTEM    SYSTEM'
    #$PartSize = [String]$RestoreItemsPart.split("\").remove(0,$FirstPart.length).TrimStart(" ").split(" ")[0]
    $PartSize = $RestoreItemsPart.split("\")
    $PartSize = $PartSize[0].remove(0,$FirstPart.length).TrimStart(" ").split(" ")[0]
    If ($PartSize.Substring($PartSize.length - 1, 1) -eq "K")
    {
        $PartSize = [int32]$PartSize.replace("K","") * 1024
    }else{
        $PartSize = [int32]$PartSize
    }
    # $PartSize = 1
    #$Line = @{}
    #$Line.add($RestoreDBName,$PartSize)
    $Line = New-Object PSObject -Property @{
            "Instance" = ($RestoreItemsPart.split("\")[4]).Split(".")[2]
            "DatabaseName" = $RestoreDBName
            "BackupTimeStamp" = $RestoreItemsPart.split("\")[3]
            "DatabasePartSize" = $PartSize
        }
    Return $Line
}
Function GetAvailableRestores ($RestoreFromFQDN,$NetbackupInstallDir)
{
    #Write-host "GetAvailableRestores 1.0"
    #write-host $RestoreFromFQDN
    #Set-Location -Path ("$NetbackupInstallDir" + "Netbackup\Bin")
	#$RestoreFromFQDN = "htvudbtib2.dev.hbf.com.au"
	#$BPLISTLocation = ("$NetbackupInstallDir" + "Netbackup\Bin\" + "bplist.exe")
    #$RestoreItems = (.\bplist.exe -l -C $RestoreFromFQDN -t 18 -R /) | foreach{GetTimestampAndSize -RestoreItemsPart $_}
    Start-Process "$NetbackupInstallDir\Netbackup\Bin\bplist.exe" -ArgumentList "-l -C $RestoreFromFQDN -t 18 -R /" -RedirectStandardOutput $TempLocation\DB2_Netbackup.tmp -wait #-WindowStyle Hidden 
	$TempIn = Get-Content -Path $TempLocation\DB2_Netbackup.tmp
	
	#$FileEXE = "$BPLISTLocation -l -C $RestoreFromFQDN -t 18 -R /" #"$NetbackupInstallDir\Netbackup\Bin\bplist.exe -l -C $RestoreFromFQDN -t 18 -R /"
	#$Parms = "-l -C $RestoreFromFQDN -t 18 -R /"
	#$TempIn = & "$FileEXE" #$Parms


    #Write-host "GetAvailableRestores 1.1"
    #Write-host $TempIn
   # Write-host "GetAvailableRestores 1.2"
    $RestoreItems = $TempIn | ForEach-Object{GetTimestampAndSize -RestoreItemsPart $_}
    #Write-Host $RestoreItems
    #$RestoreItems = (.\bplist.exe -C $RestoreFromFQDN -t 18 -R /) | foreach{$_.split("\")[1]} | Select-Object -Unique | Sort | foreach {}
    Return $RestoreItems
}
#Set-Location -Path $CurrentLocation
Function SearchButton_Click()
{
	$CompletedPercentage = "Completed: " + 0 + "%"
	$label7.Text = $CompletedPercentage
	$ProgressBar1.Value = 0
	$objListBox1.Items.clear()
	$objListBox2.Items.clear()

	
    #Write-host "SearchButton_Click 1.0"
    #$RestoreFromFQDN = "htvudbtibweb1.dev.hbf.com.au"
	$RestoreFromFQDN = ($objTextBox.Text).tostring().ToLower()
	$Global:RestoreFromFQDN = $RestoreFromFQDN
    #Write-Host "Searching for backups for: $RestoreFromFQDN"
    $global:RestoreDetails = New-Object PSObject -Property @{
        "DatabasesAvailable" = (GetAvailableRestores -RestoreFromFQDN $RestoreFromFQDN -NetbackupInstallDir $NetbackupInstallDir)    
    }
    #Write-host "SearchButton_Click 1.1"
    #write-host $RestoreDetails.DatabasesAvailable
    #$RestoreDetailsTempDBList = $RestoreDetails.DatabasesAvailable | Select-Object -Unique DatabaseName | sort DatabaseName
    $RestoreDetailsTempDBList = $global:RestoreDetails.DatabasesAvailable | Select-Object -Unique Instance,DatabaseName | Sort-Object Instance,DatabaseName
    foreach($RestoreItem in $RestoreDetailsTempDBList)
    {
        $objListBox1.Items.Add($RestoreItem.Instance+'::::'+$RestoreItem.DatabaseName)
        #Write-host $RestoreItem.DatabaseName
    }
}
Function objListBox1_Click()
{
	
	$objListBox2.Items.clear()
	$TempSelection = ($objListBox1.SelectedItem.tostring()).split("::::")
	#Write-host "objListBox1_Click 1.1"
	#Write-host "objListBox1_Click "$TempSelection
	#Write-host "objListBox1_Click " $TempSelection[4]
	$SelectedDatabaseDetails = $global:RestoreDetails.DatabasesAvailable | where-object {$_.databasename -eq $TempSelection[4]} | Sort-Object BackupTimeStamp -Descending
	$TimestampTemp = $SelectedDatabaseDetails | Select-Object -Unique BackupTimeStamp
    foreach($TimestampTempItem in $TimestampTemp)
    {
		#Write-host "objListBox1_Click :" $TimestampTempItem
        $objListBox2.Items.Add($TimestampTempItem.BackupTimeStamp)
        #Write-host $RestoreItem.DatabaseName
    }
}
Function GeneratedScript_Cleanup([String]$GeneratedScript,[String]$TempDestDatabase)
{
	$infile  = $GeneratedScript
	$outfile = "$TempLocation\DB2_GenScript_Cleaned.tmp"
	Remove-Item -Path $outfile -Recurse -Confirm:$false -ErrorAction SilentlyContinue



	$oldDbName = (Select-String -Path $infile -Pattern "database" -List).ToString().split("{ }")[2]
	$newDbName = (Select-String -Path $infile -Pattern "INTO " -List).ToString().split("{ }")[1]


	# Remove comments and empty lines, format nicely
	#Write-Host "InFile: "$infile
	$file = Get-Content $infile
	foreach($line in $file) {
		if (($line.Length -gt 0) -and ($line -notlike "--*" -and $line -notlike "UPDATE COMMAND*" -and $line -notlike "SET CLIENT*") -or `
									  ($line -like "-- NEWLOG*" -or $line -like "-- LOGTAR*")) {
		
			$trim += "$line " -replace ("; ",";`f") `
						  -replace ("-- LOGTARGET '<directory>'","`fLOGTARGET 'F:\temp_backup\logtarget\$newDbName'") `
						  -replace ("-- NEWLOGPATH ","`fNEWLOGPATH ") `
						  -replace ("\\$oldDbName\\","\$newDbName\") `
						  -replace ("NODE0000\\LOGSTREAM0000\\","") `
						  -replace ("REDIRECT","`fREDIRECT  WITHOUT PROMPTING")
		}
	}

	New-Item -Path 'E:\CONTAINERS\'            -Name $newDbName -ItemType directory -Force
	New-Item -Path 'F:\temp_backup\logtarget\' -Name $newDbName -ItemType directory -Force
	New-Item -Path 'L:\db2_logs\'              -Name $newDbName -ItemType directory -Force


	$trim | Out-File $outfile	
	Return $outfile
}
# Function Set_Netbackup_ClientName([String]$ClientName)
# {
# 	Set-ItemProperty -Path $global:NetbackupRegConfig -Name Client_Name -Value $ClientName
# }
Function PrepareDB2Conf ($SRCINST,$SRCALIAS,$DESTINST,$DESTALIAS)
{
	#$FileExe = "$NetbackupInstallDir" + "Netbackup\Bin\bpclimagelist.exe"
	
	#Start-Process $FileExe -ArgumentList "-client $Global:RestoreFromFQDN -ct 18" -RedirectStandardOutput $TempLocation\DB2_Netbackup_DB2_Source.tmp -wait
	'# keyword lines needed to specify the alternate restore' | Out-File $DB2ConfRestoreFile -Encoding ascii
	"OBJECTTYPE`tALTERNATE`t# Specifies an alternate restore" | Out-File $DB2ConfRestoreFile -Encoding ascii -Append
	"SRCINST`t`t$SRCINST`t`t# Names the source instance that was backed up" | Out-File $DB2ConfRestoreFile -Encoding ascii -Append
	"SRCALIAS`t$SRCALIAS`t# Names the source database that was backed up" | Out-File $DB2ConfRestoreFile -Encoding ascii -Append
	"DESTINST`t$DESTINST`t# Names the destination instance name" | Out-File $DB2ConfRestoreFile -Encoding ascii -Append
	"DESTALIAS`t$DESTALIAS`t# Names the destination database alias name" | Out-File $DB2ConfRestoreFile -Encoding ascii -Append
	"ENDOPER" | Out-File $DB2ConfRestoreFile -Encoding ascii -Append

	"" | Out-File $DB2ConfRestoreFile -Encoding ascii -Append

	'# Destination keyword lines needed to define the NEW database' | Out-File $DB2ConfRestoreFile -Encoding ascii -Append
	"DATABASE`t$DESTALIAS" | Out-File $DB2ConfRestoreFile -Encoding ascii -Append
	"OBJECTTYPE`tDATABASE" | Out-File $DB2ConfRestoreFile -Encoding ascii -Append
	"POLICY`t`tDB2_POLICY" | Out-File $DB2ConfRestoreFile -Encoding ascii -Append
	"SCHEDULE`tUSER" | Out-File $DB2ConfRestoreFile -Encoding ascii -Append
	"CLIENT_NAME`t$Global:LocalFQDN" | Out-File $DB2ConfRestoreFile -Encoding ascii -Append
	"ENDOPER" | Out-File $DB2ConfRestoreFile -Encoding ascii -Append

	"" | Out-File $DB2ConfRestoreFile -Encoding ascii -Append

	'# Source keyword lines needed to define the OLD database' | Out-File $DB2ConfRestoreFile -Encoding ascii -Append
	"DATABASE`t$SRCALIAS" | Out-File $DB2ConfRestoreFile -Encoding ascii -Append
	"OBJECTTYPE`tDATABASE" | Out-File $DB2ConfRestoreFile -Encoding ascii -Append
	"POLICY`t`tDB2_POLICY" | Out-File $DB2ConfRestoreFile -Encoding ascii -Append
	"SCHEDULE`tUSER" | Out-File $DB2ConfRestoreFile -Encoding ascii -Append
	"CLIENT_NAME`t$Global:RestoreFromFQDN" | Out-File $DB2ConfRestoreFile -Encoding ascii -Append
	"ENDOPER" | Out-File $DB2ConfRestoreFile -Encoding ascii -Append

}

Function NewDatabaseNameInput ()
{
	
	Function TextBoxRemoveWaterMark()
	{
		If ($NDBNInputtextBox.text -eq $WatermarkText)
		{
			$NDBNInputtextBox.ForeColor = 'Black'
			$NDBNInputtextBox.MaxLength = 8
			$NDBNInputtextBox.text = ''

		}
	}
	Function TextBoxAddWaterMark()
	{
		If ($NDBNInputtextBox.text -eq '')
		{
			$NDBNInputtextBox.ForeColor = 'DarkGray'
			$NDBNInputtextBox.MaxLength = 32
			$NDBNInputtextBox.text = $WatermarkText
		}
	}

	Add-Type -AssemblyName System.Windows.Forms
	Add-Type -AssemblyName System.Drawing

	$NDBNInput = New-Object System.Windows.Forms.Form
	$NDBNInput.Text = 'Set Target DB2 Database Name'
	$NDBNInput.Size = New-Object System.Drawing.Size(270,180)
	$NDBNInput.StartPosition = 'CenterScreen'
	$NDBNInput.FormBorderStyle =[System.Windows.Forms.FormBorderStyle]::FixedDialog
	$NDBNInput.MaximizeBox = $false
	$NDBNInput.MinimizeBox = $false

	$NDBNInputOKButton = New-Object System.Windows.Forms.Button
	$NDBNInputOKButton.Location = New-Object System.Drawing.Point(10,100)
	$NDBNInputOKButton.Size = New-Object System.Drawing.Size(75,23)
	$NDBNInputOKButton.Text = 'OK'
	$NDBNInputOKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
	$NDBNInput.AcceptButton = $NDBNInputOKButton
	$NDBNInput.Controls.Add($NDBNInputOKButton)

	$NDBNInputCancelButton = New-Object System.Windows.Forms.Button
	$NDBNInputCancelButton.Location = New-Object System.Drawing.Point(165,100)
	$NDBNInputCancelButton.Size = New-Object System.Drawing.Size(75,23)
	$NDBNInputCancelButton.Text = 'Cancel'
	$NDBNInputCancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
	$NDBNInput.CancelButton = $NDBNInputCancelButton
	$NDBNInput.Controls.Add($NDBNInputCancelButton)

	$NDBNInputlabel = New-Object System.Windows.Forms.Label
	$NDBNInputlabel.Location = New-Object System.Drawing.Point(10,20)
	$NDBNInputlabel.Size = New-Object System.Drawing.Size(240,40)
	$NDBNInputlabel.Text = "Please choose a Target DB2 Database Name `n(MAX 8 Characters)"
	$NDBNInputlabel.Add_Click({TextBoxAddWaterMark})
	$NDBNInput.Controls.Add($NDBNInputlabel)

	$NDBNInputtextBox = New-Object System.Windows.Forms.TextBox
	$NDBNInputtextBox.Location = New-Object System.Drawing.Point(10,65)
	$NDBNInputtextBox.Size = New-Object System.Drawing.Size(230,20)
	$NDBNInputtextBox.MaxLength = 32
	$WatermarkText = 'Enter new DB2 Database name here'
	$NDBNInputtextBox.ForeColor = 'DarkGray'
	$NDBNInputtextBox.Text = $WatermarkText
	$NDBNInputtextBox.Add_Click({TextBoxRemoveWaterMark})
	$NDBNInputtextBox.Add_LostFocus({TextBoxAddWaterMark})
	$NDBNInput.Add_Click({TextBoxAddWaterMark})
	$NDBNInput.Controls.Add($NDBNInputtextBox)
	
	$NDBNInput.Topmost = $true

	$result = $NDBNInput.ShowDialog()

	if ($result -eq [System.Windows.Forms.DialogResult]::OK)
	{
		if ($NDBNInputtextBox.Text -eq $WatermarkText -or $NDBNInputtextBox.Text.trim() -eq '')
		{
			$NewDatabaseNameVal = 'XXXXXXXX'
		}else{
			$NewDatabaseNameVal = $NDBNInputtextBox.Text
		}
		
		
	}elseif ($result -eq [System.Windows.Forms.DialogResult]::Cancel)
	{
		$NewDatabaseNameVal = 'XXXXXXXX'
	}else {
		$NewDatabaseNameVal = 'XXXXXXXX'
	}

	Return $NewDatabaseNameVal

}


Function GenerateButton_Click()
{
	
	#Set_Netbackup_ClientName -ClientName ($objTextBox.text.split("."))[0].toUpper()


	$global:SourceDatabaseSize = $null
	$TempDestSQLLibCopy = (($objListBox3.SelectedItem.tostring()).split(":"))[0]
	$TempDestInstance = (($objListBox3.SelectedItem.tostring()).split(":"))[4]
	$TempDestDatabase = (($objListBox3.SelectedItem.tostring()).split(":"))[8]
	$TempDestSQLLibPath = ($global:InstanceList.SQLLibs | Where-Object {$_.SQLLibCopyName -eq $TempDestSQLLibCopy}).SQLLibCopyBin | Select-Object -Unique

	set-item -path env:DB2INSTANCE -value $TempDestInstance
	Set-Item -path env:DB2CLP -value $TempDestSQLLibPath
	
	$TempSourceInstance = (($objListBox1.SelectedItem.tostring()).split(":"))[0]
	$TempSourceDatabase = (($objListBox1.SelectedItem.tostring()).split(":"))[4]
	$TempSourceTimeStamp = $objListBox2.SelectedItem
	
	$TempDBDetails = $global:RestoreDetails.DatabasesAvailable | Where-Object {$_.DatabaseName -eq $TempSourceDatabase -and $_.BackupTimeStamp -eq $TempSourceTimeStamp}
	
	$TempDBDetails | ForEach-Object {$global:SourceDatabaseSize += [double]$_.DatabasePartSize}
	#Write-host "Database total size: "$global:SourceDatabaseSize
	If ($TempDestDatabase -eq '<<OTHER>>')
	{
		#$TempDestDatabase = "XXXXXXXX"
		$TempDestDatabase = NewDatabaseNameInput
		PrepareDB2Conf -SRCINST $TempSourceInstance -SRCALIAS $TempSourceDatabase -DESTINST $TempDestInstance -DESTALIAS $TempDestDatabase
		$TempGenScriptArguments = "restore db $TempSourceDatabase load 'D:\Program Files\VERITAS\NetBackup\bin\nbdb2.dll' taken at $TempSourceTimeStamp into $TempDestDatabase redirect generate script $TempLocation\DB2_GenScript.tmp"
		#Write-host "Gen 1.0 ::::" $TempGenScriptArguments
		
		Start-Process "$env:DB2CLP\db2.exe" -ArgumentList $TempGenScriptArguments -WorkingDirectory $TempLocation -wait -RedirectStandardOutput $TempLocation\DB2_GenScript_REPORT.tmp
	}else{
		#Write-host "Gen 1.1 ::::" $TempGenScriptArguments
		PrepareDB2Conf -SRCINST $TempSourceInstance -SRCALIAS $TempSourceDatabase -DESTINST $TempDestInstance -DESTALIAS $TempDestDatabase
		$TempGenScriptArguments = "restore db $TempSourceDatabase load 'D:\Program Files\VERITAS\NetBackup\bin\nbdb2.dll' taken at $TempSourceTimeStamp into $TempDestDatabase redirect generate script $TempLocation\DB2_GenScript.tmp"
		Start-Process "$env:DB2CLP\db2.exe" -ArgumentList $TempGenScriptArguments -WorkingDirectory $TempLocation -wait -RedirectStandardOutput $TempLocation\DB2_GenScript_REPORT.tmp
	}

	Copy-Item -Path "$TempLocation\DB2_GenScript.tmp" -Destination "$TempLocation\DB2_GenScript2.tmp"
	$CleanedDBRestoreScript = GeneratedScript_Cleanup -GeneratedScript "$TempLocation\DB2_GenScript.tmp" -TempDestDatabase $TempDestDatabase
	$RichTextBox1.text = (Get-Content -Path $CleanedDBRestoreScript).replace("`f","`n")
	$RestoreButton.enabled = $true
	#Set_Netbackup_ClientName -ClientName $global:NetbackupClientName
}

Function CreateRequiredFolders($TempFolderCreation)
{
	ForEach ($TempLine in $TempFolderCreation)
	{
		if ($TempLine -like "LOGTARGET*")
		{
			$TempLineFolder = $TempLine.split("'")[1]
			if (!(Test-Path -Path $TempLineFolder))
			{
				New-Item -Path $TempLineFolder -ItemType Directory
			}
		}

		if ($TempLine -like "NEWLOGPATH*")
		{
			$TempLineFolder = $TempLine.split("'")[1]
			if (!(Test-Path -Path $TempLineFolder))
			{
				New-Item -Path $TempLineFolder -ItemType Directory
			}
		}

		if ($TempLine -like "SET TABLESPACE CONTAINERS FOR*")
		{
			$TempLineFolder = $TempLine.split("'")[1].Substring(0,$TempLine.split("'")[1].lastindexof("\"))
			#$TempLineFolder = $test.split("'")[1].Substring(0,$test.split("'")[1].lastindexof("\"))
			if (!(Test-Path -Path $TempLineFolder))
			{
				New-Item -Path $TempLineFolder -ItemType Directory
			}
		}	
	}
}


Function Restore_Start($RestoreScript)
{

	#$RestoreButton.enabled = $false
	Remove-Item -Path "$TempLocation\DB2_GenScript_Cleaned_Restore.tmp" -force -ErrorAction SilentlyContinue
	Remove-Item -Path "$TempLocation\DB2_GenScript_Folders.tmp" -force -ErrorAction SilentlyContinue
	$tempin = $RichTextBox1.text
	$tempin | ForEach-Object {$_.replace("`f","`n")|Out-File -FilePath $RestoreScript -Encoding ascii -Append}

	$tempin | ForEach-Object {$_.replace("`f","`r`n")|Out-File -FilePath "$TempLocation\DB2_GenScript_Folders.tmp" -Encoding ascii -Append}
	$TempFolderCreation = get-content "$TempLocation\DB2_GenScript_Folders.tmp"
	CreateRequiredFolders -TempFolderCreation $TempFolderCreation


	Start-Sleep -Seconds 2
	$tempin = Get-Content -Path $RestoreScript
	#New-Item -Path $tempin[2].replace('NEWLOGPATH ',"").Replace("'","") -Type Directory -ErrorAction SilentlyContinue
	Start-Sleep -Seconds 5
	$objListBox2.Items.clear()

	#$TempRestoreArguments = "-tvf $RestoreScript" #-z $global:DB2RestoreOut"
	#Start-Process "$env:DB2CLP\db2.exe" -ArgumentList $TempRestoreArguments #-NoNewWindow # -RedirectStandardOutput $global:DB2RestoreOut # | Out-file C:\temp\test.txt
	#Start-Job -FilePath "$env:DB2CLP\db2.exe" -ArgumentList $TempRestoreArguments | Out-file $global:DB2RestoreOut
	Start-Job -Name RestoreBlock -ScriptBlock {
			param ($SQLLib,$Instance,$RestoreScript)#,$DB2RestoreOut1)
			Set-Item -path env:DB2CLP -value $SQLLib
			set-item -path env:DB2INSTANCE -value $Instance
			$TempRestoreArguments = "-tvf $RestoreScript"
			Start-Process "$env:DB2CLP\db2.exe" -ArgumentList $TempRestoreArguments -wait -NoNewWindow -RedirectStandardOutput C:\temp\db2restore.out
		} -ArgumentList @($env:DB2CLP,$env:DB2INSTANCE,$RestoreScript)#,$global:DB2RestoreOut)
}

Function Update_Progress_Bar
{
	$TempRestoreArguments = "list utilities show detail" # -z $TempLocation\DB2_Restore_Completed.tmp "# > $TempLocation\DB2_Restore_Completed.tmp
	#Write-host "Arguments : " $TempRestoreArguments
	$TimeOutCounter = 0
	do {
		$form.Hide
		$form.show()
		$form.Refresh()
		$CompletedTemp = $null
		#Start-Process "$env:DB2CLP\db2.exe" -ArgumentList $TempRestoreArguments -NoNewWindow -RedirectStandardOutput $TempLocation\DB2_Restore_Completed.tmp -Wait

		Start-Job -Name ProgressBlock -ScriptBlock {
			param ($SQLLib,$Instance,$TempLocation)#,$RestoreScript,$DB2RestoreOut1)
			Set-Item -path env:DB2CLP -value $SQLLib
			set-item -path env:DB2INSTANCE -value $Instance
			$TempRestoreArguments = "list utilities show detail"
			Start-Process "$env:DB2CLP\db2.exe" -ArgumentList $TempRestoreArguments -wait -NoNewWindow -RedirectStandardOutput $TempLocation\DB2_Restore_Completed.tmp
		} -ArgumentList @($env:DB2CLP,$env:DB2INSTANCE,$TempLocation)#,$RestoreScript)

		Start-sleep -Seconds 5
		$CompletedTemp = Get-Content -Path $TempLocation\DB2_Restore_Completed.tmp
		$CompletedBytes = [string](([string]($CompletedTemp | Select-String -Pattern "Completed Work")).split("=")[1].trim().replace(" bytes","").trim())
		#Write-host $CompletedTemp
		#Write-host "Completed Bytes		: " $CompletedBytes
		#Write-host "Source Size Bytes	: " $global:SourceDatabaseSize
		$CompletedPercentage = [int](([Double]$CompletedBytes/[Double]$global:SourceDatabaseSize)*100)
		$ProgressBarVal = $CompletedPercentage
		#Write-host "Percent Val			: " $CompletedPercentage
		#Write-host "Progress Val		: " $ProgressBarVal
		$CompletedPercentageText = "Completed: " + $ProgressBarVal + "%"
		$label7.Text = $CompletedPercentageText
		$ProgressBar1.Value = $ProgressBarVal
		#Remove-Item -Path $TempLocation\DB2_Restore_Completed.tmp
		#Start-sleep -Seconds 5
		$TimeOutCounter += 20
	} until ($ProgressBarVal -eq 100 -or ($TimeOutCounter -gt 120 -and $CompletedTemp -like "*No data was returned by Database System Monitor*"))
	Start-Process "notepad.exe" -ArgumentList $global:DB2RestoreOut
}
Function RestoreButton_Click()
{
	#Set_Netbackup_ClientName -ClientName ($objTextBox.text.split("."))[0].toUpper()
	$form.Hide
	$form.show()
	#Start-Process -
	$RestoreScript = "$TempLocation\DB2_GenScript_Cleaned_Restore.tmp"
	#$RichTextBox1.text | Out-File "$TempLocation\DB2_GenScript_Cleaned_Restore.tmp" -Encoding ascii
	Restore_Start -RestoreScript $RestoreScript
	Rename-Item -Path $RestoreScript -NewName $DB2ConfRestoreFileRename
	Update_Progress_Bar
	#Set_Netbackup_ClientName -ClientName $global:NetbackupClientName
}
# $global:InstanceList = New-Object PSObject -Property @{
#     "SQLLibs" = $(ListInstancesOfSQLLibs -RegistryPath $RegistryPath)
#     "Instances" = $(GetInstanceDatabaseList -SQLLib (ListInstancesOfSQLLibs -RegistryPath $RegistryPath))
# }
Function DB2_Restore_GUI
{	
	param ()
	Add-Type -AssemblyName System.Windows.Forms
	Add-Type -AssemblyName System.Drawing
    $DialogHeading = "DB2 Restore" 
    

    
 ###################Object Sizes and locations###############
	##############SIZE##############
	###Form
	$formWidth = 1205 + 50
	$formHeight = 500
	###Default Button Size
	$DefLabelWidth = 75
	$DefLabelHeight = 20
	###Default Button Size
	$DefButtonWidth = 75
	$DefButtonHeight = 20
	###Default List Box Size
	$DefListWidth = 155
	$ListTimeStamp = 50
	$DefListBoxHeight = 350
	###Default Text Box Size
	$DefTextBoxWidth = 170
	$DefTextBoxHeight = 20
	###Default Label Size
	$DefLabelWidth = 200
	$DefLabelHeight = 15
	###Default Spacer
	$DefSpacerWidth = 5
	$DefSpacerHeight = 5
	###Default Rich Text Box Size
	$DefRichTextBoxWidth = 500
	$DefRichTextBoxHeight = 380
	###Default Progress Bar
	$DefProgressBarWidth = 1170 + 50
	$DefProgressBarHeight = 30
	################################
	############Location############
	###Label 1
	$Label1X = 10
	$Label1Y = 20
	###Text Box 1
	$TextBox1X = 12
	$TextBox1Y = 35
	###Search Button
	$SearchButtonX = $TextBox1X + $DefTextBoxWidth
	$SearchButtonY = $TextBox1Y
	###Generate Button
	$GenerateButtonX = $SearchButtonX + $DefButtonWidth
	$GenerateButtonY = $SearchButtonY
	###Cancel Button
	$CancelButtonX = $GenerateButtonX + $DefButtonWidth
	$CancelButtonY = $GenerateButtonY
	###Label 2
	$Label2X = 10
	$Label2Y = $TextBox1Y + $DefTextBoxHeight
	###List Box 1
	$ListBox1X = 12
	$ListBox1Y = $Label2Y + $DefLabelHeight
	###Label 3
	$Label3X = $ListBox1X + $DefListWidth + 2
	$Label3Y = $TextBox1Y + $DefTextBoxHeight
	###List Box 2
	$ListBox2X = $ListBox1X + $DefListWidth + $DefSpacerWidth
	$ListBox2Y = $ListBox1Y
	###Label 4
	$Label4X = $ListBox2X + $DefListWidth + 5 - $ListTimeStamp
	$Label4Y = $ListBox2Y + ($DefListBoxHeight / 3)
	# $Label8X = $ListBox2X + $DefListWidth + 5 - $ListTimeStamp
	# $Label8Y = $Label3Y
	###List Box 3
	$ListBox3X = $Label4X + $DefLabelWidth - 115
	$ListBox3Y = $ListBox1Y
	$Label8X = $ListBox3X
	$Label8Y = $Label3Y
	###Label 5
	$Label5X = $ListBox3X + $DefListWidth + 5 + 50
	$Label5Y = $ListBox3Y + ($DefListBoxHeight / 3)
	###Rich Text Box 1
	$RichTextBox1X = $Label5X + ($DefLabelWidth - 125)
	$RichTextBox1Y = $TextBox1Y
	###Restore Button
	$RestoreButtonX = $RichTextBox1X + $DefRichTextBoxWidth + $DefSpacerWidth
	$RestoreButtonY = $RichTextBox1Y
	###Label 6
	$Label6X = $RichTextBox1X
	$Label6Y = $Label1Y
	###Progress Bar 1
	$ProgressBar1X = 12
	$ProgressBar1Y = $RichTextBox1Y + $DefRichTextBoxHeight + $DefSpacerHeight
	###Label 7
	$Label7X = $ProgressBar1X + ($DefProgressBarWidth / 2) - 50
	$Label7Y = $ProgressBar1Y + ($DefSpacerHeight + 2)
	################################
 ###################Form
	$form = New-Object System.Windows.Forms.Form 
	$form.MaximizeBox = $false
	$form.MinimizeBox = $false
	$form.Text = $DialogHeading
	#$Image = [system.drawing.image]::FromFile("C:\Temp\Unicorn.jpg")
	#$Form.BackgroundImage = $Image
	#$Form.BackgroundImageLayout = "None"
	$form.Size = New-Object System.Drawing.Size($formWidth,$formHeight) 

	$form.StartPosition = "CenterScreen"
	$form.FormBorderStyle =[System.Windows.Forms.FormBorderStyle]::FixedDialog
	#$form.Icon = $DialogIconLoc
 ##########################Search Source Client for backups
	Function Button_Toggle()
	{
		if (($objListBox1.SelectedIndex -ne "-1") -and ($objListBox2.SelectedIndex -ne "-1") -and ($objListBox3.SelectedIndex -ne "-1"))
		{
			$GenerateButton.enabled = $true
			
		}else{
			$GenerateButton.enabled = $false
			$RestoreButton.enabled = $false
		}
	}
	#Label: Source Client FQDN
	$label1 = New-Object System.Windows.Forms.Label
	$label1.Location = New-Object System.Drawing.Point($Label1X,$Label1Y) 
	$label1.Size = New-Object System.Drawing.Size(($DefLabelWidth - 50),$DefLabelHeight) 
	$Label1.BackColor = "Transparent"
	$label1.Text = "Source Client FQDN"
	$form.Controls.Add($label1) 

	#Text Box: Enter source client FQDN
	$objTextBox = New-Object System.Windows.Forms.TextBox 
	$objTextBox.Location = New-Object System.Drawing.Size($TextBox1X,$TextBox1Y) 
	$objTextBox.Size = New-Object System.Drawing.Size($DefTextBoxWidth,$DefTextBoxHeight) 
	#$objTextBox.Text = "Enter source client FQDN"
	#$LocalFQDN = ([System.Net.Dns]::GetHostEntry([string]$env:computername).HostName).tolower()
	#$objTextBox.Text = "hrvudbtib2.corp.hbf.com.au"
	$objTextBox.Text = "$Global:LocalFQDN"
	$form.Controls.Add($objTextBox)

	#Button: Search
	$SearchButton = New-Object System.Windows.Forms.Button
	$SearchButton.Location = New-Object System.Drawing.Size($SearchButtonX,$SearchButtonY)
	$SearchButton.Size = New-Object System.Drawing.Size($DefButtonWidth,$DefButtonHeight)
	$SearchButton.Text = "Search"
	$SearchButton.Add_Click({SearchButton_Click;Button_Toggle})
	$form.Controls.Add($SearchButton)

	
	#Button: Generate
	$GenerateButton = New-Object System.Windows.Forms.Button
	$GenerateButton.Location = New-Object System.Drawing.Size($GenerateButtonX,$GenerateButtonY)
	$GenerateButton.Size = New-Object System.Drawing.Size($DefButtonWidth,$DefButtonHeight)
	$GenerateButton.Text = "Generate"
	$GenerateButton.enabled = $false
	$GenerateButton.Add_Click({GenerateButton_Click})
	$form.Controls.Add($GenerateButton)

	Function CancelButton_Click()
	{
		$form.Close()
	}
	#Button: Cancel
	$CancelButton = New-Object System.Windows.Forms.Button
	$CancelButton.Location = New-Object System.Drawing.Size($CancelButtonX,$CancelButtonY)
	$CancelButton.Size = New-Object System.Drawing.Size($DefButtonWidth,$DefButtonHeight)
	$CancelButton.Text = "Cancel"
	$CancelButton.Add_Click({CancelButton_Click})
	$form.Controls.Add($CancelButton)
 ##########################Restore details selection
	#Label: Select a Database
	$label2 = New-Object System.Windows.Forms.Label
	$label2.Location = New-Object System.Drawing.Point($Label2X,$Label2Y) 
	$label2.Size = New-Object System.Drawing.Size(($DefLabelWidth - 100),$DefLabelHeight)
	$Label2.BackColor = "Transparent" 
	$label2.Text = "Select a Database"
	$form.Controls.Add($label2) 
	
	#List Box: Database selection
	$objListBox1 = New-Object System.Windows.Forms.ListBox 
	$objListBox1.Location = New-Object System.Drawing.Size($ListBox1X,$ListBox1Y) 
	$objListBox1.Size = New-Object System.Drawing.Size(($DefListWidth),$DefListBoxHeight) 
	$objListBox1.Height = $DefListBoxHeight
	$objListBox1.Add_Click({objListBox1_Click})
	$objListBox1.Add_SelectedIndexChanged({Button_Toggle;objListBox1_Click})
	# [void] $objListBox1.Items.Add("DB1")
	# [void] $objListBox1.Items.Add("DB2")
	$form.Controls.Add($objListBox1) 

	#Label: Select a Timestamp
	$label3 = New-Object System.Windows.Forms.Label
	$label3.Location = New-Object System.Drawing.Point($Label3X,$Label3Y) 
	$label3.Size = New-Object System.Drawing.Size($DefLabelWidth,$DefLabelHeight) 
	$Label3.BackColor = "Transparent"
	$label3.Text = "Select a Timestamp"
	$form.Controls.Add($label3) 
 	
	#List Box: Timestamp selection
	$objListBox2 = New-Object System.Windows.Forms.ListBox 
	$objListBox2.Location = New-Object System.Drawing.Size($ListBox2X,$ListBox2Y) 
	$objListBox2.Size = New-Object System.Drawing.Size(($DefListWidth - $ListTimeStamp),$DefListBoxHeight) 
	$objListBox2.Add_SelectedIndexChanged({Button_Toggle})
	# [void] $objListBox2.Items.Add("Timestamp1")
	# [void] $objListBox2.Items.Add("Timestamp2")
	$form.Controls.Add($objListBox2) 

	#Label: Restore into >>
	$label4 = New-Object System.Windows.Forms.Label
	$label4.Location = New-Object System.Drawing.Point($Label4X,$Label4Y) 
	$label4.Size = New-Object System.Drawing.Size(($DefLabelWidth - 115),$DefLabelHeight) 
	$Label4.BackColor = "Transparent"
	$label4.Text = "Restore into >>"
	$form.Controls.Add($label4) 

	$label8 = New-Object System.Windows.Forms.Label
	$label8.Location = New-Object System.Drawing.Point($Label8X,$Label8Y) 
	$label8.Size = New-Object System.Drawing.Size(($DefLabelWidth - 90),$DefLabelHeight) 
	$label8.BackColor = "Transparent"
	$label8.Text = "Select a Destination"
	$form.Controls.Add($label8) 

	#List Box: Instance selection
	$objListBox3 = New-Object System.Windows.Forms.ListBox 
	$objListBox3.Location = New-Object System.Drawing.Size($ListBox3X,$ListBox3Y) 
	$objListBox3.Size = New-Object System.Drawing.Size(($DefListWidth + 50),$DefListBoxHeight) 
	$objListBox3.Add_SelectedIndexChanged({Button_Toggle})
	# [void] $objListBox3.Items.Add("Into Instance")
	# [void] $objListBox3.Items.Add("Into Instance")
	$TempInstanceArray = @()
	foreach($InstanceItemTemp in $global:InstanceList.Instances)
    {
		$TempSQLLibCopyName = ($global:InstanceList.SQLLibs | Where-Object {$_.SQLLibCopyBin -like $InstanceItemTemp.SQLLibCopyBin}).SQLLibCopyName
		#Write-host "TempSQLLibCopyName = $TempSQLLibCopyName"
		$TempInstanceArray += $TempSQLLibCopyName + '::::' + $InstanceItemTemp.Instance + '::::' + $InstanceItemTemp.Database
	}
	$TempUniqueInstance = $global:InstanceList.Instances | Select-Object -Unique Instance
	#Write-Host "TempInstanceArray : TempInstanceArray"
	foreach($InstanceItemTemp in $TempUniqueInstance)
    {
		#Write-host "InstanceItemTemp = $InstanceItemTemp"
		$TempSQLLibCopyName = ($global:InstanceList.SQLLibs | Where-Object {$_.Instances -like $InstanceItemTemp.Instance}).SQLLibCopyName
		#Write-host "TempSQLLibCopyName = $TempSQLLibCopyName"
		$TempInstanceArray += $TempSQLLibCopyName + '::::' + $InstanceItemTemp.Instance + '::::' + '<<OTHER>>'
	}
	$TempInstanceArray = $TempInstanceArray | Sort-Object
	foreach($InstanceItemTemp in $TempInstanceArray)
    {
		$objListBox3.Items.Add($InstanceItemTemp)
   
    }

	$form.Controls.Add($objListBox3) 

 ##########################Generate Script
	#Label: Generated >>
	$label5 = New-Object System.Windows.Forms.Label
	$label5.Location = New-Object System.Drawing.Point($Label5X,$Label5Y) 
	$label5.Size = New-Object System.Drawing.Size(($DefLabelWidth - 126),$DefLabelHeight) 
	$label5.Text = "Generated >>"
	$Label5.BackColor = "Transparent"
	$form.Controls.Add($label5) 

	#Label: Generated Script
	$label6 = New-Object System.Windows.Forms.Label
	$label6.Location = New-Object System.Drawing.Point($Label6X,$Label6Y) 
	$label6.Size = New-Object System.Drawing.Size(($DefLabelWidth - 50),$DefLabelHeight) 
	$Label6.BackColor = "Transparent"
	$label6.Text = "Generated DB2 Script"
	$form.Controls.Add($label6) 

	#Rich Text Box: Generated Script
	$RichTextBox1 = New-Object System.Windows.Forms.RichTextBox
	$RichTextBox1.Location = New-Object System.Drawing.Size($RichTextBox1X,$RichTextBox1Y)
	$RichTextBox1.Size = New-Object System.Drawing.Size($DefRichTextBoxWidth,$DefRichTextBoxHeight)
	$RichTextBox1.WordWrap = $False
	$form.Controls.Add($RichTextBox1)

	#Button: Restore
	$RestoreButton = New-Object System.Windows.Forms.Button
	$RestoreButton.Location = New-Object System.Drawing.Size($RestoreButtonX,$RestoreButtonY)
	$RestoreButton.Size = New-Object System.Drawing.Size($DefButtonWidth,$DefRichTextBoxHeight)
	$RestoreButton.Text = "Start Restore"
	#$RestoreButton.enabled = $false	
	
	#Label: Progress Bar
	$label7 = New-Object System.Windows.Forms.Label
	$label7.Location = New-Object System.Drawing.Point($Label7X,$Label7Y) 
	$label7.Size = New-Object System.Drawing.Size($DefLabelWidth,$DefLabelHeight) 
	$CompletedPercentage = "Completed: " + 0 + "%"
	$label7.Text = $CompletedPercentage
	$label7.AutoSize =$True
	$Label7.BackColor = "Transparent"
	$form.Controls.Add($label7) 

	#Progress Bar
	$ProgressBar1 = New-Object System.Windows.Forms.ProgressBar
	$ProgressBar1.Size = New-Object System.Drawing.Size($DefProgressBarWidth,$DefProgressBarHeight)
	$ProgressBar1.Style = "Continuous"
	$ProgressBar1.Left = $ProgressBar1X
	$ProgressBar1.Top = $ProgressBar1Y
	$ProgressBar1.Minimum = 0
	$ProgressBar1.Maximum = 100
	$ProgressBar1.Step = 1
	$ProgressBarVal = 0
	$ProgressBar1.Value = $ProgressBarVal
	
	$form.Controls.Add($ProgressBar1)

	# Function RestoreButton_Click()
	# {
	# 	$form.Hide
	# 	$form.show()
	# 	do {
	# 		$form.Refresh()
	# 		$ProgressBarVal += 1
	# 		$CompletedPercentage = "Completed: " + $ProgressBarVal + "%"
	# 		$label7.Text = $CompletedPercentage
	# 		$ProgressBar1.Value = $ProgressBarVal
	# 		Start-sleep -Milliseconds 50
	# 	} until ($ProgressBarVal -eq 100)
	# }
	Function EnableForm
	{
		$form.enabled = $True
	}
	Function DisableForm
	{
		$form.enabled = $False
	}
	
	$RestoreButton.Add_Click({DisableForm;RestoreButton_Click;EnableForm;Button_Toggle})
	$form.Controls.Add($RestoreButton)
	$form.KeyPreview = $True
	$form.Add_KeyDown({if ($_.KeyCode -eq "Enter") 
	{SearchButton_Click}})
	$form.Add_KeyDown({if ($_.KeyCode -eq "Escape") 
	{CancelButton_Click}})
	#$form.Topmost = $True
	$form.ShowDialog() |Out-Null
	

}

# $RestoreDetails = New-Object PSObject -Property @{
#     "DatabasesAvailable" = (GetAvailableRestores -RestoreFromFQDN $RestoreFromFQDN -NetbackupInstallDir $NetbackupInstallDir)    
# }
#$SQLLibsTemp = $(ListInstancesOfSQLLibs -RegistryPath $RegistryPath)
#$InstancesTemp = $(GetInstanceDatabaseList -SQLLib $SQLLibsTemp)
# Start-Sleep -Seconds 15

$global:InstanceList = New-Object PSObject -Property @{
    "SQLLibs" = $(ListInstancesOfSQLLibs -RegistryPath $RegistryPath)
    "Instances" = $(GetInstanceDatabaseList -SQLLib @(ListInstancesOfSQLLibs -RegistryPath $RegistryPath))
}


DB2_Restore_GUI


