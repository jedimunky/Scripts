-- Step 1. Sync

CREATE TABLE DD.DD_MF_EN_MMBR_CMPGN_AVLBLTY
(
   MMBR_NUM                          VARCHAR (20) NOT NULL,
   REPORTING_DT                      DATE NOT NULL,
   REPORTING_YR_MTH                  VARCHAR (20) NOT NULL,
   D_CMPGN_SK                        INTEGER NOT NULL,
   CMPGN_ID                          VARCHAR (20) NOT NULL,
   CMPGN_CMNCN_CNT                   INTEGER NOT NULL,
   EMAIL_CMPGN_CMNCN_CNT             INTEGER NOT NULL,
   FAX_CMPGN_CMNCN_CNT               INTEGER NOT NULL,
   INBOUND_CALL_CMPGN_CMNCN_CNT      INTEGER NOT NULL,
   MAIL_CMPGN_CMNCN_CNT              INTEGER NOT NULL,
   OUTBOUND_CALL_CMPGN_CMNCN_CNT     INTEGER NOT NULL,
   WEB_CMPGN_CMNCN_CNT               INTEGER NOT NULL,
   DSCRTNRY_CMPGN_NEXT_AVLBLTY_DT    DATE NOT NULL,
   CMNCN_LMT_30DAY_NXT_AVLBLTY_DT    DATE NOT NULL,
   CMNCN_LMT_7DAY_NXT_AVLBLTY_DT     DATE NOT NULL,
   NEXT_AVLBLTY_DT                   DATE NOT NULL,
   INSERT_BATCH_AUDIT_SK             INTEGER NOT NULL,
   INSERT_TS                         TIMESTAMP NOT NULL
)
IN TBS_BASEC_DD_16K
INDEX IN TBS_IDXC_DD_16K
COMPRESS YES ADAPTIVE
VALUE COMPRESSION
ORGANIZE BY ROW;

ALTER TABLE DD.DD_MF_EN_MMBR_CMPGN_AVLBLTY
   DATA CAPTURE NONE
   PCTFREE 0
   LOCKSIZE ROW
   APPEND OFF
   NOT VOLATILE;

SET  SCHEMA = PYR;

GRANT SELECT ON TABLE DD.DD_MF_EN_MMBR_CMPGN_AVLBLTY TO USER PYR;

GRANT ALTER,
      DELETE,
      INDEX,
      INSERT,
      SELECT,
      UPDATE
ON TABLE DD.DD_MF_EN_MMBR_CMPGN_AVLBLTY
TO USER SASBIPROD;

GRANT SELECT ON TABLE DD.DD_MF_EN_MMBR_CMPGN_AVLBLTY TO USER SASDIPROD;

GRANT SELECT
ON TABLE DD.DD_MF_EN_MMBR_CMPGN_AVLBLTY
TO USER SVC_BI_FEDDBUSER_PRD;

GRANT SELECT ON TABLE DD.DD_MF_EN_MMBR_CMPGN_AVLBLTY TO USER SVC_TBLADMIN_PRD;

GRANT SELECT ON TABLE DD.DD_MF_EN_MMBR_CMPGN_AVLBLTY TO GROUP DB2_MIS_MON;

GRANT SELECT
ON TABLE DD.DD_MF_EN_MMBR_CMPGN_AVLBLTY
TO GROUP MIS_DB_ACCESS_PROD_R;

GRANT ALTER,
      DELETE,
      INDEX,
      INSERT,
      SELECT,
      UPDATE
ON TABLE DD.DD_MF_EN_MMBR_CMPGN_AVLBLTY
TO GROUP MIS_DB_ACCESS_PROD_SYS;

SET  CURRENT SCHEMA = EDWWORK;

SET  CURRENT PATH = SYSIBM,
SYSFUN,
SYSPROC,
SYSIBMADM,
PYR;

