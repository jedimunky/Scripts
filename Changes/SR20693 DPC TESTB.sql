--DBA SQL REQUIREMENTS FOR DPC (EFF 01.07.2018 IN PROD)

--UPDATES FOR SIT3/TESTB TO BE EFFECTIVE 22.02.2018 THEREFORE CLOSE DATES TO BE 21.02.2018
--UPDATES FOR INTG/RCICS 1 TO HAVE EFFECTIVE DATE CONFIRMED

--REMOVING DIALYSIS, BARIATRIC, INSULIN PUMPS, STERILITY REVERSALS & COCHLEAR IMPLANTS FROM:
--YOUNG SAVER HOSPITAL (F*)
--YOUNG SINGLES SAVER TWIN PACK (K00)

UPDATE TESTB.TW108_EXTEND_WAIT EW
SET DTE_OFF = '2018-02-21',
    LST_UPD_USERID = 'FIX',
    LST_UPD_TERMINAL = 'BTCH',
    LST_UPD_TIMESTAMP = CURRENT TIMESTAMP
WHERE EXISTS
         (SELECT 1
          FROM TESTB.TW108_EXTEND_WAIT A, TESTB.TW331_ITEMDEFN B
          WHERE     A.ITEM_TYPE = EW.ITEM_TYPE
                AND A.ITEM_CODE = EW.ITEM_CODE
                AND A.COVER = EW.COVER
                AND A.DTE_ON = EW.DTE_ON
                AND A.ITEM_TYPE = B.ITEM_TYPE
                AND A.ITEM_CODE = B.ITEM_CODE
                AND A.DTE_OFF = '31.12.9999'
                AND B.DTE_OFF = '31.12.9999'
                AND A.COVER IN ('F00',
                                'FJ0',
                                'FK0',
                                'K00')
                AND B.ASSESS_GROUP IN ('100',
                                       '314',
                                       '101',
                                       '321',
                                       '104',
                                       '102',
                                       '103'));

--COUNT (*) = 612 INFOA



--REMOVING DIALYSIS, BARIATRIC, INSULIN PUMPS & COCHLEAR IMPLANTS FROM:
--SMART SAVER TWIN PACK (MB0)
--HEALTH SAVER TWIN PACK (L00)
--HEALTHY SAVER HOSPITAL (G00)

UPDATE TESTB.TW108_EXTEND_WAIT EW
SET DTE_OFF = '2018-02-21',
    LST_UPD_USERID = 'FIX',
    LST_UPD_TERMINAL = 'BTCH',
    LST_UPD_TIMESTAMP = CURRENT TIMESTAMP
WHERE EXISTS
         (SELECT 1
          FROM TESTB.TW108_EXTEND_WAIT A, TESTB.TW331_ITEMDEFN B
          WHERE     A.ITEM_TYPE = EW.ITEM_TYPE
                AND A.ITEM_CODE = EW.ITEM_CODE
                AND A.COVER = EW.COVER
                AND A.DTE_ON = EW.DTE_ON
                AND A.ITEM_TYPE = B.ITEM_TYPE
                AND A.ITEM_CODE = B.ITEM_CODE
                AND A.DTE_OFF = '31.12.9999'
                AND B.DTE_OFF = '31.12.9999'
                AND A.COVER IN ('MB0', 'L00', 'G00')
                AND B.ASSESS_GROUP IN ('100',
                                       '314',
                                       '101',
                                       '321',
                                       '104',
                                       '103'));

--COUNT (*) = 444 INFOA


--REMOVING INSULIN PUMPS, COCHLEAR IMPLANTS & STERILITY REVERSAL FROM:
--GMF LITE (HM0, HN0, HO0)

UPDATE TESTB.TW108_EXTEND_WAIT EW
SET DTE_OFF = '2018-02-21',
    LST_UPD_USERID = 'FIX',
    LST_UPD_TERMINAL = 'BTCH',
    LST_UPD_TIMESTAMP = CURRENT TIMESTAMP
WHERE EXISTS
         (SELECT 1
          FROM TESTB.TW108_EXTEND_WAIT A, TESTB.TW331_ITEMDEFN B
          WHERE     A.ITEM_TYPE = EW.ITEM_TYPE
                AND A.ITEM_CODE = EW.ITEM_CODE
                AND A.COVER = EW.COVER
                AND A.DTE_ON = EW.DTE_ON
                AND A.ITEM_TYPE = B.ITEM_TYPE
                AND A.ITEM_CODE = B.ITEM_CODE
                AND A.DTE_OFF = '31.12.9999'
                AND B.DTE_OFF = '31.12.9999'
                AND A.COVER IN ('HM0', 'HN0', 'HO0')
                AND B.ASSESS_GROUP IN ('104', '103', '102'));

--COUNT (*) =  96 INFOA



--REMOVING DIALYSIS & BARIATRIC FROM:
--MID HOSPITAL (A*)

UPDATE TESTB.TW108_EXTEND_WAIT EW
SET DTE_OFF = '2018-02-21',
    LST_UPD_USERID = 'FIX',
    LST_UPD_TERMINAL = 'BTCH',
    LST_UPD_TIMESTAMP = CURRENT TIMESTAMP
