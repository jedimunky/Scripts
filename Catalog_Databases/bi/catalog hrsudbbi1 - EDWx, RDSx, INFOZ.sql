-- catalog hrvudbbi1 connections

-- EDWD
uncatalog db DB_EDWDD;
uncatalog db DB_EDWSD;
uncatalog db DB_EDWLD;
uncatalog system odbc data source DB_EDWDD;
uncatalog system odbc data source DB_EDWSD;
uncatalog system odbc data source DB_EDWLD;
uncatalog node DB2EDWD2;

catalog tcpip node DB2EDWD2 remote hrsudbbi1.corp.hbf.com.au server 50030 remote_instance DB2EDWD2 system HRSUDBBI1 ostype win;
catalog db DB_EDWLD as DB_EDWLD at node DB2EDWD2;
catalog db DB_EDWDD as DB_EDWDD at node DB2EDWD2;
catalog db DB_EDWSD as DB_EDWSD at node DB2EDWD2;

-- EDWR
uncatalog db DB_EDWDR;
uncatalog db DB_EDWSR;
uncatalog db DB_EDWLR;
uncatalog system odbc data source DB_EDWDR;
uncatalog system odbc data source DB_EDWSR;
uncatalog system odbc data source DB_EDWLR;
uncatalog node DB2EDWR2;

catalog tcpip node DB2EDWR2 remote hrsudbbi1.corp.hbf.com.au server 50032 remote_instance DB2EDWR2 system HRSUDBBI1 ostype win;
catalog db DB_EDWLR as DB_EDWLR at node DB2EDWR2;
catalog db DB_EDWDR as DB_EDWDR at node DB2EDWR2;
catalog db DB_EDWSR as DB_EDWSR at node DB2EDWR2;

-- EDWS
uncatalog db DB_EDWDS;
uncatalog db DB_EDWSS;
uncatalog db DB_EDWLS;
uncatalog system odbc data source DB_EDWDS;
uncatalog system odbc data source DB_EDWSS;
uncatalog system odbc data source DB_EDWLS;
uncatalog node DB2EDWS2;

catalog tcpip node DB2EDWS2 remote hrsudbbi1.corp.hbf.com.au server 50040 remote_instance DB2EDWS2 system HRSUDBBI1 ostype win;
catalog db DB_EDWLS as DB_EDWLS at node DB2EDWS2;
catalog db DB_EDWDS as DB_EDWDS at node DB2EDWS2;
catalog db DB_EDWSS as DB_EDWSS at node DB2EDWS2;

-- RDS
uncatalog db DB_RDSR;
uncatalog db DB_RDSS;
uncatalog db DB_RDSD;
uncatalog system odbc data source DB_RDSR;
uncatalog system odbc data source DB_RDSS;
uncatalog system odbc data source DB_RDSD;
uncatalog node DB2RDSR2;

catalog tcpip node DB2RDSR2 remote hrsudbbi1.corp.hbf.com.au server 50036 remote_instance DB2RDS2 system HRSUDBBI1 ostype win;
catalog db DB_RDSR as DB_RDSR at node DB2RDSR2;
catalog db DB_RDSS as DB_RDSS at node DB2RDSR2;
catalog db DB_RDSD as DB_RDSD at node DB2RDSR2;
catalog system odbc data source DB_RDSR;
catalog system odbc data source DB_RDSS;
catalog system odbc data source DB_RDSD;

-- INFOZ
uncatalog db DB_INFOZ;
uncatalog node DB2LEG2;
uncatalog system odbc data source DB_INFOZ;

catalog tcpip node DB2LEG2 remote hrsudbbi1.corp.hbf.com.au server 50034 remote_instance DB2LEG2 system HRSUDBBI1 ostype win;
catalog db DB_INFOZ as DB_INFOZ at node DB2LEG2;
catalog system odbc data source DB_INFOZ;

terminate;