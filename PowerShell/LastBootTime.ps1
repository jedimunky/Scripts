<#
.SYSNOPSIS
Shows when your PC last started up.
.DESCRIPTION
This is a WMI wrapper function to get the date and time that your PC last started up.
.PARAMETER ComputerName
The name of the computer you want to run the command on.
.EXAMPLE
LastBootTime -ComputerName localhost
.LINK
http://www.howtogeek.com/141495/geek-school-writing-your-first-full-powershell-script/
#>

param(
    [string]$ComputerName
    )

Get-WmiObject -Class Win32_OperatingSystem -ComputerName $ComputerName | 
Select-Object -Property CSName,@{n="Last Booted";e={[Management.ManagementDateTimeConverter]::ToDateTime($_.LastBootUpTime)}}