@echo off
set PadStringTemp=                                                                                                                                           
if \{%3\}==\{\}  @echo Syntax: PadString String newString Size&goto :EOF
call set %2=%%%1%% %%%PadStringTemp:~0,^%3%%%
call set %2=%%%2:~0,^%3%%