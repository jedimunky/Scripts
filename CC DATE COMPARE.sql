SELECT A.CLIENT,
       A.SEQUENCE,
       A.CC_EXPIRY_MONTH || '/' || A.CC_EXPIRY_YEAR AS EXP_DATE
FROM TESTC.TW209_DIRECTDB A
WHERE (
         SELECT   date ('0001-01-01')
                + CAST (B.CC_EXPIRY_YEAR AS DECIMAL) YEARS
                + CAST (B.CC_EXPIRY_MONTH AS DECIMAL) MONTHS
         FROM SYSIBM.SYSDUMMY1, TESTC.TW209_DIRECTDB B
         WHERE     B.CC_EXPIRY_MONTH <> ''
               AND B.CC_EXPIRY_YEAR <> ''
               AND A.CLIENT = B.CLIENT
               AND A.SEQUENCE = B.SEQUENCE) >=
      (
         SELECT   date ('0001-01-01')
                + year (CURRENT DATE) YEARS
                - 1 YEAR
                + month (CURRENT DATE) MONTHS
                - 2 MONTH
         FROM SYSIBM.SYSDUMMY1)
ORDER BY 1, 2
FETCH FIRST 200 ROWS ONLY;