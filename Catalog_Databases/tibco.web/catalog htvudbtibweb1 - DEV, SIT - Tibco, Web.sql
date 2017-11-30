-- catalog htvudbtibweb1 connections

-- Web (dev, sit2, sit3)
uncatalog db DB_DEVLI;
uncatalog db DB_DEVLA;
uncatalog db DB_ST2I;
uncatalog db DB_ST2A;
uncatalog db DB_ST3I;
uncatalog db DB_ST3A;

uncatalog system odbc data source DB_DEVLI;
uncatalog system odbc data source DB_DEVLA;
uncatalog system odbc data source DB_ST2I;
uncatalog system odbc data source DB_ST2A;
uncatalog system odbc data source DB_ST3I;
uncatalog system odbc data source DB_ST3A;

uncatalog node DB2WEBT;

catalog tcpip node DB2WEBT remote htvudbtibweb1.dev.hbf.com.au server 50004 remote_instance DB2WEB system htvudbtibweb1 ostype win;

catalog db DB_DEVLI as DB_DEVLI  at node DB2WEBT authentication SERVER;
catalog db DB_DEVLA as DB_DEVLA  at node DB2WEBT authentication SERVER;
catalog db DB_ST2I  as DB_ST2I   at node DB2WEBT authentication SERVER;
catalog db DB_ST2A  as DB_ST2A   at node DB2WEBT authentication SERVER;
catalog db DB_ST3I  as DB_ST3I   at node DB2WEBT authentication SERVER;
catalog db DB_ST3A  as DB_ST3A   at node DB2WEBT authentication SERVER;

catalog system odbc data source DB_DEVLI;
catalog system odbc data source DB_DEVLA;
catalog system odbc data source DB_ST2I;
catalog system odbc data source DB_ST2A;
catalog system odbc data source DB_ST3I;
catalog system odbc data source DB_ST3A;

-- Eclipse (dev, sit2, sit3)
uncatalog db DB_ECLD;
uncatalog db DB_ECLS2;
uncatalog db DB_ECLS3;

uncatalog system odbc data source DB_ECLD;
uncatalog system odbc data source DB_ECLS2;
uncatalog system odbc data source DB_ECLS3;

uncatalog node DB2ECLT;

catalog tcpip node DB2ECLT remote htvudbtibweb1.dev.hbf.com.au server 50002 remote_instance DB2ECL system htvudbtibweb1 ostype win;

catalog db DB_ECLD  as DB_ECLD  at node DB2ECLT authentication SERVER;
catalog db DB_ECLS2 as DB_ECLS2 at node DB2ECLT authentication SERVER;
catalog db DB_ECLS3 as DB_ECLS3 at node DB2ECLT authentication SERVER;

catalog system odbc data source DB_ECLD;
catalog system odbc data source DB_ECLS2;
catalog system odbc data source DB_ECLS3;

-- Web Mobile (dev, sit2, sit3)
uncatalog db DB_DEVOA;
uncatalog db DB_ST2OA;
uncatalog db DB_ST3OA;

uncatalog system odbc data source DB_DEVOA;
uncatalog system odbc data source DB_ST2OA;
uncatalog system odbc data source DB_ST3OA;

uncatalog node DB2OAUT2;

catalog tcpip node DB2OAUT2 remote htvudbtibweb1.dev.hbf.com.au server 50010 remote_instance DB2OAUTH system htvudbtibweb1 ostype win;

catalog db DB_DEVOA as DB_DEVOA at node DB2OAUT2 authentication SERVER;
catalog db DB_ST2OA as DB_ST2OA at node DB2OAUT2 authentication SERVER;
catalog db DB_ST3OA as DB_ST3OA at node DB2OAUT2 authentication SERVER;

catalog system odbc data source DB_DEVOA;
catalog system odbc data source DB_ST2OA;
catalog system odbc data source DB_ST3OA;

-- Tibco (dev)
-- Legacy
uncatalog db DB_DV3AD;
uncatalog db DB_DV3CP;
uncatalog db DB_DV3UA;
uncatalog system odbc data source DB_DV3AD;
uncatalog system odbc data source DB_DV3CP;
uncatalog system odbc data source DB_DV3UA;

