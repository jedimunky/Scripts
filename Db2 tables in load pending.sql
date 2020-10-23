SELECT TABSCHEMA, TABNAME, LOAD_STATUS
FROM SYSIBMADM.ADMINTABINFO
WHERE LOAD_STATUS = 'PENDING';

-- db2 load from /dev/null of del terminate into dd.dd_mf_sum_myhbf_portal nonrecoverable