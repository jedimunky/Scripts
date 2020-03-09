# Enable Db2 CLP & NetBackup
Set-Item -Path env:DB2CLP -Value "**$$**"
Set-Item -Path Env:Path -Value "$env:Path;D:\Program Files\VERITAS\Netbackup\Bin\"
# Shortcuts
Function whoami {"You are "+$env:USERDOMAIN.ToLower()+"\"+$env:USERNAME.ToLower()+" on "+$env:COMPUTERNAME.ToLower()+"."+$env:USERDNSDOMAIN.ToLower()}
Function which ($cmd) {(Get-Command $cmd).Definition}
Function drives { Get-PSDrive -PipelineVariable FileSystem | where {$_.free -gt 1MB} | Format-Table -AutoSize }
Function hn ($n = 10) { Get-History -Count $n }
Remove-Item Alias:cd
Function cd { # allows you to go back using "cd -"
    if ($args[0] -eq '-') {
        $newdir=$OLDPWD
    } else {
        $newdir=$args[0]
    }
    $prev = Get-Location
    if ($newdir) {
        Set-Location $newdir
    }
    Set-Variable -Name OLDPWD -Value $prev -Scope global
} 
# Set up shortcuts to change copy, instance, and connect
& D:\Scripts\Db2\instanceDatabaseShortcuts.ps1
& D:\Scripts\Db2\swapDb2Copy.ps1
# Db2 Shortcuts
Function db2backup ($dbname) { #  backup a single database
	if (-not [string]::IsNullOrEmpty($dbname)) 	{
		"db2 backup db $dbname online load 'D:\Program Files\VERITAS\NetBackup\bin\nbdb2.dll' open 2 sessions dedup_device with 4 buffers buffer 1024"
		db2 "backup db $dbname online load 'D:\Program Files\VERITAS\NetBackup\bin\nbdb2.dll' open 2 sessions dedup_device with 4 buffers buffer 1024" 
	} else {
		"Usage: db2backup <dbname>"
	}
}
Function sd {Set-Location D:\Scripts\Db2}
Function lu {db2 list utilities show detail}
Function db {db2 list db directory on d | Select-String "Name"}
Function cr {db2 connect reset}
Function ladb {db2 list active databases}
Function lap {db2 list applications}
Function lapd {db2 list applications show detail > listappl.txt
               np listappl.txt}
Function la {$instlist = .\listAllDb2Databases
			 $instlist.Instances}
Function sq {$instlist = .\listAllDb2Databases
			 $instlist.SQLLibs}
Function a  ($filename) {
			 $filename = $filename.TrimStart(".\")
			 $outfile = "$filename.out"
			 db2 -tvf $filename > $outfile
			 np $outfile}			 
Set-Alias ld .\listDb2Directory.ps1
Set-Alias lb .\listDb2Backups.ps1
Set-Alias i db2ilist
Set-Alias np "D:\Program Files (x86)\Notepad++\notepad++.exe"
# Working directory
Set-Location D:\Scripts\Db2
