-- catalog SYSB mainframe connections

-- BDB2
uncatalog node HBFBDB2;
uncatalog dcs db HBFBDB2;
uncatalog db HBFBDB2;
uncatalog system odbc data source HBFBDB2;

catalog tcpip node HBFBDB2 remote vipasysb.corp.hbf.com.au server 496 system SYSB ostype os390;
catalog dcs db HBFBDB2 as HBFBDB2;
catalog db HBFBDB2 as HBFBDB2 at node HBFBDB2 authentication server;
catalog system odbc data source HBFBDB2;

-- DDB2
uncatalog node HBFDDB2;
uncatalog dcs db HBFDDB2;
uncatalog db HBFDDB2;
uncatalog system odbc data source HBFDDB2;

catalog tcpip node HBFDDB2 remote vipasysb.corp.hbf.com.au server 446 system SYSB ostype os390;
-- catalog tcpip node HBFDDB2 remote sysc.corp.hbf.com.au server 446 system SYSC ostype os390;
catalog dcs db HBFDDB2 as HBFDDB2;
catalog db HBFDDB2 as HBFDDB2 at node HBFDDB2 authentication server;
catalog system odbc data source HBFDDB2;

terminate;

