SELECT db_size AS db_bytes,
       db_size / 1024 AS db_kb,
       db_size / 1024 / 1024 AS db_mb,
       db_size / 1024 / 1024 / 1024 AS db_gb,
       db_capacity AS cap_bytes,
       db_capacity / 1024 AS cap_kb,
       db_capacity / 1024 / 1024 AS cap_mb,
       db_capacity / 1024 / 1024 / 1024 AS cap_gb
  FROM systools.stmg_dbsize_info