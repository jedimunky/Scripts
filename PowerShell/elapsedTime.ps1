$starttime = Get-Date -Format "dd/MM/yyyy HH:mm:ss"
$randomNumber = Get-Random -Minimum 10 -Maximum 20
Start-Sleep $randomNumber
$endtime = Get-Date -Format "dd/MM/yyyy HH:mm:ss"
$elapsed = New-TimeSpan -Start $starttime -End $endtime 
Write-Host "Start $starttime, End $endtime, Elapsed $elapsed"
