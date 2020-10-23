-- Step 1. Drop
DROP ALIAS SASDIDEV1.SEM_HI_QUOTES_V;

DROP ALIAS SASDIPROD.SEM_HI_QUOTES_V;

DROP ALIAS BDL_ALIAS."HBF Sales Summary";

DROP ALIAS SASDIPROD.SEM_QUOTES_SALE_TARGET_V;

DROP ALIAS SASDIDEV1.SEM_QUOTES_SALE_TARGET_V;

DROP ALIAS SASDIDEV1.SEM_HI_SALE_V;

DROP ALIAS SASDIPROD.SEM_HI_SALE_V;

DROP ALIAS SASDIPROD.SEM_HI_QUOTES_NON_WEB_V;

DROP ALIAS SASDIDEV1.SEM_HI_QUOTES_NON_WEB_V;

DROP VIEW DD.SEM_HI_QUOTES_V;

DROP TABLE BDL."HBF Sales Summary";

-- Step 2. Sync

CREATE TABLE BDL."HBF Sales Summary"
(
   "Date"                  DATE NOT NULL,
   "Entity"                VARCHAR (20) NOT NULL,
   "Channel"               VARCHAR (20) NOT NULL,
   "Channel Area"          VARCHAR (50) NOT NULL,
   "Team"                  VARCHAR (50) NOT NULL,
   "State"                 VARCHAR (10) NOT NULL DEFAULT,
   "Type"                  VARCHAR (50) NOT NULL,
   "Product Category"      VARCHAR (50),
   "Product Group"         VARCHAR (50),
   "Sale Count"            INTEGER NOT NULL,
   "Sale Count Target"     DECIMAL (21, 4),
   "Sale Value"            DECIMAL (14, 2) NOT NULL DEFAULT 0.00,
   "Sale Value Target"     DECIMAL (14, 2) NOT NULL DEFAULT 0.00,
   "Quote Count"           INTEGER NOT NULL,
   "Quote Count Target"    DECIMAL (21, 4),
   "Employee UserId"       VARCHAR (20),
   "Employee Name"         VARCHAR (100)
)
IN TBS_BLU_LEGACY_32K
ORGANIZE BY COLUMN;

SET  SCHEMA = GZD;

GRANT ALTER,
      DELETE,
      INDEX,
      INSERT,
      SELECT,
      UPDATE
   ON TABLE BDL."HBF Sales Summary"
   TO USER SASBIDEV1;

SET  SCHEMA = ZP1K;

GRANT ALTER,
      DELETE,
      INDEX,
      INSERT,
      SELECT,
      UPDATE
   ON TABLE BDL."HBF Sales Summary"
   TO USER SASBIDEV1;

SET  SCHEMA = GZD;

GRANT ALTER,
      DELETE,
      INDEX,
      INSERT,
      SELECT,
      UPDATE
   ON TABLE BDL."HBF Sales Summary"
   TO USER SASDIDEV1;

SET  SCHEMA = ZP1K;

GRANT ALTER,
      DELETE,
      INDEX,
      INSERT,
      SELECT,
      UPDATE
   ON TABLE BDL."HBF Sales Summary"
   TO USER SASDIDEV1;

SET  SCHEMA = GZD;

GRANT SELECT ON TABLE BDL."HBF Sales Summary" TO USER SVC_BI_FEDDBUSER_RLS;

SET  SCHEMA = ZP1K;

GRANT SELECT ON TABLE BDL."HBF Sales Summary" TO USER SVC_BI_FEDDBUSER_RLS;

SET  SCHEMA = GZD;

GRANT SELECT ON TABLE BDL."HBF Sales Summary" TO USER SVC_TBLADMIN_RLS;

SET  SCHEMA = ZP1K;

GRANT SELECT ON TABLE BDL."HBF Sales Summary" TO USER SVC_TBLADMIN_RLS;

SET  SCHEMA = GZD;

GRANT SELECT ON TABLE BDL."HBF Sales Summary" TO GROUP DB2_MIS_MON;

SET  SCHEMA = ZP1K;

GRANT SELECT ON TABLE BDL."HBF Sales Summary" TO GROUP DB2_MIS_MON;

SET  SCHEMA = GZD;

GRANT ALTER,
      DELETE,
      INDEX,
      INSERT,
      SELECT,
      REFERENCES,
      UPDATE
   ON TABLE BDL."HBF Sales Summary"
   TO GROUP EDW_ETL_DEVELOPER_RW_DEV
   WITH GRANT OPTION;

GRANT CONTROL
   ON TABLE BDL."HBF Sales Summary"
   TO GROUP EDW_ETL_DEVELOPER_RW_DEV;

SET  SCHEMA = ZP1K;

GRANT ALTER,
      DELETE,
      INDEX,
      INSERT,
      SELECT,
      REFERENCES,
      UPDATE
   ON TABLE BDL."HBF Sales Summary"
   TO GROUP EDW_ETL_DEVELOPER_RW_DEV
   WITH GRANT OPTION;

