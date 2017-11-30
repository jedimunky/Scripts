-- Step 1. Export of data for preserve

CREATE TABLE TMP_IWRRA.TMP_EDL_TRG_D_HI_ITEM_BAOFA
(
   D_HI_ITEM_SK INTEGER,
   R_CODE_ACCOM_TYP_SK INTEGER,
   R_CODE_AMB_TYP_SK INTEGER,
   R_CODE_BEN_SEGMENT_SK INTEGER,
   R_CODE_CRAFT_GRP_SK INTEGER,
   R_CODE_CRAFT_SUB_GRP_SK INTEGER,
   R_CODE_DRG_BROAD_GRP_SK INTEGER,
   R_CODE_DRG_ADJCNT_SK INTEGER,
   R_CODE_DRG_PARTN_SK INTEGER,
   R_CODE_DRG_SPLIT_SK INTEGER,
   R_CODE_DRG_REC_TYP_SK INTEGER,
   R_CODE_ITEM_SUMM_GRP_SK INTEGER,
   R_CODE_MAJ_SRVCE_GRP_SK INTEGER,
   R_CODE_SRC_ITEM_CAT_SK INTEGER,
   R_CODE_SRC_ITEM_TYP_SK INTEGER,
   R_CODE_SRC_SRVCE_TYP_SK INTEGER,
   R_SOURCE_SYSTEM_SK INTEGER,
   ITEM_CDE VARCHAR (10),
   ITEM_TYP VARCHAR (10),
   ITEM_START_DT DATE,
   ADJUSTMENT_ITEM_CDE_IND CHARACTER (1 OCTETS),
   DRG_ITEM_IND VARCHAR (10),
   ITEM_DESC VARCHAR (256),
   ITEM_CEASE_DT DATE,
   MBS_IND CHARACTER (1 OCTETS),
   INSERT_TS TIMESTAMP,
   UPDATE_TS TIMESTAMP,
   DEL_FLG CHARACTER (1 OCTETS)
)
IN TBS_BASEC_EDL_16K;

INSERT INTO TMP_IWRRA.TMP_EDL_TRG_D_HI_ITEM_BAOFA
   SELECT D_HI_ITEM_SK,
          R_CODE_ACCOM_TYP_SK,
          R_CODE_AMB_TYP_SK,
          R_CODE_BEN_SEGMENT_SK,
          R_CODE_CRAFT_GRP_SK,
          R_CODE_CRAFT_SUB_GRP_SK,
          R_CODE_DRG_BROAD_GRP_SK,
          R_CODE_DRG_ADJCNT_SK,
          R_CODE_DRG_PARTN_SK,
          R_CODE_DRG_SPLIT_SK,
          R_CODE_DRG_REC_TYP_SK,
          R_CODE_ITEM_SUMM_GRP_SK,
          R_CODE_MAJ_SRVCE_GRP_SK,
          R_CODE_SRC_ITEM_CAT_SK,
          R_CODE_SRC_ITEM_TYP_SK,
          R_CODE_SRC_SRVCE_TYP_SK,
          R_SOURCE_SYSTEM_SK,
          ITEM_CDE,
          ITEM_TYP,
          ITEM_START_DT,
          ADJUSTMENT_ITEM_CDE_IND,
          DRG_ITEM_IND,
          ITEM_DESC,
          ITEM_CEASE_DT,
          MBS_IND,
          INSERT_TS,
          UPDATE_TS,
          DEL_FLG
   FROM EDL.TRG_D_HI_ITEM;

