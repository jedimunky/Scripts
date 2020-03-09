function write-section-header {
   $headerText=$args[0];
   ""
   "****************************************************************************************"
   "* $headerText                                                                           "
   "****************************************************************************************"
}

function write-clustergroup-header {
   ""
   "Name                                                               OwnerNode                                                          State"
   "----                                                               ---------                                                          -----"
}

#
# Main Code
#

$ErrorActionPreference = "Stop"; # Treat all errors as terminal

# Get parameters 
$MoveDirection=$args[0]; 

$PrimaryNode="HPVSQL23"
$SecondaryNode="HPVSQL24"

$Instances=@("BUSINESSINTEL"   , "CARDIOLOG"   , "SHAREPOINTPROD",   "DEFAULT"   ) 
$AGs      =@("BUSINESSINTEL_AG", "CARDIOLOG_AG", "SHAREPOINTPROD_AG","MSSQLSERVER_AG")

switch ($MoveDirection)  {
   Failover {$PassiveNode=$SecondaryNode}
   Failback {$PassiveNode=$PrimaryNode}
   default  {throw New-Object System.FormatException "MoveDirection parameter ($MoveDirection) invalid.  Must be 'Failover' or 'Failback'."}
}

write-section-header "Cluster Group - pre move"
Get-ClusterGroup

write-section-header "Move cluster - to $PassiveNode"

""
"Moving Cluster Resources to $PassiveNode"
write-clustergroup-header
Move-ClusterGroup "Cluster Group"     $PassiveNode 
Move-ClusterGroup "Available Storage" $PassiveNode

""
"Moving Availability Groups to $PassiveNode"
for ($i=0; $i -lt $Instances.length; $i++) {
   $InstanceName=$Instances[$i]
   $AgName=$AGs[$i]
   
   Switch-SqlAvailabilityGroup -Path SQLSERVER:\Sql\$PassiveNode\$InstanceName\AvailabilityGroups\$AgName # to test without failing over add flag -WhatIf
}

write-section-header "Cluster Group - post move"
write-clustergroup-header
Get-ClusterGroup