GRANT CONTROL
   ON TABLE BDL."HBF Sales Summary"
   TO GROUP EDW_ETL_DEVELOPER_RW_DEV;

SET  SCHEMA = GZD;

GRANT SELECT ON TABLE BDL."HBF Sales Summary" TO GROUP EDW_SELF_SERVICE_R_DEV;

SET  SCHEMA = ZP1K;

GRANT SELECT ON TABLE BDL."HBF Sales Summary" TO GROUP EDW_SELF_SERVICE_R_DEV;

SET  SCHEMA = GZD;

GRANT SELECT ON TABLE BDL."HBF Sales Summary" TO GROUP MIS_DB_ACCESS_DEVL_R;

GRANT ALTER,
      DELETE,
      INDEX,
      INSERT,
      SELECT,
      UPDATE
   ON TABLE BDL."HBF Sales Summary"
   TO GROUP MIS_DB_ACCESS_DEVL_SYS;

SET  SCHEMA = ZP1K;

GRANT ALTER,
      DELETE,
      INDEX,
      INSERT,
      SELECT,
      UPDATE
   ON TABLE BDL."HBF Sales Summary"
   TO GROUP MIS_DB_ACCESS_DEVL_SYS;

SET  CURRENT SCHEMA = DD;

SET  CURRENT PATH = SYSIBM,
SYSFUN,
SYSPROC,
SYSIBMADM,
PYR;

-- Warning: View create script may contain dropped or renamed columns and may require user modification