CREATE TABLE TMP_IWRRA.TMP_DD_DD_D_HI_ITEM_IVCMU
(
   D_HI_ITEM_SK INTEGER,
   INSERT_TS TIMESTAMP,
   UPDATE_TS TIMESTAMP,
   ITEM_CDE VARCHAR (10),
   ITEM_DESC VARCHAR (256),
   ITEM_START_DT DATE,
   ITEM_CEASE_DT DATE,
   ACCOM_TYP_CDE VARCHAR (10),
   ACCOM_TYP_DESC VARCHAR (50),
   AMB_TYP VARCHAR (10),
   AMB_DESC VARCHAR (10),
   BEN_SEGMENT_CDE VARCHAR (10),
   BEN_SEGMENT_DESC VARCHAR (50),
   CRAFT_GRP_CDE VARCHAR (10),
   CRAFT_GRP_DESC VARCHAR (50),
   CRAFT_SUB_GRP_CDE VARCHAR (10),
   CRAFT_SUB_GRP_DESC VARCHAR (50),
   DRG_BROAD_GRP_CDE VARCHAR (10),
   DRG_BROAD_GRP_DESC VARCHAR (50),
   DRG_ADJCNT_CDE VARCHAR (10),
   DRG_ADJCNT_DESC VARCHAR (50),
   DRG_PARTN_CDE VARCHAR (10),
   DRG_PARTN_SHORT_DESC CHARACTER (1 OCTETS),
   DRG_PARTN_LONG_DESC VARCHAR (10),
   DRG_REC_TYP_CDE VARCHAR (10),
   DRG_REC_TYP_DESC VARCHAR (50),
   ITEM_CAT_CDE VARCHAR (10),
   ITEM_CAT_DESC VARCHAR (50),
   ITEM_TYP_CDE VARCHAR (10),
   ITEM_TYP_DESC VARCHAR (50),
   SRVCE_TYP_CDE VARCHAR (10),
   SRVCE_TYP_DESC VARCHAR (50),
   DRG_ITEM_IND VARCHAR (10),
   ADJUSTMENT_ITEM_CDE_IND CHARACTER (1 OCTETS),
   ITEM_SUMMARY_GRP VARCHAR (10),
   ITEM_SUMMARY_GRP_DESC VARCHAR (50),
   MAJOR_SERVICE_GRP VARCHAR (10),
   MAJOR_SERVICE_GRP_DESC VARCHAR (50),
   MBS_IND CHARACTER (1 OCTETS)
)
IN TBS_BASEC_DD_16K;

INSERT INTO TMP_IWRRA.TMP_DD_DD_D_HI_ITEM_IVCMU
   SELECT D_HI_ITEM_SK,
          INSERT_TS,
          UPDATE_TS,
          ITEM_CDE,
          ITEM_DESC,
          ITEM_START_DT,
          ITEM_CEASE_DT,
          ACCOM_TYP_CDE,
          ACCOM_TYP_DESC,
          AMB_TYP,
          AMB_DESC,
          BEN_SEGMENT_CDE,
          BEN_SEGMENT_DESC,
          CRAFT_GRP_CDE,
          CRAFT_GRP_DESC,
          CRAFT_SUB_GRP_CDE,
          CRAFT_SUB_GRP_DESC,
          DRG_BROAD_GRP_CDE,
          DRG_BROAD_GRP_DESC,
          DRG_ADJCNT_CDE,
          DRG_ADJCNT_DESC,
          DRG_PARTN_CDE,
          DRG_PARTN_SHORT_DESC,
          DRG_PARTN_LONG_DESC,
          DRG_REC_TYP_CDE,
          DRG_REC_TYP_DESC,
          ITEM_CAT_CDE,
          ITEM_CAT_DESC,
          ITEM_TYP_CDE,
          ITEM_TYP_DESC,
          SRVCE_TYP_CDE,
          SRVCE_TYP_DESC,
          DRG_ITEM_IND,
          ADJUSTMENT_ITEM_CDE_IND,
          ITEM_SUMMARY_GRP,
          ITEM_SUMMARY_GRP_DESC,
          MAJOR_SERVICE_GRP,
          MAJOR_SERVICE_GRP_DESC,
          MBS_IND
   FROM DD.DD_D_HI_ITEM;

-- Step 2. Drop
DROP ALIAS SASDIPROD.TRG_D_HI_ITEM;

DROP TABLE EDL.TRG_D_HI_ITEM;

DROP ALIAS SASDIPROD.DD_D_HI_ITEM;

DROP TABLE DD.DD_D_HI_ITEM;

COMMIT;

-- Step 3. Sync

ALTER TABLE DD.DD_D_PRODUCT_COMP
   ADD COLUMN OEC_PROD_COMP_L6_DESC VARCHAR (1024) NOT NULL DEFAULT 'Unknown';

ALTER TABLE DD.DD_D_PRODUCT_COMP
   ADD COLUMN OEC_PROD_COMP_DESC_EFF_DT DATE NOT NULL DEFAULT '9999-12-31';

ALTER TABLE DD.DD_D_PRODUCT_COMP
   ADD COLUMN BENEFIT_COVER_1 VARCHAR (20) NOT NULL DEFAULT 'UNK';

ALTER TABLE DD.DD_D_PRODUCT_COMP
   ADD COLUMN BENEFIT_COVER_2 VARCHAR (20) NOT NULL DEFAULT 'UNK';

