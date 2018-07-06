# Db2 file to be executed
Param([string]$filename)
$filename = $filename.TrimStart(".\")
$outfile = "$filename.out"
db2 -tvf $filename > $outfile
np $outfile