DROP VIEW DD.SEM_HI_QUOTES_NON_WEB_V;
CREATE OR REPLACE VIEW DD.SEM_HI_QUOTES_NON_WEB_V
AS
   SELECT CAL.REPORTING_DT
             AS "Processed Date",
          EMP.USER_ID
             AS "Employee UserId",
          COALESCE (
             TRIM (
                SUBSTR (T000F080_NAME_FOR_HEADINGS,
                        LOCATE (',', T000F080_NAME_FOR_HEADINGS) + 1)),
             'Unknown')
             AS "Employee First Name",
          COALESCE (
             TRIM (
                SUBSTR (T000F080_NAME_FOR_HEADINGS,
                        1,
                        LOCATE (',', T000F080_NAME_FOR_HEADINGS) - 1)),
             'Unknown')
             AS "Employee Last Name",
          GROUP_L2_DESC
             AS "Group",
          DIVISION_L3_DESC
             AS "Division",
          DEPT_L4_DESC
             AS "Department",
          SUB_DEPT_L5_DESC
             AS "Sub Department",
          BRANCH_L6_DESC
             AS "Branch Area",
          MORG.TEAM_L7_ID
             AS "Team ID",
          MORG.TEAM_L7_DESC
             AS "Team Name",
          DDPCOMP.ENTITY_L2_ID
             AS "Entity",
          CHNL.CHANNEL_CDE
             AS "Channel",
          STATE.STATE_CDE
             AS "State",
          DDPCOMP.PROD_CLASS_L3_DESC
             AS "Product Class",
          DDPCOMP.PROD_GRP_L4_DESC
             AS "Product Group",
          'ACQUISITION'
             AS "Quote Type",
          SUM (QUOTE_ACQ_CNT)
             AS "HI Quotes"
   FROM DD.DD_F_SALE_PROCESS AS FSALE
        INNER JOIN DD.DD_D_CALENDAR CAL
           ON CAL.D_CALENDAR_SK = FSALE.D_CALENDAR_SK
        INNER JOIN DD.DD_D_MGMT_ORG MORG
           ON MORG.D_MGMT_ORG_SK = FSALE.D_MGMT_ORG_SALE_SK
        INNER JOIN DD.DD_D_PRODUCT_COMP DDPCOMP
           ON DDPCOMP.D_PROD_COMP_SK = FSALE.D_PROD_COMP_SK
        INNER JOIN DD.DD_D_CHANNEL CHNL
           ON CHNL.D_CHANNEL_SK = FSALE.D_CHANNEL_SK
        INNER JOIN DD.DD_D_EMPLOYEE EMP ON FSALE.D_EMP_SK = EMP.D_EMP_SK
        INNER JOIN DD.DD_D_STATE STATE ON FSALE.D_STATE_SK = STATE.D_STATE_SK
        LEFT OUTER JOIN
        (SELECT TRIM (T803F005_USER) T803F005_USER,
                T000F080_NAME_FOR_HEADINGS
         FROM AUR.T000_WAMI
         WHERE TRIM (T803F005_USER) <> '') AUR
           ON EMP.USER_ID = AUR.T803F005_USER
   WHERE     YEAR (CAL.REPORTING_DT) >= YEAR (CURRENT DATE - 5 YEARS)
         AND ENTITY_L2_ID = 'HI'
         AND CHNL.CHANNEL_CDE <> 'Internet'
   GROUP BY CAL.REPORTING_DT,
            EMP.USER_ID,
            COALESCE (
               TRIM (
                  SUBSTR (T000F080_NAME_FOR_HEADINGS,
                          LOCATE (',', T000F080_NAME_FOR_HEADINGS) + 1)),
               'Unknown'),
            COALESCE (
               TRIM (
                  SUBSTR (T000F080_NAME_FOR_HEADINGS,
                          1,
                          LOCATE (',', T000F080_NAME_FOR_HEADINGS) - 1)),
               'Unknown'),
            MORG.MASTER_L1_DESC,
            MORG.GROUP_L2_DESC,
            MORG.DIVISION_L3_DESC,
            MORG.DEPT_L4_DESC,
            MORG.SUB_DEPT_L5_DESC,
            MORG.BRANCH_L6_DESC,
            MORG.TEAM_L7_ID,
            MORG.TEAM_L7_DESC,
            DDPCOMP.ENTITY_L2_ID,
            CHNL.CHANNEL_CDE,
            STATE.STATE_CDE,
            DDPCOMP.PROD_CLASS_L3_DESC,
            DDPCOMP.PROD_GRP_L4_DESC,
            'ACQUISITION'
   UNION ALL
   SELECT CAL.REPORTING_DT
             AS "Processed Date",
          EMP.USER_ID
             AS "Employee UserId",
          COALESCE (
             TRIM (
                SUBSTR (T000F080_NAME_FOR_HEADINGS,
                        LOCATE (',', T000F080_NAME_FOR_HEADINGS) + 1)),
             'Unknown')
             AS "Employee First Name",
          COALESCE (
             TRIM (
                SUBSTR (T000F080_NAME_FOR_HEADINGS,
                        1,
                        LOCATE (',', T000F080_NAME_FOR_HEADINGS) - 1)),
             'Unknown')
             AS "Employee Last Name",
          GROUP_L2_DESC
             AS "Group",
          DIVISION_L3_DESC
             AS "Division",
          DEPT_L4_DESC
             AS "Department",
          SUB_DEPT_L5_DESC
             AS "Sub Department",
          BRANCH_L6_DESC
             AS "Branch Area",
          MORG.TEAM_L7_ID
             AS "Team ID",
          MORG.TEAM_L7_DESC
             AS "Team Name",
          DDPCOMP.ENTITY_L2_ID
             AS "Entity",
          CHNL.CHANNEL_CDE
             AS "Channel",
          STATE.STATE_CDE
             AS "State",
          DDPCOMP.PROD_CLASS_L3_DESC
             AS "Product Class",
          DDPCOMP.PROD_GRP_L4_DESC
             AS "Product Group",
          'UPSELL'
             AS "Quote Type",
          SUM (QUOTE_UP_SELL_CNT)
             AS "HI Quotes"
   FROM DD.DD_F_SALE_PROCESS AS FSALE
        INNER JOIN DD.DD_D_CALENDAR CAL
           ON CAL.D_CALENDAR_SK = FSALE.D_CALENDAR_SK
        INNER JOIN DD.DD_D_MGMT_ORG MORG
           ON MORG.D_MGMT_ORG_SK = FSALE.D_MGMT_ORG_SALE_SK
        INNER JOIN DD.DD_D_PRODUCT_COMP DDPCOMP
           ON DDPCOMP.D_PROD_COMP_SK = FSALE.D_PROD_COMP_SK
        INNER JOIN DD.DD_D_CHANNEL CHNL
           ON CHNL.D_CHANNEL_SK = FSALE.D_CHANNEL_SK
        INNER JOIN DD.DD_D_EMPLOYEE EMP ON FSALE.D_EMP_SK = EMP.D_EMP_SK
        INNER JOIN DD.DD_D_STATE STATE ON FSALE.D_STATE_SK = STATE.D_STATE_SK
        LEFT OUTER JOIN
        (SELECT TRIM (T803F005_USER) T803F005_USER,
                T000F080_NAME_FOR_HEADINGS
         FROM AUR.T000_WAMI
         WHERE TRIM (T803F005_USER) <> '') AUR
           ON EMP.USER_ID = AUR.T803F005_USER
   WHERE     YEAR (CAL.REPORTING_DT) >= YEAR (CURRENT DATE - 5 YEARS)
         AND ENTITY_L2_ID = 'HI'
         AND CHNL.CHANNEL_CDE <> 'Internet'
   GROUP BY CAL.REPORTING_DT,
            EMP.USER_ID,
            COALESCE (
               TRIM (
                  SUBSTR (T000F080_NAME_FOR_HEADINGS,
                          LOCATE (',', T000F080_NAME_FOR_HEADINGS) + 1)),
               'Unknown'),
            COALESCE (
               TRIM (
                  SUBSTR (T000F080_NAME_FOR_HEADINGS,
                          1,
                          LOCATE (',', T000F080_NAME_FOR_HEADINGS) - 1)),
               'Unknown'),
            MORG.MASTER_L1_DESC,
            MORG.GROUP_L2_DESC,
            MORG.DIVISION_L3_DESC,
            MORG.DEPT_L4_DESC,
            MORG.SUB_DEPT_L5_DESC,
            MORG.BRANCH_L6_DESC,
            MORG.TEAM_L7_ID,
            MORG.TEAM_L7_DESC,
            DDPCOMP.ENTITY_L2_ID,
            CHNL.CHANNEL_CDE,
            STATE.STATE_CDE,
            DDPCOMP.PROD_CLASS_L3_DESC,
            DDPCOMP.PROD_GRP_L4_DESC,
            'UPSELL';

