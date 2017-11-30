-- Step 1. Drop
DROP TABLE EDWWORK.DD_D_MEMBER_WORK;

COMMIT;

-- Step 2. Sync
CREATE TABLE EDWWORK.DD_D_MEMBER_WORK (
  MMBR_NUM	VARCHAR(20)	NOT NULL,
  EFF_DT	DATE	NOT NULL,
  PRFRD_CONTACT_MTHD	VARCHAR(100)	NOT NULL,
  DOC_CHNL	VARCHAR(100)	NOT NULL,
  EMAIL_ADDR	VARCHAR(1024)	NOT NULL,
  HOME_PHONE_NUM	VARCHAR(50)	NOT NULL,
  MOBILE_PHONE_NUM	VARCHAR(50)	NOT NULL,
  WORK_PHONE_NUM	VARCHAR(50)	NOT NULL,
  GEOTRIBE_CDE	VARCHAR(50)	NOT NULL,
  GEOTRIBE_SEGMENT	VARCHAR(50)	NOT NULL,
  OPT_IN_STATUS	VARCHAR(50)	NOT NULL,
  HW_OPT_IN_EMAIL_STATUS	VARCHAR(50)	NOT NULL,
  HW_OPT_IN_FACE_TO_FACE_STATUS	VARCHAR(50)	NOT NULL,
  HW_OPT_IN_MAIL_STATUS	VARCHAR(50)	NOT NULL,
  HW_OPT_IN_SMS_STATUS	VARCHAR(50)	NOT NULL,
  HW_OPT_IN_PHONE_STATUS	VARCHAR(50)	NOT NULL,
  GNRL_OPT_IN_EMAIL_STATUS	VARCHAR(50)	NOT NULL,
  GNRL_OPT_IN_FACE_TO_FACE_STATUS	VARCHAR(50)	NOT NULL,
  GNRL_OPT_IN_MAIL_STATUS	VARCHAR(50)	NOT NULL,
  GNRL_OPT_IN_SMS_STATUS	VARCHAR(50)	NOT NULL,
  GNRL_OPT_IN_PHONE_STATUS	VARCHAR(50)	NOT NULL,
  DATE_OF_BIRTH	DATE,
  DECEASED_FLG	CHARACTER(1 OCTETS)	NOT NULL,
  DECEASED_DT	DATE,
  GENDER_CDE	VARCHAR(20)	NOT NULL,
  MMBR_MYHBF_TERMS_ACCEPTED_FLG	CHARACTER(1 OCTETS)	NOT NULL,
  MMBR_MYHBF_TERMS_ACCEPTED_TS	TIMESTAMP,
  MMBR_MYHBF_FIRST_LOGIN_TS	TIMESTAMP,
  MMBR_MYHBF_LAST_LOGIN_TS	TIMESTAMP,
  TEST_MMBR_FLG	CHARACTER(1 OCTETS)	NOT NULL,
  MMBR_LATEST_SENSITIVITY_FLG	CHARACTER(1 OCTETS)	NOT NULL
  ) 
  IN TBS_BASEC_EDW_32K
  INDEX IN TBS_IDXC_EDW_32K
  COMPRESS YES ADAPTIVE
  VALUE COMPRESSION
  ORGANIZE BY ROW;

ALTER TABLE EDWWORK.DD_D_MEMBER_WORK
  DATA CAPTURE NONE
  PCTFREE 0
  LOCKSIZE ROW
  APPEND OFF
  NOT VOLATILE;

SET SCHEMA = PYR;

GRANT SELECT ON TABLE EDWWORK.DD_D_MEMBER_WORK TO USER SASBIRLSE;

SET SCHEMA = GZD;

GRANT SELECT ON TABLE EDWWORK.DD_D_MEMBER_WORK TO USER SASDIDEV1;

SET SCHEMA = PYR;

GRANT SELECT ON TABLE EDWWORK.DD_D_MEMBER_WORK TO USER SASDIDEV1;

GRANT ALTER, DELETE, INDEX, INSERT, SELECT, UPDATE ON TABLE EDWWORK.DD_D_MEMBER_WORK TO USER SASDIRLSE;

SET SCHEMA = GZD;

GRANT SELECT ON TABLE EDWWORK.DD_D_MEMBER_WORK TO USER SVC_BI_FEDDBUSER_RLS;

SET SCHEMA = PYR;

GRANT SELECT ON TABLE EDWWORK.DD_D_MEMBER_WORK TO USER SVC_BI_FEDDBUSER_RLS;

SET SCHEMA = GZD;

GRANT SELECT ON TABLE EDWWORK.DD_D_MEMBER_WORK TO USER SVC_TBLADMIN_RLS;

SET SCHEMA = PYR;

GRANT SELECT ON TABLE EDWWORK.DD_D_MEMBER_WORK TO USER SVC_TBLADMIN_RLS;

SET SCHEMA = GZD;

GRANT SELECT ON TABLE EDWWORK.DD_D_MEMBER_WORK TO GROUP DB2_MIS_MON;

SET SCHEMA = PYR;

GRANT SELECT ON TABLE EDWWORK.DD_D_MEMBER_WORK TO GROUP DB2_MIS_MON;

SET SCHEMA = GZD;

GRANT SELECT ON TABLE EDWWORK.DD_D_MEMBER_WORK TO GROUP MIS_DB_ACCESS_RLSE_R;

SET SCHEMA = PYR;

GRANT SELECT ON TABLE EDWWORK.DD_D_MEMBER_WORK TO GROUP MIS_DB_ACCESS_RLSE_R;

SET SCHEMA = GZD;

GRANT ALTER, DELETE, INDEX, INSERT, SELECT, UPDATE ON TABLE EDWWORK.DD_D_MEMBER_WORK TO GROUP MIS_DB_ACCESS_RLSE_SYS;

SET SCHEMA = PYR;

GRANT ALTER, DELETE, INDEX, INSERT, SELECT, UPDATE ON TABLE EDWWORK.DD_D_MEMBER_WORK TO GROUP MIS_DB_ACCESS_RLSE_SYS;

-- Step 3. Restoring constraints and indexes
CREATE UNIQUE INDEX EDWWORK.XAK1DD_DD_D_MEMBER_WORK
  ON EDWWORK.DD_D_MEMBER_WORK
    ( MMBR_NUM ASC, EFF_DT ASC )
  ALLOW REVERSE SCANS
  COMPRESS YES
  INCLUDE NULL KEYS
  COLLECT STATISTICS;

SET CURRENT SCHEMA = P1K;

