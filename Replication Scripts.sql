/*
  Replication Scripts
*/

--To find the qualifier with the lowest subs:
SELECT COUNT(*), APPLY_QUAL
FROM   ASN.IBMSNAP_SUBS_MEMBR
GROUP BY APPLY_QUAL
ORDER BY 1, 2
;

--Bounce Capture to pick up change
INSERT INTO ASN.IBMSNAP_SIGNAL
   (SIGNAL_TYPE, SIGNAL_SUBTYPE, SIGNAL_STATE)
   VALUES( 'CMD'  , 'STOP'  , 'P' )
;

--Pre-Refresh
--On the Apply server � Deactivate the subs_set (optional):
UPDATE ASN.IBMSNAP_SUBS_SET
   SET ACTIVATE   = 0
 WHERE APPLY_QUAL = 'PRODAQUALxx'
   AND SET_NAME   = 'PRODASUB7xxx'
;

--On the Capture server � Set synchtime and send signal to start capturing:
UPDATE ASN.IBMSNAP_PRUNCNTL
   SET SYNCHPOINT = X'00000000000000000000',
       SYNCHTIME  = CURRENT TIMESTAMP
 WHERE APPLY_QUAL = 'PRODAQUALxx'
   AND SET_NAME   = 'PRODASUB7xxx'
;

INSERT INTO ASN.IBMSNAP_SIGNAL
   (SIGNAL_TIME, SIGNAL_TYPE, SIGNAL_SUBTYPE, SIGNAL_INPUT_IN, SIGNAL_STATE)
  VALUES
    (CURRENT TIMESTAMP, 'CMD', 'CAPSTART', '<map_id>', 'P')
;

--Post-Refresh
--On the Apply server: Set Member_State to L (loaded), and update subs_set timestamps:
UPDATE ASN.IBMSNAP_SUBS_MEMBR
   SET MEMBER_STATE = 'L'
 WHERE APPLY_QUAL   = 'PRODAQUALxx'
   AND SET_NAME     = 'PRODASUBxxx'
;

UPDATE ASN.IBMSNAP_SUBS_SET
   SET ACTIVATE    = 1,
       LASTRUN     = CURRENT TIMESTAMP,
       LASTSUCCESS = CURRENT TIMESTAMP,
       SYNCHTIME   = CURRENT TIMESTAMP,
       SYNCHPOINT  = NULL
 WHERE APPLY_QUAL  = 'PRODAQUALxx'
   AND SET_NAME    = 'PRODASUBxxx'
;

--Testing Apply
UPDATE ASN.IBMSNAP_SUBS_EVENT
   SET EVENT_TIME    = CURRENT TIMESTAMP
      ,END_OF_PERIOD = CURRENT TIMESTAMP
 WHERE EVENT_NAME    = 'PRODAQUAL18'
;
