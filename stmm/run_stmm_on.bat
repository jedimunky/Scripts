echo off
set param1=%1
db2 connect to %param1% user p1k using xxx > %param1%_stmm_out.txt
db2 -tvf stmm_on.txt                      >> %param1%_stmm_out.txt
db2 connect reset                         >> %param1%_stmm_out.txt
%param1%_stmm_out.txt
