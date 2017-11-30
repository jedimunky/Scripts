SELECT varchar (tbsp_name, 30) AS tbsp_name,
       member,
       tbsp_type,
       TBSP_STATE
  FROM TABLE (MON_GET_TABLESPACE ('', -2)) AS t
 WHERE TBSP_STATE <> 'NORMAL'
ORDER BY tbsp_name