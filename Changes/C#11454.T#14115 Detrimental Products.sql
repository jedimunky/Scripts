SELECT *
FROM TH510_REBATE_ENTL
WHERE    (HPOLICY = 'P24269207' AND DATE_FROM = '04.01.2007')
      OR (    HPOLICY = 'P29898408'
          AND (DATE_FROM = '04.11.2009' OR DATE_FROM = '04.11.2014'))
      OR (    HPOLICY = 'P43533106'
          AND (DATE_FROM = '07.11.2012' OR DATE_FROM = '07.11.2017'))
      OR (HPOLICY = 'P43563807' AND DATE_FROM = '09.07.2009')
      OR (    HPOLICY = 'P76029002'
          AND (DATE_FROM = '25.02.2012' OR DATE_FROM = '25.02.2017'));

DELETE FROM TH510_REBATE_ENTL
WHERE    (HPOLICY = 'P24269207' AND DATE_FROM = '04.01.2007')
      OR (    HPOLICY = 'P29898408'
          AND (DATE_FROM = '04.11.2009' OR DATE_FROM = '04.11.2014'))
      OR (    HPOLICY = 'P43533106'
          AND (DATE_FROM = '07.11.2012' OR DATE_FROM = '07.11.2017'))
      OR (HPOLICY = 'P43563807' AND DATE_FROM = '09.07.2009')
      OR (    HPOLICY = 'P76029002'
          AND (DATE_FROM = '25.02.2012' OR DATE_FROM = '25.02.2017'));

SELECT *
FROM TH510_REBATE_ENTL
WHERE    (HPOLICY = 'P24269207' AND DATE_FROM = '04.01.2007')
      OR (    HPOLICY = 'P29898408'
          AND (DATE_FROM = '04.11.2009' OR DATE_FROM = '04.11.2014'))
      OR (    HPOLICY = 'P43533106'
          AND (DATE_FROM = '07.11.2012' OR DATE_FROM = '07.11.2017'))
      OR (HPOLICY = 'P43563807' AND DATE_FROM = '09.07.2009')
      OR (    HPOLICY = 'P76029002'
          AND (DATE_FROM = '25.02.2012' OR DATE_FROM = '25.02.2017'));