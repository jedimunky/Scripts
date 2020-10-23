catalog tcpip node DB2WEB remote hpvudbtibweb1.corp.hbf.com.au server 50004 remote_instance DB2WEB system hpvudbtibweb1 ostype win;
catalog db DB_PRODA as DB_PRODA at node DB2WEB authentication SERVER;
catalog db DB_PRODI as DB_PRODI at node DB2WEB authentication SERVER;
catalog system odbc data source DB_PRODA;
catalog system odbc data source DB_PRODI;

catalog tcpip node DB2ECL remote hpvudbtibweb1.corp.hbf.com.au server 50002 remote_instance DB2ECL system hpvudbtibweb1 ostype win;
catalog db DB_ECLP as DB_ECLP at node DB2ECL  authentication SERVER;
catalog system odbc data source DB_ECLP;

catalog tcpip node DB2OAUTH remote hpvudbtibweb1.corp.hbf.com.au server 50010 remote_instance DB2OAUTH system hpvudbtibweb1 ostype win;
catalog db DB_PRDOA as DB_PRDOA at node DB2OAUTH authentication SERVER;
catalog system odbc data source DB_PRDOA;

catalog tcpip node DB2TIBCO remote hpvudbtibweb1.corp.hbf.com.au server 50008 remote_instance DB2TIBCO system hpvudbtibweb1 ostype win;

catalog db DB_PRDEA as DB_PRDEA at node DB2TIBCO;
catalog db DB_PRDLE as DB_PRDLE at node DB2TIBCO;
catalog db DB_PRDSM as DB_PRDSM at node DB2TIBCO;
catalog db DB_PRDTD as DB_PRDTD at node DB2TIBCO;

catalog system odbc data source DB_PRDEA;
catalog system odbc data source DB_PRDLE;
catalog system odbc data source DB_PRDSM;
catalog system odbc data source DB_PRDTD;

catalog tcpip node DB2ODS remote hpvudbtibweb1.corp.hbf.com.au server 50012 remote_instance DB2ODS system hpvudbtibweb1 ostype win;
catalog db DB_ODSP as DB_ODSP at node DB2ODS authentication SERVER;
catalog system odbc data source DB_ODSP;

catalog tcpip node DB2WEBR remote hrvudbtibweb1.corp.hbf.com.au server 50004 remote_instance DB2WEB system hrvudbtibweb1 ostype win;

catalog db DB_RLSEA as WB_RLSEA at node DB2WEBR authentication SERVER;
catalog db DB_RLSEI as DB_RLSEI at node DB2WEBR authentication SERVER;
catalog db DB_TRNGA as DB_TRNGA at node DB2WEBR authentication SERVER;
catalog db DB_TRNGI as DB_TRNGI at node DB2WEBR authentication SERVER;

catalog system odbc data source WB_RLSEA;
catalog system odbc data source DB_RLSEI;
catalog system odbc data source DB_TRNGA;
catalog system odbc data source DB_TRNGI;

catalog tcpip node DB2ECLR remote hrvudbtibweb1.corp.hbf.com.au server 50002 remote_instance DB2ECL system hrvudbtibweb1 ostype win;
catalog db DB_ECLR as DB_ECLR at node DB2ECLR authentication SERVER;
catalog system odbc data source DB_ECLR;

catalog tcpip node DB2OAUTR remote hrvudbtibweb1.corp.hbf.com.au server 50010 remote_instance DB2OAUTH system hrvudbtibweb1 ostype win;
catalog db DB_RLSOA as DB_RLSOA at node DB2OAUTR authentication SERVER;
catalog system odbc data source DB_RLSOA;

catalog tcpip node DB2TIBR remote hrvudbtibweb1.corp.hbf.com.au server 50008 remote_instance DB2TIBCO system hrvudbtibweb1 ostype win;

catalog db DB_RLSEA as TB_RLSEA at node DB2TIBR;
catalog db DB_RLSLE as DB_RLSLE at node DB2TIBR;
catalog db DB_RLSSM as DB_RLSSM at node DB2TIBR;
catalog db DB_RLSTD as DB_RLSTD at node DB2TIBR;

catalog system odbc data source TB_RLSEA;
catalog system odbc data source DB_RLSLE;
catalog system odbc data source DB_RLSSM;
catalog system odbc data source DB_RLSTD;

catalog tcpip node DB2TIBT remote hrvudbtibweb1.corp.hbf.com.au server 50018 remote_instance DB2TIBT system hrvudbtibweb1 ostype win;

catalog db DB_TRNEA as DB_TRNEA at node DB2TIBT;
catalog db DB_TRNLE as DB_TRNLE at node DB2TIBT;
catalog db DB_TRNSM as DB_TRNSM at node DB2TIBT;
catalog db DB_TRNTD as DB_TRNTD at node DB2TIBT;

catalog system odbc data source DB_TRNEA;
catalog system odbc data source DB_TRNLE;
catalog system odbc data source DB_TRNSM;
catalog system odbc data source DB_TRNTD;

catalog tcpip node DB2ODSR remote hrvudbtibweb1.corp.hbf.com.au server 50012 remote_instance DB2ODS system hrvudbtibweb1 ostype win;
catalog db DB_ODSR as DB_ODSR at node DB2ODSR authentication SERVER;
catalog system odbc data source DB_ODSR;

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

catalog tcpip node DB2ECLT remote htvudbtibweb1.dev.hbf.com.au server 50002 remote_instance DB2ECL system htvudbtibweb1 ostype win;