-- Current
uncatalog db DB_DV3EA;
uncatalog db DB_DV3LE;
uncatalog db DB_DV3SM;
uncatalog db DB_DV3TD;
uncatalog system odbc data source DB_DV3EA;
uncatalog system odbc data source DB_DV3LE;
uncatalog system odbc data source DB_DV3SM;
uncatalog system odbc data source DB_DV3TD;

uncatalog node DB2TIBD3;

catalog tcpip node DB2TIBD3 remote htvudbtibweb1.dev.hbf.com.au server 50008 remote_instance DB2TIBD3 system htvudbtibweb1 ostype win;

catalog db DB_DV3EA as DB_DV3EA at node DB2TIBD3;
catalog db DB_DV3LE as DB_DV3LE at node DB2TIBD3;
catalog db DB_DV3SM as DB_DV3SM at node DB2TIBD3;
catalog db DB_DV3TD as DB_DV3TD at node DB2TIBD3;

catalog system odbc data source DB_DV3EA;
catalog system odbc data source DB_DV3LE;
catalog system odbc data source DB_DV3SM;
catalog system odbc data source DB_DV3TD;

-- Tibco (sit2)
-- Legacy
uncatalog db DB_ST2AD;
uncatalog db DB_ST2CP;
uncatalog db DB_ST2UA;
uncatalog system odbc data source DB_ST2AD;
uncatalog system odbc data source DB_ST2CP;
uncatalog system odbc data source DB_ST2UA;

-- Current
uncatalog db DB_ST2EA;
uncatalog db DB_ST2LE;
uncatalog db DB_ST2SM;
uncatalog db DB_ST2TD;
uncatalog system odbc data source DB_ST2EA;
uncatalog system odbc data source DB_ST2LE;
uncatalog system odbc data source DB_ST2SM;
uncatalog system odbc data source DB_ST2TD;

uncatalog node DB2TIBS2;

catalog tcpip node DB2TIBS2 remote htvudbtibweb1.dev.hbf.com.au server 50012 remote_instance DB2TIBS2 system htvudbtibweb1 ostype win;

catalog db DB_ST2EA  as DB_ST2EA  at node DB2TIBS2;
catalog db DB_ST2LE  as DB_ST2LE  at node DB2TIBS2;
catalog db DB_ST2SM  as DB_ST2SM  at node DB2TIBS2;
catalog db DB_ST2TD  as DB_ST2TD  at node DB2TIBS2;

catalog system odbc data source DB_ST2EA;
catalog system odbc data source DB_ST2LE;
catalog system odbc data source DB_ST2SM;
catalog system odbc data source DB_ST2TD;

-- Tibco (sit3)
-- Legacy
uncatalog db DB_ST3AD;
uncatalog db DB_ST3CP;
uncatalog db DB_ST3UA;
uncatalog system odbc data source DB_ST3AD;
uncatalog system odbc data source DB_ST3CP;
uncatalog system odbc data source DB_ST3UA;

-- Current
uncatalog db DB_ST3EA;
uncatalog db DB_ST3LE;
uncatalog db DB_ST3SM;
uncatalog db DB_ST3TD;
uncatalog system odbc data source DB_ST3EA;
uncatalog system odbc data source DB_ST3LE;
uncatalog system odbc data source DB_ST3SM;
uncatalog system odbc data source DB_ST3TD;

uncatalog node DB2TIBS3;

catalog tcpip node DB2TIBS3 remote htvudbtibweb1.dev.hbf.com.au server 50014 remote_instance DB2TIBS3 system htvudbtibweb1 ostype win;

catalog db DB_ST3EA  as DB_ST3EA  at node DB2TIBS3;
catalog db DB_ST3LE  as DB_ST3LE  at node DB2TIBS3;
catalog db DB_ST3SM  as DB_ST3SM  at node DB2TIBS3;
catalog db DB_ST3TD  as DB_ST3TD  at node DB2TIBS3;

catalog system odbc data source DB_ST3EA;
catalog system odbc data source DB_ST3LE;
catalog system odbc data source DB_ST3SM;
catalog system odbc data source DB_ST3TD;

terminate;