-- catalog htvudbmrm2 connections

-- Siebel Sit3
uncatalog db SIEBSIT3;
uncatalog system odbc data source SIEBSIT3;
uncatalog node DB2SIES3;

catalog tcpip node DB2SIES3 remote htvudbmrm2.dev.hbf.com.au server 50000 remote_instance DB2SIEB system htvudbmrm2 ostype win;
catalog db SIEBSIT3 as SIEBSIT3 at node DB2SIES3;
catalog system odbc data source SIEBSIT3;

terminate;