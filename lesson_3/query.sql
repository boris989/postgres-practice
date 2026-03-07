CREATE TABLE isolation_lab (
                               id serial PRIMARY KEY,
                               value int
);

INSERT INTO isolation_lab(value)
VALUES (10), (20), (30);

BEGIN;
SELECT value FROM isolation_lab WHERE id = 1;
commit;

begin isolation level repeatable read;
SELECT value FROM isolation_lab WHERE id = 1;
COMMIT;
SELECT value FROM isolation_lab WHERE id = 1;

CREATE TABLE doctors_on_call (
                                 doctor text PRIMARY KEY,
                                 on_call boolean
);

INSERT INTO doctors_on_call VALUES
                                ('Alice', true),
                                ('Bob', true);

BEGIN ISOLATION LEVEL REPEATABLE READ;

SELECT count(*)
FROM doctors_on_call
WHERE on_call = true;

UPDATE doctors_on_call
SET on_call = false
WHERE doctor = 'Alice';
COMMIT;

BEGIN ISOLATION LEVEL SERIALIZABLE;

SELECT count(*)
FROM doctors_on_call
WHERE on_call = true;

UPDATE doctors_on_call
SET on_call = false
WHERE doctor = 'Alice';
COMMIT;