CREATE OR REPLACE VIEW BDL."Member Marketing Discretionary Campaigns Monthly"
AS
   SELECT MTH_AVL.REPORTING_YR_MTH
             AS "Information Month",
          MTH_AVL.REPORTING_DT
             AS "Information Date",
          MTH_AVL.MMBR_NUM
             AS "Member Number",                -- AS "Communication Channel",
          MTH_AVL.CMPGN_ID
             AS "Campaign Code",
          CPGN.CAMP_DESC
             AS "Campaign Name",
          MTH_AVL.NEXT_AVLBLTY_DT
             AS "Campaign Next Avail Date",
          MTH_AVL.CMPGN_CMNCN_CNT
             AS "Campaign Comms Count",
          MTH_AVL.EMAIL_CMPGN_CMNCN_CNT
             AS "Email Campaign Comms Count",
          MTH_AVL.FAX_CMPGN_CMNCN_CNT
             AS "Fax Campaign Comms Count",
          MTH_AVL.INBOUND_CALL_CMPGN_CMNCN_CNT
             AS "Inbound Call Campaign Comms Count",
          MTH_AVL.MAIL_CMPGN_CMNCN_CNT
             AS "Mail Campaign Comms Count",
          MTH_AVL.OUTBOUND_CALL_CMPGN_CMNCN_CNT
             AS "Outbound Call Campaign Comms Count",
          MTH_AVL.WEB_CMPGN_CMNCN_CNT
             AS "Web Campaign Comms Count",
          MEM.DATE_OF_BIRTH
             AS "Date of Birth",
          integer (floor ( (CURRENT DATE - MEM.DATE_OF_BIRTH) / 10000))
             AS "Age",
          null
             AS "Age Group",
          MEM.DECEASED_FLG
             AS "Deceased Flag",
          MEM.GENDER_CDE
             AS "Gender",
          MEM.GEOTRIBE_CDE
             AS "Geotribe",                         --  AS "Residential Area",
          CON.HI_PLCY_ACTIVE_FLG
             AS "HI Policy Active Flag",
          CON.HI_PLCY_APRA_FNCL_FLG
             AS "HI APRA  Financial Flag",
          CON.HI_PLCY_RLTNSHP_DESC
             AS "HI Policy Relationship",
          CON.GI_HOME_MOTOR_PLCY_ACTIVE_FLG
             AS "Home or Motor Policy Active Flag",
          CON.GI_TRAVEL_12_MTH_PLCY_ACTIVE_FLG
             AS "Travel Policy last 12 mths Flag",
          MEM.MMBR_LATEST_SENSITIVITY_FLG
             AS "Sensitivity Flag",
          decode (CON.MMBR_CONTACTABLE_FLG,
                  'Y',
                  1,
                  0)
             AS "Contactable Flag",
          decode (CON.MMBR_MARKETABLE_FLG,
                  'Y',
                  1,
                  0)
             AS "Marketable Flag",
          CASE
             WHEN     CON.MMBR_MARKETABLE_FLG = 'Y'
                  AND MTH_AVL.NEXT_AVLBLTY_DT <= MTH_AVL.REPORTING_DT
             THEN
                1
             ELSE
                0
          END
             AS "Available Base Flag",
          MEM.PRFRD_CONTACT_MTHD
             AS "Preferred Contact Method",
          MEM.DOC_CHNL
             AS "Document Channel",
          MEM.OPT_IN_STATUS
             AS "Opt In Status",
          MEM.HW_OPT_IN_EMAIL_STATUS
             AS "Opt In H & W Email Flag",
          MEM.HW_OPT_IN_FACE_TO_FACE_STATUS
             AS "Opt In H & W Face to Face Flag",
          MEM.HW_OPT_IN_MAIL_STATUS
             AS "Opt In H & W Mail Flag",
          MEM.HW_OPT_IN_SMS_STATUS
             AS "Opt In H & W SMS Flag",
          MEM.HW_OPT_IN_PHONE_STATUS
             AS "Opt In H & W Phone Flag",
          MEM.GNRL_OPT_IN_EMAIL_STATUS
             AS "Opt In General Email Flag",
          MEM.GNRL_OPT_IN_FACE_TO_FACE_STATUS
             AS "Opt In General Face to Face Flag",
          MEM.GNRL_OPT_IN_MAIL_STATUS
             AS "Opt In General Mail Flag",
          MEM.GNRL_OPT_IN_SMS_STATUS
             AS "Opt In General SMS Flag",
          MEM.GNRL_OPT_IN_PHONE_STATUS
             AS "Opt In General Phone Flag",
          decode (MEM.EMAIL_ADDR,
                  'Unknown',
                  0,
                  1)
             AS "Email Flag",
          decode (MEM.MOBILE_PHONE_NUM,
                  'Unknown',
                  0,
                  1)
             AS "Mobile Flag",
          decode (MEM.HOME_PHONE_NUM,
                  'Unknown',
                  0,
                  1)
             AS "Home Phone Flag",
          decode (MEM.WORK_PHONE_NUM,
                  'Unknown',
                  0,
                  1)
             AS "Work Phone Flag"
   FROM DD.DD_MF_EN_MMBR_CMPGN_AVLBLTY MTH_AVL,
        DD.DD_D_CAMPAIGN CPGN,
        DD.DD_D_EN_CONTACTABLE_MEMBER CON,
        DD.DD_D_MEMBER_MASTER MEM
   WHERE     MTH_AVL.D_CMPGN_SK = CPGN.D_CAMP_SK -- JOIN TO DD_D_EN_CONTACTABLE
         AND MTH_AVL.MMBR_NUM = CON.MMBR_NUM
         AND MTH_AVL.REPORTING_DT BETWEEN CON.EFF_DT AND CON.END_DT -- JOIN TO DD_D_MEMBER_M  ASTER
         AND MTH_AVL.MMBR_NUM = MEM.MMBR_NUM
         AND MTH_AVL.REPORTING_DT BETWEEN MEM.EFF_DT AND MEM.END_DT         --
         AND MEM.TEST_MMBR_FLG = 'N';

