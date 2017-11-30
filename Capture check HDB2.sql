SELECT (END_OF_PERIOD - 7 MINUTES)                     -- INTO V_PROCESS_POINT
FROM ASN.IBMSNAP_SUBS_EVENT
WHERE EVENT_NAME = 'PRODAQUAL60';

SELECT SYNCHTIME                                           -- INTO V_SYNCHTIME
FROM ASN.IBMSNAP_REGISTER A
WHERE GLOBAL_RECORD = 'Y';

/*
IF V_SYNCHTIME > V_PROCESS_POINT THEN
  SET P_RETURN_CODE = 'HAPPY';       
ELSE                                 
  SET P_RETURN_CODE = 'RETRY';       
END IF;                              
*/