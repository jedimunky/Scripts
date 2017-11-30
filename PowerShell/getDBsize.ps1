Set-Location D:\scripts\Db2
$dblist  = .\listAllDb2Databases.ps1
$getsize = "CALL GET_DBSIZE_INFO(?, ?, ?, 0)"
$report  = ""

foreach ($item in $dblist) {
    $instance      = $item.Instance
    $SQLLibCopyBin = $item.SQLLibCopyBin
    $dbname        = $item.Database
    Set-Item -Path env:DB2CLP -value $SQLLibCopyBin
    Set-Item -Path env:DB2INSTANCE -value $Instance
    Set-Location $SQLLibCopyBin

    .\db2 +o "connect to $dbname"
    $dbSize = (.\db2 $getsize)
    .\db2 +o "connect reset"

    [int64]$Size = $dbSize[14].ToString().split("{:}")[1]
    switch ($Size) {
        {$Size -ge 1TB} {$dbSize = ("{0:N2}" -f ($Size/1TB)).ToString() + " TB" ; break}
        {$Size -ge 1GB} {$dbSize = ("{0:N2}" -f ($Size/1GB)).ToString() + " GB" ; break}
        {$Size -ge 1MB} {$dbSize = ("{0:N2}" -f ($Size/1MB)).ToString() + " MB" ; break}
        {$Size -ge 1KB} {$dbSize = ("{0:N2}" -f ($Size/1KB)).ToString() + " KB" ; break}
        Default { $dbSize = $Size + " Bytes" }
    }
    $report += "Database $dbname is $dbSize`n"
}
Set-Location D:\scripts\Db2
$report
