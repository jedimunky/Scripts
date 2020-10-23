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

catalog db LRLSEINT as LRLSEINT at node LRLSEINT;
catalog db LRLSEEXT as LRLSEEXT at node LRLSEEXT;
catalog db LDAPCLOG as LCLOGRLI at node LRLSEINT;
catalog db LDAPCLOG as LCLOGRLE at node LRLSEEXT;

catalog system odbc data source LRLSEINT;
catalog system odbc data source LRLSEEXT;
catalog system odbc data source LCLOGRLI;
catalog system odbc data source LCLOGRLE;

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

catalog tcpip node LSIT1INT remote htvldap2.dev.hbf.com.au server 50000 remote_instance LSIT1INT system htvldap2 ostype win;
catalog tcpip node LSIT1EXT remote htvldap2.dev.hbf.com.au server 50000 remote_instance LSIT1EXT system htvldap2 ostype win;

catalog db LSIT1INT as LSIT1INT at node LSIT1INT;
catalog db LSIT1EXT as LSIT1EXT at node LSIT1EXT;

catalog system odbc data source LSIT1INT;
catalog system odbc data source LSIT1EXT;

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
