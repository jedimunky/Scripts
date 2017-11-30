-- catalog hpvudbmrm1 connections

-- Siebel Prod
uncatalog db SIEBPRD;
uncatalog system odbc data source SIEBPRD;
uncatalog node DB2SIEB;

catalog tcpip node DB2SIEB remote hpvudbmrm1.corp.hbf.com.au server 50000 remote_instance DB2SIEB system hpvudbmrm1 ostype win;
catalog db SIEBPRD as SIEBPRD at node DB2SIEB;
catalog system odbc data source SIEBPRD;

terminate;