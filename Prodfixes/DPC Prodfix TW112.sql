INSERT INTO RLSEA.TW112_HEALTHRULE
   (SELECT 'FIX',
           'BTCH',
           CURRENT TIMESTAMP,
           HR1.OVERALL_FED,
           COVER_1,
           BENEFIT_LEVEL_1,
           FED_1,
           COVER_2,
           BENEFIT_LEVEL_2,
           FED_2,
           COVER_3,
           BENEFIT_LEVEL_3,
           FED_3,
           COVER_4,
           BENEFIT_LEVEL_4,
           FED_4,
           COVER_5,
           BENEFIT_LEVEL_5,
           FED_5,
           COVER_6,
           BENEFIT_LEVEL_6,
           FED_6,
           HR1.PRODUCT,
           '2018-03-14',
           HR1.PHIAC_INC_IND,
           HR1.BENEFIT_RESTRICT_1,
           HR1.BENEFIT_RESTRICT_2,
           HR1.BENEFIT_RESTRICT_3,
           HR1.BENEFIT_RESTRICT_4,
           HR1.BENEFIT_RESTRICT_5,
           HR1.BENEFIT_RESTRICT_6,
           HR1.RANK_1,
           HR1.RANK_2,
           HR1.RANK_3,
           HR1.RANK_4,
           HR1.RANK_5,
           HR1.RANK_5,
           HR1.FED_LOYALTY_IND_1,
           HR1.FED_LOYALTY_IND_2,
           HR1.FED_LOYALTY_IND_3,
           HR1.FED_LOYALTY_IND_4,
           HR1.FED_LOYALTY_IND_5,
           HR1.FED_LOYALTY_IND_6,
           HR1.WAIVE_EXCESS_1,
           HR1.WAIVE_EXCESS_2,
           HR1.WAIVE_EXCESS_3,
           HR1.WAIVE_EXCESS_4,
           HR1.WAIVE_EXCESS_5,
           HR1.WAIVE_EXCESS_6
    FROM RLSEA.TW112_HEALTHRULE HR1, RLSEA.TW101_PRODDEFN PD
    WHERE     PD.PRODUCT = HR1.PRODUCT
          AND PD.DTE_OFF = '9999-12-31'
          AND PD.CLOSE_OFF_DTE = '9999-12-31'
          AND PD.PRODUCT_TYPE = 'H'
          AND PD.PRODUCT NOT IN ('GS1',
                                 'GS2',
                                 'GS3',
                                 'GS4',
                                 '018',
                                 '01T',
                                 '02T',
                                 '03T')
          AND HR1.DTE_ON = (SELECT MAX (DTE_ON)
                            FROM RLSEA.TW112_HEALTHRULE
                            WHERE PRODUCT = HR1.PRODUCT));