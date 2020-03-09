# Enable Db2 CLP
Set-Item -Path env:DB2CLP -Value "**$$**"
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
& "\\corp.hbf.com.au\corp\userdirs\P1K\Documents\Scripts\PowerShell\Db2\instanceDatabaseShortcuts.ps1"
# Db2 Shortcuts
& "\\corp.hbf.com.au\corp\userdirs\P1K\Documents\Scripts\PowerShell\Db2\listClientDb2Databases.ps1"
# Function db {db2 list db directory | Select-String "Alias" | Sort-Object}
Function cr {db2 connect reset}
Function a  ($filename) {
			 $filename = $filename.TrimStart(".\")
			 $outfile = "$filename.out"
			 db2 -tvf $filename > $outfile
			 np $outfile}			 
Set-Alias ld \\corp.hbf.com.au\corp\userdirs\P1K\Documents\Scripts\PowerShell\Db2\listDb2Directory.ps1
Set-Alias i db2ilist
Set-Alias np "C:\Program Files\Notepad++\notepad++.exe"
# Working directory
Set-Location \\corp.hbf.com.au\corp\userdirs\P1K\Documents
