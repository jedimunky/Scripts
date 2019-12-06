<#
.SYNOPSIS
    Lists currently installed Oracle databases.
.DESCRIPTION
    Reads the Windows Registry and provides a list of current installs,
    Home Names, locations and useful values.
.NOTES
    File Name  : List-OracleDatabases.ps1
    Author     : Paul King - paul.king@hbf.com.au
.LINK
    https://au.linkedin.com/in/kingpa
.EXAMPLE
    .\List-OracleDatabases.ps1
.RETURNVALUE
	Oracle_SID
	Oracel_Base
	Oracle_Home
	Oracle_Home_Name
#>

$CurrentLocation = Get-Location
$OraRegPath      = "HKLM:\SOFTWARE\ORACLE\"

Function Search-OracleDetails ([string]$OraRegPath)
{
<#
    Navigate to Oracle registry key
    Get list of all Oracle installs
#>
    Set-Location $OraRegPath
    $OracleInstalls = Get-ChildItem KEY* | Get-ItemProperty
	$OracleList     = @()
    
    foreach ($item in $OracleInstalls) 
    {
        $OracleList += $OracleInstalls
    }

    Set-Location -Path $CurrentLocation
    return $OracleList
}

Function Get-OracleDetails ()
{
<#
	Format the raw registry details
	into a neat Powershell list
#>
	$OracleList = Search-OracleDetails $OraRegPath
	
	ForEach ($item in $OracleList)
	{
		$OracleDetails = New-Object PSObject -Property @{
			"Oracle_SID"       = $item.ORACLE_SID
			"Oracel_Base"      = $item.ORACLE_BASE
			"Oracle_Home"      = $item.ORACLE_HOME
			"Oracle_Home_Name" = $item.ORACLE_HOME_NAME
		}
	}
	
	$OracleDetails | Select-Object -Property Oracle_SID, Oracel_Base, Oracle_Home, Oracle_Home_Name | Sort-Object Oracle_SID | Format-Table -AutoSize
}

Get-OracleDetails
