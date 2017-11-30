echo off
set param1=%1
db2 -tvf %param1%.txt >%param1%out.txt
%param1%out.txt

