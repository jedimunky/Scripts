-- catalog SYSC mainframe connections

-- BDB2 - De-identification
uncatalog dcs db HBFBDB2;
uncatalog db HBFBDB2;
uncatalog system odbc data source HBFBDB2;
uncatalog node HBFBDB2;

catalog tcpip node HBFBDB2 remote SYSC.DEV.HBF.COM.AU server 496 system SYSC ostype os390;
catalog dcs db HBFBDB2 as HBFBDB2;
catalog db HBFBDB2 as HBFBDB2 at node HBFBDB2 authentication server;
catalog system odbc data source HBFBDB2;

-- TDB2
uncatalog dcs db HBFTDB2;
uncatalog db HBFTDB2;
uncatalog system odbc data source HBFTDB2;
uncatalog node HBFTDB2;

catalog tcpip node HBFTDB2 remote SYSC.DEV.HBF.COM.AU server 456 system SYSC ostype os390;
catalog dcs db HBFTDB2 as HBFTDB2;
catalog db HBFTDB2 as HBFTDB2 at node HBFTDB2 authentication server;
catalog system odbc data source HBFTDB2;

-- RDB2
uncatalog dcs db HBFRDB2;
uncatalog db HBFRDB2;
uncatalog system odbc data source HBFRDB2;
uncatalog node HBFRDB2;

catalog tcpip node HBFRDB2 remote SYSC.DEV.HBF.COM.AU server 466 system SYSC ostype os390;
catalog dcs db HBFRDB2 as HBFRDB2;
catalog db HBFRDB2 as HBFRDB2 at node HBFRDB2 authentication server;
catalog system odbc data source HBFRDB2;

-- IDB2
uncatalog dcs db HBFIDB2;
uncatalog db HBFIDB2;
uncatalog system odbc data source HBFIDB2;
uncatalog node HBFIDB2;

catalog tcpip node HBFIDB2 remote SYSC.DEV.HBF.COM.AU server 486 system SYSC ostype os390;
catalog dcs db HBFIDB2 as HBFIDB2;
catalog db HBFIDB2 as HBFIDB2 at node HBFIDB2 authentication server;
catalog system odbc data source HBFIDB2;

terminate;