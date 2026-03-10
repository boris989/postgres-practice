DROP TABLE IF EXISTS lock_matrix_test;

CREATE TABLE lock_matrix_test (
  id INT PRIMARY KEY,
  value TEXT
);

INSERT INTO lock_matrix_test VALUES
(1, 'A'),
(2, 'B');

SELECT * FROM lock_matrix_test;