-- catalog hrvudbtibweb1 connections

-- Web (trng, rlse)
uncatalog db WB_RLSEA; 
uncatalog db DB_RLSEI;
uncatalog db DB_TRNGA; 
uncatalog db DB_TRNGI;

uncatalog system odbc data source WB_RLSEA;
uncatalog system odbc data source DB_RLSEI;
uncatalog system odbc data source DB_TRNGA;
uncatalog system odbc data source DB_TRNGI;

uncatalog node DB2WEBR;

catalog tcpip node DB2WEBR remote hrvudbtibweb1.corp.hbf.com.au server 50004 remote_instance DB2WEB system hrvudbtibweb1 ostype win;

catalog db DB_RLSEA as WB_RLSEA at node DB2WEBR authentication SERVER;
catalog db DB_RLSEI as DB_RLSEI at node DB2WEBR authentication SERVER;
catalog db DB_TRNGA as DB_TRNGA at node DB2WEBR authentication SERVER;
catalog db DB_TRNGI as DB_TRNGI at node DB2WEBR authentication SERVER;

catalog system odbc data source WB_RLSEA;
catalog system odbc data source DB_RLSEI;
catalog system odbc data source DB_TRNGA;
catalog system odbc data source DB_TRNGI;

-- Eclipse (rlse)
uncatalog db DB_ECLR;
uncatalog system odbc data source DB_ECLR;
uncatalog node DB2ECLR;

catalog tcpip node DB2ECLR remote hrvudbtibweb1.corp.hbf.com.au server 50002 remote_instance DB2ECL system hrvudbtibweb1 ostype win;
catalog db DB_ECLR as DB_ECLR at node DB2ECLR authentication SERVER;
catalog system odbc data source DB_ECLR;

-- Web Mobile (rlse)
uncatalog db DB_RLSOA;
uncatalog system odbc data source DB_RLSOA;
uncatalog node DB2OAUTR;

catalog tcpip node DB2OAUTR remote hrvudbtibweb1.corp.hbf.com.au server 50010 remote_instance DB2OAUTH system hrvudbtibweb1 ostype win;
catalog db DB_RLSOA as DB_RLSOA at node DB2OAUTR authentication SERVER;
catalog system odbc data source DB_RLSOA;

-- Tibco rlse
uncatalog db DB_RLSAD;
uncatalog db DB_RLSCP;
uncatalog db TB_RLSEA;
uncatalog db DB_RLSLE;
uncatalog db DB_RLSSM;
uncatalog db DB_RLSTD;
uncatalog db DB_RLSUA;

uncatalog system odbc data source DB_RLSAD;
uncatalog system odbc data source DB_RLSCP;
uncatalog system odbc data source TB_RLSEA;
uncatalog system odbc data source DB_RLSLE;
uncatalog system odbc data source DB_RLSSM;
uncatalog system odbc data source DB_RLSTD;
uncatalog system odbc data source DB_RLSUA;

uncatalog node DB2TIBR;

catalog tcpip node DB2TIBR remote hrvudbtibweb1.corp.hbf.com.au server 50008 remote_instance DB2TIBCO system hrvudbtibweb1 ostype win;

catalog db DB_RLSEA as TB_RLSEA at node DB2TIBR;
catalog db DB_RLSLE as DB_RLSLE at node DB2TIBR;
catalog db DB_RLSSM as DB_RLSSM at node DB2TIBR;
catalog db DB_RLSTD as DB_RLSTD at node DB2TIBR;

catalog system odbc data source TB_RLSEA;
catalog system odbc data source DB_RLSLE;
catalog system odbc data source DB_RLSSM;
catalog system odbc data source DB_RLSTD;

-- Tibco trng
uncatalog db DB_TRNAD;
uncatalog db DB_TRNCP;
uncatalog db DB_TRNEA;
uncatalog db DB_TRNLE;
uncatalog db DB_TRNSM;
uncatalog db DB_TRNTD;
uncatalog db DB_TRNUA;

uncatalog system odbc data source DB_TRNAD;
uncatalog system odbc data source DB_TRNCP;
uncatalog system odbc data source DB_TRNEA;
uncatalog system odbc data source DB_TRNLE;
uncatalog system odbc data source DB_TRNSM;
uncatalog system odbc data source DB_TRNTD;
uncatalog system odbc data source DB_TRNUA;

uncatalog node DB2TIBT;

catalog tcpip node DB2TIBT remote hrvudbtibweb1.corp.hbf.com.au server 50018 remote_instance DB2TIBT system hrvudbtibweb1 ostype win;

catalog db DB_TRNEA as DB_TRNEA at node DB2TIBT;
catalog db DB_TRNLE as DB_TRNLE at node DB2TIBT;
catalog db DB_TRNSM as DB_TRNSM at node DB2TIBT;
catalog db DB_TRNTD as DB_TRNTD at node DB2TIBT;

catalog system odbc data source DB_TRNEA;
catalog system odbc data source DB_TRNLE;
catalog system odbc data source DB_TRNSM;
catalog system odbc data source DB_TRNTD;

-- ODS (rlse)
uncatalog db DB_ODSR; 
uncatalog system odbc data source DB_ODSR;
uncatalog node DB2ODSR;

catalog tcpip node DB2ODSR remote hrvudbtibweb1.corp.hbf.com.au server 50012 remote_instance DB2ODS system hrvudbtibweb1 ostype win;
catalog db DB_ODSR as DB_ODSR at node DB2ODSR authentication SERVER;
catalog system odbc data source DB_ODSR;

terminate;
