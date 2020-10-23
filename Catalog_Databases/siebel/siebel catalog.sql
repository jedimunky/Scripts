catalog tcpip node DB2SIEB remote hpvudbmrm1.corp.hbf.com.au server 50000 remote_instance DB2SIEB system hpvudbmrm1 ostype win;
catalog db SIEBPRD as SIEBPRD at node DB2SIEB;
catalog system odbc data source SIEBPRD;

catalog tcpip node DB2SIEBR remote hrvudbmrm1.corp.hbf.com.au server 50000 remote_instance DB2SIEB system hrvudbmrm1 ostype win;
catalog db SIEBRLS as SIEBRLS at node DB2SIEBR;
catalog system odbc data source SIEBRLS;

catalog tcpip node DB2SIEBT remote hrvudbmrm3.corp.hbf.com.au server 50002 remote_instance DB2SIEBT system hrvudbmrm3 ostype win;
catalog db SIEBTRN as SIEBTRN at node DB2SIEBT;
catalog system odbc data source SIEBTRN;

catalog tcpip node DB2SIED1 remote HTVUDBMRM5.DEV.HBF.COM.AU server 50004 remote_instance DB2SIED1 system HTVUDBMRM5 ostype win;
catalog db SIEBDEV1  as SIEBDEV1 at node DB2SIED1;
catalog system odbc data source SIEBDEV1;

catalog tcpip node DB2SIED3 remote HTVUDBMRM5.DEV.HBF.COM.AU server 50002 remote_instance DB2SIED3 system HTVUDBMRM5 ostype win;
catalog db SIEBDEV3  as SIEBDEV3 at node DB2SIED3;
catalog system odbc data source SIEBDEV3;

catalog tcpip node DB2SIES1 remote htvudbmrm5.dev.hbf.com.au server 50000 remote_instance DB2SIES1 system htvudbmrm5 ostype win;
catalog db SIEBSIT1 as SIEBSIT1 at node DB2SIES1;
catalog system odbc data source SIEBSIT1;

catalog tcpip node DB2SIES2 remote htvudbmrm5.dev.hbf.com.au server 50000 remote_instance DB2SIEB system htvudbmrm5 ostype win;
catalog db SIEBSIT2 as SIEBSIT2 at node DB2SIES2;
catalog system odbc data source SIEBSIT2;

catalog tcpip node DB2SIES3 remote htvudbmrm5.dev.hbf.com.au server 50010 remote_instance DB2SIES3 system htvudbmrm5 ostype win;
catalog db SIEBSIT3 as SIEBSIT3 at node DB2SIES3;
catalog system odbc data source SIEBSIT3;

catalog tcpip node DB2SIEBI remote htvudbmrm5.dev.hbf.com.au server 50012 remote_instance DB2SIEBI system htvudbmrm5 ostype win;
catalog db SIEBINT as SIEBINT at node DB2SIEBI;
catalog system odbc data source SIEBINT;

terminate;
