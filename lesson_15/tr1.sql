BEGIN;

SELECT *
FROM lock_matrix_test
WHERE id = 1
    FOR UPDATE;


BEGIN;

SELECT *
FROM lock_matrix_test;