SELECT --   section_type,
       --   stmt_type_id,
       --   substr(package_schema,1,8) as pkgschema,
       --   substr(package_name,1,12) as pkgname,
       --   smallint(section_number) as section,
       --   substr(package_Version_id,1,16) as pkg_v,
            num_exec_with_metrics,
            stmt_exec_time,
            total_act_time,
            decimal((total_act_time / float(num_exec_with_metrics)), 10, 2) AS avg_act_time,
            decimal((float(total_act_time) / float(total_total_act_time)) * 100, 5, 2) AS pct_total_act_time,
            decimal((float(total_act_wait_time) / float(total_act_time)) * 100, 5, 2) AS pct_wait_time,
            decimal((float(total_section_sort_time) / float(total_act_time)) * 100, 5, 2) AS pct_sort_time,
            coord_stmt_exec_time,
            decimal((coord_stmt_exec_time / float(num_exec_with_metrics)), 10, 2) AS avg_coordexec_time,
            decimal((total_act_wait_time / float(stmt_exec_time)) * 100, 5, 2) AS pct_act_wait,
            decimal((lock_wait_time / float(stmt_exec_time)) * 100, 5, 2) AS pct_lock,
            decimal((log_disk_wait_time / float(stmt_exec_time)) * 100, 5, 2) AS pct_log_disk,
            decimal((pool_read_time / float(stmt_exec_time)) * 100, 5, 2) AS pct_pool_rd,
            decimal((pool_write_time / float(stmt_exec_time)) * 100, 5, 2) AS pct_pool_wd,
            decimal((fcm_recv_wait_time / float(stmt_exec_time)) * 100, 5, 2) AS pct_fcm_rcv,
            decimal((fcm_send_wait_time / float(stmt_exec_time)) * 100, 5, 2) AS pct_fcm_snd,
       --   decimal((total_extended_latch_wait_time/float(stmt_exec_time))*100,5,2) as pct_latch,
       --   decimal((prefetch_wait_time/float(stmt_exec_time))*100,5,2) as pct_prefetch,

            rows_modified,
            rows_read,
            rows_returned,
            lock_waits,
       --   total_extended_latch_waits,
            total_sorts,
            post_threshold_sorts,
            sort_overflows,
       --   total_hash_joins, post_threshold_hash_joins,  hash_join_overflows,
       --   total_hash_grpbys,  post_threshold_hash_grpbys,  hash_grpby_overflows,
            effective_isolation,
       --   TOTAL_DISP_RUN_QUEUE_TIME, TOTAL_COL_TIME, TOTAL_COL_EXECUTIONS,
            substr(stmt_text, 1, 8000) AS stmt
FROM        TABLE(mon_get_pkg_cache_stmt(NULL, NULL, '', -2)), (SELECT sum(total_act_time) AS total_total_act_time FROM TABLE(mon_get_pkg_cache_stmt(NULL, NULL, '', -2)))
WHERE       total_act_time <> 0 AND stmt_type_id LIKE 'DML, %'
      --and stmt_text like 'SELECT UNICD_DATATYPS%S_APP_VER%'
ORDER BY    avg_act_time DESC
--            avg_coordexec_time desc
--            pct_total_act_time desc
--            num_exec_with_metrics desc
FETCH FIRST 10 ROWS ONLY;
