$NumberOfMonths = 8
$After = Get-Date -Format d/MM/yyyy
$Before =(Get-Date).AddMonths($NumberOfMonths) | Get-Date -Format d/MM/yyyy
$Restrict = "NotAfter>=$After,NotAfter<=$Before"
$CertText = certutil -view -restrict $Restrict -out "RequesterName,CommonName,Certificate Expiration Date" |Select-String -Pattern "Requester Name:","Issued Common Name:","Certificate Expiration Date:"

$AmberColour = "FE8E00"
$RedColour = "FE0000"
$GreenColour = "00DD0D"
$BlueColour = "003EFE"

$Body = "<HTML><HEAD><META http-equiv=""Content-Type"" content=""text/html; charset=iso-8859-1"" /><TITLE></TITLE></HEAD>"
$Body += "<BODY bgcolor=""#FFFFFF"" style=""font-size: Small; font-family: TAHOMA; color: #000000""><P>"
$EmailTarget = "Cert_Admin <Cert_Admin@hbf.com.au>"
#$EmailTarget = "bowdi.nelson@hbf.com.au"
$EmailFrom = "Opsys <opsys@hbf.com.au>"
$EmailSubject = "Certificate Expiration List"
$EmailSMTPServer = "mail.corp.hbf.com.au"

If ($CertText.Length -ge 3)
{
	$Body += "<b>Dear Certificate Administrator</b><br>"
	$Body+="<br>" 
	$Body+="<b>Below is a list of Certificates due to expire in the next <b><font color=$BlueColour>$NumberOfMonths</b></font> months</b><br>"
	$Body+="<br>" 
	$Body+="<b><font color=$GreenColour>Green: Expiration date is further than 80 days away</font></b><br>"
	$Body+="<b><font color=$AmberColour>Amber: Expiration date is within the next 80 days</font></b><br>"
	$Body+="<b><font color=$RedColour>Red: Expiration date is within the next 40 days</font></b><br>"
	$Body+="<br>" 
	For($intCounter=0; $intCounter -lt $CertText.length; $intCounter+=3)
	{
		If (!($CertText[$intCounter] -like "*ntdomain\hpw7*" -or $CertText[$intCounter] -like "*ntdomain\hdrw7*" -or $CertText[$intCounter] -like "*ntdomain\hbfw7*" -or $CertText[$intCounter] -like "*ntdomain\gmfw7*" -or $CertText[$intCounter] -like "*ntdomain\HBFW10*" -or $CertText[$intCounter] -like "*ntdomain\HTW7T*" -or $CertText[$intCounter] -like "*ntdomain\HDW7P*" -or $CertText[$intCounter] -like "*ntdomain\GM-W10-P*" -or $CertText[$intCounter] -like "*ntdomain\HBFTHINAPP*"))                                
		{
			$DateCheck = ($CertText[$intCounter+2]).tostring()
			$DateCheck = $DateCheck.Substring(31,$DateCheck.Length-31)
			$Datecheck = get-date($DateCheck)
						
			$StartDate=(GET-DATE)
			$TextColour = ""
			$NumberofDays = (New-timespan -start $StartDate -End $DateCheck).Days
			
			If($NumberofDays -lt 40)
			{$TextColour = "$RedColour"}
			elseif ($NumberofDays -lt 80)
			{$TextColour = "$AmberColour"}
			else
			{$TextColour = "$GreenColour"}
			
			$Text = ($CertText[$intCounter]).tostring()
			$Body += "$Text<br>"
			$Text = ($CertText[$intCounter+1]).tostring()
			$Body+="$Text<br>"
			$Text = ($CertText[$intCounter+2]).tostring()
			$Body+="<font color=$TextColour>$Text</font><br>"
			$Body+="<br>" 
		}
	}
	
}
Send-MailMessage -to $EmailTarget -from $EmailFrom -subject $EmailSubject -smtpserver $EmailSMTPServer -Body $Body -BodyAsHtml
