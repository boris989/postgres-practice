SELECT pid, state, query
FROM pg_stat_activity
WHERE wait_event_type = 'Lock';

SELECT
    a.pid,
    a.state,
    l.locktype,
    l.mode,
    l.granted,
    a.query
FROM pg_locks l
         JOIN pg_stat_activity a
              ON a.pid = l.pid
WHERE a.datname = current_database();
