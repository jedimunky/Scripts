-- catalog hpsudbbi1 connections

-- INFO
uncatalog db DB_INFO;
uncatalog system odbc data source DB_INFO;
uncatalog node DB2INFO2;

catalog tcpip node DB2INFO2 remote hpsudbbi1.corp.hbf.com.au server 50008 remote_instance DB2INFO2 system hpsudbbi1 ostype win;
catalog db DB_INFO as DB_INFO at node DB2INFO2;
catalog system odbc data source DB_INFO;

-- RDS
uncatalog db DB_RDSP;
uncatalog system odbc data source DB_RDSP;
uncatalog node DB2RDS2;

catalog tcpip node DB2RDS2 remote hpsudbbi1.corp.hbf.com.au server 50010 remote_instance DB2RDS2 system hpsudbbi1 ostype win;
catalog db DB_RDSP as DB_RDSP at node DB2RDS2;
catalog system odbc data source DB_RDSP;

-- EDW
uncatalog db DB_EDWLP;
uncatalog db DB_EDWDP;
uncatalog db DB_EDWSP;
uncatalog system odbc data source DB_EDWDP;
uncatalog system odbc data source DB_EDWLP;
uncatalog system odbc data source DB_EDWSP;
uncatalog node DB2EDWP2;

catalog tcpip node DB2EDWP2 remote hpsudbbi1.corp.hbf.com.au server 50006 remote_instance DB2EDWP2 system hpsudbbi1 ostype win;
catalog db DB_EDWLP as DB_EDWLP at node DB2EDWP2;
catalog db DB_EDWDP as DB_EDWDP at node DB2EDWP2;
catalog db DB_EDWSP as DB_EDWSP at node DB2EDWP2;
catalog system odbc data source DB_EDWLP;
catalog system odbc data source DB_EDWDP;
catalog system odbc data source DB_EDWSP;

-- Siebel analytics
uncatalog db PRDOBIEE;
uncatalog system odbc data source PRDOBIEE;
uncatalog node DB2OBIEE;

catalog tcpip node DB2OBIEE remote hpsudbbi1.corp.hbf.com.au server 50002 remote_instance DB2OBIEE system hpsudbbi1 ostype win;
catalog db PRDOBIEE as PRDOBIEE at node DB2OBIEE;
catalog system odbc data source PRDOBIEE;

terminate;