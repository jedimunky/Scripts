
function write-log {
   write-host (Get-Date).ToString('yyyy-MM-dd-HH:mm:ss') $args
}

function check-capture-time {
   # Create and open a connection to the database
   $conn = new-object system.data.odbc.odbcConnection
   #$conn.connectionstring = "Driver={IBM DB2 ODBC DRIVER};Database=HBFHDB2;HostName=hrsudbbi1.corp.hbf.com.au;Protocol=TCPIP;Port=50030;Uid=asn;Pwd=YamahaR1;CurrentSchema=PRODA"
   $conn.connectionstring = "Driver={IBM DB2 ODBC DRIVER};Database=HBFHDB2;HostName=sysa.corp.hbf.com.au;Protocol=TCPIP;Port=476;Uid=asn;Pwd=YamahaR1;CurrentSchema=PRODA"
   $conn.open()

   # Set up the stored procedure call
   $cmd2             = New-Object System.Data.Odbc.OdbcCommand;
   $cmd2.connection  = $conn;
   $cmd2.CommandType = [System.Data.CommandType]::StoredProcedure;
   $cmd2.CommandText = "CALL DBA.CAPTURE_CHECK(?,?,?,?)";
   $cmd2.Parameters.AddWithValue("P_APPLY_QUAL","$applyQual").Direction=[System.Data.ParameterDirection]::Input; # this could be hard-coded if ya like
   $cmd2.Parameters.Add("P_PROCESS_POINT", [System.Data.Odbc.OdbcType]::DateTime).Direction=[System.Data.ParameterDirection]::Output;
   $cmd2.Parameters.Add("P_SYNCHTIME", [System.Data.Odbc.OdbcType]::DateTime).Direction=[System.Data.ParameterDirection]::Output;
   $cmd2.Parameters.Add("P_RETURN_CODE", [System.Data.Odbc.OdbcType]::Char,6).Direction=[System.Data.ParameterDirection]::Output;

   # Create and fill the dataset (essentially run the command) ...
   write-host ""
   write-log  "Running CAPTURE_CHECK stored procedure"
   $ds2 = New-Object system.Data.DataSet
   $da2 = New-Object system.Data.odbc.odbcDataAdapter($cmd2)
   [void]$da2.fill($ds2)

   # Close the connection
   $conn.close()

   # Display the parameters
   write-host  ""
   write-log $cmd2.Parameters.Item(0).ParameterName.PadRight(15) ": " $cmd2.Parameters.Item(0).Value
   write-log $cmd2.Parameters.Item(1).ParameterName.PadRight(15) ": " $cmd2.Parameters.Item(1).Value
   write-log $cmd2.Parameters.Item(2).ParameterName.PadRight(15) ": " $cmd2.Parameters.Item(2).Value
   write-log $cmd2.Parameters.Item(3).ParameterName.PadRight(15) ": " $cmd2.Parameters.Item(3).Value

   # Return this value to the calling program
   #$script:P_RETURN_CODE = $cmd2.Parameters.Item(3).Value
   $cmd2.Parameters.Item(3).Value
}


#
# Main Code
#

$ErrorActionPreference = "Stop"; # Treat all errors as terminal
$applyQual=$args[0]; # Get the apply qualifier parameter

# Retry variables\constants
$retryCount     = 0;
$maxRetryCount  = 10;
$retrySleepSecs = 300;

DO {
   $P_RETURN_CODE = check-capture-time

   write-host ""
   SWITCH ($P_RETURN_CODE.TRIM()) {
      HAPPY   {write-log "All is good, finishing up"
	          }
      RETRY   {$retryCount = $retryCount + 1;
	           if ($retryCount -gt $maxRetryCount) {write-log "Error, maximum retries ($maxRetryCount) exceeded"; exit 1;}
			   write-log "Need to retry, sleeping for $retrySleepSecs seconds"; 
			   Start-Sleep -s $retrySleepSecs;
			  }
      default {write-log "Error, P_RETURN_CODE is invalid"; 
	           exit 1;
			  }
   }
      
} WHILE ($P_RETURN_CODE.TRIM() -eq "RETRY")




