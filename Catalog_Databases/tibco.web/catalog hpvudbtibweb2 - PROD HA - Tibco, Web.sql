-- catalog hpvudbtibweb2 connections

-- Web External, Internal
uncatalog db DB_PRODA; 
uncatalog db DB_PRODI;
uncatalog system odbc data source DB_PRODA;
uncatalog system odbc data source DB_PRODI;
uncatalog node DB2WEB;

catalog tcpip node DB2WEB remote hpvudbtibweb2.corp.hbf.com.au server 50004 remote_instance DB2WEB system hpvudbtibweb2 ostype win;
catalog db DB_PRODA as DB_PRODA at node DB2WEB authentication SERVER;
catalog db DB_PRODI as DB_PRODI at node DB2WEB authentication SERVER;
catalog system odbc data source DB_PRODA;
catalog system odbc data source DB_PRODI;

-- Eclipse
uncatalog db DB_ECLP; 
uncatalog system odbc data source DB_ECLP;
uncatalog node DB2ECL;

catalog tcpip node DB2ECL remote hpvudbtibweb2.corp.hbf.com.au server 50002 remote_instance DB2ECL system hpvudbtibweb2 ostype win;
catalog db DB_ECLP as DB_ECLP at node DB2ECL  authentication SERVER;
catalog system odbc data source DB_ECLP;

-- Web Mobile 
uncatalog db DB_PRDOA;
uncatalog system odbc data source DB_PRDOA;
uncatalog node DB2OAUTH;

catalog tcpip node DB2OAUTH remote hpvudbtibweb2.corp.hbf.com.au server 50010 remote_instance DB2OAUTH system hpvudbtibweb2 ostype win;
catalog db DB_PRDOA as DB_PRDOA at node DB2OAUTH authentication SERVER;
catalog system odbc data source DB_PRDOA;

terminate;