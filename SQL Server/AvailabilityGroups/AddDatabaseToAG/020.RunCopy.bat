echo **************************************
echo * COPY THE BACKUP FILES TO THE STANDBY 
echo **************************************
echo.
COPY G:\SQLBackups\MSSQL13.SHAREPOINTPROD\AGInitialisation\*.bak \\HPVSQL24\G$\SQLBackups\MSSQL13.SHAREPOINTPROD\AGInitialisation
COPY G:\SQLBackups\MSSQL13.SHAREPOINTPROD\AGInitialisation\*.trn \\HPVSQL24\G$\SQLBackups\MSSQL13.SHAREPOINTPROD\AGInitialisation
