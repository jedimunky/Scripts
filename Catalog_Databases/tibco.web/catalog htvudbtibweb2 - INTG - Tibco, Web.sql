-- catalog htvudbtibweb2 connections

-- Web (intg)
uncatalog db DB_INTGA;
uncatalog db DB_INTGI;

uncatalog system odbc data source DB_INTGA;
uncatalog system odbc data source DB_INTGI;

uncatalog node DB2WEBI;

catalog tcpip node DB2WEBI remote htvudbtibweb2.dev.hbf.com.au server 50004 remote_instance DB2WEB system htvudbtibweb2 ostype win;

catalog db DB_INTGA as DB_INTGA  at node DB2WEBI authentication SERVER;
catalog db DB_INTGI as DB_INTGI  at node DB2WEBI authentication SERVER;

catalog system odbc data source DB_INTGA;
catalog system odbc data source DB_INTGI;

-- Eclipse (intg)
uncatalog db DB_ECLI; 
uncatalog system odbc data source DB_ECLI;
uncatalog node DB2ECLI;

catalog tcpip node DB2ECLI remote htvudbtibweb2.dev.hbf.com.au server 50002 remote_instance DB2ECL system htvudbtibweb2 ostype win;
catalog db DB_ECLI as DB_ECLI at node DB2ECLI authentication SERVER;
catalog system odbc data source DB_ECLI;

-- Web Mobile (intg)
uncatalog db DB_INTOA;
uncatalog system odbc data source DB_INTOA;
uncatalog node DB2OAUTI;

catalog tcpip node DB2OAUTI remote htvudbtibweb2.dev.hbf.com.au server 50010 remote_instance DB2OAUTH system htvudbtibweb2 ostype win;
catalog db DB_INTOA as DB_INTOA at node DB2OAUTI authentication SERVER;
catalog system odbc data source DB_INTOA;

-- Tibco (intg)
uncatalog db DB_INTAD;
uncatalog db DB_INTEA;
uncatalog db DB_INTUA;
uncatalog db DB_INTLE;
uncatalog db DB_INTCP;
uncatalog db DB_INTSM;
uncatalog db DB_INTTD;

uncatalog system odbc data source DB_INTAD;
uncatalog system odbc data source DB_INTEA;
uncatalog system odbc data source DB_INTUA;
uncatalog system odbc data source DB_INTLE;
uncatalog system odbc data source DB_INTCP;
uncatalog system odbc data source DB_INTSM;
uncatalog system odbc data source DB_INTTD;

uncatalog node DB2TIBI;

catalog tcpip node DB2TIBI remote htvudbtibweb2.dev.hbf.com.au server 50008 remote_instance DB2TIBCO system htvudbtibweb2 ostype win;

catalog db DB_INTEA  as DB_INTEA  at node DB2TIBI;
catalog db DB_INTLE  as DB_INTLE  at node DB2TIBI;
catalog db DB_INTSM  as DB_INTSM  at node DB2TIBI;
catalog db DB_INTTD  as DB_INTTD  at node DB2TIBI;

catalog system odbc data source DB_INTEA;
catalog system odbc data source DB_INTLE;
catalog system odbc data source DB_INTSM;
catalog system odbc data source DB_INTTD;

terminate;