SET  SCHEMA = GZD;

GRANT SELECT ON DD.SEM_HI_QUOTES_NON_WEB_V TO USER SASDIDEV1;

SET  SCHEMA = ZP1K;

GRANT SELECT ON DD.SEM_HI_QUOTES_NON_WEB_V TO USER SASDIDEV1;

SET  SCHEMA = GZD;

GRANT SELECT ON DD.SEM_HI_QUOTES_NON_WEB_V TO USER SVC_BI_FEDDBUSER_RLS;

SET  SCHEMA = ZP1K;

GRANT SELECT ON DD.SEM_HI_QUOTES_NON_WEB_V TO USER SVC_BI_FEDDBUSER_RLS;

SET  SCHEMA = GZD;

GRANT SELECT ON DD.SEM_HI_QUOTES_NON_WEB_V TO USER SVC_TBLADMIN_RLS;

SET  SCHEMA = ZP1K;

GRANT SELECT ON DD.SEM_HI_QUOTES_NON_WEB_V TO USER SVC_TBLADMIN_RLS;

SET  SCHEMA = GZD;

GRANT SELECT ON DD.SEM_HI_QUOTES_NON_WEB_V TO GROUP DB2_MIS_MON;

SET  SCHEMA = ZP1K;

GRANT SELECT ON DD.SEM_HI_QUOTES_NON_WEB_V TO GROUP DB2_MIS_MON;

SET  SCHEMA = GZD;

GRANT SELECT ON DD.SEM_HI_QUOTES_NON_WEB_V TO GROUP MIS_DB_ACCESS_DEVL_R;

SET  SCHEMA = ZP1K;

GRANT SELECT ON DD.SEM_HI_QUOTES_NON_WEB_V TO GROUP MIS_DB_ACCESS_DEVL_R;

SET  SCHEMA = GZD;

GRANT SELECT ON DD.SEM_HI_QUOTES_NON_WEB_V TO GROUP MIS_DB_ACCESS_DEVL_SYS;

SET  SCHEMA = ZP1K;

GRANT SELECT ON DD.SEM_HI_QUOTES_NON_WEB_V TO GROUP MIS_DB_ACCESS_DEVL_SYS;

SET  CURRENT SCHEMA = GZD;

SET  CURRENT PATH = "SYSIBM",
"SYSFUN",
"SYSPROC",
"SYSIBMADM",
"GZD";

-- Warning: View create script may contain dropped or renamed columns and may require user modification

CREATE OR REPLACE VIEW DD.SEM_HI_QUOTES_V
AS
   SELECT "Processed Date",
          'UNK' AS "Employee UserId",
          'Unknown' AS "Employee First Name",
          'Unknown' AS "Employee Last Name",
          "Group",
          "Division",
          "Department",
          "Sub Department",
          "Branch Area",
          "Team ID",
          "Team Name",
          "Entity",
          "Channel",
          "Product Class",
          "Product Group",
          "Quote Type",
          "HI Quotes"
   FROM DD.NICKNAME_RDS_WEB_ANALYTICS_SEM_HI_QUOTES_WEB_V
   UNION ALL
   SELECT "Processed Date",
          "Employee UserId",
          "Employee First Name",
          "Employee Last Name",
          "Group",
          "Division",
          "Department",
          "Sub Department",
          "Branch Area",
          "Team ID",
          "Team Name",
          "Entity",
          "Channel",
          "Product Class",
          "Product Group",
          "Quote Type",
          "HI Quotes"
   FROM DD.SEM_HI_QUOTES_NON_WEB_V;

CREATE OR REPLACE ALIAS SASDIDEV1.SEM_HI_QUOTES_NON_WEB_V
   FOR DD.SEM_HI_QUOTES_NON_WEB_V;

CREATE OR REPLACE ALIAS SASDIPROD.SEM_HI_QUOTES_NON_WEB_V
   FOR DD.SEM_HI_QUOTES_NON_WEB_V;

SET  CURRENT SCHEMA = DD;

SET  CURRENT PATH = SYSIBM,
SYSFUN,
SYSPROC,
SYSIBMADM,
PYR;

-- Warning: View create script may contain dropped or renamed columns and may require user modification

