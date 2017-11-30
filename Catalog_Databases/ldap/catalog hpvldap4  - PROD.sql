-- catalog hpvldap4 connections

-- PROD
uncatalog db LPRODINT;
uncatalog db LPRODEXT;
uncatalog db LCLOGPRI;
uncatalog db LCLOGPRE;

uncatalog system odbc data source LPRODINT;
uncatalog system odbc data source LPRODEXT;
uncatalog system odbc data source LCLOGPRI;
uncatalog system odbc data source LCLOGPRE;

uncatalog node LPRODEXT;
uncatalog node LPRODINT;

catalog tcpip node LPRODEXT remote hpvldap4.corp.hbf.com.au server 50002 remote_instance LPRODEXT system hpvldap4 ostype win;
catalog tcpip node LPRODINT remote hpvldap4.corp.hbf.com.au server 50004 remote_instance LPRODINT system hpvldap4 ostype win;

catalog db LPRODINT as LPRODINT at node LPRODINT;
catalog db LPRODEXT as LPRODEXT at node LPRODEXT;
catalog db LDAPCLOG as LCLOGPRI at node LPRODINT;
catalog db LDAPCLOG as LCLOGPRE at node LPRODEXT;

catalog system odbc data source LPRODINT;
catalog system odbc data source LPRODEXT;
catalog system odbc data source LCLOGPRI;
catalog system odbc data source LCLOGPRE;

terminate;