ALTER TABLE DD.DD_D_PRODUCT_COMP
   ADD COLUMN PROD_SALE_CLOSE_DT DATE NOT NULL DEFAULT '9999-12-31';

ALTER TABLE DD.DD_D_PRODUCT_COMP
   ADD COLUMN PROD_WITHDRAWN_DT DATE NOT NULL DEFAULT '9999-12-31';

ALTER TABLE DD.DD_D_PRODUCT_COMP
   ADD COLUMN PROD_TYP_CDE VARCHAR (20) NOT NULL DEFAULT 'UNK';

ALTER TABLE DD.DD_D_PRODUCT_COMP
   ADD COLUMN PROD_TYP_DESC VARCHAR (50) NOT NULL DEFAULT 'Unknown';


ALTER TABLE EDL.TRG_D_PROD_COMP
   ADD COLUMN OEC_PROD_COMP_DESC VARCHAR (1024) NOT NULL DEFAULT 'Unknown';

ALTER TABLE EDL.TRG_D_PROD_COMP
   ADD COLUMN OEC_PROD_COMP_DESC_EFF_DT DATE NOT NULL DEFAULT '9999-12-31';

ALTER TABLE EDL.TRG_D_PROD_COMP
   ADD COLUMN BENEFIT_COVER_1 VARCHAR (20) NOT NULL DEFAULT 'UNK';

ALTER TABLE EDL.TRG_D_PROD_COMP
   ADD COLUMN BENEFIT_COVER_2 VARCHAR (20) NOT NULL DEFAULT 'UNK';

ALTER TABLE EDL.TRG_D_PROD_COMP
   ADD COLUMN PROD_SALE_CLOSE_DT DATE NOT NULL DEFAULT '9999-12-31';

ALTER TABLE EDL.TRG_D_PROD_COMP
   ADD COLUMN PROD_WITHDRAWN_DT DATE NOT NULL DEFAULT '9999-12-31';

ALTER TABLE EDL.TRG_D_PROD_COMP
   ADD COLUMN PROD_TYP_CDE VARCHAR (20) NOT NULL DEFAULT 'UNK';

ALTER TABLE EDL.TRG_D_PROD_COMP
   ADD COLUMN PROD_TYP_DESC VARCHAR (50) NOT NULL DEFAULT 'Unknown';


CREATE TABLE DD.DD_D_HI_ITEM
(
   D_HI_ITEM_SK               INTEGER NOT NULL,
   INSERT_TS                  TIMESTAMP NOT NULL,
   UPDATE_TS                  TIMESTAMP NOT NULL,
   ITEM_CDE                   VARCHAR (10) NOT NULL,
   ITEM_DESC                  VARCHAR (256) NOT NULL,
   ITEM_START_DT              DATE NOT NULL,
   ITEM_CEASE_DT              DATE NOT NULL,
   ACCOM_TYP_CDE              VARCHAR (10) NOT NULL,
   ACCOM_TYP_DESC             VARCHAR (50) NOT NULL,
   AMB_TYP                    VARCHAR (10) NOT NULL,
   AMB_DESC                   VARCHAR (10) NOT NULL,
   BEN_SEGMENT_CDE            VARCHAR (10) NOT NULL,
   BEN_SEGMENT_DESC           VARCHAR (50) NOT NULL,
   CRAFT_GRP_CDE              VARCHAR (10) NOT NULL,
   CRAFT_GRP_DESC             VARCHAR (50) NOT NULL,
   CRAFT_SUB_GRP_CDE          VARCHAR (10) NOT NULL,
   CRAFT_SUB_GRP_DESC         VARCHAR (50) NOT NULL,
   DRG_BROAD_GRP_CDE          VARCHAR (10) NOT NULL,
   DRG_BROAD_GRP_DESC         VARCHAR (50) NOT NULL,
   DRG_ADJCNT_CDE             VARCHAR (10) NOT NULL,
   DRG_ADJCNT_DESC            VARCHAR (50) NOT NULL,
   DRG_PARTN_CDE              VARCHAR (10) NOT NULL,
   DRG_PARTN_SHORT_DESC       CHARACTER (1 OCTETS) NOT NULL,
   DRG_PARTN_LONG_DESC        VARCHAR (10) NOT NULL,
   DRG_REC_TYP_CDE            VARCHAR (10) NOT NULL,
   DRG_REC_TYP_DESC           VARCHAR (50) NOT NULL,
   ITEM_CAT_CDE               VARCHAR (10) NOT NULL,
   ITEM_CAT_DESC              VARCHAR (50) NOT NULL,
   ITEM_TYP_CDE               VARCHAR (10) NOT NULL,
   ITEM_TYP_DESC              VARCHAR (50) NOT NULL,
   SRVCE_TYP_CDE              VARCHAR (10) NOT NULL,
   SRVCE_TYP_DESC             VARCHAR (50) NOT NULL,
   DRG_ITEM_IND               VARCHAR (10) NOT NULL,
   ADJUSTMENT_ITEM_CDE_IND    CHARACTER (1 OCTETS) NOT NULL,
   ITEM_SUMMARY_GRP           VARCHAR (10) NOT NULL,
   ITEM_SUMMARY_GRP_DESC      VARCHAR (50) NOT NULL,
   MAJOR_SERVICE_GRP          VARCHAR (10) NOT NULL,
   MAJOR_SERVICE_GRP_DESC     VARCHAR (50) NOT NULL,
   MBS_IND                    CHARACTER (1 OCTETS) NOT NULL,
   HI_ASSESS_GRP_CDE          VARCHAR (20) NOT NULL,
   ASSESS_GRP_KEY_ITEM_FLG    CHARACTER (1 OCTETS) NOT NULL
)
IN TBS_BASEC_DD_16K
INDEX IN TBS_IDXC_DD_16K
COMPRESS YES ADAPTIVE
VALUE COMPRESSION
ORGANIZE BY ROW;

