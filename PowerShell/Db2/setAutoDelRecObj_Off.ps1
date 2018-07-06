$biglist = .\listAllDb2Databases.ps1
$dblist = $biglist.Instances
foreach ($i in $dblist) {
	$inst = $i.Instance
	$db   = $i.Database
	
	Set-Item -path env:DB2INSTANCE -value $inst
	$auto = (db2 get db cfg for $db | sls "AUTO_DEL")
	"Instance: " + $inst + ", Database: " + $db + ", " + $auto
	if ($auto -like "*= ON") {
		db2 connect to $db
		db2 update db cfg using AUTO_DEL_REC_OBJ OFF
		db2 connect reset
	}
}
