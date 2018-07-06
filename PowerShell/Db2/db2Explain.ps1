# Explain Db2 statement contained in specified text file
param([string]$stmt)

Function db?() # Checks for connection to a database
{
    $conndb = db2 connect
    if ($conndb -like "SQL1024N*")
    {
        Return 99
    } else {
        $dbalias = (($conndb | Select-String -Pattern "alias" -List).ToString().split("=")[1]).Trim()
        Return $dbalias
    }
}

Function explntabs() # Creates explain tables for user, verifies them if they exist
{
    $explntabs = db2 "select tabname from syscat.tables where tabschema = '$env:USERNAME' and tabname like 'EXPLAIN%'"
    $numrecs = ($explntabs | Select-String "record").ToString().Trim().Split(" ")[0]
    if ($numrecs -eq 0)
    {
        $explnobj = db2 "call sysproc.sysinstallobjects('EXPLAIN','C',CAST (NULL AS VARCHAR(128)),'$env:USERNAME')"
    } else {
        $explnobj = db2 "call sysproc.sysinstallobjects('EXPLAIN','V',CAST (NULL AS VARCHAR(128)),'$env:USERNAME')"
    }
    $explnobj = $explnobj.Trim()
    Return $explnobj
}

Function explain($stmt) # Calls the other functions, then excutes the explain
{
    $connected = db?
    if ($connected -ne 99)
    {
        $dbalias = $connected
        $explntabs = explntabs
        if ($explntabs -eq "Return Status = 0")
        {
            $stmt_out = "explain_"+($stmt.TrimStart(".\"))
            db2 set current explain mode explain
            db2 -tvf $stmt
            db2 set current explain mode no
            db2exfmt -d $dbalias -g TIC -w -1 -n %% -s %% -# 0 -o $stmt_out
            np $stmt_out
        } else {
            "Cannot verify explain tables."
        }
    } else {
        "No database connection."
    }
}

# Check files to explain exists, and call routine
if (-not [string]::IsNullOrEmpty($stmt))
{
    if (Test-Path -Path $stmt)
    {
        explain $stmt
    } else {
        "File not found."
    }
} else {
    "Usage: db2Explain <stmt.txt>"
}
