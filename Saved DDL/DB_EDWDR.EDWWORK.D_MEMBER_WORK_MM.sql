DROP TABLE EDWWORK.D_MEMBER_WORK_MM;

CREATE TABLE EDWWORK.D_MEMBER_WORK_MM (
  MMBR_NUM	VARCHAR(20),
  DATE_OF_BIRTH	DATE,
  DECEASED_FLG	VARCHAR(1),
  DECEASED_DT	DATE,
  GENDER_CDE	VARCHAR(20),
  MMBR_MYHBF_TERMS_ACCEPTED_FLG	VARCHAR(1),
  MMBR_MYHBF_TERMS_ACCEPTED_TS	TIMESTAMP,
  MMBR_MYHBF_FIRST_LOGIN_TS	TIMESTAMP,
  MMBR_MYHBF_LAST_LOGIN_TS	TIMESTAMP,
  TEST_MMBR_FLG	VARCHAR(1),
  MMBR_LATEST_SENSITIVITY_FLG	VARCHAR(1),
  CHANGE_FLG	VARCHAR(1),
  DEL_FLG	VARCHAR(1),
  ETL_DEL_FLG	VARCHAR(1),
  UPDATE_BATCH_AUDIT_SK	DOUBLE,
  UPDATE_TS	TIMESTAMP,
  MODIFIED_SRC_TABLES	VARCHAR(500),
  INSERT_TS	TIMESTAMP
  ) 
  IN USERSPACE1
  ORGANIZE BY ROW;

ALTER TABLE EDWWORK.D_MEMBER_WORK_MM
  DATA CAPTURE NONE
  PCTFREE 0
  LOCKSIZE ROW
  APPEND OFF
  NOT VOLATILE;

SET SCHEMA = GZD;

GRANT SELECT ON TABLE EDWWORK.D_MEMBER_WORK_MM TO USER SASDIDEV1;

GRANT SELECT ON TABLE EDWWORK.D_MEMBER_WORK_MM TO USER SVC_BI_FEDDBUSER_RLS;

GRANT SELECT ON TABLE EDWWORK.D_MEMBER_WORK_MM TO USER SVC_TBLADMIN_RLS;

GRANT SELECT ON TABLE EDWWORK.D_MEMBER_WORK_MM TO GROUP DB2_MIS_MON;

GRANT SELECT ON TABLE EDWWORK.D_MEMBER_WORK_MM TO GROUP MIS_DB_ACCESS_RLSE_R;

GRANT ALTER, DELETE, INDEX, INSERT, SELECT, UPDATE ON TABLE EDWWORK.D_MEMBER_WORK_MM TO GROUP MIS_DB_ACCESS_RLSE_SYS;

SET CURRENT SCHEMA = P1K;

