
----SCRIPT QUE TE PERMITE CONOCER LAS TABLAS QUE NO TIENEN INDICE------
select schemaname,relname,seq_scan,seq_tup_read,idx_scan,seq_tup_read / seq_scan from pg_stat_user_tables 
where seq_scan > 0 order by seq_tup_read desc;

---- filas muertas de las tablas de tu base de datos---
SELECT schemaname, relname, n_live_tup, n_dead_tup, last_autovacuum
FROM pg_stat_all_tables
ORDER BY n_dead_tup / (n_live_tup
       * current_setting('autovacuum_vacuum_scale_factor')::float8
          + current_setting('autovacuum_vacuum_threshold')::float8)
     DESC
LIMIT 20;

----COMANDO QUE PERMITE REORGANICE/REBUILD DEL INDICE-----
VACUUM ANALYZE indice;

VACUUM FULL