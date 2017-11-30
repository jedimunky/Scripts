--
-- Resync policies (change timestamp as needed)
--
UPDATE PRODA.TP1HIPOL
SET    ADB_L_DELIVERY = 'N'  -- not processed
WHERE  ADB_L_DELIVERY = 'C'  -- complete
AND    ADB_TIMESTAMP BETWEEN '2017-03-04-22.00.00.000000'
                         AND '2017-03-05-04.00.00.000000'
;
