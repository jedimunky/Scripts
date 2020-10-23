catalog tcpip node HBFHDB2 remote SYSA.CORP.HBF.COM.AU server 476 system SYSA ostype os390;
catalog dcs db HBFHDB2 as HBFHDB2;
catalog db HBFHDB2 as HBFHDB2 at node HBFHDB2 authentication server;
catalog system odbc data source HBFHDB2;

catalog tcpip node HBFTDB2 remote SYSC.DEV.HBF.COM.AU server 456 system SYSC ostype os390;
catalog dcs db HBFTDB2 as HBFTDB2;
catalog db HBFTDB2 as HBFTDB2 at node HBFTDB2 authentication server;
catalog system odbc data source HBFTDB2;

catalog tcpip node HBFRDB2 remote SYSC.DEV.HBF.COM.AU server 466 system SYSC ostype os390;
catalog dcs db HBFRDB2 as HBFRDB2;
catalog db HBFRDB2 as HBFRDB2 at node HBFRDB2 authentication server;
catalog system odbc data source HBFRDB2;

catalog tcpip node HBFIDB2 remote SYSC.DEV.HBF.COM.AU server 486 system SYSC ostype os390;
catalog dcs db HBFIDB2 as HBFIDB2;
catalog db HBFIDB2 as HBFIDB2 at node HBFIDB2 authentication server;
catalog system odbc data source HBFIDB2;

terminate;
