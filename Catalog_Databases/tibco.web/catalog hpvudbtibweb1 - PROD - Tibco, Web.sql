-- catalog hpvudbtibweb1 connections

-- Web External, Internal
uncatalog db DB_PRODA; 
uncatalog db DB_PRODI;
uncatalog system odbc data source DB_PRODA;
uncatalog system odbc data source DB_PRODI;
uncatalog node DB2WEB;

catalog tcpip node DB2WEB remote hpvudbtibweb1.corp.hbf.com.au server 50004 remote_instance DB2WEB system hpvudbtibweb1 ostype win;
catalog db DB_PRODA as DB_PRODA at node DB2WEB authentication SERVER;
catalog db DB_PRODI as DB_PRODI at node DB2WEB authentication SERVER;
catalog system odbc data source DB_PRODA;
catalog system odbc data source DB_PRODI;

-- Eclipse
uncatalog db DB_ECLP; 
uncatalog system odbc data source DB_ECLP;
uncatalog node DB2ECL;

catalog tcpip node DB2ECL remote hpvudbtibweb1.corp.hbf.com.au server 50002 remote_instance DB2ECL system hpvudbtibweb1 ostype win;
catalog db DB_ECLP as DB_ECLP at node DB2ECL  authentication SERVER;
catalog system odbc data source DB_ECLP;

-- Web Mobile 
uncatalog db DB_PRDOA;
uncatalog system odbc data source DB_PRDOA;
uncatalog node DB2OAUTH;

catalog tcpip node DB2OAUTH remote hpvudbtibweb1.corp.hbf.com.au server 50010 remote_instance DB2OAUTH system hpvudbtibweb1 ostype win;
catalog db DB_PRDOA as DB_PRDOA at node DB2OAUTH authentication SERVER;
catalog system odbc data source DB_PRDOA;

-- Tibco
uncatalog db DB_PRDAD;
uncatalog db DB_PRDCP;
uncatalog db DB_PRDEA;
uncatalog db DB_PRDLE;
uncatalog db DB_PRDSM;
uncatalog db DB_PRDTD;
uncatalog db DB_PRDUA;

uncatalog system odbc data source DB_PRDAD;
uncatalog system odbc data source DB_PRDCP;
uncatalog system odbc data source DB_PRDEA;
uncatalog system odbc data source DB_PRDLE;
uncatalog system odbc data source DB_PRDSM;
uncatalog system odbc data source DB_PRDTD;
uncatalog system odbc data source DB_PRDUA;

uncatalog node DB2TIBCO;

catalog tcpip node DB2TIBCO remote hpvudbtibweb1.corp.hbf.com.au server 50008 remote_instance DB2TIBCO system hpvudbtibweb1 ostype win;

catalog db DB_PRDEA as DB_PRDEA at node DB2TIBCO;
catalog db DB_PRDLE as DB_PRDLE at node DB2TIBCO;
catalog db DB_PRDSM as DB_PRDSM at node DB2TIBCO;
catalog db DB_PRDTD as DB_PRDTD at node DB2TIBCO;

catalog system odbc data source DB_PRDEA;
catalog system odbc data source DB_PRDLE;
catalog system odbc data source DB_PRDSM;
catalog system odbc data source DB_PRDTD;

-- ODS
uncatalog db DB_ODSP; 
uncatalog system odbc data source DB_ODSP;
uncatalog node DB2ODS;

catalog tcpip node DB2ODS remote hpvudbtibweb1.corp.hbf.com.au server 50012 remote_instance DB2ODS system hpvudbtibweb1 ostype win;
catalog db DB_ODSP as DB_ODSP at node DB2ODS authentication SERVER;
catalog system odbc data source DB_ODSP;

terminate;
