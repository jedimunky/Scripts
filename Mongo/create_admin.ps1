# Cuts a new MongoDB log file

# Set-up command
$mongo = "mongo.exe"
$command = "db.createUser( { user: `"svc_MongoDB`", pwd: `"nRo2ZWbvFxQVouKO`", roles: [`"root`", `"userAdminAnyDatabase`", `"dbAdminAnyDatabase`", `"readWriteAnyDatabase`"] } )"
$arguments = "localhost/admin -eval `"$command`""

# Execute command
Start-Process -FilePath $mongo -ArgumentList $arguments
