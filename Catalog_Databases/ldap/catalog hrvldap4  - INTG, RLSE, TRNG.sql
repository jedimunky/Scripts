-- catalog hrvldap4 connections

-- TRNG
uncatalog db LTRNGINT;
uncatalog db LTRNGEXT;
uncatalog db LCLOGTRI;
uncatalog db LCLOGTRE;

uncatalog system odbc data source LTRNGINT;
uncatalog system odbc data source LTRNGEXT;
uncatalog system odbc data source LCLOGTRI;
uncatalog system odbc data source LCLOGTRE;

uncatalog node LTRNGINT;
uncatalog node LTRNGEXT;

catalog tcpip node LTRNGINT remote hrvldap4.corp.hbf.com.au server 50002 remote_instance LTRNGINT system hrvldap4 ostype win;
catalog tcpip node LTRNGEXT remote hrvldap4.corp.hbf.com.au server 50004 remote_instance LTRNGEXT system hrvldap4 ostype win;

catalog db LTRNGINT as LTRNGINT at node LTRNGINT;
catalog db LTRNGEXT as LTRNGEXT at node LTRNGEXT;
catalog db LDAPCLOG as LCLOGTRI at node LTRNGINT;
catalog db LDAPCLOG as LCLOGTRE at node LTRNGEXT;

catalog system odbc data source LTRNGINT;
catalog system odbc data source LTRNGEXT;
catalog system odbc data source LCLOGTRI;
catalog system odbc data source LCLOGTRE;

-- RLSE
uncatalog db LRLSEINT;
uncatalog db LRLSEEXT;
uncatalog db LCLOGRLI;
uncatalog db LCLOGRLE;

uncatalog system odbc data source LRLSEINT;
uncatalog system odbc data source LRLSEEXT;
uncatalog system odbc data source LCLOGRLI;
uncatalog system odbc data source LCLOGRLE;

uncatalog node LRLSEINT;
uncatalog node LRLSEEXT;

catalog tcpip node LRLSEINT remote hrvldap4.corp.hbf.com.au server 50006 remote_instance LRLSEINT system hrvldap4 ostype win;
catalog tcpip node LRLSEEXT remote hrvldap4.corp.hbf.com.au server 50008 remote_instance LRLSEEXT system hrvldap4 ostype win;

catalog db LRLSEINT as LRLSEINT at node LRLSEINT;
catalog db LRLSEEXT as LRLSEEXT at node LRLSEEXT;
catalog db LDAPCLOG as LCLOGRLI at node LRLSEINT;
catalog db LDAPCLOG as LCLOGRLE at node LRLSEEXT;

catalog system odbc data source LRLSEINT;
catalog system odbc data source LRLSEEXT;
catalog system odbc data source LCLOGRLI;
catalog system odbc data source LCLOGRLE;

-- INTG
uncatalog db LINTGINT;
uncatalog db LINTGEXT;
uncatalog db LCLOGINI;
uncatalog db LCLOGINE;

uncatalog system odbc data source LINTGINT;
uncatalog system odbc data source LINTGEXT;
uncatalog system odbc data source LCLOGINI;
uncatalog system odbc data source LCLOGINE;

uncatalog node LINTGINT;
uncatalog node LINTGEXT;

catalog tcpip node LINTGINT remote hrvldap4.corp.hbf.com.au server 50010 remote_instance LINTGINT system hrvldap4 ostype win;
catalog tcpip node LINTGEXT remote hrvldap4.corp.hbf.com.au server 50012 remote_instance LINTGEXT system hrvldap4 ostype win;

catalog db LINTGINT as LINTGINT at node LINTGINT;
catalog db LINTGEXT as LINTGEXT at node LINTGEXT;
catalog db LDAPCLOG as LCLOGINI at node LINTGINT;
catalog db LDAPCLOG as LCLOGINE at node LINTGEXT;

catalog system odbc data source LINTGINT;
catalog system odbc data source LINTGEXT;
catalog system odbc data source LCLOGINI;
catalog system odbc data source LCLOGINE;

terminate;