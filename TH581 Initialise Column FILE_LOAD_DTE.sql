SELECT AGREEMENT_NO,
       AGREEMENT_VERS_NO,
       STATUS_DTE,
       FILE_LOAD_DTE
  FROM RLSEC.TH581_MAGM_AGMT
  WITH UR;

LOCK TABLE RLSEC.TH581_MAGM_AGMT IN EXCLUSIVE MODE;

UPDATE RLSEC.TH581_MAGM_AGMT T1
   SET T1.FILE_LOAD_DTE =
       (SELECT T2.STATUS_DTE
          FROM RLSEC.TH581_MAGM_AGMT T2
         WHERE T1.AGREEMENT_NO      = T2.AGREEMENT_NO
           AND T1.AGREEMENT_VERS_NO = T2.AGREEMENT_VERS_NO);

COMMIT;

SELECT AGREEMENT_NO,
       AGREEMENT_VERS_NO,
       STATUS_DTE,
       FILE_LOAD_DTE
  FROM RLSEC.TH581_MAGM_AGMT
  WITH UR;