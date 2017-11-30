-- catalog htvudbmrm4 connections

-- Siebel D1 (Sandpit for the Siebel code repository)
uncatalog db SIEBDEV1;
uncatalog system odbc data source SIEBDEV1;
uncatalog node DB2SIED1;

catalog tcpip node DB2SIED1 remote htvudbmrm4.dev.hbf.com.au server 50004 remote_instance DB2SIED1 system htvudbmrm4 ostype win;
catalog db SIEBDEV1 as SIEBDEV1 at node DB2SIED1;
catalog system odbc data source SIEBDEV1;

-- Siebel A3 (Ven Sandpit)
uncatalog db SIEBADM3;
uncatalog system odbc data source SIEBADM3;
uncatalog node DB2SIEA3;

catalog tcpip node DB2SIEA3 remote htvudbmrm4.dev.hbf.com.au server 50006 remote_instance DB2SIEA3 system htvudbmrm4 ostype win;
catalog db SIEBADM3 as SIEBADM3 at node DB2SIEA3;
catalog system odbc data source SIEBADM3;

-- Siebel D3
uncatalog db SIEBDEV3;
uncatalog system odbc data source SIEBDEV3;
uncatalog node DB2SIED3;

catalog tcpip node DB2SIED3 remote htvudbmrm4.dev.hbf.com.au server 50002 remote_instance DB2SIED3 system htvudbmrm4 ostype win;
catalog db SIEBDEV3 as SIEBDEV3 at node DB2SIED3;
catalog system odbc data source SIEBDEV3;

-- Siebel Sit2
uncatalog db SIEBSIT2;
uncatalog system odbc data source SIEBSIT2;
uncatalog node DB2SIES2;

catalog tcpip node DB2SIES2 remote htvudbmrm4.dev.hbf.com.au server 50000 remote_instance DB2SIEB system htvudbmrm4 ostype win;
catalog db SIEBSIT2 as SIEBSIT2 at node DB2SIES2;
catalog system odbc data source SIEBSIT2;

terminate;