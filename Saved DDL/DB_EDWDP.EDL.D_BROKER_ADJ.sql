-- Step 1. Sync

CREATE TABLE EDL.D_BROKER_ADJ
(
   D_BRKR_ADJ_SK        INTEGER NOT NULL,
   PLCY_NUM             VARCHAR (10) NOT NULL,
   PROD_COMP_ID         VARCHAR (10) NOT NULL,
   BRKR_DEAL_CDE        VARCHAR (20) NOT NULL,
   BRKR_CDE             VARCHAR (20) NOT NULL,
   DEAL_START_DT DATE,
   DEAL_END_DT DATE,
   PROD_GRP_CEASE_DT    DATE NOT NULL,
   ADJ_ACT              CHARACTER (1 OCTETS) NOT NULL,
   ADJ_PROCESS_IND      CHARACTER (1 OCTETS) NOT NULL,
   ADJ_PROCESS_DT       DATE NOT NULL,
   LATEST_ADJ_FLG       CHARACTER (1 OCTETS) NOT NULL,
   CBACK_IND CHARACTER (1 OCTETS),
   BACKPAY_IND CHARACTER (1 OCTETS),
   SCALE CHARACTER (1 OCTETS),
   RATE_CDE DECIMAL (3, 0),
   STATE_CDE CHARACTER (3 OCTETS),
   LHC_LOADING DECIMAL (5, 3),
   C_AUDIT_SK           INTEGER NOT NULL,
   INSERT_TS            TIMESTAMP NOT NULL,
   UPDATE_TS            TIMESTAMP NOT NULL
)
IN TBS_BASEC_EDL_16K
INDEX IN TBS_IDXC_EDL_16K
COMPRESS YES STATIC
ORGANIZE BY ROW;

ALTER TABLE EDL.D_BROKER_ADJ
   DATA CAPTURE NONE
   PCTFREE 0
   LOCKSIZE ROW
   APPEND OFF
   NOT VOLATILE;

SET  SCHEMA = GZD;

GRANT SELECT ON TABLE EDL.D_BROKER_ADJ TO USER SASDIDEV1;

SET  SCHEMA = ZP1K;

GRANT SELECT ON TABLE EDL.D_BROKER_ADJ TO USER SASDIDEV1;

SET  SCHEMA = GZD;

GRANT SELECT ON TABLE EDL.D_BROKER_ADJ TO USER SVC_BI_FEDDBUSER_PRD;

SET  SCHEMA = ZP1K;

GRANT SELECT ON TABLE EDL.D_BROKER_ADJ TO USER SVC_BI_FEDDBUSER_PRD;

SET  SCHEMA = DB2CON;

GRANT SELECT ON TABLE EDL.D_BROKER_ADJ TO USER SVC_TBLADMIN_PRD;

SET  SCHEMA = GZD;

GRANT SELECT ON TABLE EDL.D_BROKER_ADJ TO USER SVC_TBLADMIN_PRD;

SET  SCHEMA = ZP1K;

GRANT SELECT ON TABLE EDL.D_BROKER_ADJ TO USER SVC_TBLADMIN_PRD;

SET  SCHEMA = DB2CON;

GRANT SELECT ON TABLE EDL.D_BROKER_ADJ TO GROUP DB2_MIS_MON;

SET  SCHEMA = GZD;

GRANT SELECT ON TABLE EDL.D_BROKER_ADJ TO GROUP DB2_MIS_MON;

SET  SCHEMA = ZP1K;

GRANT SELECT ON TABLE EDL.D_BROKER_ADJ TO GROUP DB2_MIS_MON;

SET  SCHEMA = DB2CON;

GRANT SELECT ON TABLE EDL.D_BROKER_ADJ TO GROUP MIS_DB_ACCESS_PROD_R;

SET  SCHEMA = GZD;

GRANT SELECT ON TABLE EDL.D_BROKER_ADJ TO GROUP MIS_DB_ACCESS_PROD_R;

SET  SCHEMA = ZP1K;

GRANT SELECT ON TABLE EDL.D_BROKER_ADJ TO GROUP MIS_DB_ACCESS_PROD_R;

SET  SCHEMA = DB2CON;

GRANT ALTER,
      DELETE,
      INDEX,
      INSERT,
      SELECT,
      UPDATE
ON TABLE EDL.D_BROKER_ADJ
TO GROUP MIS_DB_ACCESS_PROD_SYS;

SET  SCHEMA = GZD;

GRANT ALTER,
      DELETE,
      INDEX,
      INSERT,
      SELECT,
      UPDATE
ON TABLE EDL.D_BROKER_ADJ
TO GROUP MIS_DB_ACCESS_PROD_SYS;

SET  SCHEMA = ZP1K;

GRANT ALTER,
      DELETE,
      INDEX,
      INSERT,
      SELECT,
      UPDATE
ON TABLE EDL.D_BROKER_ADJ
TO GROUP MIS_DB_ACCESS_PROD_SYS;

-- Step 2. Restoring constraints and indexes

ALTER TABLE EDL.D_BROKER_ADJ
   ADD CONSTRAINT D_BROKER_ADJ_PK PRIMARY KEY (D_BRKR_ADJ_SK) ENFORCED;

COMMIT;

-- Step 3. Runstats
RUNSTATS ON TABLE EDL.D_BROKER_ADJ
	ALLOW WRITE ACCESS;

SET  CURRENT SCHEMA = P1K;