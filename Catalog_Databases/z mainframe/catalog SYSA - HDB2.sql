-- catalog SYSA mainframe connections

-- HDB2
uncatalog dcs db HBFHDB2;
uncatalog db HBFHDB2;
uncatalog system odbc data source HBFHDB2;
uncatalog node HBFHDB2;

catalog tcpip node HBFHDB2 remote SYSA.CORP.HBF.COM.AU server 476 system SYSA ostype os390;
catalog dcs db HBFHDB2 as HBFHDB2;
catalog db HBFHDB2 as HBFHDB2 at node HBFHDB2 authentication server;
catalog system odbc data source HBFHDB2;

terminate;