SET  SCHEMA = PYR;

GRANT SELECT
ON BDL."Member Marketing Discretionary Campaigns Monthly"
TO USER SASBIPROD;

GRANT SELECT
ON BDL."Member Marketing Discretionary Campaigns Monthly"
TO USER SVC_BI_FEDDBUSER_PRD;

GRANT SELECT
ON BDL."Member Marketing Discretionary Campaigns Monthly"
TO USER SVC_TBLADMIN_PRD;

GRANT SELECT
ON BDL."Member Marketing Discretionary Campaigns Monthly"
TO GROUP DB2_MIS_MON;

GRANT SELECT
ON BDL."Member Marketing Discretionary Campaigns Monthly"
TO GROUP EDW_SELF_SERVICE_R_PROD;

GRANT SELECT
ON BDL."Member Marketing Discretionary Campaigns Monthly"
TO GROUP MIS_DB_ACCESS_PROD_R;

GRANT SELECT
ON BDL."Member Marketing Discretionary Campaigns Monthly"
TO GROUP MIS_DB_ACCESS_PROD_SYS;

CREATE OR REPLACE ALIAS BDL_ALIAS."Mbr Mktg Discre Campaigns Mthly"
   FOR BDL."Member Marketing Discretionary Campaigns Monthly";

CREATE TABLE DD.DD_MF_EN_MMBR_AVLBLTY
(
   MMBR_NUM                         VARCHAR (20) NOT NULL,
   REPORTING_DT                     DATE NOT NULL,
   REPORTING_YR_MTH                 VARCHAR (20) NOT NULL,
   MMBR_AGE                         INTEGER NOT NULL,
   CMPGN_CMNCN_CNT                  INTEGER NOT NULL,
   EMAIL_CMPGN_CMNCN_CNT            INTEGER NOT NULL,
   FAX_CMPGN_CMNCN_CNT              INTEGER NOT NULL,
   INBOUND_CALL_CMPGN_CMNCN_CNT     INTEGER NOT NULL,
   MAIL_CMPGN_CMNCN_CNT             INTEGER NOT NULL,
   OUTBOUND_CALL_CMPGN_CMNCN_CNT    INTEGER NOT NULL,
   WEB_CMPGN_CMNCN_CNT              INTEGER NOT NULL,
   NEXT_AVLBLTY_DT                  DATE NOT NULL,
   INSERT_BATCH_AUDIT_SK            INTEGER NOT NULL,
   INSERT_TS                        TIMESTAMP NOT NULL
)
IN TBS_BASEC_EDL_16K
INDEX IN TBS_IDXC_EDL_16K
COMPRESS YES ADAPTIVE
VALUE COMPRESSION
ORGANIZE BY ROW;

ALTER TABLE DD.DD_MF_EN_MMBR_AVLBLTY
   DATA CAPTURE NONE
   PCTFREE 0
   LOCKSIZE ROW
   APPEND OFF
   NOT VOLATILE;

GRANT ALTER,
      DELETE,
      INDEX,
      INSERT,
      SELECT,
      UPDATE
ON TABLE DD.DD_MF_EN_MMBR_AVLBLTY
TO USER SASBIPROD;

GRANT SELECT ON TABLE DD.DD_MF_EN_MMBR_AVLBLTY TO USER SASDIPROD;

GRANT SELECT ON TABLE DD.DD_MF_EN_MMBR_AVLBLTY TO USER SVC_BI_FEDDBUSER_PRD;

GRANT SELECT ON TABLE DD.DD_MF_EN_MMBR_AVLBLTY TO USER SVC_TBLADMIN_PRD;

GRANT SELECT ON TABLE DD.DD_MF_EN_MMBR_AVLBLTY TO GROUP DB2_MIS_MON;

GRANT SELECT ON TABLE DD.DD_MF_EN_MMBR_AVLBLTY TO GROUP MIS_DB_ACCESS_PROD_R;

