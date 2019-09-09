-- catalog htvudbmrm1 connections

-- Siebel Intg
uncatalog db SIEBINT;
uncatalog system odbc data source SIEBINT;
uncatalog node DB2SIEBI;

catalog tcpip node DB2SIEBI remote htvudbmrm1.dev.hbf.com.au server 50000 remote_instance DB2SIEB system htvudbmrm1 ostype win;
catalog db SIEBINT as SIEBINT at node DB2SIEBI;
catalog system odbc data source SIEBINT;

terminate;