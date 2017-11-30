# Cuts a new MongoDB log file

# Set-up command
$mongo = "mongo.exe"
$mongoauth = "--username `"svc_MongoDB`" --password `"nRo2ZWbvFxQVouKO`" --authenticationDatabase `"admin`""
$arguments = "localhost/admin -eval `"db.runCommand({logRotate:1})`" $mongoauth"

# Execute command
Start-Process -FilePath $mongo -ArgumentList $arguments
