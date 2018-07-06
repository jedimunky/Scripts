UPDATE RLSEC.TW108_EXTEND_WAIT EW
SET DTE_OFF = '23.03.2018',
    LST_UPD_USERID = 'FIX',
    LST_UPD_TERMINAL = 'BTCH',
    LST_UPD_TIMESTAMP = CURRENT TIMESTAMP
WHERE EXISTS
         (SELECT 1
          FROM RLSEC.TW108_EXTEND_WAIT A, RLSEC.TW331_ITEMDEFN B
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
                AND ( (   B.ASSESS_GROUP IN ('100',
                                             '314',
                                             '101',
                                             '321',
                                             '104',
                                             '102',
                                             '103')
                       OR (    B.ITEM_TYPE = 'M'
                           AND B.ITEM_CODE IN ('41617',
                                               '41618',
                                               '35694',
                                               '35697',
                                               '35700',
                                               '35703',
                                               '35706',
                                               '37616',
                                               '37619')))));

UPDATE RLSEC.TW108_EXTEND_WAIT EW
SET DTE_OFF = '23.03.2018',
    LST_UPD_USERID = 'FIX',
    LST_UPD_TERMINAL = 'BTCH',
    LST_UPD_TIMESTAMP = CURRENT TIMESTAMP
WHERE EXISTS
         (SELECT 1
          FROM RLSEC.TW108_EXTEND_WAIT A, RLSEC.TW331_ITEMDEFN B
          WHERE     A.ITEM_TYPE = EW.ITEM_TYPE
                AND A.ITEM_CODE = EW.ITEM_CODE
                AND A.COVER = EW.COVER
                AND A.DTE_ON = EW.DTE_ON
                AND A.ITEM_TYPE = B.ITEM_TYPE
                AND A.ITEM_CODE = B.ITEM_CODE
                AND A.DTE_OFF = '31.12.9999'
                AND B.DTE_OFF = '31.12.9999'
                AND A.COVER IN ('MB0', 'L00', 'G00')
                AND ( (   B.ASSESS_GROUP IN ('100',
                                             '314',
                                             '101',
                                             '321',
                                             '104',
                                             '103')
                       OR (    B.ITEM_TYPE = 'M'
                           AND B.ITEM_CODE IN ('41617', '41618')))));

UPDATE RLSEC.TW108_EXTEND_WAIT EW
SET DTE_OFF = '23.03.2018',
    LST_UPD_USERID = 'FIX',
    LST_UPD_TERMINAL = 'BTCH',
    LST_UPD_TIMESTAMP = CURRENT TIMESTAMP
WHERE EXISTS
         (SELECT 1
          FROM RLSEC.TW108_EXTEND_WAIT A, RLSEC.TW331_ITEMDEFN B
          WHERE     A.ITEM_TYPE = EW.ITEM_TYPE
                AND A.ITEM_CODE = EW.ITEM_CODE
                AND A.COVER = EW.COVER
                AND A.DTE_ON = EW.DTE_ON
                AND A.ITEM_TYPE = B.ITEM_TYPE
                AND A.ITEM_CODE = B.ITEM_CODE
                AND A.DTE_OFF = '31.12.9999'
                AND B.DTE_OFF = '31.12.9999'
                AND A.COVER IN ('HM0', 'HN0', 'HO0')
                AND ( (   B.ASSESS_GROUP IN ('104', '102', '103')
                       OR (    B.ITEM_TYPE = 'M'
                           AND B.ITEM_CODE IN ('41617',
                                               '41618',
                                               '35694',
                                               '35697',
                                               '35700',
                                               '35703',
                                               '35706',
                                               '37616',
                                               '37619')))));

UPDATE RLSEC.TW108_EXTEND_WAIT EW
SET DTE_OFF = '23.03.2018',
    LST_UPD_USERID = 'FIX',
    LST_UPD_TERMINAL = 'BTCH',
    LST_UPD_TIMESTAMP = CURRENT TIMESTAMP
WHERE EXISTS
         (SELECT 1
          FROM RLSEC.TW108_EXTEND_WAIT A, RLSEC.TW331_ITEMDEFN B
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

UPDATE RLSEC.TW108_EXTEND_WAIT EW
SET DTE_OFF = '23.03.2018',
    LST_UPD_USERID = 'FIX',
    LST_UPD_TERMINAL = 'BTCH',
    LST_UPD_TIMESTAMP = CURRENT TIMESTAMP
WHERE EXISTS
         (SELECT 1
          FROM RLSEC.TW108_EXTEND_WAIT A, RLSEC.TW331_ITEMDEFN B
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

UPDATE RLSEC.TW108_EXTEND_WAIT EW
SET DTE_OFF = '23.03.2018',
    LST_UPD_USERID = 'FIX',
    LST_UPD_TERMINAL = 'BTCH',
    LST_UPD_TIMESTAMP = CURRENT TIMESTAMP
WHERE EXISTS
         (SELECT 1
          FROM RLSEC.TW108_EXTEND_WAIT A, RLSEC.TW331_ITEMDEFN B
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
                AND B.ASSESS_GROUP IN ('066', '310'));

INSERT INTO RLSEC.TW108_EXTEND_WAIT
   (SELECT A.ITEM_TYPE,
           A.ITEM_CODE,
           A.COVER,
           '24.03.2018',
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
    FROM RLSEC.TW108_EXTEND_WAIT A, RLSEC.TW331_ITEMDEFN B
    WHERE     A.ITEM_TYPE = B.ITEM_TYPE
          AND A.ITEM_CODE = B.ITEM_CODE
          AND A.DTE_OFF = '23.03.2018'
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
          AND B.ASSESS_GROUP IN ('066', '310'));