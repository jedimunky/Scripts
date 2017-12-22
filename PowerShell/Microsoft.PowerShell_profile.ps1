# Enable Db2 CLP
Set-Item -path env:DB2CLP -value "**$$**"
# Shortcuts
Function whoami {"You are "+$env:USERDOMAIN+"\"+$env:USERNAME+" on "+$env:COMPUTERNAME+"."+$env:USERDNSDOMAIN}
Function which ($cmd) {(Get-Command $cmd).Definition}
Function hn ($n = 10) { Get-History -Count $n }
Set-Alias np "D:\Program Files (x86)\Notepad++\notepad++.exe"
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
} # end cd function
Function drives { Get-PSDrive -PipelineVariable FileSystem | where {$_.free -gt 1MB} | Format-Table -AutoSize }
# Db2 Shortcuts
Function ds {Set-Location D:\Scripts\Db2}
Function lu {db2 list utilities show detail}
Set-Alias la .\listAllDb2Databases
Set-Alias ld .\listDb2Directory
Set-Alias i db2ilist
# Instance shortcuts
Function DB2WEB   {Set-Item -path env:DB2INSTANCE -value "DB2WEB"}
Function DB2TIBS3 {Set-Item -path env:DB2INSTANCE -value "DB2TIBS3"}
Function DB2TIBS2 {Set-Item -path env:DB2INSTANCE -value "DB2TIBS2"}
Function DB2TIBD3 {Set-Item -path env:DB2INSTANCE -value "DB2TIBD3"}
Function DB2OAUTH {Set-Item -path env:DB2INSTANCE -value "DB2OAUTH"}
Function DB2ECL   {Set-Item -path env:DB2INSTANCE -value "DB2ECL"}
# Working directory
Set-Location D:\Scripts\Db2
