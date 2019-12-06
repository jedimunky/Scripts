--
-- Resync policies (change timestamp as needed)
--
UPDATE PRODA.TP1HIPOL
SET    ADB_L_DELIVERY = 'N'  -- not processed
WHERE  ADB_L_DELIVERY = 'C'  -- complete
AND    ADB_TIMESTAMP BETWEEN '2017-03-04-22.00.00.000000'
                         AND '2017-03-05-04.00.00.000000'
;
--
-- Resync single policy
--
INSERT INTO TESTA.TP1HIPOL(
			HPOLICY,
			ADB_SUBJECT,
			ADB_TIMESTAMP,
			ADB_OPCODE,
			ADB_REF_OBJECT,
			ADB_L_DELIVERY,
			SOURCE_TABLE)
SELECT  	<POLICY NUMBER>,
			'',
			CURRENT TIMESTAMP,
			1,
			'',
			'N',
			'TW301_HLTHBASIC'
