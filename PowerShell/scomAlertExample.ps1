# custom scom alerting script
# search for 'master' in scom closed alerts to see working example

$api = New-Object -comObject “MOM.ScriptAPI”  
$PropertyBag = $api.CreatePropertyBag()

$ProdMediaServer = "hpsnbmed1"
$DRMediaServer = "hdsnbmed1"

$ProdMediaServerState = ""
$DRMediaServerState = ""

If (Test-Connection -ComputerName $ProdMediaServer -Count 2)
{
	if ((cmd /C """D:\Program Files\Veritas\Volmgr\bin\vmoprcmd.exe"" -hoststatus -h $ProdMediaServer") -like "*is Active*")
	{$ProdMediaServerState = "Active"}else{$ProdMediaServerState = "Deactive"}
}else{$ProdMediaServerState = "Unreachable"}

If (Test-Connection -ComputerName $DRMediaServer -Count 2)
{
	if ((cmd /C """D:\Program Files\Veritas\Volmgr\bin\vmoprcmd.exe"" -hoststatus -h $DRMediaServer") -like "*is Active*")
	{$DRMediaServerState = "Active"}else{$DRMediaServerState = "Deactive"}
}else{$DRMediaServerState = "Unreachable"}

$PropertyBag.AddValue($ProdMediaServer,"$ProdMediaServerState")
$PropertyBag.AddValue($DRMediaServer,"$DRMediaServerState")

$PropertyBag
