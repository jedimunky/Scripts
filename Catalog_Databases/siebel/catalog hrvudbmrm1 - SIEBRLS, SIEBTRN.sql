-- catalog hrvudbmrm1 connections

-- Siebel Rlse
uncatalog db SIEBRLS;
uncatalog system odbc data source SIEBRLS;
uncatalog node DB2SIEBR;

catalog tcpip node DB2SIEBR remote hrvudbmrm1.corp.hbf.com.au server 50000 remote_instance DB2SIEB system hrvudbmrm1 ostype win;
catalog db SIEBRLS as SIEBRLS at node DB2SIEBR;
catalog system odbc data source SIEBRLS;

-- Siebel Trng
uncatalog db SIEBTRN;
uncatalog system odbc data source SIEBTRN;
uncatalog node DB2SIEBT;

catalog tcpip node DB2SIEBT remote hrvudbmrm3.corp.hbf.com.au server 50002 remote_instance DB2SIEBT system hrvudbmrm3 ostype win;
catalog db SIEBTRN as SIEBTRN at node DB2SIEBT;
catalog system odbc data source SIEBTRN;

terminate;