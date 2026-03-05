CREATE TABLE mvcc_lab (
                          id int PRIMARY KEY,
                          value text
);

INSERT INTO mvcc_lab VALUES (1, 'A');

SELECT xmin, xmax, ctid, *
FROM mvcc_lab;

UPDATE mvcc_lab
SET value = 'B'
WHERE id = 1;

SELECT n_tup_upd,
       n_dead_tup
FROM pg_stat_user_tables
WHERE relname = 'mvcc_lab';

VACUUM mvcc_lab;

SELECT n_tup_upd,
       n_dead_tup
FROM pg_stat_user_tables
WHERE relname = 'mvcc_lab';

BEGIN ISOLATION LEVEL REPEATABLE READ;

SELECT * FROM mvcc_lab WHERE id = 1;

SELECT *
FROM mvcc_lab
WHERE id = 1;

commit;

CREATE TABLE hot_lab (
                         id serial PRIMARY KEY,
                         counter int,
                         payload text
);

INSERT INTO hot_lab(counter, payload)
VALUES (0, repeat('x', 100));

SELECT pg_stat_reset();

UPDATE hot_lab
SET counter = counter + 1
WHERE id = 1;

SELECT n_tup_upd,
       n_tup_hot_upd
FROM pg_stat_user_tables
WHERE relname = 'hot_lab';

CREATE INDEX hot_lab_counter_idx
    ON hot_lab(counter);

UPDATE hot_lab
SET counter = counter + 1
WHERE id = 1;

SELECT n_tup_upd,
       n_tup_hot_upd
FROM pg_stat_user_tables
WHERE relname = 'hot_lab';

SELECT n_dead_tup
FROM pg_stat_user_tables
WHERE relname = 'hot_lab';

VACUUM hot_lab;

CREATE EXTENSION pageinspect;

SELECT *
FROM heap_page_items(get_raw_page('hot_lab', 0));