ALTER TABLE DD.DD_D_HI_ITEM
   DATA CAPTURE NONE
   PCTFREE 10
   LOCKSIZE ROW
   APPEND OFF
   NOT VOLATILE;

CREATE OR REPLACE ALIAS SASDIPROD.DD_D_HI_ITEM FOR DD.DD_D_HI_ITEM;

CREATE TABLE EDL.TRG_D_HI_ITEM
(
   D_HI_ITEM_SK               INTEGER NOT NULL,
   R_CODE_ACCOM_TYP_SK        INTEGER NOT NULL,
   R_CODE_AMB_TYP_SK          INTEGER NOT NULL,
   R_CODE_BEN_SEGMENT_SK      INTEGER NOT NULL,
   R_CODE_CRAFT_GRP_SK        INTEGER NOT NULL,
   R_CODE_CRAFT_SUB_GRP_SK    INTEGER NOT NULL,
   R_CODE_DRG_BROAD_GRP_SK    INTEGER NOT NULL,
   R_CODE_DRG_ADJCNT_SK       INTEGER NOT NULL,
   R_CODE_DRG_PARTN_SK        INTEGER NOT NULL,
   R_CODE_DRG_SPLIT_SK        INTEGER NOT NULL,
   R_CODE_DRG_REC_TYP_SK      INTEGER NOT NULL,
   R_CODE_ITEM_SUMM_GRP_SK    INTEGER NOT NULL,
   R_CODE_MAJ_SRVCE_GRP_SK    INTEGER NOT NULL,
   R_CODE_SRC_ITEM_CAT_SK     INTEGER NOT NULL,
   R_CODE_SRC_ITEM_TYP_SK     INTEGER NOT NULL,
   R_CODE_SRC_SRVCE_TYP_SK    INTEGER NOT NULL,
   R_SOURCE_SYSTEM_SK         INTEGER NOT NULL,
   ITEM_CDE                   VARCHAR (10) NOT NULL,
   ITEM_TYP                   VARCHAR (10) NOT NULL,
   ITEM_START_DT              DATE NOT NULL,
   ADJUSTMENT_ITEM_CDE_IND    CHARACTER (1 OCTETS) NOT NULL,
   DRG_ITEM_IND               VARCHAR (10) NOT NULL,
   ITEM_DESC                  VARCHAR (256) NOT NULL,
   ITEM_CEASE_DT              DATE NOT NULL,
   MBS_IND                    CHARACTER (1 OCTETS) NOT NULL,
   HI_ASSESS_GRP_CDE          VARCHAR (20) NOT NULL,
   ASSESS_GRP_KEY_ITEM_FLG    CHARACTER (1 OCTETS) NOT NULL,
   INSERT_TS                  TIMESTAMP NOT NULL,
   UPDATE_TS                  TIMESTAMP NOT NULL,
   DEL_FLG                    CHARACTER (1 OCTETS) NOT NULL
)
IN TBS_BASEC_EDL_16K
INDEX IN TBS_IDXC_EDL_16K
COMPRESS YES ADAPTIVE
VALUE COMPRESSION
ORGANIZE BY ROW;

