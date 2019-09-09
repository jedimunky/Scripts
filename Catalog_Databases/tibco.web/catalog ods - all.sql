-- ODS (Dev)
uncatalog db DB_ODSD; 
uncatalog system odbc data source DB_ODSD;
uncatalog node DB2ODSD;

catalog tcpip node DB2ODSD remote htvudbtibweb2.dev.hbf.com.au server 50012 remote_instance DB2ODS system htvudbtibweb2 ostype win;
catalog db DB_ODSD as DB_ODSD at node DB2ODSD authentication SERVER;
catalog system odbc data source DB_ODSD;

-- ODS (rlse)
uncatalog db DB_ODSR; 
uncatalog system odbc data source DB_ODSR;
uncatalog node DB2ODSR;

catalog tcpip node DB2ODSR remote hrvudbtibweb1.corp.hbf.com.au server 50012 remote_instance DB2ODS system hrvudbtibweb1 ostype win;
catalog db DB_ODSR as DB_ODSR at node DB2ODSR authentication SERVER;
catalog system odbc data source DB_ODSR;

-- ODS
uncatalog db DB_ODSP; 
uncatalog system odbc data source DB_ODSP;
uncatalog node DB2ODS;

catalog tcpip node DB2ODS remote hpvudbtibweb1.corp.hbf.com.au server 50012 remote_instance DB2ODS system hpvudbtibweb1 ostype win;
catalog db DB_ODSP as DB_ODSP at node DB2ODS authentication SERVER;
catalog system odbc data source DB_ODSP;

terminate;