DROP VIEW DD.SEM_HI_SALE_V;
CREATE OR REPLACE VIEW DD.SEM_HI_SALE_V
AS
   SELECT CAL.REPORTING_DT
             AS "Processed Date",
          EMP.USER_ID
             AS "Employee UserId",
          COALESCE (
             TRIM (
                SUBSTR (T000F080_NAME_FOR_HEADINGS,
                        LOCATE (',', T000F080_NAME_FOR_HEADINGS) + 1)),
             'Unknown')
             AS "Employee First Name",
          COALESCE (
             TRIM (
                SUBSTR (T000F080_NAME_FOR_HEADINGS,
                        1,
                        LOCATE (',', T000F080_NAME_FOR_HEADINGS) - 1)),
             'Unknown')
             AS "Employee Last Name",
          GROUP_L2_DESC
             AS "Group",
          DIVISION_L3_DESC
             AS "Division",
          DEPT_L4_DESC
             AS "Department",
          SUB_DEPT_L5_DESC
             AS "Sub Department",
          BRANCH_L6_DESC
             AS "Branch Area",
          MORG.TEAM_L7_ID
             AS "Team ID",
          MORG.TEAM_L7_DESC
             AS "Team Name",
          DDPCOMP.ENTITY_L2_ID
             AS "Entity",
          CHNL.CHANNEL_CDE
             AS "Channel",
          STATE.STATE_CDE
             AS "State",
          DDPCOMP.PROD_CLASS_L3_DESC
             AS "Product Class",
          DDPCOMP.PROD_GRP_L4_DESC
             AS "Product Group",
          POLEVE.PLCY_EVNT_TYP_DESC
             AS "Sale Type",
          SUM (CASE POLEVE.PLCY_EVNT_CAT_ID WHEN 1 THEN SALE_CNT ELSE 0 END)
             AS "HI Pending Sales",
          SUM (CASE POLEVE.PLCY_EVNT_CAT_ID WHEN 2 THEN SALE_CNT ELSE 0 END)
             AS "HI Financial Sales",
          SUM (CASE POLEVE.PLCY_EVNT_CAT_ID WHEN 1 THEN SALE_AMT ELSE 0 END)
             AS "HI Pending Sale Amount",
          SUM (CASE POLEVE.PLCY_EVNT_CAT_ID WHEN 2 THEN SALE_AMT ELSE 0 END)
             AS "HI Financial Sale Amount"
   FROM DD.DD_F_SALE FSALE
        INNER JOIN DD.DD_D_CALENDAR CAL
           ON CAL.D_CALENDAR_SK = FSALE.D_CALENDAR_SALE_SK
        INNER JOIN DD.DD_D_MGMT_ORG MORG
           ON MORG.D_MGMT_ORG_SK = FSALE.D_MGMT_ORG_SALE_SK
        INNER JOIN DD.DD_D_PRODUCT_COMP DDPCOMP
           ON DDPCOMP.D_PROD_COMP_SK = FSALE.D_PROD_COMP_SK
        INNER JOIN DD.DD_D_CHANNEL CHNL
           ON CHNL.D_CHANNEL_SK = FSALE.D_CHANNEL_SK
        INNER JOIN DD.DD_D_POLICY_EVENT POLEVE
           ON POLEVE.D_PLCY_EVNT_SK = FSALE.D_PLCY_EVNT_SK
        INNER JOIN DD.DD_D_EMPLOYEE EMP ON FSALE.D_EMP_SK = EMP.D_EMP_SK
        INNER JOIN DD.DD_D_STATE STATE ON FSALE.D_STATE_SK = STATE.D_STATE_SK
        LEFT OUTER JOIN (SELECT *
                         FROM AUR.T000_WAMI
                         WHERE TRIM (T803F005_USER) <> '') AUR
           ON EMP.USER_ID = TRIM (AUR.T803F005_USER)
   WHERE     YEAR (CAL.REPORTING_DT) >= YEAR (CURRENT DATE - 5 YEARS)
         AND POLEVE.PLCY_EVNT_CAT_ID IN ('1', '2')
         AND ENTITY_L2_ID = 'HI'
   GROUP BY CAL.REPORTING_DT,
            EMP.USER_ID,
            COALESCE (
               TRIM (
                  SUBSTR (T000F080_NAME_FOR_HEADINGS,
                          LOCATE (',', T000F080_NAME_FOR_HEADINGS) + 1)),
               'Unknown'),
            COALESCE (
               TRIM (
                  SUBSTR (T000F080_NAME_FOR_HEADINGS,
                          1,
                          LOCATE (',', T000F080_NAME_FOR_HEADINGS) - 1)),
               'Unknown'),
            MORG.MASTER_L1_DESC,
            MORG.GROUP_L2_DESC,
            MORG.DIVISION_L3_DESC,
            MORG.DEPT_L4_DESC,
            MORG.SUB_DEPT_L5_DESC,
            MORG.BRANCH_L6_DESC,
            MORG.TEAM_L7_ID,
            MORG.TEAM_L7_DESC,
            DDPCOMP.ENTITY_L2_ID,
            CHNL.CHANNEL_CDE,
            STATE.STATE_CDE,
            DDPCOMP.PROD_CLASS_L3_DESC,
            DDPCOMP.PROD_GRP_L4_DESC,
            POLEVE.PLCY_EVNT_TYP_DESC;

SET  SCHEMA = GZD;

GRANT SELECT ON DD.SEM_HI_SALE_V TO USER SASDIDEV1;

SET  SCHEMA = ZP1K;

GRANT SELECT ON DD.SEM_HI_SALE_V TO USER SASDIDEV1;

SET  SCHEMA = GZD;