ALTER TABLE EDL.TRG_D_HI_ITEM
   DATA CAPTURE NONE
   PCTFREE 10
   LOCKSIZE ROW
   APPEND OFF
   NOT VOLATILE;

CREATE OR REPLACE ALIAS SASDIPROD.TRG_D_HI_ITEM FOR EDL.TRG_D_HI_ITEM;

-- Step 4. Import of data for preserve

INSERT INTO EDL.TRG_D_HI_ITEM (D_HI_ITEM_SK,
                               R_CODE_ACCOM_TYP_SK,
                               R_CODE_AMB_TYP_SK,
                               R_CODE_BEN_SEGMENT_SK,
                               R_CODE_CRAFT_GRP_SK,
                               R_CODE_CRAFT_SUB_GRP_SK,
                               R_CODE_DRG_BROAD_GRP_SK,
                               R_CODE_DRG_ADJCNT_SK,
                               R_CODE_DRG_PARTN_SK,
                               R_CODE_DRG_SPLIT_SK,
                               R_CODE_DRG_REC_TYP_SK,
                               R_CODE_ITEM_SUMM_GRP_SK,
                               R_CODE_MAJ_SRVCE_GRP_SK,
                               R_CODE_SRC_ITEM_CAT_SK,
                               R_CODE_SRC_ITEM_TYP_SK,
                               R_CODE_SRC_SRVCE_TYP_SK,
                               R_SOURCE_SYSTEM_SK,
                               ITEM_CDE,
                               ITEM_TYP,
                               ITEM_START_DT,
                               ADJUSTMENT_ITEM_CDE_IND,
                               DRG_ITEM_IND,
                               ITEM_DESC,
                               ITEM_CEASE_DT,
                               MBS_IND,
                               INSERT_TS,
                               UPDATE_TS,
                               DEL_FLG)
   SELECT D_HI_ITEM_SK,
          R_CODE_ACCOM_TYP_SK,
          R_CODE_AMB_TYP_SK,
          R_CODE_BEN_SEGMENT_SK,
          R_CODE_CRAFT_GRP_SK,
          R_CODE_CRAFT_SUB_GRP_SK,
          R_CODE_DRG_BROAD_GRP_SK,
          R_CODE_DRG_ADJCNT_SK,
          R_CODE_DRG_PARTN_SK,
          R_CODE_DRG_SPLIT_SK,
          R_CODE_DRG_REC_TYP_SK,
          R_CODE_ITEM_SUMM_GRP_SK,
          R_CODE_MAJ_SRVCE_GRP_SK,
          R_CODE_SRC_ITEM_CAT_SK,
          R_CODE_SRC_ITEM_TYP_SK,
          R_CODE_SRC_SRVCE_TYP_SK,
          R_SOURCE_SYSTEM_SK,
          ITEM_CDE,
          ITEM_TYP,
          ITEM_START_DT,
          ADJUSTMENT_ITEM_CDE_IND,
          DRG_ITEM_IND,
          ITEM_DESC,
          ITEM_CEASE_DT,
          MBS_IND,
          INSERT_TS,
          UPDATE_TS,
          DEL_FLG
   FROM TMP_IWRRA.TMP_EDL_TRG_D_HI_ITEM_BAOFA;

DROP TABLE TMP_IWRRA.TMP_EDL_TRG_D_HI_ITEM_BAOFA;

