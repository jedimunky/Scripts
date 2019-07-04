-- catalog hpvldap5 connections

-- PROD
uncatalog db DPRODINT;
uncatalog db DPRODEXT;
uncatalog db DCLOGPRI;
uncatalog db DCLOGPRE;

uncatalog system odbc data source DPRODINT;
uncatalog system odbc data source DPRODEXT;
uncatalog system odbc data source DCLOGPRI;
uncatalog system odbc data source DCLOGPRE;

uncatalog node DPRODEXT;
uncatalog node DPRODINT;

catalog tcpip node DPRODEXT remote hpvldap5.corp.hbf.com.au server 50002 remote_instance LPRODEXT system hpvldap5 ostype win;
catalog tcpip node DPRODINT remote hpvldap5.corp.hbf.com.au server 50004 remote_instance LPRODINT system hpvldap5 ostype win;

catalog db LPRODINT as DPRODINT at node DPRODINT;
catalog db LPRODEXT as DPRODEXT at node DPRODEXT;
catalog db LDAPCLOG as DCLOGPRI at node DPRODINT;
catalog db LDAPCLOG as DCLOGPRE at node DPRODEXT;

catalog system odbc data source DPRODINT;
catalog system odbc data source DPRODEXT;
catalog system odbc data source DCLOGPRI;
catalog system odbc data source DCLOGPRE;

terminate;