GRANT SELECT ON DD.SEM_HI_SALE_V TO USER SVC_BI_FEDDBUSER_RLS;

SET  SCHEMA = ZP1K;

GRANT SELECT ON DD.SEM_HI_SALE_V TO USER SVC_BI_FEDDBUSER_RLS;

SET  SCHEMA = GZD;

GRANT SELECT ON DD.SEM_HI_SALE_V TO USER SVC_TBLADMIN_RLS;

SET  SCHEMA = ZP1K;

GRANT SELECT ON DD.SEM_HI_SALE_V TO USER SVC_TBLADMIN_RLS;

SET  SCHEMA = GZD;

GRANT SELECT ON DD.SEM_HI_SALE_V TO GROUP DB2_MIS_MON;

SET  SCHEMA = ZP1K;

GRANT SELECT ON DD.SEM_HI_SALE_V TO GROUP DB2_MIS_MON;

SET  SCHEMA = GZD;

GRANT SELECT ON DD.SEM_HI_SALE_V TO GROUP MIS_DB_ACCESS_DEVL_R;

SET  SCHEMA = ZP1K;

GRANT SELECT ON DD.SEM_HI_SALE_V TO GROUP MIS_DB_ACCESS_DEVL_R;

SET  SCHEMA = GZD;

GRANT SELECT ON DD.SEM_HI_SALE_V TO GROUP MIS_DB_ACCESS_DEVL_SYS;

SET  SCHEMA = ZP1K;

GRANT SELECT ON DD.SEM_HI_SALE_V TO GROUP MIS_DB_ACCESS_DEVL_SYS;

CREATE OR REPLACE ALIAS SASDIPROD.SEM_HI_SALE_V FOR DD.SEM_HI_SALE_V;

CREATE OR REPLACE ALIAS SASDIDEV1.SEM_HI_SALE_V FOR DD.SEM_HI_SALE_V;

SET  CURRENT SCHEMA = V0B;

SET  CURRENT PATH = SYSIBM,
SYSFUN,
SYSPROC,
SYSIBMADM,
V0B;

-- Warning: View create script may contain dropped or renamed columns and may require user modification