GRANT ALTER,
      DELETE,
      INDEX,
      INSERT,
      SELECT,
      UPDATE
ON TABLE DD.DD_MF_EN_MMBR_AVLBLTY
TO GROUP MIS_DB_ACCESS_PROD_SYS;

CREATE TABLE EDWWORK.DD_MF_EN_MMBR_AVLBLTY_WORK1
(
   MMBR_NUM                         VARCHAR (20) NOT NULL,
   REPORTING_DT                     DATE NOT NULL,
   REPORTING_YR_MTH                 VARCHAR (20) NOT NULL,
   MMBR_AGE                         INTEGER NOT NULL,
   CMPGN_CMNCN_CNT                  INTEGER NOT NULL,
   EMAIL_CMPGN_CMNCN_CNT            INTEGER NOT NULL,
   FAX_CMPGN_CMNCN_CNT              INTEGER NOT NULL,
   INBOUND_CALL_CMPGN_CMNCN_CNT     INTEGER NOT NULL,
   MAIL_CMPGN_CMNCN_CNT             INTEGER NOT NULL,
   OUTBOUND_CALL_CMPGN_CMNCN_CNT    INTEGER NOT NULL,
   WEB_CMPGN_CMNCN_CNT              INTEGER NOT NULL,
   NEXT_AVLBLTY_DT                  DATE NOT NULL,
   INSERT_BATCH_AUDIT_SK            INTEGER NOT NULL,
   INSERT_TS                        TIMESTAMP NOT NULL
)
IN TBS_BASEC_EDW_32K
INDEX IN TBS_IDXC_EDW_32K
COMPRESS YES ADAPTIVE
VALUE COMPRESSION
ORGANIZE BY ROW;

ALTER TABLE EDWWORK.DD_MF_EN_MMBR_AVLBLTY_WORK1
   DATA CAPTURE NONE
   PCTFREE 0
   LOCKSIZE ROW
   APPEND OFF
   NOT VOLATILE;

GRANT ALTER,
      DELETE,
      INDEX,
      INSERT,
      SELECT,
      UPDATE
ON TABLE EDWWORK.DD_MF_EN_MMBR_AVLBLTY_WORK1
TO USER SASBIPROD;

GRANT SELECT ON TABLE EDWWORK.DD_MF_EN_MMBR_AVLBLTY_WORK1 TO USER SASDIPROD;

GRANT SELECT
ON TABLE EDWWORK.DD_MF_EN_MMBR_AVLBLTY_WORK1
TO USER SVC_BI_FEDDBUSER_PRD;

GRANT SELECT
ON TABLE EDWWORK.DD_MF_EN_MMBR_AVLBLTY_WORK1
TO USER SVC_TBLADMIN_PRD;

GRANT SELECT
ON TABLE EDWWORK.DD_MF_EN_MMBR_AVLBLTY_WORK1
TO GROUP DB2_MIS_MON;

GRANT SELECT
ON TABLE EDWWORK.DD_MF_EN_MMBR_AVLBLTY_WORK1
TO GROUP MIS_DB_ACCESS_PROD_R;

GRANT ALTER,
      DELETE,
      INDEX,
      INSERT,
      SELECT,
      UPDATE
ON TABLE EDWWORK.DD_MF_EN_MMBR_AVLBLTY_WORK1
TO GROUP MIS_DB_ACCESS_PROD_SYS;

CREATE TABLE EDWWORK.DD_MF_EN_MMBR_CMPGN_AVLBL_WORK1
(
   MMBR_NUM                          VARCHAR (20) NOT NULL,
   REPORTING_DT                      DATE NOT NULL,
   REPORTING_YR_MTH                  VARCHAR (20) NOT NULL,
   D_CMPGN_SK                        INTEGER NOT NULL,
   CMPGN_ID                          VARCHAR (20) NOT NULL,
   CMPGN_CMNCN_CNT                   INTEGER NOT NULL,
   EMAIL_CMPGN_CMNCN_CNT             INTEGER NOT NULL,
   FAX_CMPGN_CMNCN_CNT               INTEGER NOT NULL,
   INBOUND_CALL_CMPGN_CMNCN_CNT      INTEGER NOT NULL,
   MAIL_CMPGN_CMNCN_CNT              INTEGER NOT NULL,
   OUTBOUND_CALL_CMPGN_CMNCN_CNT     INTEGER NOT NULL,
   WEB_CMPGN_CMNCN_CNT               INTEGER NOT NULL,
   DSCRTNRY_CMPGN_NEXT_AVLBLTY_DT    DATE NOT NULL,
   CMNCN_LMT_30DAY_NXT_AVLBLTY_DT    DATE NOT NULL,
   CMNCN_LMT_7DAY_NXT_AVLBLTY_DT     DATE NOT NULL,
   NEXT_AVLBLTY_DT                   DATE NOT NULL,
   INSERT_BATCH_AUDIT_SK             INTEGER NOT NULL,
   INSERT_TS                         TIMESTAMP NOT NULL
)
IN TBS_BASEC_EDW_32K
INDEX IN TBS_IDXC_EDW_32K
COMPRESS YES ADAPTIVE
VALUE COMPRESSION
ORGANIZE BY ROW;

