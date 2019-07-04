-- catalog hrvldap5 connections

-- TRNG
uncatalog db DTRNGINT;
uncatalog db DTRNGEXT;
uncatalog db DCLOGTRI;
uncatalog db DCLOGTRE;

uncatalog system odbc data source DTRNGINT;
uncatalog system odbc data source DTRNGEXT;
uncatalog system odbc data source DCLOGTRI;
uncatalog system odbc data source DCLOGTRE;

uncatalog node DTRNGINT;
uncatalog node DTRNGEXT;

catalog tcpip node DTRNGINT remote hrvldap5.corp.hbf.com.au server 50002 remote_instance LTRNGINT system hrvldap5 ostype win;
catalog tcpip node DTRNGEXT remote hrvldap5.corp.hbf.com.au server 50004 remote_instance LTRNGEXT system hrvldap5 ostype win;

catalog db LTRNGINT as DTRNGINT at node DTRNGINT;
catalog db LTRNGEXT as DTRNGEXT at node DTRNGEXT;
catalog db LDAPCLOG as DCLOGTRI at node DTRNGINT;
catalog db LDAPCLOG as DCLOGTRE at node DTRNGEXT;

catalog system odbc data source DTRNGINT;
catalog system odbc data source DTRNGEXT;
catalog system odbc data source DCLOGTRI;
catalog system odbc data source DCLOGTRE;

-- RLSE
uncatalog db DRLSEINT;
uncatalog db DRLSEEXT;
uncatalog db DCLOGRLI;
uncatalog db DCLOGRLE;

uncatalog system odbc data source DRLSEINT;
uncatalog system odbc data source DRLSEEXT;
uncatalog system odbc data source DCLOGRLI;
uncatalog system odbc data source DCLOGRLE;

uncatalog node DRLSEINT;
uncatalog node DRLSEEXT;

catalog tcpip node DRLSEINT remote hrvldap5.corp.hbf.com.au server 50006 remote_instance LRLSEINT system hrvldap5 ostype win;
catalog tcpip node DRLSEEXT remote hrvldap5.corp.hbf.com.au server 50008 remote_instance LRLSEEXT system hrvldap5 ostype win;

catalog db LRLSEINT as DRLSEINT at node DRLSEINT;
catalog db LRLSEEXT as DRLSEEXT at node DRLSEEXT;
catalog db LDAPCLOG as DCLOGRLI at node DRLSEINT;
catalog db LDAPCLOG as DCLOGRLE at node DRLSEEXT;

catalog system odbc data source DRLSEINT;
catalog system odbc data source DRLSEEXT;
catalog system odbc data source DCLOGRLI;
catalog system odbc data source DCLOGRLE;

-- INTG
uncatalog db DINTGINT;
uncatalog db DINTGEXT;
uncatalog db DCLOGINI;
uncatalog db DCLOGINE;

uncatalog system odbc data source DINTGINT;
uncatalog system odbc data source DINTGEXT;
uncatalog system odbc data source DCLOGINI;
uncatalog system odbc data source DCLOGINE;

uncatalog node DINTGINT;
uncatalog node DINTGEXT;

catalog tcpip node DINTGINT remote hrvldap5.corp.hbf.com.au server 50010 remote_instance LINTGINT system hrvldap5 ostype win;
catalog tcpip node DINTGEXT remote hrvldap5.corp.hbf.com.au server 50012 remote_instance LINTGEXT system hrvldap5 ostype win;

catalog db LINTGINT as DINTGINT at node DINTGINT;
catalog db LINTGEXT as DINTGEXT at node DINTGEXT;
catalog db LDAPCLOG as DCLOGINI at node DINTGINT;
catalog db LDAPCLOG as DCLOGINE at node DINTGEXT;

catalog system odbc data source DINTGINT;
catalog system odbc data source DINTGEXT;
catalog system odbc data source DCLOGINI;
catalog system odbc data source DCLOGINE;

terminate;