DROP VIEW DD.SEM_QUOTES_SALE_TARGET_V;
CREATE OR REPLACE VIEW DD.SEM_QUOTES_SALE_TARGET_V
AS
   SELECT CAL.REPORTING_DT
             AS "Processed Date",
          GROUP_L2_DESC
             AS "Group",
          DIVISION_L3_DESC
             AS "Division",
          DEPT_L4_DESC
             AS "Department",
          SUB_DEPT_L5_DESC
             AS "Sub Department",
          BRANCH_L6_DESC
             AS "Branch Area",
          MORG.TEAM_L7_ID
             AS "Team ID",
          MORG.TEAM_L7_DESC
             AS "Team Name",
          EMP.USER_ID
             AS "Employee UserId",
          COALESCE (
             TRIM (
                SUBSTR (T000F080_NAME_FOR_HEADINGS,
                        LOCATE (',', T000F080_NAME_FOR_HEADINGS) + 1)),
             'Unknown')
             AS "Employee First Name",
          COALESCE (
             TRIM (
                SUBSTR (T000F080_NAME_FOR_HEADINGS,
                        1,
                        LOCATE (',', T000F080_NAME_FOR_HEADINGS) - 1)),
             'Unknown')
             AS "Employee Last Name",
          DDPCOMP.ENTITY_L2_ID
             AS "Entity",
          CHNL.CHANNEL_CDE
             AS "Channel",
          DDPCOMP.PROD_CLASS_L3_DESC
             AS "Product Class",
          DDPCOMP.PROD_GRP_L4_DESC
             AS "Product Group",
          'ACQUISITION'
             AS "Sale Type",
          STATE.STATE_CDE
             AS "State",
          SUM (CASE FSALE.ROW_TYP WHEN 'Q' THEN TRGT_SALE_CNT ELSE 0 END)
             AS "Target Quote Counts",
          SUM (CASE FSALE.ROW_TYP WHEN 'S' THEN TRGT_SALE_CNT ELSE 0 END)
             AS "Target Sale Counts",
          SUM (CASE FSALE.ROW_TYP WHEN 'S' THEN TRGT_SALE_AMT ELSE 0 END)
             AS "Target Sale Amount"
   FROM DD.DD_F_SALE_TARGET FSALE
        INNER JOIN DD.DD_D_CALENDAR CAL
           ON CAL.D_CALENDAR_SK = FSALE.D_CALENDAR_SK
        INNER JOIN DD.DD_D_MGMT_ORG MORG
           ON MORG.D_MGMT_ORG_SK = FSALE.D_MGMT_ORG_SK
        INNER JOIN DD.DD_D_PRODUCT_COMP DDPCOMP
           ON DDPCOMP.D_PROD_COMP_SK = FSALE.D_PROD_COMP_SK
        INNER JOIN DD.DD_D_CHANNEL CHNL
           ON CHNL.D_CHANNEL_SK = FSALE.D_CHANNEL_SK
        INNER JOIN DD.DD_D_POLICY_EVENT POLEVE
           ON POLEVE.D_PLCY_EVNT_SK = FSALE.D_PLCY_EVNT_SK
        INNER JOIN DD.DD_D_EMPLOYEE EMP ON EMP.D_EMP_SK = FSALE.D_EMP_SK
        INNER JOIN DD.DD_D_STATE STATE ON STATE.D_STATE_SK = FSALE.D_STATE_SK
        LEFT OUTER JOIN (SELECT *
                         FROM AUR.T000_WAMI
                         WHERE TRIM (T803F005_USER) <> '') AUR
           ON EMP.USER_ID = TRIM (AUR.T803F005_USER)
   WHERE     YEAR (CAL.REPORTING_DT) >= YEAR (CURRENT DATE - 5 YEARS)
         AND ENTITY_L2_ID IN ('HI', 'GI')
         AND NOT (
                        ENTITY_L2_ID IN ('HI')
                    AND CHNL.CHANNEL_CDE = 'Internet'
                    AND FSALE.ROW_TYP = 'Q')
   GROUP BY CAL.REPORTING_DT,
            MORG.MASTER_L1_DESC,
            MORG.GROUP_L2_DESC,
            MORG.DIVISION_L3_DESC,
            MORG.DEPT_L4_DESC,
            MORG.SUB_DEPT_L5_DESC,
            MORG.BRANCH_L6_DESC,
            MORG.TEAM_L7_ID,
            MORG.TEAM_L7_DESC,
            EMP.USER_ID,
            COALESCE (
               TRIM (
                  SUBSTR (T000F080_NAME_FOR_HEADINGS,
                          LOCATE (',', T000F080_NAME_FOR_HEADINGS) + 1)),
               'Unknown'),
            COALESCE (
               TRIM (
                  SUBSTR (T000F080_NAME_FOR_HEADINGS,
                          1,
                          LOCATE (',', T000F080_NAME_FOR_HEADINGS) - 1)),
               'Unknown'),
            DDPCOMP.ENTITY_L2_ID,
            CHNL.CHANNEL_CDE,
            DDPCOMP.PROD_CLASS_L3_DESC,
            DDPCOMP.PROD_GRP_L4_DESC,
            'ACQUISITION',
            STATE.STATE_CDE
   UNION ALL
   SELECT CAL.REPORTING_DT
             AS "Processed Date",
          GROUP_L2_DESC
             AS "Group",
          DIVISION_L3_DESC
             AS "Division",
          DEPT_L4_DESC
             AS "Department",
          SUB_DEPT_L5_DESC
             AS "Sub Department",
          BRANCH_L6_DESC
             AS "Branch Area",
          MORG.TEAM_L7_ID
             AS "Team ID",
          MORG.TEAM_L7_DESC
             AS "Team Name",
          EMP.USER_ID
             AS "Employee UserId",
          COALESCE (
             TRIM (
                SUBSTR (T000F080_NAME_FOR_HEADINGS,
                        LOCATE (',', T000F080_NAME_FOR_HEADINGS) + 1)),
             'Unknown')
             AS "Employee First Name",
          COALESCE (
             TRIM (
                SUBSTR (T000F080_NAME_FOR_HEADINGS,
                        1,
                        LOCATE (',', T000F080_NAME_FOR_HEADINGS) - 1)),
             'Unknown')
             AS "Employee Last Name",
          DDPCOMP.ENTITY_L2_ID
             AS "Entity",
          CHNL.CHANNEL_CDE
             AS "Channel",
          DDPCOMP.PROD_CLASS_L3_DESC
             AS "Product Class",
          DDPCOMP.PROD_GRP_L4_DESC
             AS "Product Group",
          'ACQUISITION'
             AS "Sale Type",
          STATE.STATE_CDE
             AS "State",
          (MAX (CASE FSALE.ROW_TYP WHEN 'Q' THEN TRGT_SALE_CNT ELSE 0 END))
             AS "Target Quote Counts",
          0
             AS "Target Sale Counts",
          0
             AS "Target Sale Amount"
   FROM DD.DD_F_SALE_TARGET FSALE
        INNER JOIN DD.DD_D_CALENDAR CAL
           ON CAL.D_CALENDAR_SK = FSALE.D_CALENDAR_SK
        INNER JOIN DD.DD_D_MGMT_ORG MORG
           ON MORG.D_MGMT_ORG_SK = FSALE.D_MGMT_ORG_SK
        INNER JOIN DD.DD_D_PRODUCT_COMP DDPCOMP
           ON DDPCOMP.D_PROD_COMP_SK = FSALE.D_PROD_COMP_SK
        INNER JOIN DD.DD_D_CHANNEL CHNL
           ON CHNL.D_CHANNEL_SK = FSALE.D_CHANNEL_SK
        INNER JOIN DD.DD_D_POLICY_EVENT POLEVE
           ON POLEVE.D_PLCY_EVNT_SK = FSALE.D_PLCY_EVNT_SK
        INNER JOIN DD.DD_D_EMPLOYEE EMP ON EMP.D_EMP_SK = FSALE.D_EMP_SK
        INNER JOIN DD.DD_D_STATE STATE ON STATE.D_STATE_SK = FSALE.D_STATE_SK
        LEFT OUTER JOIN (SELECT *
                         FROM AUR.T000_WAMI
                         WHERE TRIM (T803F005_USER) <> '') AUR
           ON EMP.USER_ID = TRIM (AUR.T803F005_USER)
   WHERE     YEAR (CAL.REPORTING_DT) >= YEAR (CURRENT DATE - 5 YEARS)
         AND ENTITY_L2_ID IN ('HI')
         AND CHNL.CHANNEL_CDE = 'Internet'
         AND FSALE.ROW_TYP = 'Q'
   GROUP BY CAL.REPORTING_DT,
            MORG.MASTER_L1_DESC,
            MORG.GROUP_L2_DESC,
            MORG.DIVISION_L3_DESC,
            MORG.DEPT_L4_DESC,
            MORG.SUB_DEPT_L5_DESC,
            MORG.BRANCH_L6_DESC,
            MORG.TEAM_L7_ID,
            MORG.TEAM_L7_DESC,
            EMP.USER_ID,
            COALESCE (
               TRIM (
                  SUBSTR (T000F080_NAME_FOR_HEADINGS,
                          LOCATE (',', T000F080_NAME_FOR_HEADINGS) + 1)),
               'Unknown'),
            COALESCE (
               TRIM (
                  SUBSTR (T000F080_NAME_FOR_HEADINGS,
                          1,
                          LOCATE (',', T000F080_NAME_FOR_HEADINGS) - 1)),
               'Unknown'),
            DDPCOMP.ENTITY_L2_ID,
            CHNL.CHANNEL_CDE,
            DDPCOMP.PROD_CLASS_L3_DESC,
            DDPCOMP.PROD_GRP_L4_DESC,
            STATE.STATE_CDE;