ALTER TABLE EDWWORK.DD_MF_EN_MMBR_CMPGN_AVLBL_WORK1
   DATA CAPTURE NONE
   PCTFREE 0
   LOCKSIZE ROW
   APPEND OFF
   NOT VOLATILE;

GRANT ALTER,
      DELETE,
      INDEX,
      INSERT,
      SELECT,
      UPDATE
ON TABLE EDWWORK.DD_MF_EN_MMBR_CMPGN_AVLBL_WORK1
TO USER SASBIPROD;

GRANT ALTER,
      DELETE,
      INDEX,
      INSERT,
      SELECT,
      UPDATE
ON TABLE EDWWORK.DD_MF_EN_MMBR_CMPGN_AVLBL_WORK1
TO USER SASDIPROD;

GRANT SELECT
ON TABLE EDWWORK.DD_MF_EN_MMBR_CMPGN_AVLBL_WORK1
TO USER SASDIPROD;

GRANT SELECT
ON TABLE EDWWORK.DD_MF_EN_MMBR_CMPGN_AVLBL_WORK1
TO USER SVC_BI_FEDDBUSER_PRD;

GRANT SELECT
ON TABLE EDWWORK.DD_MF_EN_MMBR_CMPGN_AVLBL_WORK1
TO USER SVC_TBLADMIN_PRD;

GRANT SELECT
ON TABLE EDWWORK.DD_MF_EN_MMBR_CMPGN_AVLBL_WORK1
TO GROUP DB2_MIS_MON;

GRANT SELECT
ON TABLE EDWWORK.DD_MF_EN_MMBR_CMPGN_AVLBL_WORK1
TO GROUP MIS_DB_ACCESS_PROD_R;

GRANT ALTER,
      DELETE,
      INDEX,
      INSERT,
      SELECT,
      UPDATE
ON TABLE EDWWORK.DD_MF_EN_MMBR_CMPGN_AVLBL_WORK1
TO GROUP MIS_DB_ACCESS_PROD_SYS;

-- Step 2. Restoring constraints and indexes

CREATE UNIQUE INDEX DD.XAK1DD_MF_EN_MMBR_CMPGN_AVLBLTY
   ON DD.DD_MF_EN_MMBR_CMPGN_AVLBLTY (MMBR_NUM ASC,
                                      CMPGN_ID ASC,
                                      REPORTING_YR_MTH ASC)
   ALLOW REVERSE SCANS
      COMPRESS YES
      INCLUDE NULL KEYS
      COLLECT STATISTICS;

CREATE UNIQUE INDEX DD.XPKDD_MF_EN_MMBR_AVLBLTY_U2
   ON DD.DD_MF_EN_MMBR_AVLBLTY (REPORTING_YR_MTH ASC,
                                MMBR_NUM ASC,
                                REPORTING_DT ASC)
   ALLOW REVERSE SCANS
      COMPRESS YES
      INCLUDE NULL KEYS;

ALTER TABLE DD.DD_MF_EN_MMBR_AVLBLTY
   ADD CONSTRAINT XPKDD_MF_EN_MMBR_AVLBLTY PRIMARY KEY
          (MMBR_NUM, REPORTING_YR_MTH, REPORTING_DT)
          ENFORCED;

COMMIT;

-- Step 3. Runstats
RUNSTATS ON TABLE DD.DD_MF_EN_MMBR_AVLBLTY
	ALLOW WRITE ACCESS;

RUNSTATS ON TABLE DD.DD_MF_EN_MMBR_CMPGN_AVLBLTY
	ALLOW WRITE ACCESS;

RUNSTATS ON TABLE EDWWORK.DD_MF_EN_MMBR_AVLBLTY_WORK1
	ALLOW WRITE ACCESS;

RUNSTATS ON TABLE EDWWORK.DD_MF_EN_MMBR_CMPGN_AVLBL_WORK1
	ALLOW WRITE ACCESS;

SET  CURRENT SCHEMA = P1K;