catalog db DB_ECLD  as DB_ECLD  at node DB2ECLT authentication SERVER;
catalog db DB_ECLS2 as DB_ECLS2 at node DB2ECLT authentication SERVER;
catalog db DB_ECLS3 as DB_ECLS3 at node DB2ECLT authentication SERVER;

catalog system odbc data source DB_ECLD;
catalog system odbc data source DB_ECLS2;
catalog system odbc data source DB_ECLS3;

catalog tcpip node DB2OAUT2 remote htvudbtibweb1.dev.hbf.com.au server 50010 remote_instance DB2OAUTH system htvudbtibweb1 ostype win;

catalog db DB_DEVOA as DB_DEVOA at node DB2OAUT2 authentication SERVER;
catalog db DB_ST2OA as DB_ST2OA at node DB2OAUT2 authentication SERVER;
catalog db DB_ST3OA as DB_ST3OA at node DB2OAUT2 authentication SERVER;

catalog system odbc data source DB_DEVOA;
catalog system odbc data source DB_ST2OA;
catalog system odbc data source DB_ST3OA;

catalog tcpip node DB2TIBD3 remote htvudbtibweb1.dev.hbf.com.au server 50008 remote_instance DB2TIBD3 system htvudbtibweb1 ostype win;

catalog db DB_DV3EA as DB_DV3EA at node DB2TIBD3;
catalog db DB_DV3LE as DB_DV3LE at node DB2TIBD3;
catalog db DB_DV3SM as DB_DV3SM at node DB2TIBD3;
catalog db DB_DV3TD as DB_DV3TD at node DB2TIBD3;

catalog system odbc data source DB_DV3EA;
catalog system odbc data source DB_DV3LE;
catalog system odbc data source DB_DV3SM;
catalog system odbc data source DB_DV3TD;

catalog tcpip node DB2TIBS2 remote htvudbtibweb1.dev.hbf.com.au server 50012 remote_instance DB2TIBS2 system htvudbtibweb1 ostype win;

catalog db DB_ST2EA  as DB_ST2EA  at node DB2TIBS2;
catalog db DB_ST2LE  as DB_ST2LE  at node DB2TIBS2;
catalog db DB_ST2SM  as DB_ST2SM  at node DB2TIBS2;
catalog db DB_ST2TD  as DB_ST2TD  at node DB2TIBS2;

catalog system odbc data source DB_ST2EA;
catalog system odbc data source DB_ST2LE;
catalog system odbc data source DB_ST2SM;
catalog system odbc data source DB_ST2TD;

catalog tcpip node DB2TIBS3 remote htvudbtibweb1.dev.hbf.com.au server 50014 remote_instance DB2TIBS3 system htvudbtibweb1 ostype win;

catalog db DB_ST3EA  as DB_ST3EA  at node DB2TIBS3;
catalog db DB_ST3LE  as DB_ST3LE  at node DB2TIBS3;
catalog db DB_ST3SM  as DB_ST3SM  at node DB2TIBS3;
catalog db DB_ST3TD  as DB_ST3TD  at node DB2TIBS3;

catalog system odbc data source DB_ST3EA;
catalog system odbc data source DB_ST3LE;
catalog system odbc data source DB_ST3SM;
catalog system odbc data source DB_ST3TD;

catalog tcpip node DB2WEBI remote htvudbtibweb2.dev.hbf.com.au server 50004 remote_instance DB2WEB system htvudbtibweb2 ostype win;

catalog db DB_INTGA as DB_INTGA  at node DB2WEBI authentication SERVER;
catalog db DB_INTGI as DB_INTGI  at node DB2WEBI authentication SERVER;

catalog system odbc data source DB_INTGA;
catalog system odbc data source DB_INTGI;

catalog tcpip node DB2ECLI remote htvudbtibweb2.dev.hbf.com.au server 50002 remote_instance DB2ECL system htvudbtibweb2 ostype win;
catalog db DB_ECLI as DB_ECLI at node DB2ECLI authentication SERVER;
catalog system odbc data source DB_ECLI;

catalog tcpip node DB2OAUTI remote htvudbtibweb2.dev.hbf.com.au server 50010 remote_instance DB2OAUTH system htvudbtibweb2 ostype win;
catalog db DB_INTOA as DB_INTOA at node DB2OAUTI authentication SERVER;
catalog system odbc data source DB_INTOA;

catalog tcpip node DB2TIBI remote htvudbtibweb2.dev.hbf.com.au server 50008 remote_instance DB2TIBCO system htvudbtibweb2 ostype win;

catalog db DB_INTEA  as DB_INTEA  at node DB2TIBI;
catalog db DB_INTLE  as DB_INTLE  at node DB2TIBI;
catalog db DB_INTSM  as DB_INTSM  at node DB2TIBI;
catalog db DB_INTTD  as DB_INTTD  at node DB2TIBI;

catalog system odbc data source DB_INTEA;
catalog system odbc data source DB_INTLE;
catalog system odbc data source DB_INTSM;
catalog system odbc data source DB_INTTD;

catalog tcpip node DB2ODSD remote htvudbtibweb2.dev.hbf.com.au server 50012 remote_instance DB2ODS system htvudbtibweb2 ostype win;
catalog db DB_ODSD as DB_ODSD at node DB2ODSD authentication SERVER;
catalog system odbc data source DB_ODSD;

terminate;
