-- catalog htvldap2 connections

-- SIT2
uncatalog db LSIT2INT;
uncatalog db LSIT2EXT;
uncatalog db LCLOGS2I;
uncatalog db LCLOGS2E;

uncatalog system odbc data source LSIT2INT;
uncatalog system odbc data source LSIT2EXT;
uncatalog system odbc data source LCLOGS2I;
uncatalog system odbc data source LCLOGS2E;

uncatalog node LSIT2INT;
uncatalog node LSIT2EXT;

catalog tcpip node LSIT2INT remote htvldap2.dev.hbf.com.au server 50006 remote_instance LSIT2INT system htvldap2 ostype win;
catalog tcpip node LSIT2EXT remote htvldap2.dev.hbf.com.au server 50008 remote_instance LSIT2EXT system htvldap2 ostype win;

catalog db LSIT2INT as LSIT2INT at node LSIT2INT;
catalog db LSIT2EXT as LSIT2EXT at node LSIT2EXT;
catalog db LDAPCLOG as LCLOGS2I at node LSIT2INT;
catalog db LDAPCLOG as LCLOGS2E at node LSIT2EXT;

catalog system odbc data source LSIT2INT;
catalog system odbc data source LSIT2EXT;
catalog system odbc data source LCLOGS2I;
catalog system odbc data source LCLOGS2E;

-- SIT3
uncatalog db LSIT3INT;
uncatalog db LSIT3EXT;
uncatalog db LCLOGS3I;
uncatalog db LCLOGS3E;

uncatalog system odbc data source LSIT3INT;
uncatalog system odbc data source LSIT3EXT;
uncatalog system odbc data source LCLOGS3I;
uncatalog system odbc data source LCLOGS3E;

uncatalog node LSIT3INT;
uncatalog node LSIT3EXT;

catalog tcpip node LSIT3INT remote htvldap2.dev.hbf.com.au server 50002 remote_instance LSIT3INT system htvldap2 ostype win;
catalog tcpip node LSIT3EXT remote htvldap2.dev.hbf.com.au server 50004 remote_instance LSIT3EXT system htvldap2 ostype win;

catalog db LSIT3INT as LSIT3INT at node LSIT3INT;
catalog db LSIT3EXT as LSIT3EXT at node LSIT3EXT;
catalog db LDAPCLOG as LCLOGS3I at node LSIT3INT;
catalog db LDAPCLOG as LCLOGS3E at node LSIT3EXT;

catalog system odbc data source LSIT3INT;
catalog system odbc data source LSIT3EXT;
catalog system odbc data source LCLOGS3I;
catalog system odbc data source LCLOGS3E;

terminate;