WHERE EXISTS
         (SELECT 1
          FROM TESTB.TW108_EXTEND_WAIT A, TESTB.TW331_ITEMDEFN B
          WHERE     A.ITEM_TYPE = EW.ITEM_TYPE
                AND A.ITEM_CODE = EW.ITEM_CODE
                AND A.COVER = EW.COVER
                AND A.DTE_ON = EW.DTE_ON
                AND A.ITEM_TYPE = B.ITEM_TYPE
                AND A.ITEM_CODE = B.ITEM_CODE
                AND A.DTE_OFF = '31.12.9999'
                AND B.DTE_OFF = '31.12.9999'
                AND A.COVER IN ('A00', 'AJ0', 'AK0')
                AND B.ASSESS_GROUP IN ('100',
                                       '314',
                                       '101',
                                       '321'));

--COUNT (*) = 360



--REMOVING DIALYSIS FROM:
--MID HOSPITAL COVER (4K0, 5K0, 6K0)

UPDATE TESTB.TW108_EXTEND_WAIT EW
SET DTE_OFF = '2018-02-21',
    LST_UPD_USERID = 'FIX',
    LST_UPD_TERMINAL = 'BTCH',
    LST_UPD_TIMESTAMP = CURRENT TIMESTAMP
WHERE EXISTS
         (SELECT 1
          FROM TESTB.TW108_EXTEND_WAIT A, TESTB.TW331_ITEMDEFN B
          WHERE     A.ITEM_TYPE = EW.ITEM_TYPE
                AND A.ITEM_CODE = EW.ITEM_CODE
                AND A.COVER = EW.COVER
                AND A.DTE_ON = EW.DTE_ON
                AND A.ITEM_TYPE = B.ITEM_TYPE
                AND A.ITEM_CODE = B.ITEM_CODE
                AND A.DTE_OFF = '31.12.9999'
                AND B.DTE_OFF = '31.12.9999'
                AND A.COVER IN ('4K0', '5K0', '6K0')
                AND B.ASSESS_GROUP IN ('100', '314'));

--COUNT (*) = 42 INFOA

--REDUCING SERVICES – WW14

--REDUCING COVERAGE OF PSYCHOLOGY FROM FULL BENEFIT TO RESTRICTED MINIMUM DEFAULT BENEFIT FROM:
--MID HOSPITAL (A*)
--MID HOSPITAL COVER (4K, 5K, 6K)
--GMF MID HOSPITAL (HG0, HH0, HI0)
--GMF MID NO MATERNITY (HJ0, HK0, HL0)

UPDATE TESTB.TW108_EXTEND_WAIT EW
SET DTE_OFF = '2018-02-21',
    LST_UPD_USERID = 'FIX',
    LST_UPD_TERMINAL = 'BTCH',
    LST_UPD_TIMESTAMP = CURRENT TIMESTAMP
WHERE EXISTS
         (SELECT 1
          FROM TESTB.TW108_EXTEND_WAIT A, TESTB.TW331_ITEMDEFN B
          WHERE     A.ITEM_TYPE = EW.ITEM_TYPE
                AND A.ITEM_CODE = EW.ITEM_CODE
                AND A.COVER = EW.COVER
                AND A.DTE_ON = EW.DTE_ON
                AND A.ITEM_TYPE = B.ITEM_TYPE
                AND A.ITEM_CODE = B.ITEM_CODE
                AND A.DTE_OFF = '31.12.9999'
                AND B.DTE_OFF = '31.12.9999'
                AND A.COVER IN ('A00',
                                'AJ0',
                                'AK0',
                                '4K0',
                                '5K0',
                                '6K0',
                                'HG0',
                                'HH0',
                                'HI0',
                                'HJ0',
                                'HK0',
                                'HL0')
                AND B.ASSESS_GROUP IN ('066',
                                       '310',
                                       '061',
                                       '073'));

--COUNT (*) = 5952 INFOA


--THEN REINSERT THE ABOVE RECORDS AND SET
--DTE ON = 'PER SECTION 2'
--RESTICT IND = Y

INSERT INTO TESTB.TW108_EXTEND_WAIT
   (SELECT A.ITEM_TYPE,
           A.ITEM_CODE,
           A.COVER,
           '2018-02-22',
           '9999-12-31',
           '',
           A.SUPP_WAIT,
           A.WAIT_PERIOD,
           A.PRE_EXIST_PERIOD,
           'FIX',
           'BTCH',
           CURRENT TIMESTAMP,
           A.SERVICE_CODE,
           A.ASSESS_GROUP,
           'Y'
    FROM TESTB.TW108_EXTEND_WAIT A, TESTB.TW331_ITEMDEFN B
    WHERE     A.ITEM_TYPE = B.ITEM_TYPE
          AND A.ITEM_CODE = B.ITEM_CODE
          AND A.DTE_OFF = '31.12.9999'
          AND B.DTE_OFF = '31.12.9999'
          AND A.COVER IN ('A00',
                          'AJ0',
                          'AK0',
                          '4K0',
                          '5K0',
                          '6K0',
                          'HG0',
                          'HH0',
                          'HI0',
                          'HJ0',
                          'HK0',
                          'HL0')
          AND B.ASSESS_GROUP IN ('066',
                                 '310',
                                 '061',
                                 '073'));