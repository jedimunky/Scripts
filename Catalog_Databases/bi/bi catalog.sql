catalog tcpip node DB2INFO2 remote hpsudbbi1.corp.hbf.com.au server 50008 remote_instance DB2INFO2 system hpsudbbi1 ostype win;
catalog db DB_INFO as DB_INFO at node DB2INFO2;
catalog system odbc data source DB_INFO;

catalog tcpip node DB2RDS2 remote hpsudbbi1.corp.hbf.com.au server 50010 remote_instance DB2RDS2 system hpsudbbi1 ostype win;
catalog db DB_RDSP as DB_RDSP at node DB2RDS2;
catalog system odbc data source DB_RDSP;

catalog tcpip node DB2EDWP2 remote hpsudbbi1.corp.hbf.com.au server 50006 remote_instance DB2EDWP2 system hpsudbbi1 ostype win;
catalog db DB_EDWLP as DB_EDWLP at node DB2EDWP2;
catalog db DB_EDWDP as DB_EDWDP at node DB2EDWP2;
catalog db DB_EDWSP as DB_EDWSP at node DB2EDWP2;
catalog system odbc data source DB_EDWLP;
catalog system odbc data source DB_EDWDP;
catalog system odbc data source DB_EDWSP;

catalog tcpip node DB2OBIEE remote hpsudbbi1.corp.hbf.com.au server 50002 remote_instance DB2OBIEE system hpsudbbi1 ostype win;
catalog db PRDOBIEE as PRDOBIEE at node DB2OBIEE;
catalog system odbc data source PRDOBIEE;

catalog tcpip node DB2EDWD2 remote hrsudbbi1.corp.hbf.com.au server 50030 remote_instance DB2EDWD2 system HRSUDBBI1 ostype win;
catalog db DB_EDWLD as DB_EDWLD at node DB2EDWD2;
catalog db DB_EDWDD as DB_EDWDD at node DB2EDWD2;
catalog db DB_EDWSD as DB_EDWSD at node DB2EDWD2;

catalog tcpip node DB2EDWR2 remote hrsudbbi1.corp.hbf.com.au server 50032 remote_instance DB2EDWR2 system HRSUDBBI1 ostype win;
catalog db DB_EDWLR as DB_EDWLR at node DB2EDWR2;
catalog db DB_EDWDR as DB_EDWDR at node DB2EDWR2;
catalog db DB_EDWSR as DB_EDWSR at node DB2EDWR2;

catalog tcpip node DB2EDWS2 remote hrsudbbi1.corp.hbf.com.au server 50040 remote_instance DB2EDWS2 system HRSUDBBI1 ostype win;
catalog db DB_EDWLS as DB_EDWLS at node DB2EDWS2;
catalog db DB_EDWDS as DB_EDWDS at node DB2EDWS2;
catalog db DB_EDWSS as DB_EDWSS at node DB2EDWS2;

catalog tcpip node DB2RDSR2 remote hrsudbbi1.corp.hbf.com.au server 50036 remote_instance DB2RDS2 system HRSUDBBI1 ostype win;
catalog db DB_RDSR as DB_RDSR at node DB2RDSR2;
catalog db DB_RDSS as DB_RDSS at node DB2RDSR2;
catalog db DB_RDSD as DB_RDSD at node DB2RDSR2;
catalog system odbc data source DB_RDSR;
catalog system odbc data source DB_RDSS;
catalog system odbc data source DB_RDSD;

catalog tcpip node DB2LEG2 remote hrsudbbi1.corp.hbf.com.au server 50034 remote_instance DB2LEG2 system HRSUDBBI1 ostype win;
catalog db DB_INFOZ as DB_INFOZ at node DB2LEG2;
catalog system odbc data source DB_INFOZ;

terminate;
