-- Permissions are absent in the script due to errors.
-- See exception log for details.

CREATE TABLE EDL.D_W_MEMBER_LATEST (
  MMBR_NUM	VARCHAR(20)	NOT NULL,
  DATE_OF_BIRTH	DATE,
  DECEASED_FLG	CHARACTER(1 OCTETS)	NOT NULL,
  DECEASED_DT	DATE,
  GENDER_CDE	VARCHAR(10)	NOT NULL,
  MMBR_MYHBF_TERMS_ACCEPTED_FLG	CHARACTER(1 OCTETS)	NOT NULL,
  MMBR_MYHBF_TERMS_ACCEPTED_TS	TIMESTAMP,
  MMBR_MYHBF_FIRST_LOGIN_TS	TIMESTAMP,
  MMBR_MYHBF_LAST_LOGIN_TS	TIMESTAMP,
  DEL_FLG	CHARACTER(1 OCTETS)	NOT NULL,
  INSERT_BATCH_AUDIT_SK	INTEGER	NOT NULL,
  UPDATE_BATCH_AUDIT_SK	INTEGER	NOT NULL,
  INSERT_TS	TIMESTAMP	NOT NULL,
  UPDATE_TS	TIMESTAMP	NOT NULL
  ) 
  IN TBS_BASEC_EDL_16K
  INDEX IN TBS_IDXC_EDL_16K
  COMPRESS YES ADAPTIVE
  VALUE COMPRESSION
  ORGANIZE BY ROW;

ALTER TABLE EDL.D_W_MEMBER_LATEST
  DATA CAPTURE NONE
  PCTFREE 0
  LOCKSIZE ROW
  APPEND OFF
  NOT VOLATILE;

SET SCHEMA = GZD;

GRANT SELECT ON TABLE EDL.D_W_MEMBER_LATEST TO USER SASDIDEV1;

GRANT SELECT ON TABLE EDL.D_W_MEMBER_LATEST TO USER SVC_BI_FEDDBUSER_PRD;

GRANT SELECT ON TABLE EDL.D_W_MEMBER_LATEST TO USER SVC_TBLADMIN_PRD;

GRANT SELECT ON TABLE EDL.D_W_MEMBER_LATEST TO GROUP DB2_MIS_MON;

GRANT SELECT ON TABLE EDL.D_W_MEMBER_LATEST TO GROUP MIS_DB_ACCESS_PROD_R;

GRANT ALTER, DELETE, INDEX, INSERT, SELECT, UPDATE ON TABLE EDL.D_W_MEMBER_LATEST TO GROUP MIS_DB_ACCESS_PROD_SYS;

CREATE OR REPLACE ALIAS SASDIPROD.D_W_MEMBER_LATEST
  FOR EDL.D_W_MEMBER_LATEST;

--This is system required index
CREATE UNIQUE INDEX EDL.XAK1D_W_MEMBER_LATEST
  ON EDL.D_W_MEMBER_LATEST
    ( MMBR_NUM ASC )
  ALLOW REVERSE SCANS
  COMPRESS YES
  INCLUDE NULL KEYS;

ALTER TABLE EDL.D_W_MEMBER_LATEST
  ADD CONSTRAINT XPK_D_W_MEMBER_LATEST PRIMARY KEY
    (MMBR_NUM)
    ENFORCED;

SET CURRENT SCHEMA = P1K;