INSERT INTO DD.DD_D_HI_ITEM (D_HI_ITEM_SK,
                             INSERT_TS,
                             UPDATE_TS,
                             ITEM_CDE,
                             ITEM_DESC,
                             ITEM_START_DT,
                             ITEM_CEASE_DT,
                             ACCOM_TYP_CDE,
                             ACCOM_TYP_DESC,
                             AMB_TYP,
                             AMB_DESC,
                             BEN_SEGMENT_CDE,
                             BEN_SEGMENT_DESC,
                             CRAFT_GRP_CDE,
                             CRAFT_GRP_DESC,
                             CRAFT_SUB_GRP_CDE,
                             CRAFT_SUB_GRP_DESC,
                             DRG_BROAD_GRP_CDE,
                             DRG_BROAD_GRP_DESC,
                             DRG_ADJCNT_CDE,
                             DRG_ADJCNT_DESC,
                             DRG_PARTN_CDE,
                             DRG_PARTN_SHORT_DESC,
                             DRG_PARTN_LONG_DESC,
                             DRG_REC_TYP_CDE,
                             DRG_REC_TYP_DESC,
                             ITEM_CAT_CDE,
                             ITEM_CAT_DESC,
                             ITEM_TYP_CDE,
                             ITEM_TYP_DESC,
                             SRVCE_TYP_CDE,
                             SRVCE_TYP_DESC,
                             DRG_ITEM_IND,
                             ADJUSTMENT_ITEM_CDE_IND,
                             ITEM_SUMMARY_GRP,
                             ITEM_SUMMARY_GRP_DESC,
                             MAJOR_SERVICE_GRP,
                             MAJOR_SERVICE_GRP_DESC,
                             MBS_IND)
   SELECT D_HI_ITEM_SK,
          INSERT_TS,
          UPDATE_TS,
          ITEM_CDE,
          ITEM_DESC,
          ITEM_START_DT,
          ITEM_CEASE_DT,
          ACCOM_TYP_CDE,
          ACCOM_TYP_DESC,
          AMB_TYP,
          AMB_DESC,
          BEN_SEGMENT_CDE,
          BEN_SEGMENT_DESC,
          CRAFT_GRP_CDE,
          CRAFT_GRP_DESC,
          CRAFT_SUB_GRP_CDE,
          CRAFT_SUB_GRP_DESC,
          DRG_BROAD_GRP_CDE,
          DRG_BROAD_GRP_DESC,
          DRG_ADJCNT_CDE,
          DRG_ADJCNT_DESC,
          DRG_PARTN_CDE,
          DRG_PARTN_SHORT_DESC,
          DRG_PARTN_LONG_DESC,
          DRG_REC_TYP_CDE,
          DRG_REC_TYP_DESC,
          ITEM_CAT_CDE,
          ITEM_CAT_DESC,
          ITEM_TYP_CDE,
          ITEM_TYP_DESC,
          SRVCE_TYP_CDE,
          SRVCE_TYP_DESC,
          DRG_ITEM_IND,
          ADJUSTMENT_ITEM_CDE_IND,
          ITEM_SUMMARY_GRP,
          ITEM_SUMMARY_GRP_DESC,
          MAJOR_SERVICE_GRP,
          MAJOR_SERVICE_GRP_DESC,
          MBS_IND
   FROM TMP_IWRRA.TMP_DD_DD_D_HI_ITEM_IVCMU;

DROP TABLE TMP_IWRRA.TMP_DD_DD_D_HI_ITEM_IVCMU;

DROP SCHEMA TMP_IWRRA RESTRICT;

-- Step 5. Restoring constraints and indexes

CREATE UNIQUE INDEX DD.XAK1DD_D_HI_ITEM
   ON DD.DD_D_HI_ITEM (ITEM_CDE ASC, ITEM_TYP_CDE ASC, ITEM_START_DT ASC)
   ALLOW REVERSE SCANS
      COMPRESS YES
      INCLUDE NULL KEYS;

CREATE UNIQUE INDEX EDL.XAK1TRG_D_HI_ITEM
   ON EDL.TRG_D_HI_ITEM (ITEM_CDE ASC, ITEM_TYP ASC, ITEM_START_DT ASC)
   ALLOW REVERSE SCANS
      COMPRESS YES
      INCLUDE NULL KEYS;

--This is system required index

CREATE UNIQUE INDEX DD.XPKDD_D_HI_ITEM
   ON DD.DD_D_HI_ITEM (D_HI_ITEM_SK ASC)
   ALLOW REVERSE SCANS
      COMPRESS YES
      INCLUDE NULL KEYS;

ALTER TABLE DD.DD_D_HI_ITEM
   ADD PRIMARY KEY (D_HI_ITEM_SK) ENFORCED;

ALTER TABLE DD.DD_D_HI_ITEM
   ADD CONSTRAINT XPKDD_D_HI_ITEM PRIMARY KEY (D_HI_ITEM_SK) ENFORCED;

ALTER TABLE EDL.TRG_D_HI_ITEM
   ADD PRIMARY KEY (D_HI_ITEM_SK) ENFORCED;

ALTER TABLE EDL.TRG_D_HI_ITEM
   ADD CONSTRAINT XPKTRG_D_HI_ITEM PRIMARY KEY (D_HI_ITEM_SK) ENFORCED;

COMMIT;

-- Step 6. Runstats
RUNSTATS ON TABLE DD.DD_D_HI_ITEM
	ALLOW WRITE ACCESS;

RUNSTATS ON TABLE EDL.TRG_D_HI_ITEM
	ALLOW WRITE ACCESS;

SET  CURRENT SCHEMA = P1K;