-- catalog htvudbmrm5 connections

-- Siebel Dev1
uncatalog node DB2SIED1;
uncatalog db SIEBDEV1;
uncatalog system odbc data source SIEBDEV1;

catalog tcpip node DB2SIED1 remote HTVUDBMRM5.DEV.HBF.COM.AU server 50004 remote_instance DB2SIED1 system HTVUDBMRM5 ostype win;
catalog db SIEBDEV1  as SIEBDEV1 at node DB2SIED1;
catalog system odbc data source SIEBDEV1;

-- Siebel Dev3
uncatalog node DB2SIED3;
uncatalog db SIEBDEV3;
uncatalog system odbc data source SIEBDEV3;

catalog tcpip node DB2SIED3 remote HTVUDBMRM5.DEV.HBF.COM.AU server 50002 remote_instance DB2SIED3 system HTVUDBMRM5 ostype win;
catalog db SIEBDEV3  as SIEBDEV3 at node DB2SIED3;
catalog system odbc data source SIEBDEV3;

-- Siebel Sit1
uncatalog db SIEBSIT1;
uncatalog system odbc data source SIEBSIT1;
uncatalog node DB2SIES1;

catalog tcpip node DB2SIES1 remote htvudbmrm5.dev.hbf.com.au server 50000 remote_instance DB2SIES1 system htvudbmrm5 ostype win;
catalog db SIEBSIT1 as SIEBSIT1 at node DB2SIES1;
catalog system odbc data source SIEBSIT1;

-- Siebel Sit2
uncatalog db SIEBSIT2;
uncatalog system odbc data source SIEBSIT2;
uncatalog node DB2SIES2;

catalog tcpip node DB2SIES2 remote htvudbmrm5.dev.hbf.com.au server 50000 remote_instance DB2SIEB system htvudbmrm5 ostype win;
catalog db SIEBSIT2 as SIEBSIT2 at node DB2SIES2;
catalog system odbc data source SIEBSIT2;

-- Siebel Sit3
uncatalog db SIEBSIT3;
uncatalog system odbc data source SIEBSIT3;
uncatalog node DB2SIES3;

catalog tcpip node DB2SIES3 remote htvudbmrm5.dev.hbf.com.au server 50010 remote_instance DB2SIES3 system htvudbmrm5 ostype win;
catalog db SIEBSIT3 as SIEBSIT3 at node DB2SIES3;
catalog system odbc data source SIEBSIT3;

terminate;