SET  SCHEMA = GZD;

GRANT SELECT ON DD.SEM_QUOTES_SALE_TARGET_V TO USER SASDIDEV1;

SET  SCHEMA = ZP1K;

GRANT SELECT ON DD.SEM_QUOTES_SALE_TARGET_V TO USER SASDIDEV1;

SET  SCHEMA = GZD;

GRANT SELECT ON DD.SEM_QUOTES_SALE_TARGET_V TO USER SVC_BI_FEDDBUSER_RLS;

SET  SCHEMA = ZP1K;

GRANT SELECT ON DD.SEM_QUOTES_SALE_TARGET_V TO USER SVC_BI_FEDDBUSER_RLS;

SET  SCHEMA = GZD;

GRANT SELECT ON DD.SEM_QUOTES_SALE_TARGET_V TO USER SVC_TBLADMIN_RLS;

SET  SCHEMA = ZP1K;

GRANT SELECT ON DD.SEM_QUOTES_SALE_TARGET_V TO USER SVC_TBLADMIN_RLS;

SET  SCHEMA = GZD;

GRANT SELECT ON DD.SEM_QUOTES_SALE_TARGET_V TO GROUP DB2_MIS_MON;

SET  SCHEMA = ZP1K;

GRANT SELECT ON DD.SEM_QUOTES_SALE_TARGET_V TO GROUP DB2_MIS_MON;

SET  SCHEMA = GZD;

GRANT SELECT ON DD.SEM_QUOTES_SALE_TARGET_V TO GROUP MIS_DB_ACCESS_DEVL_R;

SET  SCHEMA = ZP1K;

GRANT SELECT ON DD.SEM_QUOTES_SALE_TARGET_V TO GROUP MIS_DB_ACCESS_DEVL_R;

SET  SCHEMA = GZD;

GRANT SELECT ON DD.SEM_QUOTES_SALE_TARGET_V TO GROUP MIS_DB_ACCESS_DEVL_SYS;

SET  SCHEMA = ZP1K;

GRANT SELECT ON DD.SEM_QUOTES_SALE_TARGET_V TO GROUP MIS_DB_ACCESS_DEVL_SYS;

CREATE OR REPLACE ALIAS SASDIDEV1.SEM_QUOTES_SALE_TARGET_V
   FOR DD.SEM_QUOTES_SALE_TARGET_V;

CREATE OR REPLACE ALIAS SASDIPROD.SEM_QUOTES_SALE_TARGET_V
   FOR DD.SEM_QUOTES_SALE_TARGET_V;

CREATE OR REPLACE ALIAS BDL_ALIAS."HBF Sales Summary"
   FOR BDL."HBF Sales Summary";

CREATE OR REPLACE ALIAS SASDIPROD.SEM_HI_QUOTES_V FOR DD.SEM_HI_QUOTES_V;

CREATE OR REPLACE ALIAS SASDIDEV1.SEM_HI_QUOTES_V FOR DD.SEM_HI_QUOTES_V;

COMMIT;

-- Step 3. Runstats
RUNSTATS ON TABLE BDL."HBF Sales Summary"
	ALLOW WRITE ACCESS;

SET  CURRENT SCHEMA = P1K;